---
bibliotheque: BIB25
fichier_source: QDDSSRC
membre: CLIENTS2
type: DDS
longueur_enregistrement: 80
lignes: 15
modifie: 2026-11-25
---

# BIB25/QDDSSRC/CLIENTS2

```text
     A                                      UNIQUE
     A          R FCLIENTS
     A            ID             6S 0       COLHDG('ID CLIENT')
     A                                      COMP(NE 0)
     A            NOM           25A         COLHDG('NOM CLIENT')
     A            PRENOM        25A         COLHDG('PRENOM CLIENT')
     A            CODEPOSTAL     5A         COLHDG('CODE POSTAL CLIENT')
     A            DATE_A          L         COLHDG('ANNIVERSAIRE CLIENT')
     A                                      DATFMT(*DMY)
     A                                      DATSEP('.')
     A            DATE_C          L         COLHDG('DATE CREATION')
     A                                      DATFMT(*EUR)
     A            PAYS           2A         COLHDG('PAYS CLIENT')
     A                                      VALUES('FR' 'EN')
     A          K ID
```
