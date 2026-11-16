---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: DCLINDIC
type: DDS
longueur_enregistrement: 100
lignes: 13
modifie: 2026-11-16
---

# BIB02/QDDSRC/DCLINDIC

```text
       // Renommage des indicateurs pour faire plus Bô ....

          DCL-S pIndicators Pointer Inz(%Addr(*In));
          DCL-DS DspInd Based(pIndicators);
               Sortie   Ind Pos(3);
               Creation Ind Pos(6);
               Annuler  Ind Pos(12);
               Sfl_Clr  Ind Pos(31);
               Sfl_Dsp  Ind Pos(32);
               Roll     Ind Pos(39);
               Eropt    Ind Pos(85);
               Sfl_End  Ind Pos(90);
          end-ds;
```
