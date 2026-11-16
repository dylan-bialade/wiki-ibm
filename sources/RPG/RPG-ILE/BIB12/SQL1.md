---
bibliotheque: BIB12
fichier_source: QRPGLESRC
membre: SQL1
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 26
modifie: 2026-11-16
---

# BIB12/QRPGLESRC/SQL1

```rpg
**free

dcl-s uniname char(100);
dcl-s name char(20);
exec sql
set option commit = *none;


exec sql declare C1 cursor for
    select nom from BIB10.bonbon;

exec sql open c1;
dou sqlcode <>0;
  exec sql fetch c1 into :name;
  if sqlcode =0;
  dsply name;
  endif;
enddo;

// exec sql
    // SELECT uniname
    // into :uniname
    // from anime.universV2
    // where univer = 44544;
// dsply %subst(uniname:1:52);
*inlr=*on;
```
