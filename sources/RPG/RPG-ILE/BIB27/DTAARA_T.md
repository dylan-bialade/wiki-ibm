---
bibliotheque: BIB27
fichier_source: QRPGLESRC
membre: DTAARA_T
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 40
modifie: 2026-11-25
---

# BIB27/QRPGLESRC/DTAARA_T

```rpg
**free

// La dtaara va servir à stocke de l'information brut
// *LDA (Local Data Area) encloisoner au travail en cours


// Création de DTAARA
// CRTDTAARA DTAARA(BIB27/DTAARA_T) TYPE(*CHAR) LEN(100) +
//            VALUE('nombre commande : 0')

// Afficher la DTAARA
// DSPDTAARA DTAARA(BIB27/DTAARA_T)


// Déclaration DTAARA dans programe RPG
dcl-ds dtaara_t dtaara len(100) ;
    text char(18);
    nbr char(5) ;
    nbr2 zoned(5:0) pos(19);
end-ds ;


// Déclaration de variables
dcl-s aff char(50);

in *lock DTAARA_T;  // Obligatoire

if %dec(nbr:5:0) < 2;
    nbr2 += 1;
ENDIF;

aff = text + nbr;
dsply aff;

out DTAARA_T;   // Obligatoire



// sortie du programme
*inlr = *on;
```
