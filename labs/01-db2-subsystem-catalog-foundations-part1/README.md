# Lab 01 — Db2 for z/OS Foundations — Part 1

**Estado:** CLOSED — PART 1

## Objetivo
Primera exploración teórico-práctica del subsistema Db2 `D9G`: DB2I, comandos operativos, threads, DDF, SPUFI, catálogo y troubleshooting SQL.

## Ejecución real documentada
1. Acceso a DB2I (`SSID: D9G`).
2. Entrada en DB2 COMMANDS.
3. Corrección y ejecución de `-DISPLAY THREAD(*)`.
4. Observación de threads CICS y TSO y `NORMAL COMPLETION`.
5. Ejecución de `-DISPLAY DDF`; DDF observado como `STATUS=STARTED`.
6. Intento de `-DISPLAY DATABASE` rechazado; se conserva como troubleshooting.
7. Entrada en SPUFI.
8. Consulta correcta de `SYSIBM.SYSDATABASE`.
9. Consulta de `SYSIBM.SYSTABLESPACE` con `DBNAME`, rechazada con `SQLCODE -206 / SQLSTATE 42703`.
10. Cierre de la Parte 1 en ese punto.

## Conclusiones
- `D9G` es el subsistema, no una database.
- DB2 COMMANDS y SQL cumplen funciones diferentes.
- Db2 puede mostrar actividad asociada a CICS y TSO.
- DDF está iniciado en el entorno observado.
- SPUFI permite ejecutar SQL almacenado en un miembro de entrada y revisar la salida.
- El catálogo debe consultarse respetando la estructura real del release instalado.
- Los errores reales se documentan y no se ocultan.

## Continuación
La Parte 2 comenzará inspeccionando el catálogo real antes de continuar con:
`SUBSYSTEM -> DATABASE -> TABLE SPACE -> TABLE -> INDEX`.

## Evidencias
Las capturas reales están en `evidence/screenshots/`.
La captura DDF incluida ha sido sanitizada para ocultar información de red.
