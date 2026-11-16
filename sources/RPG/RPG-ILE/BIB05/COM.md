---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: COM
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 259
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/COM

```rpg
**FREE
// =============================================================
// COMPILMON - Moniteur de compilation via QSYS2.JOBLOG_INFO
// V3 - Fix: + au lieu de || pour concatenation RPG
//
// Compilation :
//   CRTSQLRPGI OBJ(QF_RPG/COMPILMON)
//              SRCFILE(QF_RPG/QRPGLESRC)
//              SRCMBR(COMPILMON)
//              COMMIT(*NONE)
//              DBGVIEW(*SOURCE)
//
// Appel :
//   CALL QF_RPG/COMPILMON
// =============================================================
ctl-opt dftactgrp(*no) actgrp(*caller);

exec sql set option commit = *none,
                    datfmt = *iso,
                    closqlcsr = *endmod;

// ---------------------------------------------------------
// Variables
// ---------------------------------------------------------
dcl-s commande    varchar(1024);
dcl-s qualJob     varchar(28);
dcl-s jobStatut   varchar(10);
dcl-s tentatives  int(5);
dcl-s msgTokens   varchar(256);
dcl-s nbLignes    int(10);

// Messages de compilation
dcl-s msgId       varchar(7);
dcl-s msgType     varchar(13);
dcl-s severite    int(5);
dcl-s msgTexte    varchar(512);
dcl-s ordPos      int(10);

// Compteurs
dcl-s compteurTotal int(5) inz(0);
dcl-s compteurOk    int(5) inz(0);
dcl-s compteurDiag  int(5) inz(0);
dcl-s compteurEsc   int(5) inz(0);

// Affichage
dcl-s ligne       varchar(52);

// =============================================================
// ETAPE 0 : Creer un JOBD avec LOGOUTPUT(*PND) dans QGPL
//           *PND = job log reste en memoire apres fin du job
//           QLOGOUTPUT sur Agrion = *JOBEND donc sans *PND
//           le job log est detruit a la fin du batch
// =============================================================
// Supprimer si deja existant (ignore erreur)
exec sql CALL QSYS2.QCMDEXC(
  'DLTJOBD JOBD(QGPL/COMPILPND)');

exec sql CALL QSYS2.QCMDEXC(
  'CRTJOBD JOBD(QGPL/COMPILPND) LOG(4 00 *SECLVL) LOGOUTPUT(*PND)');

// Verifier que le JOBD a ete cree
if sqlstate >= '02000';
  dsply 'ERREUR : CRTJOBD echoue';
  *inlr = *on;
  return;
endif;

dsply 'JOBD COMPILPND cree OK';

// =============================================================
// ETAPE 1 : Soumettre la compilation en batch
// =============================================================
commande = 'SBMJOB CMD(CRTSQLRPGI OBJ(QTEMP/ABOCLAUDE) ' +
           'SRCFILE(QF_RPG/QRPGLESRC) ' +
           'SRCMBR(ABOCLAUDE) ' +
           'COMMIT(*NONE) ' +
           'DBGVIEW(*SOURCE) ' +
           'OPTION(*EVENTF)) ' +
           'JOB(COMPABO) JOBQ(QBATCH) ' +
           'JOBD(QGPL/COMPILPND)';

exec sql CALL QSYS2.QCMDEXC(:commande);

if sqlstate >= '02000';
  dsply 'ERREUR : SBMJOB echoue';
  *inlr = *on;
  return;
endif;

dsply 'SBMJOB soumis OK';

// Delai pour laisser CPC1221 arriver
exec sql CALL QSYS2.QCMDEXC('DLYJOB DLY(1)');

// =============================================================
// ETAPE 2 : Recuperer le nom qualifie du job batch
//           CPC1221 dans NOTRE job log contient le nom du batch
// =============================================================
exec sql
  SELECT MESSAGE_TOKENS
    INTO :msgTokens
    FROM TABLE(QSYS2.JOBLOG_INFO('*')) A
    WHERE A.MESSAGE_ID = 'CPC1221'
    ORDER BY ORDINAL_POSITION DESC
    FETCH FIRST 1 ROW ONLY;

if sqlstate >= '02000' or msgTokens = '';
  dsply 'ERREUR : CPC1221 non trouve';
  *inlr = *on;
  return;
endif;

// MESSAGE_TOKENS CPC1221 :
//   pos 1-10  = nom du job
//   pos 11-20 = utilisateur
//   pos 21-26 = numero du job
qualJob = %trim(%subst(msgTokens:21:6)) + '/' +
          %trim(%subst(msgTokens:11:10)) + '/' +
          %trim(%subst(msgTokens:1:10));

ligne = 'Job batch : ' + qualJob;
dsply ligne;

// =============================================================
// ETAPE 3 : Attendre que le job batch soit termine
// =============================================================
tentatives = 0;
jobStatut = '';

dsply 'Attente fin du batch...';

// Delai initial 5 sec (CRTSQLRPGI = ~3-10 sec)
exec sql CALL QSYS2.QCMDEXC('DLYJOB DLY(5)');

dow tentatives < 60;
  tentatives += 1;
  jobStatut = '';

  exec sql
    SELECT JOB_STATUS
      INTO :jobStatut
      FROM TABLE(QSYS2.JOB_INFO(
             JOB_NAME_FILTER => :qualJob))
      FETCH FIRST 1 ROW ONLY;

  // Debug : afficher chaque tentative
  ligne = 'Poll #' + %char(tentatives) +
          ' sql=' + sqlstate +
          ' stat=' + %trim(jobStatut);
  dsply ligne;

  // OUTQ = job termine, job log dispo grace a *PND
  if jobStatut = 'OUTQ';
    leave;
  endif;

  // Job disparu
  if sqlstate >= '02000';
    dsply 'Job non trouve, on tente';
    leave;
  endif;

  // Pas fini, attendre 2 secondes
  exec sql CALL QSYS2.QCMDEXC('DLYJOB DLY(2)');
enddo;

if tentatives >= 60;
  dsply 'TIMEOUT : batch trop long';
  *inlr = *on;
  return;
endif;

ligne = 'OK apres ' + %char(tentatives) + ' polls';
dsply ligne;

// =============================================================
// ETAPE 4 : Compter les messages du job batch
// =============================================================
exec sql
  SELECT COUNT(*)
    INTO :nbLignes
    FROM TABLE(QSYS2.JOBLOG_INFO(
           JOB_NAME => :qualJob,
           IGNORE_ERRORS => 'YES')) A;

ligne = 'Joblog: ' + %char(nbLignes) + ' msg total';
dsply ligne;

// =============================================================
// ETAPE 5 : Lire les messages de compilation
// =============================================================
exec sql DECLARE curCompil CURSOR FOR
  SELECT ORDINAL_POSITION,
         MESSAGE_ID,
         MESSAGE_TYPE,
         SEVERITY,
         CAST(MESSAGE_TEXT AS VARCHAR(512) CCSID 1208)
    FROM TABLE(QSYS2.JOBLOG_INFO(
           JOB_NAME => :qualJob,
           IGNORE_ERRORS => 'YES')) A
    WHERE MESSAGE_ID IN ('RNS9304', 'RNS9308', 'RNS9310')
    ORDER BY ORDINAL_POSITION;

exec sql OPEN curCompil;

dsply '--- MESSAGES COMPILATION ---';

dow sqlstate = '00000';
  exec sql FETCH curCompil
    INTO :ordPos, :msgId, :msgType, :severite, :msgTexte;

  if sqlstate <> '00000';
    leave;
  endif;

  compteurTotal += 1;

  select;
    when msgType = 'COMPLETION';
      compteurOk += 1;
    when msgType = 'ESCAPE';
      compteurEsc += 1;
    when msgType = 'DIAGNOSTIC' and severite >= 30;
      compteurDiag += 1;
    other;
      compteurDiag += 1;
  endsl;

  // Afficher (tronque a 52 car pour DSPLY)
  ligne = msgId + ' S' +
          %editc(severite:'Z') + ' ' +
          %subst(msgTexte:1:
            %min(%len(%trimr(msgTexte)):35));
  dsply ligne;
enddo;

exec sql CLOSE curCompil;

// =============================================================
// ETAPE 6 : Bilan
// =============================================================
dsply '--- BILAN ---';

ligne = 'Total=' + %char(compteurTotal) +
        ' OK=' + %char(compteurOk) +
        ' Diag=' + %char(compteurDiag) +
        ' Esc=' + %char(compteurEsc);
dsply ligne;

if compteurEsc > 0;
  dsply 'RESULTAT : ECHEC';
elseif compteurOk > 0;
  dsply 'RESULTAT : SUCCES';
else;
  dsply 'RESULTAT : INDETERMINE';
endif;

*inlr = *on;
return;
```
