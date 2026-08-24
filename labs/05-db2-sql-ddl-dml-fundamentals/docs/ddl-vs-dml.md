# DDL frente a DML

DDL (Data Definition Language) cambia la definición de objetos: CREATE, ALTER y DROP.

DML (Data Manipulation Language) cambia los datos almacenados: INSERT, UPDATE y DELETE.

La diferencia quedó demostrada en el laboratorio: DELETE eliminó una fila pero LAB02 siguió consultable; DROP eliminó LAB02 y el SELECT posterior devolvió -204.
