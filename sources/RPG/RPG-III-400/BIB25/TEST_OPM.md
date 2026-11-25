---
bibliotheque: BIB25
fichier_source: QRPGSRC
membre: TEST_OPM
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 25
modifie: 2026-11-25
---

# BIB25/QRPGSRC/TEST_OPM

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      * Déclaration fichier CLIENTS1
     FSTUDENT IF  E           K        DISK
      ** Rename d'une zone du fichier
     IFSTUDENT
     I              FIRSTNAME                       FNAME
      ** Déclaration Data structure d'affichage
     IRES         DS
     I                                        1  20 FN
     I                                       21  25 FF
     I                                       26  50 CN
      **Logique du programme
     C                     MOVEL' '       NOMF   25
     C                     READ FSTUDENT                 30
     C           *IN30     DOWEQ'0'
     C                     CALL 'TESTCALL'
     C                     PARM           ID
     C                     PARM           NOMF
     C                     MOVELFNAME     FN
     C                     MOVE ' FRM:'   FF
     C                     MOVE NOMF      CN
     C           RES       DSPLY
     C                     READ FSTUDENT                 30
     C                     ENDDO
      * Sortie du programme
     C                     SETON                     LR
```
