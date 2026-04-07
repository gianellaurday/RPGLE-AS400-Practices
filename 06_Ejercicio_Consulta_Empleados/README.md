# 🗂️ Módulo: Mantenimiento Integral de Empleados (CRUD)

Este repositorio contiene los archivos fuente de un sistema interactivo en **IBM i (AS/400)** diseñado para gestionar el ciclo de vida completo de la información de empleados, integrando una consulta avanzada con capacidades de edición en tiempo real.

🎯 **Objetivo del Proyecto**
Demostrar y practicar el dominio en la arquitectura de capas dentro del entorno IBM i:
* **Base de Datos:** Definición de archivos físicos y lógicos en DB2.
* **Interfaz de Usuario:** Diseño de pantallas interactivas mediante DDS.
* **Lógica de Negocio:** Programación en **RPGLE (Fixed Format)** para el control de procesos y persistencia de datos.

---

## 📄 Descripción de Archivos

### 1. Base de Datos (DB2)
* **`EMPMPF.pf` (Physical File):** Define la tabla maestra. Utiliza tipos de datos empaquetados (`P`) para optimizar el almacenamiento de ID y Salario.
* **`EMPMLF.lf` (Logical File):** Vista lógica que permite el acceso ordenado por el campo `EMPNOM` (Nombre), facilitando búsquedas alfabéticas rápidas y el uso de operaciones posicionales.

### 2. Interfaz de Usuario (DDS)
* **`EMPMDF.dspf` (Display File):** Implementa una interfaz profesional "Pantalla Verde" que incluye:
    * **Subfiles (`SFL`/`SFLCTL`):** Para visualización masiva de datos y navegación.
    * **Ventanas Emergentes (`WINDOW`):** Formato `CONFIRMAR` para validación de borrado, mejorando la seguridad de la operación (UX).
    * **Formularios Dinámicos:** Formatos `REGNUEVO` y `REGEDITAR` para la entrada y modificación de datos.
    * **Control de Cursor:** Uso de `SFLRCDNBR` para mantener la posición del usuario tras las actualizaciones.

### 3. Lógica de Negocio (RPG)
* **`EMPMRPG.rpgle` (RPGLE):** Motor principal del sistema que orquesta la interacción.
    * **Procesamiento Eficiente:** Utiliza `READC` para identificar únicamente las filas modificadas por el usuario en el subfile, optimizando recursos del sistema.
    * **Operaciones I/O:** Implementa `CHAIN` para localización por llave, `UPDATE` para edición, `DELETE` para eliminación y `WRITE` para nuevas altas.
    * **Manejo de Indicadores:** Control de flujo mediante indicadores de respuesta (ej. `*IN90` para validación de existencia y `*IN12` para gestión de cancelaciones/salida).

---

## 💡 Notas Técnicas
* **Integridad de Datos:** El sistema garantiza que no se procesen registros inexistentes mediante validaciones previas a la actualización.
* **Experiencia de Usuario:** Uso de la palabra clave `OVERLAY` para evitar el parpadeo de pantalla (refresh) y permitir la superposición de la ventana de confirmación sobre la Consulta Maestra.
* **Optimización:** El uso de archivos lógicos permite que la función de búsqueda sea instantánea.
