---
bibliotheque: BIB05
fichier_source: QFREERPGLE
membre: FIRSTFREE
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 18
modifie: 2026-11-16
---

# BIB05/QFREERPGLE/FIRSTFREE

```text
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
**free
//dcl-pr val1 zoned(4);
  //  nb1 zoned(4);
//end-pr;

dcl-pi *n;
    nb1 packed(4);
end-pi;
dcl-s nb2 packed(8);
dsply nb1;
      nb1=nb1*2;
      nb2=nb1 * nb1;
dsply nb2;

 *inlr=*on;
```
