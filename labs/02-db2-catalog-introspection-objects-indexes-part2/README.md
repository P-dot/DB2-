# Lab 02 — Db2 Catalog Introspection, Objects and Indexes — Part 2

**Status: CLOSED — PART 2**

## Objective
Continue the practical Db2 for z/OS work on subsystem `D9G`, using the real Db2 catalog to diagnose SQL errors and demonstrate the object hierarchy down to columns and indexes.

## Practical work

### Catalog introspection
After `SQLCODE -206`, the lab stopped guessing and inspected the real catalog:

```sql
SELECT NAME, COLNO, COLTYPE, LENGTH
FROM SYSIBM.SYSCOLUMNS
WHERE TBNAME = 'SYSTABLESPACE'
  AND TBCREATOR = 'SYSIBM'
ORDER BY COLNO;
```

The output confirmed catalog columns including `NAME`, `CREATOR`, `DBNAME`, `DBID`, `OBID`, `PSID` and `BPOOL`.

### Qualification troubleshooting
A later statement resolved `SYSTABLESPACE` under `IBMUSER` and produced:

```text
SQLCODE = -204
SQLSTATE = 42704
IBMUSER.SYSTABLESPACE IS AN UNDEFINED NAME
```

The catalog object was then explicitly qualified:

```sql
SELECT NAME, DBNAME, DBID, PSID, BPOOL
FROM SYSIBM.SYSTABLESPACE
FETCH FIRST 20 ROWS ONLY;
```

The corrected statement displayed 20 rows successfully and the subsequent COMMIT returned SQLCODE 0.

### DATABASE -> TABLE SPACE
The successful output showed table spaces belonging to `DSNDB06`, with `DBID`, `PSID` and `BPOOL`.

### TABLE SPACE -> TABLE
```sql
SELECT CREATOR, NAME, DBNAME, TSNAME
FROM SYSIBM.SYSTABLES
WHERE DBNAME = 'DSNDB06'
FETCH FIRST 20 ROWS ONLY;
```

Horizontal ISPF Browse was used to inspect the complete row and demonstrate the relationship between database, table space and table.

### TABLE -> COLUMN
```sql
SELECT NAME, COLNO, COLTYPE, LENGTH
FROM SYSIBM.SYSCOLUMNS
WHERE TBNAME = 'SYSTABLES'
  AND TBCREATOR = 'SYSIBM'
ORDER BY COLNO;
```

The evidence shows real column names and types such as `VARCHAR`, `CHAR`, `INTEGER` and `SMALLINT`.

### TABLE -> INDEX
```sql
SELECT CREATOR, NAME, TBNAME, TBCREATOR
FROM SYSIBM.SYSINDEXES
WHERE TBCREATOR = 'SYSIBM'
FETCH FIRST 20 ROWS ONLY;
```

The query displayed 20 rows successfully. Horizontal Browse exposed index names and their associated tables.

## Architecture demonstrated

```text
D9G
 |
 +-- DATABASE
      |
      +-- TABLE SPACE
           |
           +-- TABLE
                |-- COLUMN
                +-- INDEX
```

## Troubleshooting chain
`-206 -> catalog introspection -> -204 -> identify qualification problem -> SYSIBM qualifier -> successful execution`

The errors are intentionally retained because they document diagnosis and correction rather than a scripted success.

## Boundary
EXPLAIN, access paths, clustering strategy, index design and performance tuning are intentionally left for later labs.
