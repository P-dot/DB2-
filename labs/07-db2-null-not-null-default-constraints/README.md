# Lab 07 — Db2 NULL, NOT NULL and DEFAULT Constraints

## Objetivo
Demostrar en Db2 for z/OS, mediante DB2I/SPUFI, la diferencia entre `NULL`,
`NOT NULL` y `NOT NULL WITH DEFAULT`, incluyendo una prueba negativa de integridad.

## Entorno y objetos
- Db2 for z/OS / DB2I / SPUFI
- Schema: `IBMUSER`
- Tabla: `IBMUSER.LAB07EMP`
- Miembro: `IBMUSER.DB2LAB.SPUFI(SPU071)`

## Flujo validado
1. CREATE TABLE correcto.
2. INSERT de ANA omitiendo TELEPHONE y CITY.
3. `TELEPHONE IS NULL` recupera ANA.
4. `CITY IS NULL` devuelve 0 filas.
5. `LENGTH(CITY)` devuelve 0.
6. INSERT deliberadamente inválido con `NAME=NULL`.
7. Db2 devuelve `SQLCODE -407`, `SQLSTATE 23502` y rollback.
8. Se comprueba que la fila rechazada no existe.
9. INSERT de LUIS con `TELEPHONE=NULL` termina con SQLCODE 0 y commit.
10. SELECT final devuelve ANA y LUIS.

## Conclusión
Una representación visual vacía no implica necesariamente `NULL`. El laboratorio
demuestra además que `NULL` es válido cuando la definición de la columna lo permite
y que Db2 protege una columna `NOT NULL` rechazando la operación incompatible.

**STATUS: COMPLETED**
