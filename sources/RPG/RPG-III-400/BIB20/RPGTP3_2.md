---
bibliotheque: BIB20
fichier_source: QRPGSRC
membre: RPGTP3_2
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 14
modifie: 2026-11-16
---

# BIB20/QRPGSRC/RPGTP3_2

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FECRRPGTPCF  E                    WORKSTN
      *SI LE F3 EST ACTIVEE
     C           *IN03     DOWEQ'0'
     C                     EXFMTSAISIE
      * SI LE NOM EST VIDE
     C           NOM       IFEQ ' '
     C                     SETON                         50
     C                     ENDIF
     C                     MOVEL'Bonjour' RESULT
     C                     MOVE NOM       RESULT
      * AFFICHAGE DE L'ECRAN BONJOUR
     C  N50                EXFMTAFFICHE
     C                     ENDDO
     C                     SETON                     LR
```
