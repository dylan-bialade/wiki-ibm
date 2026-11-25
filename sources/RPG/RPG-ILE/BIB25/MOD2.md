---
bibliotheque: BIB25
fichier_source: QMODSRC
membre: MOD2
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 11
modifie: 2026-11-25
---

# BIB25/QMODSRC/MOD2

```rpg
**free

CTL-OPT NOMAIN copyright('(C) ORGFORM 2025.') DATFMT(*ISO);
dcl-f MODDSPF workstn;
dcl-proc DisplayDSPF export;
    exfmt fmt01;
    if *in03;
    dsply 'j ai appuyé sur F3';
    return;
    endif;
end-proc;
```
