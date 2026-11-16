---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: SFLSTAT
type: DDS
longueur_enregistrement: 100
lignes: 45
modifie: 2026-11-16
---

# BIB02/QDDSRC/SFLSTAT

```text
      *=======================================================================
     FSfl001d   cf   e             Workstn
     F                                     Sfile(Sfl1:RANG)
     FSfl002lf  if   e           k Disk
     DSflmax           C                   Const(500)
     DRANG             S              4  0
      /Free

       Dou *IN03;  // Sortie si touches F3

          // A- Initialisation du sous-fichier
          RANG = *Zero;   // Initialisat° du compteur d'enregistrement.
          *In31 = *On;    // Activat° de l'indic de vidage de SFL  (Associé au mot clé SFLCR)
          Write Sf1ctl;      // Vidage du sous-fichier
          *In31 = *Off;   // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLCLR)

          // B- Lecture de la base de données
          Setll (Ptname:' ') Sfl002lf;  // On se positionne avec la zone Ptname saisie à l'écran
          Read Sfl002lf;

          // B- Tant que non fin de fichier
          Dow (Not %eof) And (RANG <= Sflmax); // TQ Non Fin de Fichier et limite de 500 ligne

            RANG += 1;  // Incrémentation du compteur de ligne
            // les zones du PF ayant le même nom que celle du SFL, le "move" de celles-ci
            // est implicite et ça se passe ici !
            Write Sfl1;       // Ecriture du format de sous-fichier
            Read Sfl002lf;    // Lecture enregistrement suivant

          Enddo;

          // C -Cas particulier (aucun enregistrement)
          If RANG = *Zero;  // Si aucun enregistement à charger
            *In32 = *On;    // Indicateur de non affichage du SFL (Associé au mot clé SFLDSP)
          Endif;

          Write Fkey1;        // Affiche la ligne de touches de fonctions
          rang = 1;
          Exfmt Sf1ctl;       // Affiche le format de contrôle du SFL

       Enddo;

       *Inlr = *On;

      /End-Free
```
