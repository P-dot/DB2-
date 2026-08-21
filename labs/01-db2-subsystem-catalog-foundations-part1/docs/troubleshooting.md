# Troubleshooting

## DISPLAY THREAD
Un intento anterior con parámetros PLAN/TYPE fue rechazado. Se corrigió a:
`-DISPLAY THREAD(*)`
Resultado: `NORMAL COMPLETION`.

## DISPLAY DATABASE
El intento fue rechazado con keyword inválida y `ABNORMAL COMPLETION`. No se siguieron probando variantes a ciegas.

## SPUFI — DSNE803A
Se observó `INPUT FILE WAS NOT CHANGED` durante el flujo de edición. No debe confundirse con un SQLCODE.

## SQLCODE -206
Sentencia:
```sql
SELECT DBNAME, NAME
FROM SYSIBM.SYSTABLESPACE
ORDER BY DBNAME, NAME;
```
Resultado observado:
`SQLCODE = -206`
`SQLSTATE = 42703`

Decisión: detener aquí la Parte 1 e inspeccionar en la Parte 2 la estructura real del catálogo del release instalado.
