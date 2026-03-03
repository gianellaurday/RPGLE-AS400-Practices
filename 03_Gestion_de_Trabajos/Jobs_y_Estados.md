# ⚙️ Gestión de Trabajos (Jobs) y Monitoreo

En IBM i, cada acción que se realiza como: Compilar, ejecutar un programa, abrir una sesión, se considera un **Job**. Entender cómo monitorearlos es vital para asegurar que los procesos de negocio no se detengan.

### 1. Comandos de Monitoreo Principal

| Comando | Función |
| :--- | :--- |
| **WRKACTJOB** | Trabajar con Trabajos Activos. Es la vista principal para ver qué está consumiendo recursos en tiempo real. |
| **WRKSPLF** | Trabajar con Archivos de Spool. Aquí es donde revisamos los reportes de salida y, sobre todo, los **errores de compilación**. |
| **WRKJOB** | Permite ver los detalles de un trabajo específico (log, bibliotecas, variables). |

---

### 2. Estados Críticos de un Job

Uno de los aprendizajes más importantes fue identificar cuándo un proceso requiere intervención humana.

* **ACTIVE (ACT):** El trabajo se está ejecutando normalmente.
* **JOBQ:** El trabajo está en cola, esperando su turno para ejecutarse.
* **MSGW (Message Wait):** 🚩 **Estado crítico**. El trabajo se ha detenido porque ha encontrado un error o requiere una respuesta.


### 3. El Log del Trabajo y Severidad

Cuando un trabajo falla o envía un mensaje, el sistema categoriza la importancia del evento. En mis prácticas, identifiqué que:

* **Severity 00:** Información general.
* **Severity 10-20:** Advertencias (Warnings) que permiten que el proceso continúe.
* **Severity 30-40+:** Errores graves que suelen detener el Job o impedir la compilación.

* Si un programa se queda en `MSGW`, se usa la opción **7 (Display message)** en `WRKACTJOB` para leer el error y responder (C=Cancel, G=Go, D=Dump).
