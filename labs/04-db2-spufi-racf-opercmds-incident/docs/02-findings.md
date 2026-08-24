# Findings

## Confirmed findings

### F01 — SPUFI was a symptom, not the root cause
DB2I/SPUFI failed because subsystem `DB9G` was not operational.

### F02 — Db2 terminated abnormally
SYSLOG contained `DSNV086E` for `DB9G`, followed by subsystem termination messages.

### F03 — Dump capacity was also unhealthy
Automatic SVC dump allocation failed because no suitable dump data set could be allocated. This is a separate reliability/diagnostic finding and should be remediated in another lab.

### F04 — RACF denied an MVS START operation
`ICH408I` showed insufficient authority for a protected MVS START resource associated with `DB9GDBM1`.

### F05 — The requested access was UPDATE
The denial explicitly showed `ACCESS INTENT(UPDATE)`.

### F06 — IBM documents UPDATE for START
IBM MVS System Commands maps START of a started task to `MVS.START.STC.mbrname[.id]` in OPERCMDS with UPDATE authority.

### F07 — The effective security control was OPERCMDS
The relevant `MVS.**` / `MVS.START.STC...` profile path was therefore the correct place to investigate and correct.

### F08 — Recovery did not require Db2 data recovery
No evidence supported catalog corruption or a need to restore Db2 data. After the security correction/rollback and restart, SPUFI became accessible again.

## Not claimed

This package intentionally does not claim an exact RACF `PERMIT`, `RALTER`, `RDELETE`, or `SETROPTS` mutation command unless that command is preserved as evidence. The session established the authorization cause and successful rollback/correction, but the supplied artifact set does not preserve the exact mutation line.

This distinction keeps the portfolio evidence reproducible and defensible.
