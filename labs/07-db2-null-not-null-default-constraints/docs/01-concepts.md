# Conceptos demostrados

- `NULL`: ausencia de valor; se comprueba con `IS NULL`.
- `NOT NULL`: impide almacenar NULL.
- `NOT NULL WITH DEFAULT`: permite omitir la columna sin almacenar NULL.
- La evidencia muestra que CITY no es NULL y que `LENGTH(CITY)=0`.
- Una operación que viola NOT NULL es rechazada y no deja la fila almacenada.
