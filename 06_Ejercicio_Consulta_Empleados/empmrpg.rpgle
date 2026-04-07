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
     C* SANGUCHITO. ESCRIBE SFLCTL LUEGO EL FOOTER PARA QUE SE MUESTR
     C                   WRITE     SFLCTL01
     C                   WRITE     FOOTER
     C                   READ      SFLCTL01

     C* SI PRESIONA F3, SALE DEL PROGRAMA
     C                   IF        *IN03 = *ON
     C                   LEAVE

     C* SI PRESIONA F6, SE EJECUTA SUBRUTINA DE CREAR EMPLEADO
     C* SE APAGA EL INDICADOR UNA VEZ QUE SE ACCEDE
     C                   ELSEIF    *IN06 = *ON
     C                   EVAL      *IN06 = *OFF
     C                   EXSR      CREAREMP
     C* SE CARGAN LOS DATOS CON EL NUEVO EMPLEADO
     C                   EXSR      CARGADATOS

     C* SI NO ES F3 O F6, VER SI MARCO OPCIONES 2 O 4
     C                   ELSE
     C* BUSCAR SI SE HAN PUESTO OPC2 O 4 EN LOS DATOS
     C* READ CHANGE RECORD VA A LA LINEA MODIFICADA DE FRENTE
     C                   READC     SFL01                                  95
     C* DO WHILE HAYA MODIFICACIONES EN OPC
     C                   DOW       *IN95 = *OFF

     C* SI OPCION 2, ES EDITAR
     C                   IF        OPC = '2'
     C                   EXSR      EDITAREMP
     C                   ENDIF

     C* SI OPCION 4, ES ELIMINAR
     C                   IF        OPC = '4'
     C                   EXSR      BORRAREMP
     C                   ENDIF

     C* LIMPIAR LA OPCION PARA QUE NO SE QUEDE CON EL NUMERO
     C                   EVAL      OPC = *BLANKS
     C                   UPDATE    SFL01

     C                   READC     SFL01                                  95
     C                   ENDDO

     C* REFRESCAR EL SUBFILE CON LOS CAMBIOS
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
     C* --- QUE SOLO MUESTRE LO QUE SE PIDE ---
     C* Si hay texto, verificamos que el nombre empiece con esas letras
     C                   IF        BUSNOM <> *BLANKS AND
     C                             %SCAN(%TRIM(BUSNOM): EMPNOM) <> 1
     C                   LEAVE
     C                   ENDIF
     C* ------------------------------
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
     C* CURSOR EN LA PRIMERA POSICION, CUANDO HAY DATOS
     C                   EVAL      RRN = 1
     C                   ELSE
     C* SI NO HAY EMPLEADOS SOLO SE MUESTRA ENCABEZADOS
     C                   EVAL      *IN71 = *OFF
     C                   EVAL      *IN72 = *ON
     C* CUANDO NO HAY DATOS PARA QUE IGUAL PUEDA MOSTRAR.
     C                   EVAL      RRN = 1
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


     C* ==========================================================
     C* SUBRUTINA: EDITAREMP (OPCION 2)
     C* ==========================================================
     C     EDITAREMP     BEGSR
     C* CARGAR DATOS DEL SUBFILE A LA PANTALLA DE EDICION
     C                   EVAL      EEMPID  = EMPID
     C                   EVAL      EEMPNOM = EMPNOM
     C                   EVAL      EEMPDEP = EMPDEP
     C                   EVAL      EEMPSAL = EMPSAL
     C                   EVAL      EEMPEST = EMPEST

     C* MOSTRAR LA PANTALLA DE EDICION
     C                   EXFMT     REGEDITAR

     C* SI NO PRESIONO F12, ACTUALIZAMOS EL ARCHIVO FISICO
     C                   IF        *IN12 = *OFF
     C     EMPID         CHAIN     RNUEVO                             90
     C* SI ESTA APAGADO QUIERE DECIR QUE ENCONTRO EL DATO
     C                   IF        *IN90 = *OFF
     C                   EVAL      EMPNOM = EEMPNOM
     C                   EVAL      EMPDEP = EEMPDEP
     C                   EVAL      EMPSAL = EEMPSAL
     C                   EVAL      EMPEST = EEMPEST
     C                   UPDATE    RNUEVO
     C                   ENDIF
     C                   ENDIF

     C                   EVAL      *IN12 = *OFF
     C                   ENDSR


     C* ==========================================================
     C* SUBRUTINA: BORRAREMP (OPCION 4)
     C* ==========================================================
     C     BORRAREMP     BEGSR

     C* TOMAR EL NOMBRE PARA CONFIRMAR
     C                   EVAL      C_NOM = EMPNOM

     C* MOSTRAR LA VENTANA DE CONFIRMACION
     C                   EXFMT     CONFIRMAR

     C* SI NO PRESIONO F12
     C* SIGNIFICA QUE PRESIONO ENTER, CONFIRMAR Y PROCEDE
     C                   IF        *IN12 = *OFF

     C* BUSCA EL DATO POR MEDIO DEL ID, QUE ES KEY
     C* USAMOS EL EMPID QUE VIENE DE LA FILA DEL SUBFILE
     C     EMPID         CHAIN     RNUEVO                             90

     C* SI EL INDICADOR 90 ESTA EN OFF, SIGNIFICA QUE LO ENCONTRO
     C                   IF        *IN90 = *OFF
     C* LO BORRA
     C                   DELETE    RNUEVO
     C                   ENDIF
     C                   ENDIF

     C                   ENDSR
