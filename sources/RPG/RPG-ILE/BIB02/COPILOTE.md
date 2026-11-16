---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: COPILOTE
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 27
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/COPILOTE

```text
ctl-opt dftactgrp(*no);

// Déclaration du fichier
dcl-f Film disk usage(*input);


dcl-pr PGMIMPRESSION;
end-pr;

// Boucle principale
dow not %eof(Film);
    // Lecture du fichier
    read Film;

    // Vérification de la fin de fichier
    if not %eof(Film);
        // Appel du programme d'impression
        call PGMIMPRESSION;

        // Affichage de la zone TITREFILM
        dsply TITREFILM; // Corrected variable name

    endif;
enddo;

// Sortie du programme
*inlr = *on;
```
