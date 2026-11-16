---
bibliotheque: BIB20
fichier_source: QRPGSRC
membre: TESTPSDT
type: RPG/RPG-III-400
longueur_enregistrement: 160
lignes: 24
modifie: 2026-11-16
---

# BIB20/QRPGSRC/TESTPSDT

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FSOLDAT  IF  E           K        DISK                                          FECRTPSDTCF  E                    WORKSTN
    ****************************************************************************      *                DEFINITION DU ARRAY
      **************************************************************************     E                    ARRERR  1   5 50
    ****************************************************************************      *                DEFINITION DU CODE
      *                                                                               *  IN06=ECRAN CREATION  IN31=ECRAN MODIF  IN32=ECRAN AFFICHE
    ****************************************************************************     C           *IN03     DOWEQ'0'
     C                     SELEC                                                     C           *IN06     WHEQ '1'
     C                     EXFMTCREATION                                             C           *IN31     WHEQ '1'
     C                     EXFMTMODIF                                                C           *IN32     WHEQ '1'
     C                     EXFMTAFFICHE                                              C           *IN31     WHNE '1'
     C                     EXFMTSAISIE                                               C                     ENDSL
     C                     SETOF                         90                          ****************      SAISIE     ****************************************
     C           *IN06     IFEQ '0'                                                  C           *IN31     ANDEQ'0'
     C           *IN32     ANDEQ'0'                                                  C           ESID      SETLLSOLDAT
     C                     READESOLDAT                   91                          C           *IN91     IFEQ '1'
     C                     MOVE ARRERR,1  MSGERS                                     C                     SETOF                         91
     C                     ITER                                                      C                     ENDIF
     C                     ENDIF                                                     C                     SETOF                         31
     C                     SETOF                         32                          C                     ENDDO
     C                     SETON                         LR                     ********************************************************************************
     **                DEFINITION DES ARRAYS                                    ********************************************************************************
**                                                                              L'id renseigné ne correspond à aucun soldat
Des données sont manquantes                                                     Le soldat a bien été ajouté
Le soldat a bien été modifié                                                    Le soldat a bien été supprimé
```
