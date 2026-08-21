# Class notes — Db2 for z/OS Part 1

## Conceptos aprendidos

### Db2 subsystem
Db2 se ejecuta integrado en z/OS como subsistema. En esta práctica el SSID observado es `D9G`.

### SQL vs Db2 commands
SQL trabaja con datos y objetos:
`SELECT`, `INSERT`, `UPDATE`, `DELETE`, `CREATE`, `GRANT`, etc.

Db2 commands permiten observar/controlar el subsistema:
`-DISPLAY ...`, `-START ...`, `-STOP ...`, etc.

En esta parte solo se utilizaron operaciones de observación.

### Thread
Representa actividad/unidad de trabajo conocida por Db2. `-DISPLAY THREAD(*)` permitió observar actividad CICS y TSO.

### AUTHID
Authorization ID utilizado por Db2 en el contexto de autorización.

### ASID
Address Space Identifier de z/OS asociado a actividad observada.

### DDF
Distributed Data Facility proporciona conectividad distribuida de Db2. En D9G se observó `STATUS=STARTED`.

### SPUFI
SQL Processing Using File Input. Utiliza un data set de entrada con SQL y un data set secuencial de salida.

### Catálogo
Las tablas `SYSIBM` describen el entorno Db2. `SYSIBM.SYSDATABASE` permitió inventariar databases.

### SQLCODE / SQLSTATE
La consulta posterior sobre `SYSTABLESPACE` devolvió `SQLCODE -206` y `SQLSTATE 42703`. El error pertenece a la sentencia SQL, no al funcionamiento de SPUFI.

## Lección operativa
Primero observar, después interpretar y solo entonces cambiar. Los errores reales se conservan cuando ayudan a demostrar diagnóstico y corrección.
