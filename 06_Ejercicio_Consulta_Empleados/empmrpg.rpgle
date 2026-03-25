     H* ==========================================================
     H* PROGRAMA: EMPMRPG (RPG IV - FIXED FORMAT)
     H* AUTOR   : GIANELLA
     H* CONSULTA MAESTRA DE EMPLEADOS
     H* ==========================================================

     F* ==========================================================
     F* DEFINICION DE ARCHIVOS
     F* ==========================================================
     F* DISPLAY FILE
     F* 'C' = COMBINED, IN AND OUT, 'F' = F.PROCEDURAL 'E' = EXTERNO
     F* WORKSTN PARA PANTALLA INTERACTIVA
     FEMPMDF    CF   E             WORKSTN
     F                                     SFILE(SFL01:RRN)

     F* LOGICAL FILE
     F* 'I' = INPUT, 'F' = F.PROCEDURAL, 'E' = EXTERNO
     F* 'K' = HAY UNA VARIABLE KEY
     F* EL ARCHIVO ESTÁ EN EL DISCO LOCAL
     FEMPMLF    IF   E           K DISK

     F* PHYSICAL FILE
     F* 'U' = UPDATE, 'A' = ADD PARA HACER WRITE AL CREAR DATOS
     FEMPMPF    UF A E           K DISK
     F* SE CAMBIA EL NOMBRE SOLO DENTRO DE LA MEMORIA. PARA QUE NO HAYA PROBLEMAS
     F                                     RENAME(REMPM:RNUEVO)

     D* ==========================================================
     D* DEFINICION DE VARIABLES GLOBALES
     D* ==========================================================
     D* RRN (Relative Record Number): CONTADOR DE FILAS
     D* VARIABLE NUMERICA SIN DECIMALES
     D RRN             S              4S 0

     C* ==========================================================
     C* RUTINA PRINCIPAL
     C* ==========================================================
     C* CAMPO DE BUSQUEDA LIMPIO AL INICIAR
     C                   EVAL      BUSNOM = *BLANKS
     C* SUBRUTINA CARGADATOS MUESTRA LOS DATOS DISPONIBLES
     C                   EXSR      CARGADATOS

     C* MIENTRAS NO SE PRESIONE F3 SEGUIR EN LA PANTALLA
     C                   DOW       *IN03 = *OFF
     C                   WRITE     FOOTER
     C                   EXFMT     SFLCTL01

     C* SI PRESIONA F3, SALE DEL PROGRAMA
     C                   IF        *IN03 = *ON
     C                   LEAVE

     C* SI PRESIONA F6, SE EJECUTA SUBRUTINA DE CREAR EMPLEADO
     C* SE APAGA EL INDICADOR UNA VEZ QUE SE ACCEDE
     C                   ELSEIF    *IN06 = *ON
     C                   EVAL      *IN06 = *OFF
     C                   EXSR      CREAREMP

     C* SI NO ES NINGUNO DE LOS DOS SE CARGAN LOS DATOS
     C                   ELSE
     C                   EXSR      CARGADATOS
     C                   ENDIF

     C                   ENDDO

     C* SI LAST RECORD ON, TERMINA DE LEER DATOS,
     C                   SETON                                        LR
     C                   RETURN

     C* ==========================================================
     C* SUBRUTINA: CARGASFL-LIMPIA Y LLENA LA TABLA DE PANTALLA
     C* ==========================================================
     C     CARGADATOS    BEGSR

     C* LIMPIAR EL SUBFILE VIEJO
     C* IN74 ON LIMPIA LO QUE ESTÁ EN PANTALLA
     C                   EVAL      *IN74 = *ON
     C                   EVAL      *IN71 = *OFF
     C                   EVAL      *IN72 = *OFF
     C* SE ESCRIBE QUE NO HAY NADA EN LA LISTA
     C                   WRITE     SFLCTL01
     C                   EVAL      *IN74 = *OFF
     C* LA CANTIDAD DE FILAS EN LA LISTA SE PONE A CERO
     C                   Z-ADD     0             RRN

     C* BUSCAR EN LA BASE DE DATOS
     C* SETLL SE PONE EN LA POSICION MENOR
     C* POSICIONA LA BUSQUEDA EN LOS DATOS QUE HAY
     C     BUSNOM        SETLL     EMPMLF
     C                   READ      EMPMLF

     C* BUCLE PARA LEER LA BD Y LLENAR EL SUBFILE
     C* DO WHILE NO SEA EL FINAL DE ARCHIVO Y FILAS MENOR A 9999
     C                   DOW       NOT %EOF(EMPMLF) AND RRN < 9999
     C* SUMAR 1 A LA FILA
     C                   ADD       1             RRN
     C* LIMPIAR CAMPO DE OPCION
     C                   EVAL      OPC = *BLANKS
     C* ESCRIBIR EL DATO EN PANTALLA, PARA PASAR AL SIGUIENTE EN EMPMLF
     C                   WRITE     SFL01
     C                   READ      EMPMLF
     C                   ENDDO

     C* DECIDIR QUÉ MOSTRAR EN PANTALLA
     C* SI HAY AL MENOS 1 EMPLEADO, SE MUESTRA LOS DATOS Y ENCABEZADOS
     C                   IF        RRN > 0
     C                   EVAL      *IN71 = *ON
     C                   EVAL      *IN72 = *ON
     C* CURSOR EN LA PRIMERA POSICION
     C                   EVAL      RRN = 1
     C                   ELSE
     C* SI NO HAY EMPLEADOS SOLO SE MUESTRA ENCABEZADOS
     C                   EVAL      *IN72 = *ON
     C                   ENDIF
     C                   ENDSR


     C*=========================================================
     C* SUBRUTINA: CREAREMP (MUESTRA EL FORMULARIO Y GUARDA)
     C* ==========================================================
     C     CREAREMP      BEGSR
     C* LIMPIAR VARIABLES, TODO A CERO
     C                   EVAL      NEMPID = 0
     C                   EVAL      NEMPNOM = *BLANKS
     C                   EVAL      NEMPDEP = *BLANKS
     C                   EVAL      NEMPSAL = 0
     C                   EVAL      NEMPEST = 'A'

     C* ABRIR PESTANA DE REGISTRO NUEVO
     C                   EXFMT     REGNUEVO

     C* SI F12 SE SALE DEL OVERLAY E IN12 EN 0FF, SALIR DE SUBRUTINA
     C                   IF        *IN12 = *ON
     C                   EVAL      *IN12 = *OFF
     C                   LEAVESR
     C                   ENDIF
     C*
     C* LOS DATOS INGRESADOS PASAN AL MAESTRO
     C                   EVAL      EMPID  = NEMPID
     C                   EVAL      EMPNOM = NEMPNOM
     C                   EVAL      EMPDEP = NEMPDEP
     C                   EVAL      EMPSAL = NEMPSAL
     C                   EVAL      EMPEST = NEMPEST

     C* ESCRIBIR LOS DATOS EN EL REGISTRO
     C                   WRITE     RNUEVO

     C* SE EJECUTA CARGADATOS CON LOS NUEVOS DATOS
     C                   EXSR      CARGADATOS

     C                   ENDSR
