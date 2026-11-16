---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: TINT
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 63
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/TINT

```rpg
**FREE
ctl-opt dftactgrp(*no) actgrp(*caller)
option(*nodebugio:*srcstmt) datfmt(*iso) timfmt(*iso);

// Déclaration du fichier écran
dcl-f eint workstn;

// Variables de travail
dcl-s trouve ind inz(*off);


// Compilateur SQL
exec sql
  set option commit = *none , alwcpydta = *optimize, closqlcsr = *endmod,
  datfmt = *iso, timfmt = *iso;

dow not *in03;
  // Curseur SQL pour lire les enregistrements
  exec sql declare c1 cursor for
  select id, nom
  from tstint
  order by id;

  // Ouverture du curseur
  exec sql open c1;

  // Boucle principale de lecture
  dow sqlcode = 0;

    // Lecture d'un enregistrement
    exec sql fetch next from c1
    into :idint, :nmint;

    // Si enregistrement trouvé
    if sqlcode = 0;
      trouve = *on;

      // Affichage sur l'écran
      exfmt fmt1;

      if *in03 = *on;
        leave;
      endif;

    endif;

  enddo;

  // Si aucun enregistrement trouvé
  if not trouve;
    idint = 0;
    nmint = 'Aucune donnée trouvée';
    exfmt fmt1;
  endif;

  // Fermeture du curseur
  exec sql close c1;

enddo;

// Fin du programme
*inlr = *on;
return;
```
