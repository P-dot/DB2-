# Commands used during diagnosis

These are diagnostic/read-only commands observed during the investigation or directly relevant to reproducing the checks.

## Db2 / subsystem observation

From SDSF/SYSLOG, search for:

```text
DB9G
DB9GDBM1
DSNV086E
DSN3104I
DSN3100I
ICH408I
MVS.START.STC.DB9GDBM1
```

## RACF STARTED identity review

```text
RLIST STARTED * STDATA
RLIST STARTED DB9GDBM1.* STDATA ALL
```

Purpose: determine how started-task identities are mapped. This was useful context, but the decisive failure was in `OPERCMDS`, not merely in the STARTED identity mapping.

## RACF OPERCMDS review

```text
RLIST OPERCMDS MVS.START.STC.DB9GDBM1 ALL
RLIST OPERCMDS MVS.** ALL
```

Purpose: identify the profile protecting the MVS START operation and inspect effective access.

## Dump status

From the operator console:

```text
D DUMP
```

Purpose: verify availability of SVC dump data sets after automatic allocation failures.

## Validation

After the security rollback/correction and Db2 restart:

```text
DB2I
```

Then select:

```text
1  SPUFI
```

Successful entry into SPUFI is the end-to-end service validation.

## Deliberately excluded from this file

The exact RACF write command used to restore/correct authorization is not reproduced because it is not preserved in the evidence supplied for packaging. Do not substitute a guessed `PERMIT` command in a production system.
