# Evidencia de SQLCODE -407

La sentencia que intentó insertar `NULL` en `NAME` fue rechazada.

Resultado observado:
- SQLCODE: -407
- SQLSTATE: 23502
- ROLLBACK realizado por SPUFI

`NAME` estaba definida `NOT NULL`. Una consulta posterior confirmó que `ID=2`
no se había almacenado. Después, `TELEPHONE=NULL` sí fue aceptado porque esa
columna admite valores nulos.
