---
bibliotheque: BIB05
fichier_source: QFREERPGLE
membre: COLVERFULF
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 147
modifie: 2026-11-16
---

# BIB05/QFREERPGLE/COLVERFULF

```text
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
**free
//------------------------------------------------------------
// Description :
// Auteur      :
// Date        :
//------------------------------------------------------------
// Chaque bloc montre :
//   RPG IV colonnes fixes : l'ancienne écriture
//   Full free             : l'écriture moderne
//------------------------------------------------------------

//------------------------------------------------------------
// 1. Début du source
//------------------------------------------------------------
// RPG IV colonnes fixes : rien, le source commence directement
//                         par les spécifications (H, F, D, C, P)
// Full free             : "**free" en toute première ligne
//                         (déjà présent ci-dessus)

//------------------------------------------------------------
// 2. Options de contrôle (spec H)
//------------------------------------------------------------
// RPG IV colonnes fixes :
//   H DFTACTGRP(*NO) ACTGRP(*NEW)
// Full free :
// ctl-opt dftactgrp(*no) actgrp(*new) option(*srcstmt : *nodebugio);

//------------------------------------------------------------
// 3. Fichiers (spec F)
//------------------------------------------------------------
// RPG IV colonnes fixes :
//   FMONFICHIER IF   E           K DISK
// Full free :
// dcl-f MONFICHIER usage(*input) keyed;

//------------------------------------------------------------
// 4. Constantes (spec D, type C)
//------------------------------------------------------------
// RPG IV colonnes fixes :
//   D C_OK            C                   CONST(0)
// Full free :
// dcl-c C_OK const(0);

//------------------------------------------------------------
// 5. Variables (spec D, type S)
//------------------------------------------------------------
// RPG IV colonnes fixes :
//   D message         S             50A   VARYING INZ('Hello World !')
//   D rc              S             10I 0
// Full free :
dcl-s message varchar(50) inz('Hello World !');
// dcl-s rc int(10);

//------------------------------------------------------------
// 6. Structure de données (spec D, type DS)
//------------------------------------------------------------
// RPG IV colonnes fixes :
//   D maDs            DS
//   D  zone1                        10A
//   D  zone2                         7P 2
// Full free :
// dcl-ds maDs qualified;
//   zone1 char(10);
//   zone2 packed(7:2);
// end-ds;

//------------------------------------------------------------
// 7. Prototype (spec D, type PR)
//------------------------------------------------------------
// RPG IV colonnes fixes :
//   D traiter         PR            10I 0
//   D  pParam                       50A   VARYING CONST
// Full free :
// dcl-pr traiter int(10);
//   pParam varchar(50) const;
// end-pr;

//------------------------------------------------------------
// 8. Paramètres du programme
//------------------------------------------------------------
// RPG IV colonnes fixes :
//   C     *ENTRY        PLIST
//   C                   PARM                    pEntree
// Full free :
// dcl-pi *n;
//   pEntree char(10);
// end-pi;

//------------------------------------------------------------
// 9. Calculs (spec C)
//------------------------------------------------------------
// RPG IV colonnes fixes (code opération en colonnes 26-35) :
//   C                   EVAL      rc = 0
//   C                   DSPLY                   message
//   C                   IF        rc <> 0
//   C                   ENDIF
// Full free : le code s'écrit n'importe où, avec ";" à la fin
// rc = 0;
dsply message;
// if rc <> 0;
// endif;

//------------------------------------------------------------
// 10. Gestion d'erreur
//------------------------------------------------------------
// RPG IV colonnes fixes :
//   C                   MONITOR
//   C                   EVAL      rc = traiter(message)
//   C                   ON-ERROR
//   C                   ENDMON
// Full free :
// monitor;
//   rc = traiter(message);
// on-error;
//   dsply 'Erreur inattendue';
// endmon;

//------------------------------------------------------------
// 11. Fin du programme
//------------------------------------------------------------
// RPG IV colonnes fixes :
//   C                   EVAL      *INLR = *ON
//   C                   RETURN
// Full free :
*inlr = *on;
return;

//------------------------------------------------------------
// 12. Procédure (spec P)
//------------------------------------------------------------
// RPG IV colonnes fixes :
//   P traiter         B
//   D traiter         PI            10I 0
//   D  pParam                       50A   VARYING CONST
//   C                   RETURN    0
//   P traiter         E
// Full free :
// dcl-proc traiter;
//   dcl-pi *n int(10);
//     pParam varchar(50) const;
//   end-pi;
//
//   return 0;
// end-proc;
```
