---
bibliotheque: BIB25
fichier_source: QMODSRC
membre: PGM1
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 39
modifie: 2026-11-25
---

# BIB25/QMODSRC/PGM1

```rpg
**free
CTL-OPT DFTACTGRP(*NO) ACTGRP(*new);


// Déclaration DS envoyé en paramètre
DCL-DS EmployeDS EXTNAME('EMPLOYES') qualified END-DS;
DCL-DS RemployeDS likeds(EmployeDS);

// Réception des paramètres
DCL-PI *N;
    idEmp packed(9:0);
END-PI;

// Déclaration du prototype procédure
DCL-PR LireEmploye ind;
    id packed(9:0);
    RemployeDS likeds(EmployeDS);
END-PR;

// Déclaration indicateur retour
DCL-S find ind;

// Utilisation de la procédure
find = LireEmploye(idEmp:RemployeDS);

// Résultats
if find;
    dsply 'Enregistrement trouvé';
    dsply ('ID : ' + %char(RemployeDS.ID));
    dsply ('NOM : ' + RemployeDS.NOM );
    dsply ('PRENOM : ' + RemployeDS.PRENOM );
    dsply ('Date d''entrée : ' + %char(RemployeDS.DATE_ENTRE));
    dsply ('Salaire : ' + %char(RemployeDS.SALAIRE));
else;
    dsply 'Enregistrement non trouvé';
endif;

// sortie du programme
*INLR = *ON;
```
