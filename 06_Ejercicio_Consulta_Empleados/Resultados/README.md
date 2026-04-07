# 🖥️ Módulo: Consulta Maestra de Empleados (AS400)

![Estado del Proyecto](https://img.shields.io/badge/Estado-Finalizado-success?style=for-the-badge&logo=github)
![Lenguaje Principal](https://img.shields.io/badge/Lenguaje-RPG_IV_Fixed-blue?style=for-the-badge&logo=ibm)
![Plataforma](https://img.shields.io/badge/Plataforma-IBM_i_/_AS400-8A2BE2?style=for-the-badge)

---

## 🚀 Objetivo del Proyecto

Este repositorio contiene el código fuente completo para un programa interactivo diseñado para consultar, filtrar y gestionar el maestro de empleados de una compañía en un entorno **AS400 (IBM i)**.

El objetivo principal es demostrar el dominio en la arquitectura de **separación de capas**:
1.  **Base de Datos:** (Físicos y Lógicos)
2.  **Interfaz de Usuario:** (DSPF / Subfiles)
3.  **Lógica de Negocio:** (RPGLE)

---

## 📸 Demostración Visual (Resultados)

Aquí puedes ver cómo luce la aplicación interactiva funcionando en el emulador de terminal.

<p align="center">
  <img width="50%" height="50%" alt="Captura de Pantalla 2026-04-07 a la(s) 11 12 29" src="https://github.com/user-attachments/assets/1027a2fa-6e9a-457b-b19d-33a3cdd88732" />
  <br>
  <em>Imagen 1: Estado inicial de la base de datos (sin registros).</em>
</p>

<p align="center">
  <img width="50%" height="50%" alt="Captura de Pantalla 2026-04-07 a la(s) 11 39 24" src="https://github.com/user-attachments/assets/bfe08fd1-53b2-4332-a485-919e240a11e2" />
  <br>
  <em>Imagen 2: Pantalla para crear nuevo empleado.</em>
</p>

<p align="center">
  <img width="50%" height="50%" alt="Captura de Pantalla 2026-04-07 a la(s) 11 38 49" src="https://github.com/user-attachments/assets/8a5e203f-b9b1-4e58-90ab-1fb1bfe46760" />
  <br>
  <em>Imagen 3: Lista de empleados ordenada alfabéticamente.</em>
</p>
---

## 🛠️ Descripción de Archivos y Arquitectura

He estructurado el proyecto siguiendo las mejores prácticas de desarrollo en AS400. Así es como se conectan los archivos:

### 📦 Estructura del Directorio

```text
06_Ejercicio_Consulta_Empleados/
├── ✨ Resultados/             <-- Capturas de la app corriendo
│   └── README.md
├── 🖥️ empmdf.dspf           <-- Interfaz (Pantalla)
├── 📂 empmpf.pf             <-- Base de Datos (Físico)
├── 🔍 empmlf.lf             <-- Base de Datos (Lógico, por Nombre)
├── ⚙️ empmrpg.rpgle         <-- Lógica del Programa (RPG)
└── 📝 README.md
