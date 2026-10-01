# Db2 for z/OS Engineering Labs

> **Data management, SQL, catalog analysis, operational troubleshooting and cross-domain integration on IBM z/OS.**

This repository is the **Db2 for z/OS engineering domain** of the [IBM z/OS Mainframe Engineering Portfolio](https://github.com/P-dot).

It documents work executed and validated in the laboratory: Db2 subsystem interaction, DB2I/SPUFI, catalog exploration, relational objects, SQL, integrity constraints, troubleshooting, and selected security and operational dependencies.

The repository is evidence-driven: successful execution, failures, diagnosis, correction, and final validation are preserved where they contribute to understanding the system.

---

## Portfolio Navigation

| Destination | Purpose |
|---|---|
| [Portfolio Home](https://github.com/P-dot) | Global entry point to the engineering portfolio |
| [Core z/OS Engineering](https://github.com/P-dot/zos-adcd-hercules-engineering-lab) | System-level z/OS engineering environment |
| [Db2 Labs](labs/) | Practical Db2 laboratory progression |
| [Ecosystem Integration](docs/ECOSYSTEM-INTEGRATION.md) | Ownership, dependencies, and integration model |

---

## Repository Role

| Attribute | Scope |
|---|---|
| Engineering domain | Data & Storage / Application Data |
| Platform | IBM z/OS |
| Primary technology | Db2 for z/OS |
| Interactive tooling | TSO/ISPF, DB2I, SPUFI |
| Data focus | Catalog, relational objects, SQL, constraints |
| Operational focus | SQLCODE/SQLSTATE diagnosis and subsystem interaction |
| Security interaction | RACF where directly demonstrated |
| Evidence model | Execute → Observe → Diagnose → Correct → Validate → Document |

Db2 is treated here as both a **relational data platform** and a **z/OS subsystem with operational dependencies**. This repository owns Db2-specific learning and evidence; it does not duplicate the responsibilities of COBOL, CICS, JCL/JES2, RACF, workload automation, or core z/OS engineering.

---

## Position in the Engineering Ecosystem

```text
                    IBM z/OS Engineering Portfolio
                               |
          +--------------------+--------------------+
          |                    |                    |
      TSO / ISPF          RACF / Security       JCL / JES2
          |                    |                    |
          +--------------------+--------------------+
                               |
                          Db2 for z/OS
                               |
              +----------------+----------------+
              |                |                |
             SQL            Catalog       Operational state
              |                |                |
              +----------------+----------------+
                               |
                    Application integration
                               |
              +----------------+----------------+
              |                |                |
            COBOL             CICS        Batch / Scheduler
```

Detailed ownership boundaries, upstream dependencies, validated capabilities, and future integration targets are maintained in [Db2 for z/OS — Ecosystem Integration](docs/ECOSYSTEM-INTEGRATION.md).

---

## Validated Lab Progression

### Lab 01 — Db2 Subsystem and Catalog Foundations

Establishes DB2I, Db2 command execution, thread and DDF observation, SPUFI, catalog SQL, and the distinction between a Db2 subsystem and a database. The lab preserves troubleshooting evidence, including a catalog query that produced `SQLCODE -206 / SQLSTATE 42703` and required inspection of the actual catalog structure.

**[Open Lab 01](labs/01-db2-subsystem-catalog-foundations-part1/)**

### Lab 02 — Catalog Introspection, Objects and Indexes

Continues from catalog troubleshooting and validates the relationship between subsystem, database, table space, table, column, and index.

```text
SUBSYSTEM
    |
 DATABASE
    |
TABLE SPACE
    |
  TABLE
   / \
COLUMN INDEX
```

**[Open Lab 02](labs/02-db2-catalog-introspection-objects-indexes-part2/)**

### Lab 03 — Tables, Data Types, SPUFI and QMF

Develops practical understanding of relational tables, common Db2 data types, and interactive SQL workflows using the tooling exercised in the laboratory.

**[Open Lab 03](labs/03-db2-tables-datatypes-spufi-qmf/)**

### Lab 04 — SPUFI Outage: RACF OPERCMDS Root-Cause Analysis and Recovery

Documents a real operational incident in which the visible symptom appeared in Db2/DB2I/SPUFI, while decisive evidence identified a RACF `OPERCMDS` authorization failure affecting an MVS START path required by Db2.

```text
Security hardening/change
          |
          v
   RACF OPERCMDS
          |
          v
   MVS START denied
          |
          v
 Db2 startup path fails
          |
          v
 DB2I / SPUFI unavailable
          |
          v
 Diagnose → Correct → Restart → Validate
```

The lab distinguishes the root cause from secondary diagnostic-storage errors and deliberately avoids inventing an exact RACF mutation command that was not preserved in the evidence.

**[Open Lab 04](labs/04-db2-spufi-racf-opercmds-incident/)**

### Lab 05 — Db2 SQL DDL and DML Fundamentals

Extends the practical SQL path into definition and manipulation operations.

**[Open Lab 05](labs/05-db2-sql-ddl-dml-fundamentals/)**

### Lab 06 — Db2 SQL Subqueries, Aggregation and Top-N

Develops progressively more advanced SQL query construction through subqueries, aggregation, correlated logic, and Top-N techniques.

**[Open Lab 06](labs/06-db2-sql-subqueries-aggregation-top-n/)**

### Lab 07 — Db2 NULL, NOT NULL and DEFAULT Constraints

Demonstrates nullability, defaults, and integrity enforcement through positive and negative tests. The validated flow includes deliberate rejection of an incompatible insert, `SQLCODE -407 / SQLSTATE 23502`, rollback verification, and successful final inserts and queries.

**[Open Lab 07](labs/07-db2-null-not-null-default-constraints/)**

---

## Evidence Model

The repository follows the portfolio engineering workflow:

```text
BUILD → EXECUTE → OBSERVE → DIAGNOSE → CORRECT → VALIDATE → DOCUMENT
```

Failures are not automatically removed from the record. When a failure contributes to understanding the platform, the diagnostic path becomes engineering evidence:

```text
Unexpected behavior
        |
        v
 Evidence collection
        |
        v
 Root-cause analysis
        |
        v
     Correction
        |
        v
 Validated final state
```

---

## Cross-Domain Connections

| Engineering area | Repository | Relationship to Db2 |
|---|---|---|
| Core z/OS | [zos-adcd-hercules-engineering-lab](https://github.com/P-dot/zos-adcd-hercules-engineering-lab) | Operating environment and system engineering |
| TSO/E & ISPF | [MVS_TSO_ISPF](https://github.com/P-dot/MVS_TSO_ISPF) | Interactive entry path to DB2I/SPUFI |
| JCL & JES2 | [JCL_LABS](https://github.com/P-dot/JCL_LABS) | Batch execution foundation |
| RACF & Security | [mainframe-racf-security-evidence](https://github.com/P-dot/mainframe-racf-security-evidence) | Authorization and security boundaries |
| COBOL | [COBOL](https://github.com/P-dot/COBOL) | Application-language layer |
| CICS | [CICS](https://github.com/P-dot/CICS) | Online transaction-processing layer |
| VSAM | [vsam01](https://github.com/P-dot/vsam01) | Data-access and storage engineering |
| Workload Automation | [zos-batch-scheduler](https://github.com/P-dot/zos-batch-scheduler) | Batch orchestration and production control |
| Integrated Application Path | [mainframe-cobol-db2-cics-devops-lab](https://github.com/P-dot/mainframe-cobol-db2-cics-devops-lab) | Cross-component application integration |

These links describe engineering relationships. They do **not** imply that every possible integration path has already been implemented. Validated work and future integration targets remain explicitly separated.

---

## Repository Boundaries

General TSO/E and ISPF operation belongs to `MVS_TSO_ISPF`; general JCL/JES2 engineering to `JCL_LABS`; RACF administration and security engineering to `mainframe-racf-security-evidence`; COBOL fundamentals to `COBOL`; CICS transaction processing to `CICS`; scheduling and production-control behavior to `zos-batch-scheduler`; and core system engineering to `zos-adcd-hercules-engineering-lab`.

This separation keeps ownership clear while allowing validated cross-domain scenarios to connect the repositories.

---

## Integration Strategy

```text
Specialized repository
        |
        v
Validated capability
        |
        v
Cross-domain scenario
        |
        v
Production track
        |
        v
Integrated z/OS engineering evidence
```

Representative paths include `JCL/JES2 → COBOL → Db2 → RACF → Scheduler` and `3270 → CICS → COBOL → Db2 → Security/Operational Evidence`. Only implemented and validated integrations should be presented as complete.

---

## Documentation Structure

```text
DB2-/
├── README.md
├── docs/
│   └── ECOSYSTEM-INTEGRATION.md
└── labs/
    ├── 01-db2-subsystem-catalog-foundations-part1/
    ├── 02-db2-catalog-introspection-objects-indexes-part2/
    ├── 03-db2-tables-datatypes-spufi-qmf/
    ├── 04-db2-spufi-racf-opercmds-incident/
    ├── 05-db2-sql-ddl-dml-fundamentals/
    ├── 06-db2-sql-subqueries-aggregation-top-n/
    └── 07-db2-null-not-null-default-constraints/
```

The root README is the repository navigation layer. Detailed implementation and evidence remain with the corresponding lab, while ecosystem ownership and integration planning remain in `docs/ECOSYSTEM-INTEGRATION.md`.

---

## Current Status

**Active engineering repository**

```text
01  Subsystem & catalog foundations
 ↓
02  Catalog introspection & objects
 ↓
03  Tables, data types & interactive SQL
 ↓
04  Operational/security incident
 ↓
05  DDL & DML
 ↓
06  Subqueries, aggregation & Top-N
 ↓
07  NULL / NOT NULL / DEFAULT
```

Future capabilities should be added only when supported by laboratory work or clearly marked as integration targets.

---

## Security and Publication Standard

Public evidence should demonstrate engineering methodology without unnecessarily exposing host-specific information. Before publication, screenshots, command output, configuration fragments, and evidence should be reviewed for credentials, secrets, private IP addresses, MAC addresses, host adapter identifiers, and other environment-specific information that does not need to be public.

---

## Continue Through the Portfolio

**[Portfolio Home](https://github.com/P-dot)** · **[Core z/OS](https://github.com/P-dot/zos-adcd-hercules-engineering-lab)** · **[CICS](https://github.com/P-dot/CICS)** · **[COBOL](https://github.com/P-dot/COBOL)** · **[RACF Security](https://github.com/P-dot/mainframe-racf-security-evidence)** · **[Workload Automation](https://github.com/P-dot/zos-batch-scheduler)**

---

> Part of the **IBM z/OS Mainframe Engineering Portfolio** — an independent hands-on environment focused on systems, operations, development, security, automation, diagnostics, and recovery.
