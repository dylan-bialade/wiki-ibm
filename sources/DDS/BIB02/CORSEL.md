---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: CORSEL
type: DDS
longueur_enregistrement: 100
lignes: 18
modifie: 2026-11-16
---

# BIB02/QDDSRC/CORSEL

```text
**FREE
ctl-opt copyright('(C) ORGFORM 2023.') dftactgrp(*no) optimize(*full)
actgrp(*caller) datfmt(*iso) timfmt(*iso) alloc(*stgmdl)
stgmdl(*inherit) thread(*serialize);

// Inclusion des définitions de fichiers externes
dcl-f ETUDIANTPF keyed usage(*input);

// Boucle principale pour lire et afficher les données
dow not %eof(ETUDIANTPF);
  read ETUDIANTPF;
  if not %eof(ETUDIANTPF);
    dsply ('Nom: ' + %trim(NOM));
    dsply ('Prenom: ' + %trim(PRENOM));
  endif;
enddo;

*inlr = *on;
```
