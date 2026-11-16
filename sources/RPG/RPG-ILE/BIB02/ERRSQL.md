---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: ERRSQL
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 17
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/ERRSQL

```rpg
**FREE
dcl-s SqlCode int(10);
dcl-s SqlState char(5);
dcl-s SqlMsg char(52);

Exec SQL
    INSERT INTO ENTREPOT VALUES ('1115', 'tata', 18, current_date);

SqlCode = SQLCODE;
SqlState = SQLSTATE;

If SqlCode < 0;
    Exec SQL GET DIAGNOSTICS CONDITION 1 :SqlMsg = MESSAGE_TEXT;
    dsply sqlmsg
endif;

 *inlr = *on;
```
