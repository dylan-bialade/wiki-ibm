---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: FFSFR3
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 387
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/FFSFR3

```rpg
**FREE
ctl-opt copyright('(C) ARMONIE 2024.') dftactgrp(*no) optimize(*none)
actgrp(*caller) datfmt(*iso) timfmt(*iso) alloc(*stgmdl)
stgmdl(*inherit) thread(*serialize) ;

// ----------------------------------------------------------------------//
//   Programme     : FFSFR                                               //
//   Libelle       : Sous-fichier de la table entrepot                   //
//   Observation   : Ce programme est un exemple de sous-fichier         //
// ----------------------------------------------------------------------//
//   Menu :                                                              //
// ----------------------------------------------------------------------//
// 22/11/2023 | SYLVAIN | Créat |                                        //
// ----------------------------------------------------------------------//

// **********************************************************************//
// Déclaration des fichiers                                              //
// **********************************************************************//
dcl-f SFDSPSQL2 WORKSTN SFILE(SFL1:rang);


// **********************************************************************//
// Déclaration des prototypes                                            //
// **********************************************************************//
// Envoi message programme.
Dcl-PR Qmhsndpm  extpgm('QSYS/QMHSNDPM');
  MsgId          Char(7)    const;
  MsgF           Char(20)   const;
  MsgDta         Char(512)  options(*varsize) const;
  MsgDtaLen      Int(10)    const;
  MsgType        Char(10)   const;
  PgmQ           Char(10)   const;
  Stk            Int(10)    const;
  MsgKey         Char(4)    const;
  ErrorCode      likeds(Errcode);
End-pr;

// Vidage d une file de message
dcl-pr vidMsgQ  extpgm('QSYS/QMHRMVPM');
  MsgQueue       Char(276)   const;
  CallStack      Int(10)     const;
  MsgKey         Char(4)    const;
  MsgRmv         Char(10)   const;
  Error                     like( errorDS );
end-pr;

// **********************************************************************//
// Déclaration des DS                                                    //
// **********************************************************************//
dcl-ds *N PSDS;
  PgmPrc *PROC;
  PgmSts *STATUS;
  PgmExr *ROUTINE;
  PgmPrm *PARMS;
  PgmEri char(7)    pos(40);
  PgmLib char(10)   pos(81);
  PgmErm char(80)   pos(91);
  PgmDt8 char(8)    pos(191);
  PgmJnm char(10)   pos(244);
  PgmUsr char(10)   pos(254);
  PgmJnb zoned(6:0) pos(264);
end-ds;

Dcl-ds Errcode;
  BytesProv       Int(10) Inz(*zero);
  BytesAvail      Int(10) Inz(*zero);
End-ds;


// Erreur restituee par l API QMHRMVPM.
Dcl-DS errorDS Len(16);
  ByteProv      Int(10)    inz(%size(errorDS));
  ByteAvail     Int(10);
  ExceptionID   Char(7);
End-DS;



// **********************************************************************//
// Déclaration des variables                                             //
// **********************************************************************//
dcl-s last_rang zoned(4:0) inz(*zero); // Dernier rrn écrit av pagination
dcl-s i         zoned(4:0) inz(*zero);
dcl-s datejour  date(*iso) inz(*job);
dcl-s test1 zoned(10:0);
dcl-s ht int(10) inz(100);
dcl-s tva int(3) inz(20);

// **********************************************************************//
// Déclaration des constantes                                            //
// **********************************************************************//
dcl-c SFLPAG    const(12);   // Nombre de ligne à afficher par page ...
dcl-c AFFICHER  const('5');
dcl-c SUPPRIMER const('4');
dcl-c MODIFIER  const('2');



// **********************************************************************//
// Traitement pricipal                                                   //
// **********************************************************************//

// Option de compilation SQL
exec sql
set option commit = *none , alwcpydta = *optimize, closqlcsr = *endmod, dlyprp = *yes,
datfmt=*iso, timfmt=*iso;



// A - initialisation du sous-fichier
initialisation_sous_fichier();

// B - fabrication du sous-fichier
fabrication_sous_fichier();

// La zone de "afficher à partir de" à blanc
scodpro = *blank;



dou *in03;  // Sortie F3

  write MSGSFLH;
  write Fkey1;


  exfmt SF1CTL;
  vidMsgQ (PGMPRC: *zero: *blanks: '*ALL': errorDS);

  // Et là, on se pose la question : Qu'à fait l'utilisateur ?
  select;
  when scodpro <> *blank; // a-t-il touché à la zone "Afficher à partir de" ?
    exec sql close c1;
    initialisation_sous_fichier();
    fabrication_sous_fichier();
    clear Scodpro;
  when *in39;    // a-t-il paginé ? (Pagedown)
    fabrication_sous_fichier();
  when *in05; // F5=Réafficher
    exec sql close c1;
    initialisation_sous_fichier();
    fabrication_sous_fichier();
  when *in06; // F6=Création
    creation();
    exec sql close c1;
    initialisation_sous_fichier();
    fabrication_sous_fichier();
  other; // La touche ENTRER
    exec sql
    SELECT codpro INTO :e1codpro FROM entrepot;
    if sqlcode <> 100;
      trt_readc();  // on fait un readc seulement s'il y a des données
    endif;

    exec sql close c1;
    initialisation_sous_fichier();
    fabrication_sous_fichier();
  endsl;

enddo;

exec sql close c1;
*inlr = *on;

// ************************************************************************
// initialisation du sous fichier                                       //
// ************************************************************************
dcl-proc initialisation_sous_fichier;
  rang = *zero;      // initialisat° du compteur d'enregistrement.
  last_rang = *zero; // initialisat° du dernier rrn d'enregistrement.
  *in31 = *on;       // Activat° de l'indic de vidage de SFL  (Associé au mot clé SFLCR)
  write SF1CTL;      // Vidage du sous-fichier
  *in31 = *off;      // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLCLR)
  *in32 = *off;      // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLDSP)
  *in90 = *off;      // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLend)
  exec sql
    DECLARE c1 CURSOR FOR
    (select codpro, nmpro, qtpro, dtdinv
    from entrepot
    order by codpro)
    FOR READ ONLY OPTIMIZE FOR 12 ROWS;

  exec sql
    open c1;
end-proc;

// ************************************************************************
// fabrication du sous fichier                                          //
// ************************************************************************
dcl-proc fabrication_sous_fichier;
  rang = last_rang;        // Le "RRN" reçoit la valeur du dernier rang

  for i=1 to SFLPAG;  // Tantque i est inférieur à sflpag
    exec sql FETCH c1 INTO :e1codpro, :e1nmpro, :e1qtpro, :e1dtdinv;
    if sqlcode = 100;
      *in90=*on;   // "Fin" en bas à droite de l'écran et on sort.
      leave;
    endif;

    // Gere le "Afficher à partir de..."
    if e1codpro >= scodpro;
      rang += 1;  // incrémentation du compteur de ligne
      write SFL1; // Ecrie le sous-fichier
    endif;
  endfor;


  if rang = *zero;
    *in32 = *on;
  endif;

  last_rang = rang;

end-proc;


// ******************************************************************
// Traitement du READC                                            //
// ******************************************************************
dcl-proc trt_readc;
  Readc SFL1;
  dow not %eof;
    select;
    when opt = AFFICHER;  // option 5 Afficher
      affiche();
    when opt = SUPPRIMER; // option 4 Supprimer
      suppression();
    when opt = MODIFIER;  // option 2 Modifier
      modification();
    endsl;
    Readc SFL1;
  enddo;
end-proc;

// ************************************************************************
// Créer                                                                //
// ************************************************************************
dcl-proc creation;
  dou *in03;
    e6dtdinv = datejour;
    exfmt FMT6; // Affiche l'ecran de création
    select;
    when *in03;
      iter;
    when *in12;
      leave;
    when *in23;
      // Exemple gestion d'erreur sur l'ecran avec indicateur
      if e6codpro = *blank;
        *in70=*on;
      else;
        exec sql
          INSERT INTO entrepot (codpro, nmpro, qtpro, dtdinv)
          VALUES (:e6codpro, :e6nmpro, :e6qtpro, :datejour);
        gstErrSQL();
        SndPgmMsg('Ajout réussi');
        leave;
      endif;
    endsl;
  enddo;
  clear opt; // Remise à blanc de l'option saisie
end-proc;

// ************************************************************************
// Afficher                                                             //
// ************************************************************************
dcl-proc affiche;
  exec sql
    SELECT codpro, nmpro, qtpro, dtdinv
    INTO :e5codpro, :e5nmpro, :e5qtpro, :e5dtdinv
    FROM entrepot
    WHERE codpro = :e1codpro;
  exfmt FMT5;
  clear opt; // Remise à blanc de l'option saisie
end-proc;

// ************************************************************************
// Modifier                                                             //
// ************************************************************************
dcl-proc modification;
  exec sql
    select codpro, nmpro, qtpro, dtdinv
    INTO :e2codpro, :e2nmpro, :e2qtpro, :e2dtdinv
    FROM entrepot
    WHERE codpro = :e1codpro;
  dou *in03;
    exfmt FMT2; // Affiche l'ecran de modification
    select;
    when *in03;
      iter;
    when *in12;
      leave;
    when *in23;
      exec sql
        UPDATE entrepot
        SET codpro = :e2codpro, nmpro = :e2nmpro,
        qtpro = :e2qtpro, dtdinv = :E2DTDinV
        WHERE codpro = :e2codpro;
      gstErrSQL();
      SndPgmMsg('Modification réussi');
      leave;
    other;
      SndPgmMsg('Touche non permise');
      write MSGSFLH;
      vidMsgQ (PGMPRC: *zero: *blanks: '*ALL': errorDS);
    endsl;
  enddo;
  clear opt;    // Remise à blanc de l'option saisie
  update SFL1;  // Mets à jour le Sous-fichier
end-proc;

// ************************************************************************
// Supprimer                                                            //
// ************************************************************************
dcl-proc suppression;
  exec sql
    SELECT codpro, nmpro, qtpro, dtdinv
    INTO :e4codpro, :e4nmpro, :e4qtpro, :e4dtdinv
    FROM entrepot
    WHERE codpro = :e1codpro;
  dou *in03;
    exfmt FMT4 ; // Affiche l'ecran de suppression
    select;
    when *in03;
      iter;
    when *in12;
      leave;
    when *in23;
      exec sql
          delete from entrepot where codpro = :e4codpro;
      gstErrSQL();
      SndPgmMsg('Suppression réussi');
    other;
      SndPgmMsg('Touche non permise');
      write MSGSFLH;
      vidMsgQ (PGMPRC: *zero: *blanks: '*ALL': errorDS);
    endsl;
  enddo;
  clear opt; // Remise à blanc de l'option saisie
  update SFL1;   // Mets à jour le Sous-fichier
end-proc;



// ************************************************************************
// Envoi Message                                                        //
// ************************************************************************
dcl-proc SndPgmMsg;
  dcl-pi *n extproc(*dclcase);
    PMsgDta         Char(512)  options(*varsize) const;
  end-pi;
  dcl-s msgkey char(4);
  dcl-s STACK_OFFSET int(10) inz(0);

  Qmhsndpm('CPF9897':'QCPFMSG   QSYS':
          PMsgDta:
          %LEN(PMsgDta):'*DIAG':
         PGMPRC:STACK_OFFSET:msgkey:Errcode);
end-proc;


// ------------------------------------------------------------------------
// ************************************************************************
// Gestion Erreur SQL *                                                   *
// ****************                                                       *
// ************************************************************************
Dcl-Proc gstErrSQL;
  // Pour envoi de messages d'erreur.
  dcl-s msgId      char(7) inz('CPF9898');
  dcl-s msgData    varchar(32767);
  dcl-s msgText    varchar(256);
  dcl-s msgDataLen int(10);

  if sqlCode < 0;
    msgData = 'Erreur SQL ' + %char(sqlcode);
    exec sql get diagnostics condition 1
         :msgText = MESSAGE_TEXT;

    if %len(msgText) > 0;
      msgData = msgData + ' : ' + %trim(msgText);
    endif;

    msgDataLen =  %len(msgData);
    Qmhsndpm( msgId : 'QCPFMSG   QSYS      ' : msgData
              : msgDataLen : '*ESCAPE': PGMPRC : 2 : msgKey : Errcode );
  endif;
End-Proc;
```
