---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: TP2
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 14
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/TP2

```text
     FCLIENT    IF   E           K Disk
     DNMCLI            S              5S 0
      * Début du programme principal
      /free
       NMCLI = 2;            // On affecte la valeur 2 à la variable NMCLI (on cherche le client n°2

       Chain NMCLI CLIENT;   // On cherche dans le fichier CLIENT lenregistrement correspondant à N

       If %found;           // Si un client avec ce numéro existe...
         dsply PRECLI;       // On affiche à l'écran le nom du client (zone PRECLI issue du fichier
       endif;

       *inlr = *on;     // Fin du programme
      /end-free
```
