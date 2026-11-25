---
bibliotheque: BIB27
fichier_source: QRPGLESRC
membre: TEST_PUSH
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 23
modifie: 2026-11-25
---

# BIB27/QRPGLESRC/TEST_PUSH

```rpg
**free

dcl-f test_push workstn;




dow not *IN03;
    exfmt fmt1;

    if zone1 = 1;
    zone2 = 'valeur1';
    endif;

    if zone1 = 2;
        zone2 = 'valeur2';
    endif;
enddo;




*inlr = *on;
```
