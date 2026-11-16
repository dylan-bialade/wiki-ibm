---
bibliotheque: BIB10
fichier_source: QRPGLESRC
membre: TESTRNIND
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 8
modifie: 2026-11-16
---

# BIB10/QRPGLESRC/TESTRNIND

```text
     D PtrInd          S               *   Inz(%Addr(*In))
     D DS_Global       DS                  Based(PtrInd)
     d DSpl                   01     52A
     D ds2                    53    100A
     c                   eval      *inlr = *on
     c                   eval      *in05 = *on
     c     dspl          dsply
     c     ds2           dsply
```
