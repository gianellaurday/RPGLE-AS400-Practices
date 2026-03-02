# ⌨️ Fundamentos del Entorno IBM i: Atajos de Teclado

Una de las primeras barreras al interactuar con sistemas legacy como el AS400 es la navegación puramente basada en teclado (Pantalla verde / Emulador 5250). 

Se documenta los atajos fundamentales y teclas de función (F-keys) necesarios para operar de manera eficiente en el sistema, basados en mis apuntes del bootcamp de NTT DATA.

### Teclas de Función Principales (F-Keys)

| Tecla | Descripción | Nota de Uso |
| :--- | :--- | :--- |
| **F1** | Ayuda contextual | Muestra información del campo donde está el cursor. |
| **F3** | **Salir / Volver a la pantalla anterior** | *Comando crítico para navegación segura.* |
| **F4** | **Solicitud de valores (Prompt)** | *Despliega opciones para un comando escrito.* |
| **F5** | Refrescar / Renovar pantalla | Útil para actualizar el estado de los *Jobs*. |
| **F6** | Crear | Para archivos, programas, miembros, etc. |
| **F7** | Retroceder página (Page Up) | |
| **F8** | Avanzar página (Page Down) | |
| **F9** | **Recuperar comando anterior** | *Ahorra tiempo al evitar reescribir comandos largos.* |
| **F10** | Entrada directa de comandos | |
| **F11** | Cambiar vista / Visualizar detalles | |
| **F12** | **Cancelar / Volver sin guardar** | *Comando crítico para salir de una pantalla sin alterar datos.* |
| **F13** | Cambiar valores predeterminados | Se activa con `Shift + F1`. |
| **F14** | Opciones adicionales | |
| **F15** | Submenú / Funciones adicionales | |
| **F19-24**| Funciones extendidas | Varían según la pantalla (ej. `Shift + F7` para F19). |

---

### Teclas de Navegación y Edición

* **Control (Ctrl / Reset):** Esencial para **desbloquear el teclado**. Cuando el emulador arroja un error o procesa un dato incorrecto, el teclado se bloquea (aparece un candado o una 'X' en la parte inferior). Presionar Control libera el terminal para seguir escribiendo.
* **Av Pág / Re Pág (Page Down / Page Up):** Se utilizan para moverse entre páginas, especialmente cuando en la esquina inferior del sistema aparece el indicador **"More..."** o **"Más..."**.
* **Enter:** Ejecuta la opción ingresada o confirma la acción en pantalla.
* **Tab:** Avanza entre campos de entrada.
* **Shift + Tab:** Retrocede entre campos de entrada.
* **Espacio:** Permite seleccionar opciones (ej. poner un `1` o `2` al lado de un objeto) o limpiar campos.
* **Backspace:** Borra caracteres hacia la izquierda.
* **Supr / Delete:** Borra caracteres hacia la derecha (depende de la configuración del emulador).
