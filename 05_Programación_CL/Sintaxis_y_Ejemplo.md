# 💻 Programación en Control Language (CL)

El CL es el lenguaje que utilizamos para administrar el entorno del sistema y controlar la ejecución de otros programas.

### Reglas de Sintaxis Fundamentales
Según mis notas de aprendizaje:
* **Inicio y Fin:** Todo programa debe empezar con el comando `PGM` y terminar con `ENDPGM`.
* **Variables:** Siempre se identifican con el símbolo ampersand (`&`).
* **Declaración:** Se usa el comando `DCL` al inicio del código.
* **Estructuras:** Los bloques `IF` deben cerrarse siempre con un `ENDDO`.

### Tipos de Datos
* `*CHAR`: Caracteres (letras y números tratados como texto).
* `*DEC`: Números decimales (máximo 15 dígitos según el estándar).
* `*LGL`: Booleano (0 para *OFF/False, 1 para *ON/True).
* `*INT`: Números enteros.

### Ejemplo de Código: Programa PRUEBA2
Este es el código que desarrollé para practicar la recuperación de valores y toma de decisiones:

```cl
/* PROCESO GENERAL */
PGM PARM(&FECHA)

/* DECLARACIÓN DE VARIABLES */
DCL VAR(&FLAG96) TYPE(*CHAR) LEN(1)
DCL VAR(&FECHA)  TYPE(*CHAR) LEN(8)

REPITE:
/* RECUPERAR VALOR DE LA DATA AREA (POSICIÓN 8, LONGITUD 1) */
RTVDTAARA DTAARA(GUI281/PROCESO (8 1)) RTNVAR(&FLAG96)

/* CASO 1: PROCESO NO LISTO (FLAG VACÍO) */
IF COND(&FLAG96 *EQ ' ') THEN(DO)
    SNDMSG MSG('AUN NO DEBE EJECUTARSE EL PROCESO ' *TCAT &FECHA) +
           MSGTYPE(*INFO) TOMSGQ(QSYSOPR)
    DLYJOB DLY(60)
    GOTO CMDLBL(REPITE)
ENDDO

/* CASO 2: EJECUCIÓN DIARIA */
IF COND(&FLAG96 *EQ 'D') THEN(DO)
    SNDMSG MSG('VA A EJECUTARSE EL PROCESO DIARIO ' *TCAT &FECHA) +
           MSGTYPE(*INFO) TOUSR(GUI28)
    CALL GUI281/PRUEBA3
ENDDO

ENDPGM
