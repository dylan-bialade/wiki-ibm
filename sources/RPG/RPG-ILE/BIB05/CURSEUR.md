---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: CURSEUR
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 66
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/CURSEUR

```rpg
**FREE
CTL-OPT COPYRIGHT('(C) ORGFORM 2025.') OPTION(*SRCSTMT) DFTACTGRP(*NO)
ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO);

//**********************************************************************//
// Prototype de l'API QMHSNDPM - Envoi d'un message dans la joblog    //
//**********************************************************************//
Dcl-Pr SndMsg    ExtPgm('QMHSNDPM');
  MsgId         Char(7)   Const;
  MsgFile       Char(20)  Const;
  MsgData       Char(256) Const;
  MsgDataLen    Int(10)   Const;
  MsgType       Char(10)  Const;
  CallStkEntry  Char(10)  Const;
  CallStkCount  Int(10)   Const;
  MsgKey        Char(4);
  ErrorDs       Char(15);
End-Pr;

//**********************************************************************//
// Déclaration des variables                                            //
//**********************************************************************//
Dcl-S Nom      Char(20);
Dcl-S Prenom   Char(20);
Dcl-S WkMsg    Char(256);
Dcl-S MsgKey   Char(4);
Dcl-S ErrDs    Char(15) Inz(*ALLX'00');

//**********************************************************************//
// Traitement principal                                                 //
//**********************************************************************//
EXEC SQL
 SET option commit = *NONE , Datfmt = *iso,
 timfmt =*iso, ALWCPYDTA = *OPTIMIZE, CLOSQLCSR = *ENDMOD;


// Déclaration du curseur
EXEC SQL DECLARE C1 CURSOR FOR
  SELECT NOMCLI, PRECLI FROM QF_RPG.client;

// Ouverture du curseur
EXEC SQL OPEN C1;

EXEC SQL FETCH C1 INTO :Nom, :Prenom;

// Récupération en boucle
Dow sqlcod = 0;
   // Construction et envoi du message dans la joblog
   WkMsg = %TRIM(Nom) + ' ' + %TRIM(Prenom);
   SndMsg('CPF9897'            // ID message générique
         :'QCPFMSG   *LIBL'   // Fichier message
         :WkMsg                // Données du message
         :%Len(%TrimR(WkMsg))  // Longueur des données
         :'*INFO'              // Type de message
         :'*'                  // Pile d'appel : appelant immédiat
         :0                    // Niveau dans la pile
         :MsgKey               // Clé retournée
         :ErrDs);              // Zone d'erreur

   EXEC SQL FETCH C1 INTO :Nom, :Prenom;
EndDo;

// Fermeture du curseur
EXEC SQL CLOSE C1;

*inlr = *on;
```
