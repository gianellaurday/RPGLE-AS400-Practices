# 🗂️ Módulo: Consulta Maestra de Empleados

Este directorio contiene los archivos fuente de un programa interactivo en AS400 (IBM i) diseñado para consultar, filtrar y gestionar el maestro de empleados de una compañía.

## 🎯 Objetivo del Proyecto
Demostrar el dominio en la separación de capas en AS400: Base de datos (Físicos/Lógicos), Interfaz de Usuario (DSPF / Subfiles) y Lógica de Negocio (RPGLE).

## 📄 Descripción de Archivos

* **`EMPMPF.pf` (Physical File):**
  Define la tabla base de datos. Contiene los campos fundamentales: ID del empleado, Nombre, Departamento y Salario.

* **`EMPMLF.lf` (Logical File):**
  Índice de base de datos construido sobre `EMPMPF`. Está ordenado por el campo Nombre (`EMPNOM`) para permitir búsquedas alfanuméricas de alto rendimiento mediante la operación `SETLL`.

* **`EMPMDF.dspf` (Display File):**
  Interfaz de usuario. Implementa:
  * Arquitectura de Subfiles (`SFL` y `SFLCTL`).
  * Paginación automática (`SFLSIZ 9999`, `SFLPAG 0012`).
  * Gestión de indicadores (71=Display, 72=Display Control, 74=Clear).
  * Retención de posición del cursor (`SFLRCDNBR`).
  * Búsqueda posicional por nombre de empleado.

* **`EMPMRPG.rpgle` (Programa RPGLE):**
  Programa de control para la lectura del archivo lógico y la carga dinámica de la pantalla utilizando operaciones de Record Level Access (`SETLL`, `READ`, `WRITE`, `EXFMT`).

## 💡 Notas Técnicas
El diseño de la pantalla utiliza la palabra clave `OVERLAY` en el pie de página para superponer los menús de navegación sin parpadeos, ofreciendo una experiencia de usuario fluida y estándar del entorno corporativo.
