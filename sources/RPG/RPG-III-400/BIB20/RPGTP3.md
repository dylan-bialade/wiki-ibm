---
bibliotheque: BIB20
fichier_source: QRPGSRC
membre: RPGTP3
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 26
modifie: 2026-11-16
---

# BIB20/QRPGSRC/RPGTP3

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FECRRPGTPCF  E                    WORKSTN
     C           DEBUT     TAG
     C                     EXFMTSAISIE
      *SI LE F3 EST ACTIVEE
     C           *IN03     IFEQ '1'
     C                     GOTO FIN
     C                     ENDIF
      * SI LE NOM EST VIDE
     C           NOM       IFEQ ' '
     C                     SETON                         50
     C                     GOTO DEBUT
     C                     ENDIF
      * SI LE NOM EST CORRECTE
     C                     SETOF                         50
     C                     MOVEL'Bonjour' RESULT
     C                     MOVE NOM       RESULT
      * AFFICHAGE DE L'ECRAN BONJOUR
     C                     EXFMTAFFICHE
      * SI F3 EST ACTIVEE
     C           *IN03     IFEQ '1'
     C                     GOTO FIN
     C                     ENDIF
      *Boucle pour revenir au debut
     C                     GOTO DEBUT
     C           FIN       TAG
     C                     SETON                     LR
```
