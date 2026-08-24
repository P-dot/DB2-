# Lab 05 — Db2 SQL DDL & DML Fundamentals

## Objetivo
Demostrar en Db2 for z/OS, mediante DB2I/SPUFI, la diferencia práctica entre DDL y DML trabajando sobre `IBMUSER.LAB02`.

## Recorrido realizado
`CREATE → INSERT → SELECT → ALTER → UPDATE → DELETE → SELECT → DROP → SELECT negativo`

### DDL
- `CREATE TABLE`: crea el objeto.
- `ALTER TABLE`: modifica su definición.
- `DROP TABLE`: elimina el objeto.

### DML
- `INSERT`: incorpora filas.
- `UPDATE`: modifica filas.
- `DELETE`: elimina filas.

`SELECT` se utiliza como mecanismo de consulta y verificación.

## Resultado
Se creó y manipuló `IBMUSER.LAB02`; tras `DELETE ... WHERE ID=3`, la consulta confirmó que permanecían las filas 1 y 2. `DROP TABLE IBMUSER.LAB02` terminó con `SQLCODE 0`. La consulta posterior produjo `SQLCODE -204`, `SQLSTATE 42704`, demostrando que el objeto ya no existía.

## Alcance
COMMIT/ROLLBACK queda fuera de este lab y se estudiará posteriormente.

**STATUS: COMPLETED**
