---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: RPGSFLOPT
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 140
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/RPGSFLOPT

```text
     FEBONSFLOPTcf   e             workstn sfile(ebonsflf:RANG)
     FLFBONNOM  IF A E           K DISK
     FMARQP     IF   E           K DISK    PREFIX(M)
     FLFBONBON  UF   E           K DISK    PREFIX(NUM)
     F                                     RENAME(FBONBON:NUMBONBONF)
     ********************** Declaration varibale ***************************
     Di                S              2s 0 INZ(1)
     DLASTRANK         S              4S 0 INZ(0)
     DLASTSCROLL       S              5S 0 INZ(0)
     ********************** DEBUT DU CODE **********************************
     C                   DOW       *IN03 = *OFF
     C                   WRITE     EXIT
     C                   EXFMT     EBONCTL
     C
     C                   SELECT
     C                   WHEN      *IN03
     C                   LEAVE
     ****   Quand il fait F6 pour Créer ****
     C                   WHEN      *IN06
     C                   EXSR      CREATE
     ****         Quand Il pagine vers le bas ****
     C                   WHEN      *IN29
     C                   EXSR      REMP
     ****         Quand il y une recherche ****
     C                   WHEN      SEARCH <> *BLANKS
     C     SEARCH        SETLL     LFBONNOM
     C                   EXSR      CLEAR
     C                   EXSR      REMP

     C                   OTHER
     C                   DOU       NOT %EOF()
     C                   READC     EBONSFLF
     C                   SELECT
     C                   WHEN      *IN03
     C                   LEAVE
     C                   WHEN      OPT = 2
     C                   EXSR      MODIFIER
     C                   WHEN      OPT = 4
     C                   EXSR      SUPPRIMER
     C                   WHEN      OPT = 5
     C                   EXSR      AFFICHER
     C                   ENDSL
     C                   CLEAR                   OPT
     C                   ENDDO
     C                   ENDSL
     c
     C
     C                   ENDDO
     C                   EVAL      *INLR = *ON
     ***************** Sous routine d'initialisation ***********************
     c     *INZSR        BEGSR
     **** Active sfl et ctl ****
     c                   EVAL      *IN30 = *ON
     c                   EVAL      *IN31 = *ON
     C                   EXSR      CLEAR
     C     *LOVAL        SETLL     LFBONNOM
     C                   EXSR      REMP
     c                   ENDSR
     **************** SOUS ROUTINE CLEAR **********************************
     C     CLEAR         BEGSR
     c                   EVAL      RANG = 0
     C                   EVAL      LASTRANK = 0
     c                   EVAL      *IN32 = *ON
     c                   WRITE     EBONCTL
     c                   EVAL      *IN32 = *OFF
     c                   ENDSR
     **************** SOUS ROUTINE REMPLISSAGE *****************************
     C     REMP          BEGSR
     C                   EVAL      RANG = LASTRANK
     C                   FOR       i = 1 to 12
     C                   READ      LFBONNOM
     C                   IF        %EOF()
     C                   EVAL      *IN33 = *ON
     C                   LEAVE
     C                   ENDIF
     C                   ADD       1             RANG
     C     MARQUE        CHAIN     MARQP                              50
     C                   WRITE     EBONSFLF
     C                   EVAL      *IN50 = *OFF
     C                   ENDFOR
     C                   EVAL      LASTRANK = RANG
     C                   ENDSR
     ****************** SOUS ROUTINE CREATION ************************
     C     CREATE        BEGSR
     C                   EXSR      VIDEZONE
     C                   DOW       1 = 1
     C                   EXFMT     CREATION
     C                   EVAL      *IN90 = *OFF
     C                   SELECT
     C                   WHEN      *IN03 OR *IN12
     C                   LEAVE
     C                   OTHER
     C     NUMBB         CHAIN     LFBONBON
     C                   IF        NOT %FOUND()
     C                   WRITE     FBONBON
     C                   EVAL      MSGCREA = 'Le bonbon a été ajouté.'
     C                   EXSR      VIDEZONE
     C                   ELSE
     C                   EVAL      MSGCREA = 'Le numéro du bonbon existe déjà.'
     C                   EVAL      *IN90 = *ON
     C                   ENDIF
     C                   ENDSL
     C                   ENDDO
     C                   EXSR      NEWPLACE
     C                   ENDSR
     ******************** SOUS ROUTINE VIDAGE DE ZONES **********************
     C     VIDEZONE      BEGSR
     C                   CLEAR                   NUMBB
     C                   CLEAR                   NOM
     C                   CLEAR                   MARQUE
     C                   CLEAR                   PRIX
     C                   CLEAR                   COULEU
     C                   ENDSR
     ***************** SOUS ROUTINE MODIFIER *******************
     C     MODIFIER      BEGSR
     C     NUMBB         CHAIN     LFBONBON
     C                   EXFMT     MODIF
     C                   UPDATE    NUMBONBONF
     C                   UPDATE    EBONSFLF
     C                   ENDSR
     ***************** SOUS ROUTINE SUPPRIMER ******************
     C     SUPPRIMER     BEGSR
     C     NUMBB         CHAIN     LFBONBON
     C                   DELETE    NUMBONBONF
     C                   CLEAR                   OPT
     C                   EXSR      NEWPLACE
     C                   ENDSR
     ***************** SOUS ROUTINE AFFICHER *******************
     C     AFFICHER      BEGSR
     C                   EXFMT     AFFICHE
     C                   ENDSR
     *************************** SOUS ROUTINE POUR REFRAICHIR LA PAGE JUSQU'AU SCROLL ***
     C     NEWPLACE      BEGSR
     C                   EVAL      LASTSCROLL = SCROLL
     C                   EXSR      CLEAR
     C     *LOVAL        SETLL     LFBONNOM
     C                   DOW       RANG < LASTSCROLL
     C                   EXSR      REMP
     C                   ENDDO
     C                   ENDSR
```
