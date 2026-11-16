---
bibliotheque: BIB10
fichier_source: QRPGSRC
membre: TVA
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 24
modifie: 2026-11-16
---

# BIB10/QRPGSRC/TVA

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      *=================================================*
      *              CALCUL DE TVA                    *
      *PARMS:                                         *
      *  - HT ( MONTANT HT (*DEC 5 2))                  *
      *  - TV (TAUX DE TVA ENTIER (*DEC 3 2))           *
      *                                                 *
      *=================================================*
      *
     C                     SETON                         LR
     C           *ENTRY    PLIST
     C                     PARM           HT      52
     C                     PARM           TV      52
     C           TV        DIV  100       TVA     52
     C           HT        MULT TVA       MTVA    52
     C           MTVA      ADD  HT        TTC     52
     C                     MOVELHT        SHT     5
     C                     MOVELMTVA      SMTVA   5
     C                     MOVELTTC       STTC    5
     C           'MT HT:'  CAT  SHT:1     MT     12
     C           'MT TVA:' CAT  SMTVA:1   TVP    13
     C           'MT TTC:' CAT  STTC:1    TC     13
     C           MT        DSPLY
     C           TVP       DSPLY
     C           TC        DSPLY
```
