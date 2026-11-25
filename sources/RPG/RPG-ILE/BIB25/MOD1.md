---
bibliotheque: BIB25
fichier_source: QMODSRC
membre: MOD1
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 27
modifie: 2026-11-25
---

# BIB25/QMODSRC/MOD1

```rpg
**free
ctl-opt NOMAIN copyright('(C) ORGFORM 2025.') DATFMT(*ISO);

// Procédures de lecture de fichier : test
// Déclaration fichier EMPLOYES
DCL-F EMPLOYES usage(*input) keyed
        RENAME(EMPLOYES:FEMPLOYES);

DCL-DS EmployeDS EXTNAME('EMPLOYES') qualified END-DS;
// Procédure CHAIN sur le fichier des employes
DCL-PROC LireEmploye EXPORT;
    dcl-pi *n ind;
        id packed(9:0);
        RemployeDS likeds(EmployeDS);
    end-pi;
    CHAIN id FEMPLOYES;
    if %found;
        RemployeDS.ID = ID;
        RemployeDS.NOM = NOM;
        RemployeDS.PRENOM = PRENOM;
        RemployeDS.DATE_ENTRE = DATE_ENTRE;
        RemployeDS.SALAIRE = SALAIRE;
        return *on;
    else;
        return *off;
    endif;
END-PROC;
```
