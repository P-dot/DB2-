# Incident timeline and reasoning

## 1. User-visible symptom

The incident was first noticed from DB2I/SPUFI: Db2 could no longer be entered normally and `DB9G` was not operational.

At this point the symptom alone did not identify whether the failure belonged to SPUFI, Db2, storage, startup processing, or security.

## 2. System-level validation

SDSF and SYSLOG were used instead of repeatedly retrying SPUFI.

The logs showed Db2 startup/termination activity and ultimately:

```text
DSNV086E -DB9G DB2 ABNORMAL TERMINATION
```

and the standard termination sequence ending with the subsystem ready for a new START command.

This established that SPUFI was a downstream symptom: the Db2 subsystem itself had terminated.

## 3. Dump messages

During the failure, z/OS also reported that automatic SVC dump allocation could not obtain a dump data set. Observed messages included the equivalent of:

```text
IKJ56245I DATA SET SYS1.ADCD.DMP0001x NOT ALLOCATED,
NOT ENOUGH SPACE ON VOLUME...
IEA794I AUTOMATIC ALLOCATION OF SVC DUMP DATASET FAILED
IEA793A NO DUMP DATA SETS AVAILABLE FOR DUMPID=...
```

`D DUMP` subsequently showed no available dump data sets and automatic allocation active.

This was recorded as a separate infrastructure weakness: it reduced diagnostic capture capability, but it did not account for the authorization denial seen later.

## 4. Historical comparison

Earlier SYSLOG periods were reviewed to determine whether Db2 had previously started correctly. Historical entries showed `DB9GDBM1` starts in earlier sessions.

This was important because it shifted the question from:

> "Is this Db2 installation fundamentally broken?"

to:

> "What changed between the last known-good start and the current failure?"

## 5. Security evidence

The decisive messages were RACF `ICH408I` records generated around the failing startup.

The relevant failure showed the started-task identity `START2` attempting an MVS START operation and receiving insufficient authority for a resource under:

```text
MVS.START.STC.DB9GDBM1
```

with:

```text
ACCESS INTENT(UPDATE)
ACCESS ALLOWED(NONE)
```

This was the turning point of the investigation.

## 6. OPERCMDS profile inspection

RACF was queried with:

```text
RLIST OPERCMDS MVS.START.STC.DB9GDBM1 ALL
```

and with the generic profile:

```text
RLIST OPERCMDS MVS.** ALL
```

The generic profile evidence showed protection under `OPERCMDS MVS.**` and an access level that did not satisfy the `UPDATE` authority required for an MVS START.

The investigation therefore moved away from Db2 internals and toward the security change made during hardening.

## 7. Why the solution was in RACF, not SPUFI

IBM's MVS command documentation defines START of a started task as an `OPERCMDS`-protected resource of the form:

```text
MVS.START.STC.mbrname[.id]
```

and specifies `UPDATE` access.

That exactly matches the access intent shown by the RACF denial.

The evidence therefore forms a direct chain:

```text
IBM START authorization model
            +
ICH408I ACCESS INTENT(UPDATE)
            +
MVS.START.STC.DB9GDBM1
            +
insufficient allowed access
            =
RACF OPERCMDS authorization failure
```

## 8. Recovery

The security hardening affecting this path was rolled back/corrected so that the Db2 startup flow could again issue the required START operation.

Db2 was then restarted and returned to service.

Final operational validation was not merely the absence of an error in SYSLOG: DB2I/SPUFI was entered successfully again.

## 9. Engineering lesson

A middleware symptom does not necessarily imply a middleware root cause.

The correct diagnostic path was:

1. Observe the application/tool symptom.
2. Confirm subsystem state.
3. Read the startup/termination logs.
4. Compare with a known-good historical startup.
5. Correlate security denials with the exact protected resource.
6. Verify the required access level in authoritative documentation.
7. Correct the smallest responsible control.
8. Restart and validate from the original user path.

That sequence avoided unnecessary Db2 recovery, catalog changes, DASD rollback, or shadow-disk restoration.
