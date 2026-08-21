# Apuntes de clase — Parte 1

## DB2I
Interfaz de trabajo Db2 desde ISPF. En la práctica se observó el subsistema D9G y las opciones SPUFI, DCLGEN, preparación de programas, precompile, bind, run, commands y utilities.

## SQL frente a Db2 Commands
SQL consulta o manipula datos/objetos. Los Db2 commands observan o administran el subsistema.

## THREAD
`-DISPLAY THREAD(*)` terminó correctamente y mostró actividad CICS y TSO.

## DDF
`-DISPLAY DDF` mostró `STATUS=STARTED`. La evidencia pública está sanitizada.

## SPUFI
Se trabajó con `DB2LAB.SPUFI(SPU031)` como entrada y `DB2LAB.SPUFO` como salida.

## Catálogo
`SYSIBM.SYSDATABASE` devolvió el inventario de databases.

## Troubleshooting
La consulta a `SYSIBM.SYSTABLESPACE` usando `DBNAME` devolvió `SQLCODE -206 / SQLSTATE 42703`. Este es el punto de arranque de la Parte 2.
