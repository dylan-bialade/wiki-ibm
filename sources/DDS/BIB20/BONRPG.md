---
bibliotheque: BIB20
fichier_source: QPRTSRC
membre: BONRPG
type: DDS
longueur_enregistrement: 80
lignes: 27
modifie: 2026-11-16
---

# BIB20/QPRTSRC/BONRPG

```text
     FLFBONBONIF  E           K        DISK
     FBONPRT  O   E             60     PRINTER
     FMARQP   IF  E           K        DISK
     ******************************************************
     C           NUMBB     SETLLLFBONBON
     C                     READ LFBONBON                 90
     C           *IN90     DOWEQ'0'
     C           PRIX      MULT 5         PRIX
     C           MARQUE    CHAINMARQP                95
     C           *IN95     IFEQ '1'
     C                     WRITEETOILE
     C                     SETOF                     95
     C                     ENDIF
     C                     WRITEDETAILS
     C           *IN60     IFEQ '1'
     C                     WRITEEJECT
     C                     WRITETITRE
     C                     WRITEENTETE
     C                     SETOF                     60
     C                     ENDIF
     C                     READ LFBONBON                 90
     C                     ENDDO
     C                     SETON                     LR
     C           *INZSR    BEGSR
     C                     WRITETITRE
     C                     WRITEENTETE
     C                     ENDSR
```
