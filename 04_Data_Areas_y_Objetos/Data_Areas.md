# 📌 Data Areas (*DTAARA)

En mis apuntes, se define una **Data Area** como un **"Post-it Global"**. Es un objeto del sistema que permite almacenar una pequeña cantidad de datos de forma persistente para que puedan ser consultados por diferentes programas.

### Comandos de Gestión
Basado en las capturas de mi entorno de trabajo:

| Comando | Función |
| :--- | :--- |
| **CRTDTAARA** | Crear una nueva área de datos. |
| **DSPDTAARA** | Visualizar el contenido y la estructura del área. |
| **CHGDTAARA** | Cambiar o actualizar los valores almacenados. |
| **DLTDTAARA** | Eliminar el objeto del sistema. |
| **RTVDTAARA** | Recuperar el valor desde un programa CL para usarlo en la lógica. |

### 🔍 Manipulación Avanzada (Substrings)

Se observa que no siempre se recupera toda la Data Area, sino que se trabaja por **posiciones**.

* **Lectura por Posición:** En mi ejercicio `PROCESO`, usé `DTAARA(GUI281/PROCESO (8 1))`. Esto significa que el sistema solo lee **1 carácter** empezando desde la **posición 8**.
* **Modificación Selectiva:** El comando `CHGDTAARA` también permite cambiar solo una parte. Ejemplo: `CHGDTAARA DTAARA(GUI281/PROCESO (1 7)) VALUE('AHORROS')` cambia los primeros 7 caracteres para poner la palabra "AHORROS" sin afectar el resto del objeto.

### 📋 Atributos Técnicos de una Data Area
Según la pantalla de "Display Object Description" de mis capturas:
* **Type:** `*DTAARA`.
* **Attribute:** Espacio para texto descriptivo (ej. "CONTROL DE PROCESOS").
* **Owner:** Usuario que la creó (ej. `GUI28`).
* **Library:** La biblioteca donde reside (ej. `GUI281`).
