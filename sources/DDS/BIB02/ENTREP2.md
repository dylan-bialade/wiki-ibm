---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: ENTREP2
type: DDS
longueur_enregistrement: 100
lignes: 48
modifie: 2026-11-16
---

# BIB02/QDDSRC/ENTREP2

```text
     FENTREP1   cf   e             Workstn
     F                                     Sfile(Sfl1:RANG)
     FENTREPOTLfif   e           k Disk    PREFIX(ENT_)
     DSflmax           C                   Const(500)
     DRANG             S              4  0
      /Free

       Dou *IN03;  // Sortie si touches F3

          // A- Initialisation du sous-fichier
          RANG = *Zero;   // Initialisat° du compteur d'enregistrement.
          *In31 = *On;    // Activat° de l'indic de vidage de SFL  (Associé au m
          Write Sf1ctl;      // Vidage du sous-fichier
          *In31 = *Off;   // Désactivat° de l'indic de vidage de SFL (Associé au

          // B- Lecture de la base de données
          Setll (Z_CODPRO) ENTREPOTL1; // Position avec la saisie
          Read ENTREPOTL1;

          // B- Tant que non fin de fichier
          Dow (Not %eof) And (RANG <= Sflmax); // TQ Non Fin de Fichier et limit

            RANG += 1;  // Incrémentation du compteur de ligne
            // les zones du PF ayant le même nom que celle du SFL, le "move" de
            // est implicite et ça se passe ici !
            CODPRO = ENT_CODPRO;
            NMPRO= ENT_NMPRO;
            QTPRO = ENT_QTPRO;
            DTDINV  = ENT_DTDINV;
            Write Sfl1;       // Ecriture du format de sous-fichier
            Read  ENTREPOTL1;    // Lecture enregistrement suivant

          Enddo;

          // C -Cas particulier (aucun enregistrement)
          If RANG = *Zero;  // Si aucun enregistement à charger
            *In32 = *On;    // Indicateur de non affichage du SFL (Associé au mo
          Endif;

          Write Fkey1;        // Affiche la ligne de touches de fonctions
          rang = 1;
          Exfmt Sf1ctl;       // Affiche le format de contrôle du SFL

       Enddo;

       *Inlr = *On;

      /End-Free
```
