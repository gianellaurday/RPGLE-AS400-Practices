# 📂 Estructura de Objetos y Navegación PDM

Para trabajar con facilidad en AS400, es fundamental comprender cómo se organiza la información. A diferencia de Windows (Carpetas/Archivos), el IBM i utiliza una jerarquía de contenedores lógicos.

### 1. La Jerarquía de Contenedores

Basado en mi análisis del sistema, la estructura se divide en tres niveles:

* **Biblioteca (Library - *LIB):** Es el contenedor de nivel superior, el contenedor raíz como una 'biblioteca'. Ejemplo: `GUI281`.
* **Objeto (Object - *OBJ):** Dentro de una biblioteca existen objetos de distintos tipos, que se le puede tomar como 'carpetas'. Ejemplo: `QRPGLESRC`, `QCLSRC`.
* **Miembro (Member - *MBR):** Es donde reside el código fuente real. Sería el 'archivo individual'. Ejemplo: `PROG01`, `REPORTE02`.



---

### 2. Gestión con PDM (Program Development Manager)

El PDM es la herramienta principal para navegar por esta jerarquía. Los comandos clave que utilizo son:

| Comando | Función |
| :--- | :--- |
| **STRPDM** | Menú principal del Program Development Manager. |
| **WRKLIBPDM** | Trabajar con bibliotecas. |
| **WRKOBJPDM** | Trabajar con objetos dentro de una biblioteca. |
| **WRKMBRPDM** | Trabajar con los miembros (código fuente) de un archivo. |

### 3. Opciones Rápidas en PDM
Dentro de las pantallas de PDM, utilizo estas opciones numéricas para agilizar el desarrollo:
* **2 (Edit):** Abre el editor SEU para modificar el código.
* **3 (Copy):** Duplicar un miembro o objeto.
* **4 (Delete):** Eliminar (requiere confirmación).
* **5 (Display):** Solo lectura.
* **14 (Compile):** Envía el código a compilar.

* **Comando clave:** `DSPFFD` (Display File Field Description), que nos permitía auditar la estructura de los campos y asegurar que la lógica de negocio coincidiera con los datos almacenados.
