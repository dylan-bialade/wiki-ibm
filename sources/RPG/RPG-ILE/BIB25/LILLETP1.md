---
bibliotheque: BIB25
fichier_source: QILETP
membre: LILLETP1
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 18
modifie: 2026-11-25
---

# BIB25/QILETP/LILLETP1

```rpg
**free

dcl-pr CheckEmail ind;
    email char(40);
end-pr;


dcl-s emailtest char(40) INZ('adresse@exemple.invalid');
dcl-s retour ind;

retour = CheckEmail(emailtest);

if retour;
    dsply 'email valid';
else;
    dsply ('email non valid' + %trim(email) );
endif;
*inlr = *on;
```
