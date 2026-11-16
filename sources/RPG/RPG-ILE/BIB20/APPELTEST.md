---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: APPELTEST
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 12
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/APPELTEST

```text

                   ctl-opt dftactgrp(*no) actgrp(*caller);

                   // Prototype du programme a appeler
                   dcl-pr testAlter extpgm('TESTALTER');
                   end-pr;

                  // Appel du programme TESTALTER
                     testAlter();

                    *inlr = *on;
                    return;
```
