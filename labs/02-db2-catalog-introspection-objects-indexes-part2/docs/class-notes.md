# Class Notes — Part 2

- `SYSIBM.SYSCOLUMNS` was used to introspect the catalog itself.
- `SYSIBM.SYSTABLESPACE` exposed database/table-space metadata.
- `SYSIBM.SYSTABLES` linked tables to `DBNAME` and `TSNAME`.
- `SYSIBM.SYSCOLUMNS` described the columns of `SYSTABLES`.
- `SYSIBM.SYSINDEXES` linked indexes to their tables.
- PF11/F11 Right was used when SPUFI output extended beyond the visible Browse width.

Final demonstrated hierarchy:
`SUBSYSTEM -> DATABASE -> TABLE SPACE -> TABLE -> COLUMN / INDEX`.
