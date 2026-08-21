# Troubleshooting

## Caso 1 — DISPLAY THREAD con parámetros inválidos
**Síntomas:** `DSN9015I`, `DSN9001I`, `DSN9023I`.

**Corrección aplicada:**
```text
-DISPLAY THREAD(*)
```

**Resultado:** `DSN9022I ... NORMAL COMPLETION`.

## Caso 2 — DISPLAY DATABASE rechazado
**Síntomas:** keyword inválida y `ABNORMAL COMPLETION`.

**Decisión:** no probar variantes a ciegas. Documentar y continuar mediante catálogo/SPUFI.

## Caso 3 — DSNE803A INPUT FILE WAS NOT CHANGED
Mensaje del flujo de SPUFI/edición. No debe confundirse automáticamente con un SQLCODE.

## Caso 4 — SQLCODE -206
**SQL:**
```sql
SELECT DBNAME, NAME
FROM SYSIBM.SYSTABLESPACE
ORDER BY DBNAME, NAME;
```

**Resultado:**
```text
SQLCODE = -206
SQLSTATE = 42703
DBNAME IS NOT VALID IN THE CONTEXT WHERE IT IS USED
```

**Decisión:** inspeccionar en la Parte 2 las columnas reales del catálogo de este release antes de continuar.
