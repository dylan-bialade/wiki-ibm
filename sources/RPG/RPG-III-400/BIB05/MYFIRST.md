---
bibliotheque: BIB05
fichier_source: QRPGSRC
membre: MYFIRST
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 15
modifie: 2026-11-16
---

# BIB05/QRPGSRC/MYFIRST

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      *COMENTAIRE
     C                     SETON                     LR
     C                     MOVE 'DYLAN'   MSG    50
     C                     MOVEL'BONJOUR 'MSG5    8
     C                     MOVEL'ELLE EST'MSG1    8
     C                     MOVE ' TOP LA 'MSG2    8
     C                     MOVE 'FORMATIO'MSG3    8
     C                     MOVE 'N?'      MSG4    2
     C           MSG1      CAT  MSG2      MSGTO  16
     C           MSG3      CAT  MSG4      MSGTA  10
     C           MSGTO     CAT  MSGTA     MSGTI  26
      *C           AGE       IFGT 17
      * C           MSG5      CAT  'MAJEURE' MSGMAJ 16
      * C           MSGMAJ    DSPLY
      * C                     ENDIF
```
