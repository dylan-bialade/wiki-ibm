---
bibliotheque: BIB20
fichier_source: QRPGSRC
membre: RPGHERMES
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 85
modifie: 2026-11-16
---

# BIB20/QRPGSRC/RPGHERMES

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FEHERMES   CF   E             WORKSTN SFILE(HERMESF : RANG)
     FHERMES    UF a E           k DISK
     ************ DECLARATION VARIABLE ********************
     DSAVERANG         S              4s 0 INZ(1)
     DFIRST            S              1s 0 INZ(0)
     *************  CODE **********************************
     C                   DOW       *IN03 = *OFF
     C                   EXSR      CLR
     C                   EXSR      REMP
     C                   IF        RANG > 0 AND FIRST = 0
     C                   EVAL      FIRST = 1
     C                   SETON                                        33
     C                   ENDIF
     C                   EVAL      RANG = SAVERANG
     ******  Affiche le format et le controle *******
     C                   SETON                                        3031
     *******    Affiche Fin a la fin ***********
     C                   EXFMT     HERMESCTL
     c                   READC     HERMESF
     C                   EVAL      SAVERANG = SCROLL
     c                   SELECT
     C                   WHEN      *IN03 = *ON
     c                   ITER
     c*                  WHEN      *IN04 = *ON
     c*                  EXSR      CHANGECOLOR
     c                   WHEN      SELECT = '2'
     C                   EXSR      MODIFSR
     C                   WHEN      SELECT = '4'
     C                   EXSR      SUPPRSR
     C                   WHEN      SELECT = '5'
     C                   EXSR      AFFICHESR
     C                   endsl
     C                   CLEAR                   SELECT
     C
     C
     C                   ENDDO
     C                   SETON                                            LR
     *******      SOUS ROUTINE CLEAR ********************
     c     CLR           BEGSR
     C                   SETOFF                                       3031
     C                   Z-ADD     0             RANG
     c                   SETON                                        32
     C                   WRITE     HERMESCTL
     C                   SETOFF                                           32
     C                   ENDSR
     ***********    SOUS ROUTINE REMPLISSAGE *************
     C     REMP          BEGSR
     C     *LOVAL        SETLL     HERMESPF
     C                   READ      HERMESPF
     C                   DOW       NOT %EOF()
     C                   ADD       1             RANG
     C                   WRITE     HERMESF
     C                   READ      HERMESPF
     C                   ENDDO
     c                   ENDSR
     ***********    SOUS ROUTINE MODIFICATION *************
     C     MODIFSR       BEGSR
     c     RANG          CHAIN     HERMESF
     C                   EXFMT     MODIF
     c                   SELECT
     c                   WHEN      *IN03 = *ON OR *IN12 = *ON
     c                   LEAVESR
     c                   OTHER
     C     IDARTICLE     SETLL     HERMESPF
     C                   READ      HERMESPF
     c                   UPDATE    HERMESPF
     c                   ENDSL
     c                   ENDSR
     *************   SOUS ROUTINE AFFICHAGE D'UNE COULEUR *************
     c     CHANGECOLOR   BEGSR
     c                   ENDSR
     ************  SOUS ROUTINE SUPPRESSION *****************
     c     SUPPRSR       BEGSR
     c     RANG          CHAIN     HERMESF
     C     IDARTICLE     SETLL     HERMESPF
     C                   READ      HERMESPF
     c                   DELETE    HERMESPF
     c                   EXSR      CLR
     c                   EXSR      REMP
     c                   ENDSR
     ************  SOUS ROUTINE AFFICHAGE   *****************
     c     AFFICHESR     BEGSR
     c     RANG          CHAIN     HERMESF
     C                   EXFMT     AFFICHE
     c                   ENDSR
```
