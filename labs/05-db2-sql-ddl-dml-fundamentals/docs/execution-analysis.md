# Análisis de ejecución

## DELETE
`DELETE FROM IBMUSER.LAB02 WHERE ID = 3;`

Resultado observado:
- `DSNE615I NUMBER OF ROWS AFFECTED IS 1`
- `DSNE616I ... SQLCODE IS 0`

El `SELECT` posterior mostró únicamente ID 1 e ID 2.

## DROP
`DROP TABLE IBMUSER.LAB02;`

Resultado observado:
- ejecución correcta
- `SQLCODE 0`

## Prueba negativa
`SELECT * FROM IBMUSER.LAB02;`

Resultado:
- `DSNT408I SQLCODE = -204`
- `IBMUSER.LAB02 IS AN UNDEFINED NAME`
- `DSNT418I SQLSTATE = 42704`

Esto demuestra experimentalmente la diferencia entre eliminar filas y eliminar el objeto.
