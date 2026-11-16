---
bibliotheque: BIB01
fichier_source: QRPGLESRC
membre: TSTCLIENTS
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 9
modifie: 2026-11-16
---

# BIB01/QRPGLESRC/TSTCLIENTS

```text
     FCLIENTS   IF   E           K DISK    INFDS(INFDS)
     D INFDS           DS
     D  RECNO                397    400I 0
     C                   READ      CLIENTS                                90
     C     *IN90         DOWEQ     '0'
     C     RECNO         DSPLY
     C                   READ      CLIENTS                                90
     C                   ENDDO
     C                   SETON                                        LR
```
