---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: TP3
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 35
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/TP3

```text
     FLIVRESL   IF   E           K Disk
     FLIVDSP    CF   E             Workstn
      /free
       // Boucle principale tant que l'utilisateur n'appuie pas sur la touche F3
       DOW  *inkc = *off ;

         // Affichage de l'écran FMT1 pour que l'utilisateur saisisse un ISBN
         exfmt fmt1;

         //Si l'utilisateur n'a pas appuyé sur F3
         IF  *INKC = *off ;

         // Lecture du livre dans le fichier logique LIVRESL en fonction de l'ISBN saisi
           chain ISBN LIVRESL;

           // Si le livre est trouvé
           IF (%found);

            // Nouvelle boucle d'affichage de l'écran FMT2, tant que l'utilisateur
             // n'appuie ni sur F12 (INKL) ni sur F3 (INKC)
             DOW  *INKL = *off and *INKC = *off ;

               // Affiche l'écran FMT2 pour afficher/modifier les infos du livre
               exfmt fmt2;

             ENDDO;  // Fin de boucle écran FMT2

           ENDIF;     // Fin du IF %FOUND

         ENDIF;     // Fin du IF INKC = *OFF

       ENDDO;      // Fin de boucle principale (tant que F3 non pressé)

       *INLR = *on;
      /end-free
```
