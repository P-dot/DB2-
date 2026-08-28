# Lab 06 — Db2 SQL Subqueries, Aggregation and Top-N Queries

## Objetivo
Practicar en Db2 for z/OS mediante DB2I/SPUFI funciones agregadas, subconsultas, subconsultas anidadas y correlacionadas, alias de tabla y una técnica TOP-N.

## Entorno
- z/OS ADCD 1.11
- Db2 for z/OS
- DB2I / SPUFI
- Esquema: `IBMUSER`
- Tabla de laboratorio: `IBMUSER.LAB06EMP`
- Miembro SPUFI utilizado: `IBMUSER.DB2LAB.SPUFI(SPU061)`

## Recorrido realizado
1. Creación de `LAB06EMP`.
2. Inserción de seis empleados.
3. Verificación con `ORDER BY SALARIO DESC`.
4. `MAX(SALARIO)`.
5. Segundo salario máximo mediante subconsulta.
6. Identificación del empleado asociado al segundo máximo.
7. Subconsulta correlacionada con alias `A` y `B`.
8. Conteo de salarios superiores con `COUNT(*)`.
9. TOP-3 mediante correlación.
10. Troubleshooting de `SQLCODE -104 / SQLSTATE 42601`.
11. Corrección de la coma sobrante delante de `SALARIO`.
12. Generalización TOP-N y prueba TOP-2.

## Resultado
El laboratorio demuestra progresivamente cómo el resultado de una consulta puede alimentar otra y cómo una subconsulta correlacionada depende de la fila exterior. La prueba TOP-3 devolvió Carlos, María y Laura; posteriormente se generalizó el criterio para TOP-2.

## Incidencia real
Durante TOP-N apareció `SQLCODE -104`. La investigación terminó mostrando que no fallaba la capacidad de Db2 ni la subconsulta correlacionada: existía una coma sobrante delante de `SALARIO` en la lista `SELECT`. La sintaxis se corrigió y la consulta funcionó.

## Alcance
COMMIT/ROLLBACK no forma parte de este laboratorio.

**STATUS: COMPLETED**
