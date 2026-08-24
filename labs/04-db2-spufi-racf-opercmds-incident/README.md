# Lab 04 — Db2 SPUFI outage: RACF OPERCMDS root-cause analysis and recovery

## Objective

Document a real operational incident in a z/OS ADCD 1.11 laboratory running on Hercules in which Db2 subsystem `DB9G` stopped being usable from DB2I/SPUFI after a security-hardening change.

The purpose of this lab is not to present a manufactured failure. It preserves the diagnostic path followed during the incident: symptom, SYSLOG investigation, Db2 abnormal termination, RACF denial, identification of the effective OPERCMDS profile, rollback/correction, restart, and final validation through SPUFI.

## Executive result

The initial symptom appeared to be a Db2/SPUFI problem, but the decisive evidence was outside SPUFI.

The SYSLOG showed an `ICH408I` authorization failure for the identity `START2` while attempting an MVS START operation associated with the Db2 DBM1 started task. The protected resource was in the RACF `OPERCMDS` class and required `UPDATE` authority.

The generic profile review also showed that the relevant `MVS.**` protection was not granting the authority required by an MVS START operation. IBM documents that START of a started task is protected as `MVS.START.STC.<member>[.<id>]` and requires `UPDATE`.

Therefore, the failure chain was:

```text
OPERCMDS hardening/change
        |
        v
MVS START authorization evaluated by RACF
        |
        v
START2 lacks required UPDATE authority
        |
        v
ICH408I / START request denied
        |
        v
Db2 DBM1 startup path cannot complete correctly
        |
        v
DSNV086E abnormal Db2 termination
        |
        v
DB9G not operational
        |
        v
DB2I / SPUFI unavailable
```

The corrective action was to restore/correct the RACF OPERCMDS authorization behavior that had been changed during hardening, rather than attempting to repair SPUFI, restore DASD shadows, or alter Db2 data structures. After the security rollback/correction and Db2 restart, SPUFI was usable again.

> Important evidence discipline: the exact RACF mutation command used during the interactive recovery is not preserved in the supplied artifact set. This lab therefore does **not** invent one. It records the observed profile, required access level, failure messages, and validated recovery outcome.

## Environment

- IBM z/OS ADCD 1.11
- Hercules
- Db2 for z/OS subsystem: `DB9G`
- TSO/ISPF
- DB2I / SPUFI
- SDSF / SYSLOG
- RACF
- RACF class: `OPERCMDS`

## What made this incident valuable

Several plausible explanations were investigated:

- Db2 itself had failed.
- SPUFI might have been damaged.
- DASD or a shadow disk might need rollback.
- SVC dump allocation errors might be the root cause.
- The previous shutdown might have corrupted Db2.
- Started-task identities or STARTED profiles might be wrong.

The logs allowed these hypotheses to be separated from the actual authorization failure.

The SVC dump allocation messages were real, but they were a secondary diagnostic-storage problem: `SYS1.DUMP` had no available dump data sets / insufficient allocation space. They explained why diagnostic dumps could not be captured; they did not explain why the START command was denied.

The decisive evidence was the RACF `ICH408I` for an MVS START resource with `ACCESS INTENT(UPDATE)` and insufficient authority.

## Completion criteria

- [x] Db2/SPUFI outage reproduced and observed
- [x] Historical SYSLOG reviewed
- [x] Db2 abnormal termination identified
- [x] SVC dump allocation failure distinguished from root cause
- [x] RACF `ICH408I` located
- [x] `OPERCMDS` identified as the controlling class
- [x] START command access requirement correlated with IBM documentation
- [x] Relevant generic OPERCMDS profile reviewed
- [x] Security change rolled back/corrected
- [x] Db2 returned to operational state
- [x] SPUFI access validated
- [x] No shadow-disk rollback used
- [x] No Db2 catalog/data recovery required

## Final status

**LAB 04 — COMPLETED**

Root cause category: **RACF authorization / OPERCMDS hardening interaction**

Service restored: **Db2 DB9G + DB2I/SPUFI operational**

Next lab: **Lab 05 — Db2 SQL DDL and DML fundamentals**, kept separate so that this incident remains a focused troubleshooting/security engineering case study.
