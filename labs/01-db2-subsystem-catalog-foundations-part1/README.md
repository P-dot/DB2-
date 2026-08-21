# Lab 01 — Db2 for z/OS Foundations — Part 1

## Estado
**CERRADO — PARTE 1**

## Objetivo
Realizar una primera exploración teórico-práctica de Db2 for z/OS sobre el subsistema `D9G`, diferenciando:
- subsistema Db2 y objetos de base de datos;
- SQL y comandos Db2;
- trabajo local mediante TSO/DB2I;
- actividad distribuida mediante DDF;
- uso de SPUFI y del catálogo `SYSIBM`;
- interpretación inicial de mensajes y SQLCODE.

## Entorno observado
- z/OS ADCD / Hercules
- TSO/ISPF
- DB2I
- SSID: `D9G`
- SPUFI
- Catálogo Db2 `SYSIBM`

## Desarrollo realizado

### 1. Acceso a DB2I
Se verificó el `DB2I PRIMARY OPTION MENU` para `SSID: D9G`.

Se identificaron las funciones principales:
`SPUFI`, `DCLGEN`, `PROGRAM PREPARATION`, `PRECOMPILE`,
`BIND/REBIND/FREE`, `RUN`, `DB2 COMMANDS`, `UTILITIES`, `QMF`.

### 2. Db2 Commands y threads
Se conservó un intento anterior con sintaxis incorrecta y se corrigió con:

```text
-DISPLAY THREAD(*)
```

El comando terminó con `NORMAL COMPLETION`.

La salida mostró actividad asociada a:
- `CICS`
- `TSO`
- `AUTHID IBMUSER`

Esto permitió introducir los conceptos `THREAD`, `AUTHID`, `ASID` y la relación entre actividad TSO/CICS y Db2.

### 3. DDF
Se ejecutó:

```text
-DISPLAY DDF
```

El informe mostró:

```text
STATUS=STARTED
```

Se verificó así que Distributed Data Facility estaba iniciado.

> La evidencia original contiene datos de red. No debe publicarse sin sanitización.

### 4. Intento de DISPLAY DATABASE
Se intentó un `-DISPLAY DATABASE` que terminó con:

```text
DSN9001I ... KEYWORD ... IS INVALID
DSN9023I ... ABNORMAL COMPLETION
```

Se conserva como troubleshooting y como recordatorio de que la sintaxis administrativa debe ajustarse al release instalado.

### 5. SPUFI
Se utilizó:
- input: `IBMUSER.DB2LAB.SPUFI(SPU031)`
- output: `IBMUSER.DB2LAB.SPUFO`

Se repasó el flujo:

```text
PDS member -> SPUFI -> D9G -> output sequential data set
```

### 6. Consulta del catálogo
Se ejecutó correctamente:

```sql
SELECT NAME
FROM SYSIBM.SYSDATABASE
ORDER BY NAME;
```

La salida devolvió múltiples databases registradas en el catálogo del subsistema.

Esto demostró de forma práctica que:

```text
D9G (subsystem)
   |
   +-- database
   +-- database
   +-- database
   +-- ...
```

Por tanto, `SSID/subsystem` y `database` no son conceptos equivalentes.

### 7. SQLCODE -206
Se probó:

```sql
SELECT DBNAME, NAME
FROM SYSIBM.SYSTABLESPACE
ORDER BY DBNAME, NAME;
```

D9G respondió:

```text
SQLCODE = -206
SQLSTATE = 42703
DBNAME IS NOT VALID IN THE CONTEXT WHERE IT IS USED
```

La ejecución de SPUFI funcionó; el rechazo correspondió a la sentencia SQL.

La conclusión de esta parte es metodológica: no asumir la estructura del catálogo de otro release. En la Parte 2 se inspeccionará el catálogo real del sistema antes de construir consultas adicionales.

## Resultado
La Parte 1 queda cerrada con:
- DB2I operativo;
- subsistema `D9G` identificado;
- `-DISPLAY THREAD(*)` ejecutado correctamente;
- threads CICS/TSO observados;
- DDF verificado como `STARTED`;
- SPUFI utilizado;
- catálogo `SYSIBM.SYSDATABASE` consultado;
- troubleshooting documentado;
- `SQLCODE -206 / SQLSTATE 42703` interpretado como punto de continuidad.

## Punto exacto de reanudación — Parte 2
La siguiente práctica comenzará consultando `SYSIBM.SYSCOLUMNS` para descubrir la estructura real de `SYSIBM.SYSTABLESPACE` en este Db2 antes de seguir con la jerarquía:

`SUBSYSTEM -> DATABASE -> TABLE SPACE -> TABLE -> INDEX`.

## Seguridad
No publicar:
- IPs;
- MAC;
- hostnames sensibles;
- nombres de adaptadores;
- credenciales;
- datos de red innecesarios.

La captura de `-DISPLAY DDF` debe sanitizarse antes de incorporarla al repositorio público.
