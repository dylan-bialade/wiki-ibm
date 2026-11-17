# PRRPG : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB06 | QRPGSRC | RPG/RPG-III-400 | 20 | 71 % |  | [PRRPG.md](../../sources/RPG/RPG-III-400/BIB06/PRRPG.md) |
| BIB10 | QRPGSRC | RPG/RPG-III-400 | 24 | 100 % |  | [PRRPG.md](../../sources/RPG/RPG-III-400/BIB10/PRRPG.md) |

## Differences


## Codes

### BIB06 (RPG/RPG-III-400, 20 lignes)

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

### BIB10 (RPG/RPG-III-400, 24 lignes)

```text
      *=================================================*
      * MON PREMIER RPG                                 *
      * CONCATENATION DE STRING ET PYSPLAY SUR MESSAGE  *
      *=================================================*
      *
      * METHODE CAT
     C                     SETON                     LR
     C                     MOVEL'ELLE EST'MSG     8
     C           MSG       CAT  'TOP LA'MSG1   16
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
     C                     Z-ADD*ZEROS    TST    100
     C                     MOVE 3         TST
     C           TST       DSPLY
```
