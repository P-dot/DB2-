# Observed evidence register

This register transcribes the decisive observations from the interactive incident session.

## E01 — Db2 abnormal termination

Observed in SYSLOG:

```text
DSNV086E -DB9G DB2 ABNORMAL TERMINATION
```

The log then showed Db2 termination completing and the subsystem becoming ready for a subsequent START.

## E02 — SVC dump allocation problem

Observed during the abnormal termination:

```text
IKJ56245I DATA SET SYS1.ADCD.DMP0000x NOT ALLOCATED,
NOT ENOUGH SPACE ON VOLUME...
IEA794I AUTOMATIC ALLOCATION OF SVC DUMP DATASET FAILED
IEA793A NO DUMP DATA SETS AVAILABLE FOR DUMPID=...
```

Interpretation: diagnostic dump capture was impaired. This is not used as the root-cause proof for the Db2 outage.

## E03 — RACF denial

Observed around the failing Db2 startup:

```text
ICH408I USER(START2) ...
MVS.START.STC.DB9GDBM1
WARNING: INSUFFICIENT ACCESS AUTHORITY
FROM MVS.** (G)
ACCESS INTENT(UPDATE)
ACCESS ALLOWED(NONE)
```

This is the decisive incident evidence.

## E04 — OPERCMDS profile inspection

The session reviewed:

```text
RLIST OPERCMDS MVS.START.STC.DB9GDBM1 ALL
RLIST OPERCMDS MVS.** ALL
```

The generic `MVS.**` profile was the effective protection path observed during diagnosis.

## E05 — Successful recovery

After correcting/rolling back the security change and restarting Db2, the user successfully entered DB2I/SPUFI again.

This closes the incident from the same user-facing path in which it was originally detected.
