# References

Authoritative IBM references used to validate the diagnosis:

1. IBM — z/OS MVS System Commands — START command and OPERCMDS resource naming.
   https://www.ibm.com/docs/en/zos/3.2.0?topic=reference-start-command

2. IBM — z/OS Security Server RACF — Controlling the use of operator commands.
   https://www.ibm.com/docs/en/zos/3.2.0?topic=commands-controlling-use-operator

3. IBM — Db2 for z/OS — Recovering from subsystem termination.
   https://www.ibm.com/docs/en/db2-for-zos/13.0.0?topic=problems-recovering-from-subsystem-termination

Key correlation used in this lab:

- MVS START of a started task is protected through OPERCMDS.
- The resource form includes `MVS.START.STC.<member>[.<id>]`.
- START requires `UPDATE`.
- The incident's ICH408I requested `UPDATE` for `MVS.START.STC.DB9GDBM1` and showed insufficient allowed access.
