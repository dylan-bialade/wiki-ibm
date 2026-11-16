---
bibliotheque: BIB10
fichier_source: QRPGSRC
membre: DSPCLI
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 17
modifie: 2026-11-16
---

# BIB10/QRPGSRC/DSPCLI

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      *=================================================*
      *DSPCLI                                         *
      *CONCATENATION DE STRING ET DSPLY SUR MESSAGE   *
      *=================================================*
     FCLIENTL IF  E           K        DISK
     C                     SETON                       LR
     C                     MOVEL'BIB10'    LL     30
     C*          LL        SETLLCLIENTL
     C                     READ CLIENTL                  90
     C           *IN90     DOWEQ'0'
      * TRIMCAT AVEC :N OU N EST LE NB DE BLANC ENTRE LES VAR
     C           ''       CAT  NOMCLI:0  MSG    50
     C           MSG       CAT  '':0     MSG
     C           MSG       CAT  PRECLI:0  MSG
     C           MSG       DSPLY
     C                     READ CLIENTL                  90
     C                     ENDDO
```
