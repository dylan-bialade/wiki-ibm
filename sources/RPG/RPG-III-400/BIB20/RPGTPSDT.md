---
bibliotheque: BIB20
fichier_source: QRPGSRC
membre: RPGTPSDT
type: RPG/RPG-III-400
longueur_enregistrement: 160
lignes: 107
modifie: 2026-11-16
---

# BIB20/QRPGSRC/RPGTPSDT

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FSOLDAT  UF  E           K        DISK                      A                   FECRTPSDTCF  E                    WORKSTN
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
     C                     SETOF                         90                          C                     SETOF                         89
     ****************      SAISIE     ****************************************       C           *IN06     IFEQ '0'
     C           *IN31     ANDEQ'0'                                                  C           *IN32     ANDEQ'0'
     C           ESID      SETLLSOLDAT                                               C                     READ SOLDAT                   91
     C           *IN91     IFEQ '1'                                                  C                     SETON                         90
     C                     MOVELARRERR,1  MSGERS                                     C                     SETOF                         91
     C                     ITER                                                      C                     ENDIF
     C                     SETON                         32                          C                     ENDIF
     ****************      CREATION    ***************************************        *VARIABLES: ECNMSD ,ECPRSD ,ECARS1  ,ECARS2  ,ECCLAS
      *IN23=AJOUT DES DONNEES    IN89=SUCCESS                                        *************************************************************************
     C           *IN06     IFEQ '1'                                                  **         SI L'UTILISATEUR APPUIE SUR F12 (RETOUR)
     C           *IN12     IFEQ '1'                                                  C                     SETOF                         06
     C                     SETOF                         23                          C                     SETOF                         12
     C                     ITER                                                      C                     ENDIF
     **         VERIFICATION DES DONNES SEULEMENT AU DEUXIEME PASSAGE                C   23      ECNMSD    IFEQ ' '
     C                     SETON                         92                          C                     SETON                         90
     C                     ELSE                                                      C                     SETOF                         92
     C                     ENDIF                                                     C   23      ECPRSD    IFEQ ' '
     C                     SETON                         93                          C                     SETON                         90
     C                     ELSE                                                      C                     SETOF                         93
     C                     ENDIF                                                     C   23      ECARS1    IFEQ ' '
     C                     SETON                         94                          C                     SETON                         90
     C                     ELSE                                                      C                     SETOF                         94
     C                     ENDIF                                                     C   23      ECARS2    IFEQ ' '
     C                     SETON                         95                          C                     SETON                         90
     C                     ELSE                                                      C                     SETOF                         95
     C                     ENDIF                                                     C   23      ECCLAS    IFEQ ' '
     C                     SETON                         96                          C                     SETON                         90
     C                     ELSE                                                      C                     SETOF                         96
     C                     ENDIF                                                     C   23      *IN90     IFEQ '1'
     C                     MOVELARRERR,2  MSGERC                                     C                     ELSE
     C           *HIVAL    SETLLSOLDAT                                               C                     READPSOLDAT                   34
     C           *IN34     IFEQ '1'                                                  C                     MOVE 0         IDSDT
     C                     SETOF                         34                          C                     ENDIF
     C           IDSDT     ADD  1         IDSDT                                      C                     MOVE ECNMSD    NMSDT
     C                     MOVE ECPRSD    PRSDT                                      C                     MOVE ECARS1    ARSDT1
     C                     MOVE ECARS2    ARSDT2                                     C                     MOVE ECCLAS    CLASID
     C                     WRITESOLDATF                                              C                     SETON                         90
     C                     SETON                         89                          C                     MOVELARRERR,3  MSGERC
     C                     ENDIF                                                     C                     ENDIF
     ****************      MODIFICATION    ***********************************        *VARIABLES: EMNMSD ,EMPRSD ,EMARS1  ,EMARS2  ,EMCLAS
      *IN23=MODIFICATION DES DONNEES    IN89=SUCCESS                                 *************************************************************************
     C           *IN31     IFEQ '1'                                                  C                     SETOF                         32
     **         SI L'UTILISATEUR APPUIE SUR F12 (RETOUR)                             C           *IN12     IFEQ '1'
     C                     SETON                         32                          C                     SETOF                         31
     C                     SETOF                         23                          C                     SETOF                         12
     C                     ENDIF                                                     C           *IN23     IFEQ '1'
     **         VERIFICATION DES DONNES SEULEMENT AU DEUXIEME PASSAGE                C           EMNMSD    IFEQ ' '
     C                     SETON                         92                          C                     SETON                         90
     C                     ELSE                                                      C                     SETOF                         92
     C                     ENDIF                                                     C           EMPRSD    IFEQ ' '
     C                     SETON                         93                          C                     SETON                         90
     C                     ELSE                                                      C                     SETOF                         93
     C                     ENDIF                                                     C           EMARS1    IFEQ ' '
     C                     SETON                         94                          C                     SETON                         90
     C                     ELSE                                                      C                     SETOF                         94
     C                     ENDIF                                                     C           EMARS2    IFEQ ' '
     C                     SETON                         95                          C                     SETON                         90
     C                     ELSE                                                      C                     SETOF                         95
     C                     ENDIF                                                     C           EMCLAS    IFEQ ' '
     C                     SETON                         96                          C                     SETON                         90
     C                     ELSE                                                      C                     SETOF                         96
     C                     ENDIF                                                     C                     ENDIF
     C           *IN90     IFEQ '1'                                                  C                     MOVE ARRERR,2  MSGERM
     C                     ELSE                                                      C           *IN32     IFEQ '0'
     **                   MODIFICATION DE LA DONNEE                                  C                     MOVE ESID      IDSDT
     C                     MOVE EMNMSD    NMSDT                                      C                     MOVE EMPRSD    PRSDT
     C                     MOVE EMARS1    ARSDT1                                     C                     MOVE EMARS2    ARSDT2
     C                     MOVE EMCLAS    CLASID                                     C                     UPDATSOLDATF
     C                     SETON                         90                          C                     SETON                         89
     C                     MOVE ARRERR,4  MSGERM                                     C                     ENDIF
     C                     ENDIF                                                     C                     ENDIF
     ****************      AFFICHAGE     *************************************        *VARIABLES: EANMSD ,EAPRSD ,EAARS1  ,EAARS2  ,EACLAS ,EAIDSD
      *IN02=MODIFICATION DE LA DONNEE                                                *************************************************************************
     C           *IN32     IFEQ '1'                                                  **            MET LES DONNES DANS L'ECRAN
     C                     MOVE IDSDT     EAIDSD                                     C                     MOVE NMSDT     EANMSD
     C                     MOVE PRSDT     EAPRSD                                     C                     MOVE ARSDT1    EAARS1
     C                     MOVE ARSDT2    EAARS2                                     C                     MOVE CLASID    EACLAS
     C           *IN02     IFEQ '1'                                                  **    MET LES DONNEES DANS L'ECRAN DE MODIFICATION
     C                     MOVE NMSDT     EMNMSD                                     C                     MOVE PRSDT     EMPRSD
     C                     MOVE ARSDT1    EMARS1                                     C                     MOVE ARSDT2    EMARS2
     C                     MOVE CLASID    EMCLAS                                     C                     SETON                         31
     C                     SETOF                         02                          C                     ENDIF
     C           *IN07     IFEQ '1'                                                  C                     DELETSOLDATF
     C                     SETON                         90                          C                     SETON                         89
     C                     MOVELARRERR,5  MSGERS                                     C                     SETON                         12
     C                     ENDIF                                                     **         SI L'UTILISATEUR APPUIE SUR F12 (RETOUR)
     C           *IN12     IFEQ '1'                                                  C                     SETOF                         32
     C                     SETOF                         23                          C                     SETOF                         12
     C                     ITER                                                      C                     ENDIF
     C                     ENDIF                                                     C                     ENDDO
     C                     SETON                         LR                     ********************************************************************************
     **                ECRITURE DES ARRAYS                                      ********************************************************************************
**                                                                              L'id renseigné ne correspond à aucun soldat
Des données sont manquantes                                                     Le soldat a bien été ajouté
Le soldat a bien été modifié                                                    Le soldat a bien été supprimé
```
