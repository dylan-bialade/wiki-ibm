---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: BONBONSFL1
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 36
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/BONBONSFL1

```text
     **** DECLARATION FICHIERS ***************************************
     FBONBONS1CF  E                    WORKSTN
     F                                        LIGNE KSFILE SFL1
     FBONBONL2IF  E           K        DISK
     **** TRAITEMENT DU PROGRAMME ************************************
     C           *INKC     DOWEQ'0'
     C                     EXSR CHARGE
     C*                    WRITEBAS1
     C                     EXFMTCTL1
     C                     ENDDO
     C                     SETON                     LR
     **** FIN TRAITEMENT *********************************************
     *****************************************************************
     **** SOUS ROUTINE ***********************************************
     C           CHARGE    BEGSR
     **** **** REMISE À ZERO DES INDICATEUR ET DE LA LIGNE
     C                     MOVEA'0000'    *IN,30
     C                     Z-ADD0         LIGNE   40
     **** **** EFFACEMENT DU SOUS FICHIER
     C                     SETON                     30
     C                     WRITECTL1
     C                     SETOF                     30
     **** **** BOUCLE DE REMPLISSAGE DU SOUS FICHIER
     C           *LOVAL    SETLLFBONBON
     C                     READ FBONBON                  90
     C           *IN90     DOWEQ'0'
     C                     ADD  1         LIGNE
     C                     WRITESFL1
     C                     READ FBONBON                  90
     C                     ENDDO
     **** **** ACTIVATION DES INDICATEURS D'AFFICHAGE
     C                     SETON                     3233
     C           LIGNE     IFGT 0
     C                     SETON                     31
     C                     ENDIF
     C                     ENDSR
```
