# Lab 03 — Db2 Tables, Data Types, SPUFI and QMF

**Status:** CLOSED

## Objective
Translate the tutorial concepts of tables, rows/tuples, columns/attributes, Db2 data types, SPUFI and QMF into a real practical exercise on Db2 subsystem D9G.

## Scope
The video/tutorial remains the primary learning path. IBM documentation is complementary. This lab records only the practical sequence actually performed.

## Practical sequence

### 1. Locate an appropriate user context
Read-only catalog queries were used to inspect table spaces outside `DSNDB06` and existing objects owned by `IBMUSER`.

### 2. Create a practice table
```sql
CREATE TABLE IBMUSER.LAB02
(
    ID         INTEGER      NOT NULL,
    CODIGO     CHAR(5)      NOT NULL,
    NOMBRE     VARCHAR(30),
    EDAD       SMALLINT,
    SALARIO    DECIMAL(9,2),
    FECHA_ALTA DATE,
    HORA_ALTA  TIME
);
```

Observed result: statement execution successful, SQLCODE 0; COMMIT SQLCODE 0.

### 3. Insert rows
Three rows were inserted successfully using SPUFI. Each INSERT affected one row and returned SQLCODE 0.

### 4. Query the table
```sql
SELECT *
FROM IBMUSER.LAB02
ORDER BY ID;
```

Three rows were displayed. Horizontal Browse was used to expose the DATE and TIME columns.

### 5. Execute the same query through QMF
QMF Version 9 Release 1 was entered under authorization ID `IBMUSER`. A SQL QUERY was created with the same SELECT and executed.

QMF REPORT returned the same three rows, providing a direct practical comparison with SPUFI.

## Concepts demonstrated
- TABLE
- COLUMN / ATTRIBUTE
- ROW / TUPLE
- INTEGER
- SMALLINT
- DECIMAL
- CHAR
- VARCHAR
- DATE
- TIME
- DDL: CREATE TABLE
- DML: INSERT
- SELECT
- SPUFI workflow
- QMF SQL QUERY / REPORT

## Practical comparison
```text
                 IBMUSER.LAB02
                       |
                 same SELECT
                       |
              +--------+--------+
              |                 |
            SPUFI              QMF
              |                 |
       PDS input member      SQL QUERY
              |                 |
            SPUFO             REPORT
              |                 |
              +---- 3 rows -----+
```

## Result
The tutorial block is complete. The lab demonstrates the relational table structure and common Db2 data types using a real user table, then executes the same SELECT through SPUFI and QMF.

## Boundary
Catalog administration, EXPLAIN, access-path analysis, index tuning and advanced QMF functions are outside this lab.
