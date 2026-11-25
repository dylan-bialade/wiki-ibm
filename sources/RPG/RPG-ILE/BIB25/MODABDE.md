---
bibliotheque: BIB25
fichier_source: QTEST
membre: MODABDE
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 14
modifie: 2026-11-25
---

# BIB25/QTEST/MODABDE

```rpg
**free

ctl-opt nomain;


dcl-proc Addition EXPORT;
dcl-pi *n packed(7:2);
    num1 packed(5:2);
    num2 packed(5:2);
end-pi;

return num1 + num2 + 100;

end-proc;
```
