---
bibliotheque: BIB17
fichier_source: QCPYSRC
membre: ANZSRVP
type: RPG/Copy
longueur_enregistrement: 100
lignes: 84
modifie: 2026-11-16
---

# BIB17/QCPYSRC/ANZSRVP

```rpg
**free
/if not defined(ANZSRVP)
/define ANZSRVP
dcl-pr checkExistance ind;
    obj char(10);
    lib char(10);
end-pr;



//----------------------------------------------------------------
// Modèles de lignes (une DS par sous-fichier)
//----------------------------------------------------------------

// Programme lié au programme de service (SFLPGM)
dcl-ds pgmLie_t qualified template;
    biblio    char(10);
    nom       char(10);
    objType   char(10);
    signature char(32);
end-ds;

// Module du programme de service (SFLMOD)
dcl-ds module_t qualified template;
    nom       char(10);
    biblio    char(10);
    attribut  char(10);
    srcBiblio char(10);
    srcFich   char(10);
    srcMbr    char(10);
    dateCrea  date;
end-ds;

// Procédure exportée (SFLPRO)
dcl-ds procExp_t qualified template;
    nom       varchar(100);
end-ds;


//----------------------------------------------------------------
// Programmes liés
//----------------------------------------------------------------
dcl-pr openPgmCursor ind;
    srvpgm char(10) const;
    lib    char(10) const;
end-pr;

dcl-pr fetchPgm ind;
    ligne likeds(pgmLie_t);
end-pr;

dcl-pr closePgmCursor end-pr;

//----------------------------------------------------------------
// Modules
//----------------------------------------------------------------
dcl-pr openModCursor ind;
    srvpgm char(10) const;
    lib    char(10) const;
end-pr;

dcl-pr fetchMod ind;
    ligne likeds(module_t);
end-pr;

dcl-pr closeModCursor end-pr;

//----------------------------------------------------------------
// Procédures exportées
//----------------------------------------------------------------
dcl-pr openExpCursor ind;
    srvpgm char(10) const;
    lib    char(10) const;
end-pr;

dcl-pr fetchExp ind;
    ligne likeds(procExp_t);
end-pr;

dcl-pr closeExpCursor end-pr;



/endif
```
