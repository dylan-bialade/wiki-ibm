---
bibliotheque: BIB05
fichier_source: QRPGSRC
membre: CLIENTR
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 15
modifie: 2026-11-16
---

# BIB05/QRPGSRC/CLIENTR

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FCLIENTL IF  E           K        DISK
     C                     SETON                     LR
     C           ''       CAT  'MAJEURE' MSG1    8
     C           ''       CAT  'MINEURE' MSG2    8
     C           PRECLI    CAT  MSGTO     MSGTO  38
     C                     READ CLIENTL                  90
     C           *IN90     DOWEQ'0'
     C           AGE       IFGE 18
     C           MSG1      CAT  NOMCLI:1  MSGTO
     C                     ELSE
     C           MSG2      CAT  NOMCLI:1  MSGTO
     C                     END
     C           MSGTO     DSPLY
     C                     READ CLIENTL                  90
     C                     ENDDO
```
