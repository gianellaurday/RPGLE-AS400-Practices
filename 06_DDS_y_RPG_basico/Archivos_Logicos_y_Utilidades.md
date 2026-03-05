# 🗂️ Archivos Lógicos (*LF) y utilidades de Datos

En esta sección final de mis apuntes sobre datos, documento cómo estructurar accesos eficientes a la información y herramientas de edición rápida.

### 1. Archivos Lógicos (*LF)
A diferencia de los Archivos Físicos (*PF) que contienen los datos reales, un **Archivo Lógico** es una vista que nos permite acceder a la información de forma ordenada o filtrada sin duplicar los datos.

* **PFILE:** Palabra clave obligatoria en la DDS de un lógico para indicar cuál es su archivo físico de referencia.
* **K (Key):** Define el orden de acceso. Podemos tener un PF ordenado por DNI, pero un LF ordenado por Apellido.
* **Ventaja:** Permite que diferentes programas vean los mismos datos con diferentes ordenamientos o filtros de campo.

### 2. Comandos de Manipulación de Datos
Durante las prácticas, utilizamos herramientas para interactuar directamente con los registros:

| Comando | Función |
| :--- | :--- |
| **UPDDTA** | (Update Data) Herramienta rápida para modificar, añadir o borrar registros de un archivo físico sin necesidad de un programa. |
| **RUNQRY *NONE** | Ejecuta una consulta rápida sobre un archivo para visualizar todos sus campos y registros de forma tabular. |

### 3. El Ciclo de Desarrollo RPG (Resumen)
Basado en todo lo documentado, mi flujo de trabajo en el bootcamp fue:
1. Definir la estructura en **DDS** (PF y LF).
2. Escribir la lógica en **RPG** (Specs H, F, D, C).
3. Gestionar el proceso mediante **CL** y monitorear con **WRKACTJOB**.

---
> **Nota de aprendizaje:** Entender la relación entre el PFILE y el Archivo Lógico fue clave para optimizar las consultas en los programas de batch bancario que analizamos.
