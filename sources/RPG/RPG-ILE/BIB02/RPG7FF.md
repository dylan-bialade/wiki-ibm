---
bibliotheque: BIB02
fichier_source: QKYLE
membre: RPG7FF
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 95
modifie: 2026-11-16
---

# BIB02/QKYLE/RPG7FF

```text
     FECRAN1    CF   E             WORKSTN
     FAGENCEL1  UF A E           K DISK
     FAGENCE    UF A E             DISK    rename(AGENCEF:AGENCEPF)
     /*liste des clef*/
     C     logic         KLIST
     C                   KFLD                    CODCLI
     C                   KFLD                    CODAGN

     /***************** afficher l'ecran1  **************************/
     /******************  MAIN   ***********************************/
     C                   SETON                                        LR
     C                   DOW       NOT *IN03
     C                   EXFMT     ECRANTP1
     C                   SELECT
     C                   WHEN      *IN03 = *ON
     C                   LEAVE
     C                   WHEN      *IN05 = *ON                                  Sous routine
     C                   EXSR      SSRT_1
     C                   WHEN      *IN12 = *ON
     C                   LEAVE
     C                   WHEN      *IN06 = *ON
     C                   EXSR      SSRT_2


     C                   OTHER
     C                   ENDSL
     C                   ENDDO
     /****************    Fin du main      **************************/


     /****************Sous routine afficher l'agence**************/
     C     SSRT_1        BEGSR
     C*                 Vérification des données
     C                   IF        CODAGN = *BLANKS OR CODCLI = 0
     C                   EVAL      *IN95 = *ON
     C                   ELSE
     C*                 Affichage de l'écran2
     C     logic         CHAIN     AGENCEL1                           95
     C                   DOW       1 = 1
     C     *IN95         IFEQ      *ON
     C                   EVAL      *IN95 = *ON
     C                   LEAVE
     C                   ENDIF
     C                   EXFMT     ECRANTP12
     C*C                Indicateur pour oppération
     C                   SELECT
     C                   WHEN      *IN12 = *ON
     C                   LEAVE
     C                   WHEN      *IN03 = *ON
     C                   LEAVE
     C                   WHEN      *IN02 = *ON
     C                   EXSR      SSRT_3
     C                   OTHER
     C                   ENDSL
     C                   ENDDO
     C                   ENDIF
     C                   ENDSR
     C
     C
     /****************Sous routine créer une l'agence**************/
     C     SSRT_2        BEGSR
     C                   DOW       1 = 1
     C                   EXFMT     ECRANTP13
     C                   SELECT
     C                   WHEN      *IN03 = *ON
     C                   LEAVE
     C                   WHEN      *IN12 = *ON
     C                   LEAVE
     C                   WHEN      *IN23 = *ON
     C                   WRITE     AGENCEPF
     C                   LEAVE
     C                   OTHER
     C                   ENDSL
     C                   ENDDO
     C                   ENDSR
     C
     C
     /****************Sous routine update une l'agence**************/
     C     SSRT_3        BEGSR
     C     logic         CHAIN     AGENCEL1
     C                   EVAL      RUE1 = RUE
     C                   DOW       1 = 1
     C                   EXFMT     ECRANTP14
     C                   SELECT
     C                   WHEN      *IN03 = *ON
     C                   LEAVE
     C                   WHEN      *IN12 = *ON
     C                   LEAVE
     C                   WHEN      *IN23 = *ON
     C     logic         CHAIN     AGENCEL1
     C                   EVAL      RUE = RUE1
     C                   UPDATE    AGENCEF
     C                   ENDSL
     C                   ENDDO
     C                   ENDSR
```
