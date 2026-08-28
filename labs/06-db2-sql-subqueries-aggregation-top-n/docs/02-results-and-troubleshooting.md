# Resultados y troubleshooting

## Línea base
Orden descendente observado:
1. CARLOS — 60000.00
2. MARIA — 55000.00
3. LAURA — 47000.00
4. LUIS — 41000.00
5. PEDRO — 38000.00
6. ANA — 32000.00

## MAX
`MAX(SALARIO)` produjo 60000.00.

## Segundo máximo
La subconsulta produjo 55000.00 y la consulta anidada identificó a MARIA.

## Correlación
El contador `SUPERIORES` produjo 0, 1, 2, 3, 4 y 5.

## TOP-N
TOP-3 seleccionó CARLOS, MARIA y LAURA. Después se cambió N a 2 para demostrar que la técnica era generalizable.

## Incidencia SQLCODE -104
Durante la construcción de TOP-N se obtuvo:
- `SQLCODE -104`
- `SQLSTATE 42601`

La causa real observada fue una coma sobrante delante de `SALARIO` en la lista de columnas del `SELECT`. No era una incompatibilidad de Db2 ni un fallo conceptual de la subconsulta correlacionada. Al corregir la coma, TOP-N funcionó.

Esta incidencia se conserva porque demuestra diagnóstico de sintaxis a partir del SQLCODE y revisión de la sentencia.
