---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: EXO2
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 23
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/EXO2

```rpg
**free

// Options de contrôle : désactivation du groupe d'activation par défaut,
// utilisation du groupe d'activation de l'appelant
ctl-opt  dftactgrp(*no) actgrp(*caller);

// Déclaration du fichier CLIENT en lecture seule avec accès par clé
dcl-f CLIENT  Usage(*Input) Keyed;

// Déclaration de la variable numéro client (packed 5,0)
dcl-s nmcli packed(5:0);

// Recherche du client numéro 2
nmcli = 2;
chain nmcli client ;

// Si le client est trouvé, afficher son prénom
if %found();
  dsply precli;
endif;

// Fin du programme - libération des ressources
*inlr = *on;
```
