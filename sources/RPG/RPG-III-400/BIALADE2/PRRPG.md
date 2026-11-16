---
bibliotheque: BIALADE2
fichier_source: QRPGSRC
membre: PRRPG
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 20
modifie: 2026-11-16
---

# BIALADE2/QRPGSRC/PRRPG

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      *=================================================*
      * MON PREMIER RPG                                 *
      * CONCATENATION DE STRING ET PYSPLAY SUR MESSAGE  *
      *=================================================*
      * METHODE CAT
     C                     SETON                     LR
     C                     MOVEL'ELLE EST'MSG     8
     C           MSG       CAT  ' TOP LA 'MSG1   16
     C           MSG1      CAT  'FORMATIO'MSG2   24
     C           MSG2      CAT  'N!      'MSG3   32
     C           MSG3      DSPLY
      *
      *METHODE MOVE ET MOVEL
     C                     MOVEL'ELLE EST'TSG    16
     C                     MOVE ' TOP LA 'TSG
     C                     MOVEL'FORMATIO'TSG1   16
     C                     MOVE 'N !     'TSG1
     C                     MOVELTSG       TSG2   32
     C                     MOVE TSG1      TSG2
     C           TSG2      DSPLY
```
