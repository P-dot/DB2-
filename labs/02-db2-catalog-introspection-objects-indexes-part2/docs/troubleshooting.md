# Troubleshooting — Part 2

## SQLCODE -206 / SQLSTATE 42703
The real catalog structure was inspected through `SYSIBM.SYSCOLUMNS` instead of guessing.

## SQLCODE -204 / SQLSTATE 42704
Observed: `IBMUSER.SYSTABLESPACE IS AN UNDEFINED NAME`.

Correction: explicitly reference `SYSIBM.SYSTABLESPACE`.

Result: 20 rows displayed; subsequent COMMIT SQLCODE 0.

## Lesson
Always inspect the SQL that SPUFI actually executed and qualify catalog objects explicitly when required.
