### Estado Inicial de la Base de Datos
Al ejecutar el programa por primera vez, el sistema valida la integridad de los datos. Si el archivo físico `EMPMPF` está vacío, la subfile se inicializa sin registros, manteniendo la estructura de cabecera y controles activa.
<img width="1062" height="623" alt="BDVACIO" src="https://github.com/user-attachments/assets/84b72913-0db2-4bf7-b75e-ce14f768728a" />

### Gestión y Carga de Datos
Tras la inserción de registros (ya sea mediante la función de alta F6 o carga masiva SQL), el programa utiliza punteros `SETLL` y `READ` para refrescar dinámicamente la lista de empleados.
<img width="871" height="476" alt="BDDATO" src="https://github.com/user-attachments/assets/e0c80e4a-90a8-40ab-827e-3f615f8b3799" />
