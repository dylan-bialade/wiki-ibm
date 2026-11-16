---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: RPGBONSFL
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 134
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/RPGBONSFL

```text
     FEBONSFL   CF   E             WORKSTN SFILE(EBONSFLF : RANG)
     FLFBONNOM  IF A E           k DISK
     FLFBONBON  IF   E           K DISK    RENAME(FBONBON:NUMBONBON)
     F                                     PREFIX(XNXX)
     FMARQP     IF   E           K DISK    PREFIX(AX)
     ************ DECLARATION VARIABLE ********************
     DFIRST            S             20A   INZ(*BLANKS)
     DLAST             S             20A   INZ(*BLANKS)
     dLASTATT          S              1S 0 INZ(*ZERO)
     *************  CODE **********************************
     C                   EXSR      DEBUTSR
     C                   DOW       *IN03 = *OFF
     ******  Affiche le format et le controle *******
     C                   SETON                                        3031
     C                   WRITE     EXIT
     *******    Affiche Le SFL   ***************
     C                   EXFMT     EBONCTL
     C                   SELECT
     **** Quand il quitte ****
     C                   WHEN      *IN03
     C                   ITER
     **** Quand il roll up ****
     C                   WHEN      *IN30
     C                   EXSR      uppage
     **** Quand il roll down ****
     C                   WHEN      *IN29
     C     LAST          SETGT     LFBONNOM
     C                   EXSR      REMPPAGE
     **** Quand il veut créer ****
     C                   WHEN      *IN06
     C                   EXSR      SRCREA
     **** Pour la recherche ****
     C                   WHEN      SEARCH <> *BLANKS
     C     SEARCH        SETLL     LFBONNOM
     C                   CLEAR                   LASTATT
     C                   EXSR      REMPPAGE
     C                   ENDSL
     **** remet a zero la pagination ****
     C                   SETOFF                                       2930
     C                   ENDDO
     C                   SETON                                            LR
     *******      SOUS ROUTINE CLEAR ********************
     c     CLR           BEGSR
     C                   SETOFF                                       3031
     C                   Z-ADD     0             RANG
     c                   SETON                                        32
     C                   WRITE     EBONCTL
     C                   SETOFF                                           32
     C                   ENDSR
     ***************    ROLL UP ******************
     C     UPPAGE        BEGSR
     C     FIRST         SETLL     LFBONNOM
     C                   READP     LFBONNOM
     C                   EVAL      LASTATT = 0
     C                   IF        NOT %EOF()
     C                   EVAL      LAST = NOM
     C                   EXSR      CLR
     C                   SETOFF                                       33
     C                   EVAL      RANG = 13
     C                   DOW       NOT %EOF() AND RANG > 1
     C                   SUB       1             RANG
     C     MARQUE        CHAIN     MARQP                              50
     C                   WRITE     EBONSFLF
     C                   EVAL      FIRST = NOM
     C                   READP     LFBONNOM
     C                   SETOFF                                       50
     C                   ENDDO
     C                   ENDIF
     C                   IF        %EOF()
     C                   EXSR      DEBUTSR
     C                   ENDIF
     C                   ENDSR
     ****************  REMPLISSAGE DOWN ****************
     C     REMPPAGE      BEGSR
     C                   READ      LFBONNOM
     C                   IF        NOT %EOF() AND LASTATT = 0
     C                   EVAL      FIRST = NOM
     C                   EXSR      CLR
     C                   EVAL      RANG = 0
     C                   DOW       NOT %EOF() AND RANG < 12
     C                   ADD       1             RANG
     C     MARQUE        CHAIN     MARQP                              50
     C                   WRITE     EBONSFLF
     C                   EVAL      LAST = NOM
     C                   READ      LFBONNOM
     C                   SETOFF                                       50
     C                   ENDDO
     C                   ENDIF
     C                   IF        %EOF()
     C                   EVAL      LASTATT = 1
     C                   SETON                                        33
     C                   ENDIF
     C                   ENDSR
     ***********  SOUS ROUTINE INIT ************
     C     DEBUTSR       BEGSR
     C     *LOVAL        SETLL     LFBONNOM
     C                   EXSR      REMPPAGE
     C                   EVAL      RANG = 1
     C                   ENDSR
     ************** Sous rotuine de Nettoyage des champs **********
     C     Nettoyage     BEGSR
     C                   CLEAR                   MSGCREA
     C                   CLEAR                   NUMBB
     C                   CLEAR                   NOM
     C                   CLEAR                   MARQUE
     C                   CLEAR                   COULEU
     C                   CLEAR                   PRIX
     C                   ENDSR
     ************ Sous routine de Création ****************
     C     SRCREA        BEGSR
     C                   EXSR      NETTOYAGE
     C                   DOW       *IN03 = *OFF and *in12 = *off
     C                   EXFMT     CREATION
     C                   SELECT
     C                   WHEN      *IN03 OR *IN12
     C                   LEAVE
     C                   OTHER
     **** Verifie si il existe ****
     C     NUMBB         CHAIN     NUMBONBON
     C                   IF        NOT %FOUND()
     C                   WRITE     FBONBON
     C                   SETOFF                                       90
     C                   EVAL      MSGCREA = 'Le bonbon a été ajouté.'
     C                   ELSE
     C                   SETON                                        90
     C                   EVAL      MSGCREA = 'Le numéro du bonbon existe déjà.'
     C                   ENDIF
     C                   ENDSL
     C                   ENDDO
     C                   EVAL      *IN12 = *OFF
     C     FIRST         SETLL     LFBONNOM
     C                   EXSR      REMPPAGE
     C                   ENDSR
     C
```
