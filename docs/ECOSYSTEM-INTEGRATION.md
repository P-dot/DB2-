# Db2 for z/OS — Ecosystem Integration

## Purpose

This document defines the role of the `DB2-` repository inside the broader z/OS Engineering Laboratory.

The repository is the Db2 for z/OS data-management and SQL learning layer. Its purpose is to build practical understanding of the Db2 subsystem, catalog, relational objects, SQL execution, integrity rules, troubleshooting, and the operational dependencies that connect Db2 to the rest of z/OS.

The repository does not attempt to reproduce every Db2 administration topic. It records work that has actually been executed and validated in the laboratory and distinguishes that work from future cross-repository integration.

Master architecture:

https://github.com/P-dot/zos-adcd-hercules-engineering-lab

---

## 1. Position in the ecosystem

The repository occupies the data-management layer of the laboratory:

```text
                     z/OS Engineering Laboratory
                               |
                +--------------+--------------+
                |                             |
          MVS / TSO / ISPF              RACF / Security
                |                             |
                +-------------+---------------+
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

Db2 therefore acts as both:

- a relational data platform used by applications; and
- a z/OS subsystem with operational and security dependencies.

This distinction is important. SQL knowledge alone is not sufficient to understand Db2 for z/OS in an operational environment.

---

## 2. Repository responsibility

`DB2-` owns the practical learning path for:

- Db2 subsystem foundations;
- DB2I;
- SPUFI;
- QMF where explicitly exercised;
- Db2 commands used inside the validated labs;
- Db2 catalog introspection;
- databases, table spaces, tables, columns and indexes;
- relational tables and common Db2 data types;
- SQL DDL;
- SQL DML;
- SELECT and result verification;
- aggregation;
- subqueries;
- correlated subqueries;
- Top-N query techniques;
- NULL semantics;
- NOT NULL constraints;
- DEFAULT behavior;
- SQLCODE/SQLSTATE diagnosis;
- documented Db2 operational incidents;
- Db2 interaction with RACF where directly demonstrated.

It produces evidence showing not only successful SQL execution but also failures, diagnosis, correction and final validation.

---

## 3. What this repository does not own

The repository does not replace the specialized repositories around it.

### TSO/E and ISPF

General TSO/E and ISPF operation belongs to:

```text
MVS_TSO_ISPF
```

Db2 uses that interactive environment through DB2I/SPUFI and related workflows, but this repository does not own general ISPF training.

### JCL and JES2

General batch construction, JOB/EXEC/DD semantics, procedures and JES2 execution patterns belong to:

```text
JCL_LABS
```

Future Db2 batch execution may consume those capabilities rather than duplicating them here.

### RACF

General RACF administration, profile design, least privilege, auditing and security engineering belong to:

```text
mainframe-racf-security-evidence
```

The Db2 repository records RACF behavior only where it directly affects a Db2 workflow or incident.

### COBOL

COBOL language fundamentals belong to:

```text
COBOL
```

Future COBOL-to-Db2 work should integrate the repositories instead of turning `DB2-` into another COBOL course.

### CICS

CICS resource definition, transaction processing and CICS administration belong to:

```text
CICS
```

Future CICS/COBOL/Db2 work should be treated as a cross-repository application path.

### Batch scheduling

Job ordering, dependencies, conditions, resources, execution state, restart policy and production-control behavior belong to:

```text
zos-batch-scheduler
```

The scheduler may eventually control Db2-related batch workloads, but scheduler semantics do not belong in this repository.

### Core z/OS engineering

System initialization, JES2, SMF, WLM, storage, dumps, recovery and other system-engineering subjects belong primarily to:

```text
zos-adcd-hercules-engineering-lab
```

---

## 4. Upstream dependencies

The validated Db2 work depends on several capabilities supplied elsewhere in the ecosystem.

### MVS_TSO_ISPF

Provides the interactive entry path used to reach DB2I, SPUFI, members, output and related panels.

Conceptual path:

```text
3270 / TN3270
      |
      v
   TSO/E
      |
      v
    ISPF
      |
      v
    DB2I
      |
      +----> SPUFI
      |
      +----> Db2 commands / utilities used by the lab
```

### Core z/OS environment

The central engineering laboratory provides the operating environment in which the Db2 subsystem runs.

Db2 is therefore not treated as an isolated SQL engine.

### RACF

Security controls can affect Db2 availability and operational commands.

This dependency is not merely theoretical: Lab 04 records a real failure chain in which RACF `OPERCMDS` authorization affected an MVS START path required by Db2.

---

## 5. Validated repository progression

The current repository contains seven practical stages.

## Lab 01 — Db2 subsystem and catalog foundations

Validated areas include:

- entry into DB2I;
- Db2 command execution;
- thread observation;
- DDF status observation;
- SPUFI entry;
- catalog SQL;
- real SQL troubleshooting;
- distinction between a Db2 subsystem and a database.

The lab deliberately retains failed attempts and diagnosis.

A catalog query produced `SQLCODE -206 / SQLSTATE 42703`, establishing the need to inspect the actual catalog structure rather than assume column names.

Validated conceptual path:

```text
TSO/ISPF
   |
 DB2I
   |
   +---- Db2 commands
   |
   +---- SPUFI
            |
            v
       SYSIBM catalog
```

---

## Lab 02 — Catalog introspection, objects and indexes

Lab 02 continues from the catalog failure rather than hiding it.

It validates the hierarchy:

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

The practical troubleshooting sequence includes:

```text
SQLCODE -206
     |
     v
catalog introspection
     |
     v
qualification problem
     |
SQLCODE -204
     |
     v
explicit SYSIBM qualification
     |
     v
successful catalog query
```

This establishes catalog introspection as a diagnostic technique, not merely a source of metadata.

EXPLAIN, access-path analysis, clustering strategy, index design and performance tuning remain outside the validated scope of this lab.

---

## Lab 03 — Tables, data types, SPUFI and QMF

Lab 03 moves from catalog inspection to a user relational object.

Validated concepts include:

- tables;
- rows;
- columns;
- INTEGER;
- SMALLINT;
- DECIMAL;
- CHAR;
- VARCHAR;
- DATE;
- TIME;
- CREATE TABLE;
- INSERT;
- SELECT;
- SPUFI;
- QMF.

The same logical SELECT was exercised through SPUFI and QMF.

Validated relationship:

```text
             Db2 table
                 |
              SELECT
                 |
          +------+------+
          |             |
        SPUFI           QMF
          |             |
       output          report
```

This lab establishes the bridge from Db2 architecture into practical relational SQL.

---

## Lab 04 — SPUFI outage and RACF OPERCMDS incident

Lab 04 is the repository's first major cross-domain integration case.

The initial symptom appeared in Db2/DB2I/SPUFI, but the root cause was outside SQL.

The validated failure chain was:

```text
RACF / OPERCMDS hardening
          |
          v
MVS START authorization
          |
          v
insufficient required authority
          |
          v
ICH408I
          |
          v
Db2 startup path affected
          |
          v
Db2 abnormal termination / unavailable service
          |
          v
DB2I / SPUFI unavailable
```

Investigation used operational evidence to distinguish the root cause from secondary symptoms.

The lab also distinguishes SVC dump allocation problems from the authorization failure that caused the service disruption.

After correction/rollback of the security behavior and Db2 restart, SPUFI operation was validated again.

This demonstrates a real ecosystem relationship:

```text
RACF
  |
OPERCMDS
  |
MVS START
  |
Db2 subsystem
  |
DB2I / SPUFI
```

This relationship is **validated**, not merely planned.

The detailed RACF security model remains owned by the RACF repository.

---

## Lab 05 — SQL DDL and DML fundamentals

Lab 05 establishes the practical difference between schema/object operations and row manipulation.

Validated sequence:

```text
CREATE
  |
INSERT
  |
SELECT
  |
ALTER
  |
UPDATE
  |
DELETE
  |
SELECT
  |
DROP
  |
negative SELECT
```

DDL exercised:

- CREATE TABLE;
- ALTER TABLE;
- DROP TABLE.

DML exercised:

- INSERT;
- UPDATE;
- DELETE.

SELECT is used for query and validation.

The final negative SELECT after DROP returned an undefined-object error, demonstrating the difference between deleting rows and removing the table itself.

COMMIT/ROLLBACK is explicitly outside this lab's teaching scope.

---

## Lab 06 — Subqueries, aggregation and Top-N

Lab 06 extends SQL beyond basic DDL/DML.

Validated areas include:

- ORDER BY;
- MAX;
- nested queries;
- correlated subqueries;
- aliases;
- COUNT;
- second-highest-value queries;
- Top-N logic;
- generalization from Top-3 to Top-2;
- SQL syntax troubleshooting.

A real `SQLCODE -104 / SQLSTATE 42601` was diagnosed as a syntax problem caused by an extra comma.

The repository therefore preserves an important engineering rule:

```text
Observed failure
      |
      v
inspect statement
      |
      v
identify exact syntax defect
      |
      v
correct
      |
      v
execute again
      |
      v
validate result
```

---

## Lab 07 — NULL, NOT NULL and DEFAULT constraints

Lab 07 moves into data integrity and nullability.

Validated behavior includes:

- nullable columns;
- `IS NULL`;
- NOT NULL enforcement;
- defaulted values;
- distinction between a visually empty value and SQL NULL;
- deliberate integrity failure;
- rejected-row verification;
- successful valid NULL insertion.

The negative test produced:

```text
SQLCODE -407
SQLSTATE 23502
```

The rejected operation was then verified not to have produced the prohibited row.

This lab therefore introduces integrity enforcement as observable Db2 behavior rather than only a theoretical table-definition concept.

---

## 6. Current validated capability map

The repository currently demonstrates:

```text
Db2 subsystem
      |
      +---- DB2I
      |
      +---- operational commands
      |
      +---- DDF observation
      |
      +---- SPUFI
      |       |
      |       +---- catalog queries
      |       +---- DDL
      |       +---- DML
      |       +---- SELECT
      |       +---- subqueries
      |       +---- integrity tests
      |
      +---- QMF
      |       |
      |       +---- SQL query/report comparison
      |
      +---- SYSIBM catalog
      |       |
      |       +---- database
      |       +---- table space
      |       +---- table
      |       +---- column
      |       +---- index
      |
      +---- RACF operational dependency
              |
              +---- OPERCMDS
              +---- MVS START authorization
```

These are validated repository capabilities.

They should not be confused with the planned integrations described later in this document.

---

## 7. Inputs consumed by the repository

The Db2 learning path consumes:

- an operational z/OS environment;
- an available Db2 for z/OS subsystem;
- TSO/E;
- ISPF;
- DB2I;
- SPUFI;
- QMF where used;
- PDS/member-based SQL input;
- Db2 catalog services;
- Db2 command facilities;
- SDSF/SYSLOG evidence for operational troubleshooting;
- RACF behavior where it affects subsystem operation;
- controlled user-owned Db2 objects for practical SQL work.

---

## 8. Outputs produced by the repository

The repository produces:

- SQL source;
- catalog queries;
- user-table definitions;
- DDL examples;
- DML examples;
- query examples;
- integrity tests;
- SPUFI execution evidence;
- QMF comparison evidence;
- SQLCODE/SQLSTATE troubleshooting records;
- incident timelines;
- operational findings;
- screenshots/evidence;
- documentation of successful and failed paths;
- reusable knowledge for future COBOL, CICS and batch integration.

---

## 9. Validated cross-repository integration

At present, one particularly important cross-domain relationship has already been demonstrated directly.

### RACF → MVS START → Db2

Lab 04 proves that a security change outside Db2 can affect Db2 availability.

```text
mainframe-racf-security-evidence concepts
                 |
                 v
          RACF OPERCMDS
                 |
                 v
          MVS START path
                 |
                 v
          Db2 subsystem
                 |
                 v
           DB2I / SPUFI
```

The incident is retained in `DB2-` because the service impact and troubleshooting occurred in the Db2 learning path.

The deeper security model belongs to the RACF repository.

This is an example of the ecosystem principle:

> A subsystem failure must be diagnosed across z/OS boundaries rather than assuming that the visible component is the root cause.

---

## 10. Planned application integration

The following paths are architectural targets. They are **not presented as completed by this repository**.

### COBOL → Db2

Planned path:

```text
COBOL
  |
  v
Db2 application access
  |
  v
SQL
  |
  v
Db2 data
```

The COBOL repository should retain ownership of COBOL language concepts.

`DB2-` should retain ownership of the database objects, SQL behavior and Db2-specific diagnostics.

Future work may include embedded SQL and the Db2 application-programming lifecycle when actually implemented and validated.

---

### CICS → COBOL → Db2

Planned online-transaction path:

```text
CICS transaction
       |
       v
  COBOL program
       |
       v
      Db2
       |
       v
transactional data
```

The repositories should remain separate:

```text
CICS   -> transaction/resource layer
COBOL  -> application-language layer
DB2-   -> relational-data layer
```

The integration should prove the interfaces between them instead of duplicating each repository's fundamentals.

---

### Scheduler → JCL/JES2 → Db2 workload

Planned batch-production path:

```text
zos-batch-scheduler
        |
        v
       JCL
        |
        v
      JES2
        |
        v
Db2-related batch workload
        |
        v
   RC / failure state
        |
        v
    Scheduler
```

The scheduler decides and controls execution.

JCL describes the workload.

JES2 executes the job.

Db2 provides the database service used by the workload.

This path becomes valid only after the corresponding scheduler and Db2 batch work has actually been implemented and evidenced.

---

## 11. Planned secure batch application track

A future cross-repository track can combine:

```text
Scheduler
    |
   JCL
    |
  JES2
    |
  COBOL
    |
   Db2
    |
result / RC
```

with cross-cutting controls:

```text
RACF
SMF
SDSF
```

The objective is not simply to execute SQL from a program.

The eventual engineering flow should demonstrate:

1. controlled job ordering;
2. JCL execution;
3. application invocation;
4. Db2 access;
5. success or controlled failure;
6. observable RC/SQL failure;
7. operational diagnosis;
8. security enforcement;
9. scheduler state/history;
10. recovery or rerun where appropriate.

Until those steps are implemented, they remain roadmap items.

---

## 12. Planned online transaction track

A second future track is:

```text
RACF
  |
 CICS
  |
COBOL
  |
 Db2
  |
 SMF / operational evidence
```

This would demonstrate an online application path rather than a batch path.

The Db2 repository should contribute:

- database objects;
- SQL behavior;
- integrity rules;
- Db2-specific diagnostics;
- relevant evidence.

It should not absorb CICS administration or COBOL fundamentals.

---

## 13. Troubleshooting philosophy

The existing labs establish a consistent diagnostic method:

```text
Build
  |
Execute
  |
Observe
  |
Diagnose
  |
Correct
  |
Validate
  |
Document
```

Failures are retained when they provide engineering value.

Examples already preserved include:

- invalid Db2 command attempts;
- `SQLCODE -206`;
- `SQLCODE -204`;
- `SQLCODE -104`;
- `SQLCODE -407`;
- RACF `ICH408I`;
- Db2 abnormal termination associated with an authorization problem;
- secondary dump-allocation problems distinguished from the actual root cause.

The repository should continue to avoid rewriting history into an artificial sequence of perfect executions.

---

## 14. Evidence discipline

A completed Db2 lab should make it possible to determine:

- what was attempted;
- what object or subsystem was involved;
- what command or SQL was executed;
- what Db2 returned;
- whether the result was expected;
- what failed;
- why it failed when the cause is known;
- what correction was applied;
- what final validation proved completion.

Negative tests are first-class evidence when they demonstrate a real rule.

Examples include:

```text
DROP TABLE -> later SELECT fails because the object no longer exists
```

and:

```text
NOT NULL violation -> SQLCODE -407 -> rejected row absent
```

---

## 15. Separation of validated and planned states

Documentation must distinguish these states explicitly.

### Validated

A capability may be described as validated when it has been executed in the laboratory and supported by the repository's evidence.

Current examples:

- DB2I/SPUFI operation;
- catalog introspection;
- object hierarchy exploration;
- user-table creation;
- SPUFI/QMF query comparison;
- DDL/DML;
- aggregation/subqueries/Top-N;
- NULL and integrity behavior;
- RACF OPERCMDS impact on Db2 startup/service availability.

### Planned

A capability must remain marked as planned until implementation and evidence exist.

Current examples include:

- embedded SQL from COBOL;
- COBOL/Db2 application build lifecycle;
- CICS/COBOL/Db2 transaction flow;
- scheduler-controlled Db2 batch;
- advanced COMMIT/ROLLBACK teaching labs;
- EXPLAIN/access-path analysis;
- performance tuning;
- advanced index design;
- production-style Db2 recovery integration.

No roadmap statement should be written as if it were already completed.

---

## 16. Relationship with JCL_LABS

`JCL_LABS` is the batch-language foundation.

The intended relationship is:

```text
JCL_LABS
   |
   v
reusable batch execution patterns
   |
   v
Db2-related application or utility workload
```

`DB2-` should not re-teach basic JOB, EXEC and DD semantics.

When a Db2 lab requires batch JCL, the Db2 repository should document only the Db2-specific reason for that JCL and link the general batch concept back to `JCL_LABS`.

---

## 17. Relationship with COBOL

The intended separation is:

```text
COBOL repository
    |
    | owns
    v
language syntax
data definitions
program structure
compile/link/run fundamentals
    |
    +-----------------------+
                            |
                            v
                     application SQL
                            |
                            v
                       DB2- repository
                            |
                            | owns
                            v
                     database objects
                     SQL behavior
                     integrity
                     Db2 diagnostics
```

This avoids creating parallel copies of the same COBOL material.

---

## 18. Relationship with CICS

The CICS repository owns transaction-processing and resource concepts.

The Db2 repository owns relational-data behavior.

A future integration should therefore be documented as an interface:

```text
CICS -> COBOL -> Db2
```

not as a merger of the three learning tracks.

---

## 19. Relationship with RACF

RACF is a cross-cutting control plane.

The Db2 repository has already demonstrated why this matters operationally.

Lab 04 establishes that:

```text
visible Db2 outage
       !=
automatic proof of Db2 root cause
```

The investigation crossed:

```text
DB2I/SPUFI
   |
 Db2 messages
   |
 SYSLOG
   |
 RACF ICH408I
   |
 OPERCMDS
   |
 MVS START authorization
```

Future security integrations should preserve the same boundary:

- Db2 documents the database/service impact;
- RACF documentation owns the authorization model and security design.

---

## 20. Relationship with the scheduler

The scheduler repository is an orchestration layer above JES2.

The future relationship is:

```text
Scheduler decides
       |
JCL describes
       |
JES2 executes
       |
application uses Db2
       |
RC / SQL result observed
       |
Scheduler reacts
```

The Db2 repository must not implement its own scheduler.

The scheduler repository must not duplicate Db2 SQL teaching.

---

## 21. Relationship with the core engineering laboratory

The central repository provides the system-level context in which Db2 operates.

Relevant shared concerns may include:

- subsystem availability;
- started-task behavior;
- JES2;
- SDSF;
- SMF;
- storage;
- dumps;
- WLM;
- backup/recovery;
- system diagnostics.

Where a Db2 exercise crosses one of these areas, the specialized Db2 evidence should link to the core system concept rather than reproduce an entire system-engineering lab.

---

## 22. Publication and security rules

Public material must be reviewed before publication.

Do not expose:

- passwords;
- credentials;
- private keys;
- tokens;
- private IP addresses;
- MAC addresses;
- host adapter identifiers;
- host-only networking details;
- terminal/session identifiers when they unnecessarily identify the environment;
- sensitive host-side paths or configuration details.

Screenshots must be reviewed as carefully as text files.

The repository already demonstrates this principle: network-related evidence from the early Db2/DDF work was sanitized before publication.

A useful publication check is:

```text
source
  |
  +---- documentation review
  |
  +---- screenshot review
  |
  +---- IP/MAC scan
  |
  +---- credential review
  |
  v
safe public evidence
```

---

## 23. Repository structure and publication units

The current repository uses independent lab directories:

```text
labs/
  01-db2-subsystem-catalog-foundations-part1/
  02-db2-catalog-introspection-objects-indexes-part2/
  03-db2-tables-datatypes-spufi-qmf/
  04-db2-spufi-racf-opercmds-incident/
  05-db2-sql-ddl-dml-fundamentals/
  06-db2-sql-subqueries-aggregation-top-n/
  07-db2-null-not-null-default-constraints/
```

These should remain separate publication units.

Lab 04 in particular should remain a focused operational/security incident rather than being merged into the SQL progression.

Its value comes from preserving the real troubleshooting boundary.

---

## 24. Recommended integration branch model

Cross-repository work should use short-lived branches.

Examples:

```text
integration/cobol-db2
integration/cics-cobol-db2
integration/scheduler-cobol-db2
integration/racf-db2-operations
integration/end-to-end-production-cycle
```

Normal lifecycle:

```text
main
 |
 +--> short-lived integration branch
          |
          +--> implementation
          +--> evidence
          +--> security review
          +--> validation
          +--> documentation
          |
          v
         PR
          |
          v
        main
          |
          v
    delete branch
```

Permanent technology branches are not required.

---

## 25. Current maturity

The repository has moved beyond a single SQL tutorial.

It currently contains:

```text
Foundations
    |
Catalog
    |
Relational objects
    |
SPUFI / QMF
    |
Operational incident
    |
DDL / DML
    |
Advanced query patterns
    |
Integrity constraints
```

This creates a useful foundation for application integration.

However, the following should not yet be presented as complete:

```text
COBOL + Db2
CICS + COBOL + Db2
Scheduler + Db2 batch
full transactional recovery
performance engineering
production-style application lifecycle
```

Those are the next architectural layers, not current validated achievements.

---

## 26. Target ecosystem role

The long-term role of `DB2-` is:

> Provide the validated Db2 for z/OS relational-data, SQL, catalog, integrity and database-diagnostic layer consumed by the application and operations tracks of the z/OS Engineering Laboratory.

In practical terms:

```text
                 RACF
                   |
                   v
JCL / Scheduler -> COBOL -> Db2 <- CICS
                   |        |
                   |        +--> SQL / catalog / integrity
                   |
                   +------------ application logic

                         |
                         v
                 operational evidence
                         |
                  SDSF / SMF / logs
```

Each repository remains independently understandable, while integration labs prove how the components behave together.

---

## 27. Current integration status

| Integration path | State |
|---|---|
| TSO/ISPF → DB2I → SPUFI | Validated |
| SPUFI → Db2 catalog | Validated |
| Catalog → database/table space/table/column/index introspection | Validated |
| SPUFI → user table DDL/DML | Validated |
| QMF → same relational query path | Validated |
| SQL → aggregation/subqueries/Top-N | Validated |
| SQL → NULL/NOT NULL integrity enforcement | Validated |
| RACF OPERCMDS → MVS START → Db2 availability | Validated |
| COBOL → Db2 | Planned |
| CICS → COBOL → Db2 | Planned |
| Scheduler → JCL/JES2 → Db2 workload | Planned |
| End-to-end production cycle using Db2 | Planned |

---

## 28. Engineering rule

The repository should continue to follow one central rule:

> Document what the system actually did, not what the lab was expected to do.

That means retaining useful SQLCODEs, authorization failures, operational messages and failed hypotheses when they explain the engineering process.

The result is not simply a collection of SQL examples.

It is a progressive record of how Db2 for z/OS behaves as part of a larger z/OS system.
