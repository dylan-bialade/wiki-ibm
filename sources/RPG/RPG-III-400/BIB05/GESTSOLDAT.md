---
bibliotheque: BIB05
fichier_source: QRPGSRC2
membre: GESTSOLDAT
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 84
modifie: 2026-11-16
---

# BIB05/QRPGSRC2/GESTSOLDAT

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      *NOMPGM:GESTIONAIRE LIVRE
      *NOMPROP:BIB05
      *FILLEDEPEND:SODLAT(DTA) SOLDATDS(ECRAN)
     * SI TU VOIS SA TU A COPIER BIB05
      *============================================================
     FSOLDATDSCF  E                    WORKSTN
     FSOLDAT  UF  E           K        DISK                      A
     C           DEBUT     TAG
     C                     EXFMTFMT1
     C                     SETOF                     12    OFF RETOUR
     C           IDSLD     SETLLSOLDATR
      * BOUCLE EXIT
     C           *IN03     DOWEQ*OFF                       EXIT
      *SI 12 RETOUR ECRAN AVANT
     C           *IN12     IFEQ *ON                        RETURN
     C                     GOTO DEBUT
     C                     EXFMTFMT1
     C                     ENDIF
     C           *IN90     IFEQ *OFF
      *DEBUT MODIF
     C           *IN02     IFEQ *ON
     C           *IN07     DOWEQ*OFF
     C                     MOVE 'MODIF'   MSG
     C           IDSLD     CHAINSOLDATR              90
     C                     EXFMTFMT2
     C                     MOVELNOM       NMSLD
     C                     MOVELPRENOM    PRSLD
     C                     MOVELARME      ARSLD1
     C                     MOVELCLASSE    CLASLD
     C   07                UPDATSOLDATR
     C   03                LEAVE
     C   12                LEAVE
     C                     ENDDO
     C                     SETOF                     07
     C                     ENDIF
      *DEBUT SUPP
     C           *IN23     IFEQ *ON
     C           *IN07     DOWEQ*OFF
     C                     MOVE 'DELETE'  MSG
     C                     EXFMTFMT2
     C           IDSLD     CHAINSOLDATR              90
     C                     EXFMTFMT2
     C   07                DELETSOLDATR
     C   03                LEAVE
     C   12                LEAVE
     C                     ENDDO
     C                     SETOF                     07
     C                     ENDIF
      *DEBUT CRÉATION
     C           *IN06     IFEQ *ON
     C           *IN07     DOWEQ*OFF
     C                     MOVE 'CREATE'  MSG
     C           *HIVAL    CHAINSOLDATR              90
     C                     ADD  1         IDSLD
     C                     MOVEL*BLANK    NOM
     C                     MOVEL*BLANK    PRENOM
     C                     MOVEL*BLANK    ARME
     C                     MOVEL*BLANK    CLASSE
     C                     EXFMTFMT2
     C                     MOVELNOM       NMSLD
     C                     MOVELPRENOM    PRSLD
     C                     MOVELARME      ARSLD1
     C                     MOVELCLASSE    CLASLD
     C                     EXFMTFMT2
     C   07                WRITESOLDATR
     C   03                LEAVE
     C   12                LEAVE
     C                     ENDDO
     C                     SETOF                     07
     C                     ENDIF
      *AFFICHAGE SIMPLE
     C  N23N06N02          MOVE 'PRINT'   MSG
     C           IDSLD     CHAINSOLDATR              90
     C                     MOVELNMSLD     NOM
     C                     MOVELPRSLD     PRENOM
     C                     MOVELARSLD1    ARME
     C                     MOVELCLASLD    CLASSE
     C                     EXFMTFMT2
      *DEBUT SI ERR
     C*                    GOTO DEBUT
     C                     ENDIF
     C                     EXFMTFMT2
     C                     ENDDO
     C                     SETON                     LR
```
