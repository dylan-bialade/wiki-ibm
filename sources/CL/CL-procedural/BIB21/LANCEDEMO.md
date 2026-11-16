---
bibliotheque: BIB21
fichier_source: QCLSRC
membre: LANCEDEMO
type: CL/CL-procedural
longueur_enregistrement: 100
lignes: 333
modifie: 2026-11-16
---

# BIB21/QCLSRC/LANCEDEMO

```cl
/* ================================================================= */
/* LANCEDEMO - LANCEUR DE L'APPLICATION DE DEMONSTRATION DEMOAPP     */
/*             Bibliotheque : BIB21      Source : BIB21/QCLSRC   */
/* ================================================================= */
/*                                                                   */
/* Lancement :    CALL BIB21/LANCEDEMO                             */
/*                                                                   */
/* Ce programme est le SEUL objet de l'application place hors de la  */
/* bibliotheque DEMOAPP. Il verifie que DEMOAPP existe, la met en    */
/* tete de la liste de bibliotheques, appelle le point d'entree      */
/* DEMOAPP/EXSTART puis remet la liste de bibliotheques en l'etat.   */
/*                                                                   */
/* L'en-tete ci-dessous documente l'ensemble du projet : c'est la    */
/* "notice" de l'application.                                        */
/*                                                                   */
/* ================================================================= */
/* 1. OBJECTIF                                                       */
/* ================================================================= */
/* Application 5250 de demonstration pour les supports de cours      */
/* IBM i. Chaque ecran montre une fonctionnalite, avec :             */
/*   - des explications DANS LE CODE (commentaires tres detailles    */
/*     dans chaque source DDS, RPG, CL et SQL) ;                     */
/*   - des explications A L'ECRAN : encadre turquoise "Ce que montre */
/*     cet ecran" (mode, mots-cles, indicateurs, astuces).           */
/* Themes : administration IBM i, DDS et ecrans 5250, fichiers PF et */
/* LF, langage CL, RPG (III, IV fixe, free-format, full free) et     */
/* sous-fichiers (10 variantes).                                     */
/* Les donnees sont les joueurs d'un jeu video en ligne.             */
/*                                                                   */
/* ================================================================= */
/* 2. PREREQUIS                                                      */
/* ================================================================= */
/* - Session 5250 en 27 lignes x 132 colonnes pour la plupart des    */
/*   ecrans (DSPSIZ(*DS4)). Dans ACS : Emulateur 5250 > Communication*/
/*   > Configurer > Taille d'ecran 27x132 (type d'unite 3477-FC).    */
/* - En 24x80, le menu (double taille *DS4 *DS3) s'affiche quand     */
/*   meme : un avertissement rouge apparait en ligne 21 et les       */
/*   options marquees (27x132) sont refusees avec un message, au     */
/*   lieu de laisser l'ouverture de l'ecran echouer (CPF4169).       */
/*   Restent accessibles en 24x80 : CL (option 4), sous-fichier      */
/*   statique 24x80 (option 6 puis 2), reinitialisation (option 9).  */
/* - Profil ayant les droits sur DEMOAPP (*USE sur les programmes,   */
/*   *CHANGE sur les fichiers pour les CRUD).                        */
/*                                                                   */
/* ================================================================= */
/* 3. ARBORESCENCE DES MENUS                                         */
/* ================================================================= */
/* LANCEDEMO (BIB21) -> EXSTART (DEMOAPP) -> EXMNUP / EXMNUD       */
/*                                                                   */
/* Menu principal (MNU00)                                            */
/*  1  Administration IBM i ..... EXADMP  (27x132)                   */
/*       Catalogue EXADMCMD : 53 commandes en 11 categories.         */
/*       5=explication (fenetre), 4=invite, 1=executer (si permis).  */
/*  2  DDS et ecrans 5250 ....... EXDDSP  (27x132)                   */
/*       12 ecrans : DSPATR, COLOR, types et usages, EDTCDE/EDTWRD,  */
/*       controles de saisie, touches CA/CF, messages, fenetres,     */
/*       controles graphiques (MNUBAR...), curseur et superposition, */
/*       DSPSIZ/DSPMOD, aide HLPRCD/HLPARA.                          */
/*  3  Fichiers PF / LF ......... EXPFLFP (27x132)                   */
/*       5=fiche du fichier + 50 enregistrements lus PAR CE FICHIER, */
/*       7=DSPFD  8=DSPFFD  9=DSPDBR.                                */
/*  4  Langage CL ............... EXCLP   (24x80, sous-menu en CL)   */
/*       EXCL01 variables et fonctions  EXCL02 MONMSG / erreurs      */
/*       EXCL03 DCLF/RCVF statistiques  EXCL04 RTVJOBA / DTAARA      */
/*       EXCL05 OVRDBF/RUNSQL/SBMJOB    EXCL06 structures controle   */
/*  5  Sous-menu RPG (MNU05) : meme programme ecrit 4 fois,          */
/*     ecran commun EXRPGD (27x132)                                  */
/*       1 EXR3P  RPG III (QRPGSRC, CRTRPGPGM)                       */
/*       2 EXR4P  RPG IV format fixe                                 */
/*       3 EXRXP  RPG IV free-format (/FREE ... /END-FREE)           */
/*       4 EXRFP  RPG IV full free (**FREE)                          */
/*  6  Sous-menu sous-fichiers (MNU06)                               */
/*       1 EXSF01P statique, affichage simple         (27x132)       */
/*       2 EXSF02P statique, affichage simple         (24x80)        */
/*       3 EXSF03P statique + CRUD                    (27x132)       */
/*       4 EXSF04P statique + filtres multicriteres   (27x132)       */
/*       5 EXSF05P statique + "Afficher a partir de"  (27x132)       */
/*       6 EXSF06P statique, TOUTES les options       (27x132)       */
/*       7 EXSF07P semi-dynamique (sans remise a blanc)  (27x132)    */
/*       8 EXSF08P semi-dynamique, TOUTES les options (27x132)       */
/*       9 EXSF09P dynamique complet (remise a blanc) (27x132)       */
/*      10 EXSF10P dynamique complet, TOUTES options  (27x132)       */
/*      11 Schema des 3 modes de sous-fichier (ecran SCHSFL)         */
/*  7  Sous-menu SQL (MNU07)                                         */
/*       1 EXSQLP  SQL natif DB2 for i                 (27x132)      */
/*         schemas DDS/SQL, *SYS/*SQL, SQE/CQE, commit ;             */
/*         navigateur de 58 requetes (EXSQLREQ) : SELECT, jointures, */
/*         CTE, OLAP, JSON, catalogue QSYS2, services IBM i ;        */
/*         DDL en direct (EXSQLDDL), DML en direct, commandes.       */
/*       2 EXSQEP  SQL embarque dans le RPG (SQLRPGLE)  (27x132)     */
/*         precompilation, variables hotes, indicateurs NULL,        */
/*         curseurs (multi-lignes, SCROLL, FOR UPDATE, WITH HOLD),   */
/*         SQL dynamique et injection, transactions et journal,      */
/*         diagnostics, natif contre SQL, procedure et UDF.          */
/*  8  Environnement ILE ........ EXILEP  (27x132)                   */
/*       OPM/ILE, *MODULE, *PGM (liaison par copie), *SRVPGM         */
/*       (reference, signature, source de liage), *BNDDIR,           */
/*       groupes d'activation (demo vivante EXILESV), pile           */
/*       d'appels et messages, parametres, inspection en direct.     */
/*  9  Reinitialiser les donnees (RUNSQLSTM de QSQLSRC/EXJOUDTA)     */
/* 10  Schema de l'architecture de DEMOAPP (ecran SCHARC)            */
/* 90  Quitter                                                       */
/* Ligne de commande du menu : toute commande CL (QCMDEXC),          */
/* F4 = invite, F9 = rappel. F1 = aide. F3 = quitter partout,        */
/* F12 = retour a l'ecran precedent.                                 */
/* F2 sur TOUS les ecrans : masque / affiche l'encadre pedagogique   */
/* (etat commun : octet 1024 de la *LDA, remis a blanc par EXSTART). */
/*                                                                   */
/* "TOUTES les options" des sous-fichiers 06, 08 et 10 :             */
/*   CRUD (2 modifier, 3 copier, 4 supprimer avec confirmation,      */
/*   5 afficher, F6 creer, verrou optimiste), 8 = inventaire des 30  */
/*   cases en fenetre, filtres, "a partir de", tri par colonne       */
/*   (curseur sur l'en-tete, RTNCSRLOC), vue 2 (F11), barre de       */
/*   defilement, sous-fichier message, couleurs selon le statut.     */
/*                                                                   */
/* ================================================================= */
/* 4. INVENTAIRE DES OBJETS DE DEMOAPP                               */
/* ================================================================= */
/* Base de donnees (source QDDSSRC)                                  */
/*   EXREF     PF  dictionnaire de reference (REFFLD), sans donnees  */
/*   EXJOUEUR  PF  joueurs, SANS CLE, 15 000 enregistrements         */
/*   EXCLASSE  PF  10 classes de personnage, cle UNIQUE CLCODE       */
/*   EXADMCMD  PF  catalogue des commandes d'administration          */
/*   EXJOUL01  LF  cle JOID, UNIQUE : acces des CRUD                 */
/*   EXJOUL02  LF  cle pseudo + id : "Afficher a partir de"          */
/*   EXJOUL03  LF  classement : niveau DESCEND, XP DESCEND           */
/*   EXJOUL04  LF  cle classe + niveau, S(elect) statut = 'A'        */
/*   EXJOUL05  LF  O(mit) bannis, RANGE niveau 10-100, DYNSLT,       */
/*                 cle serveur + rang                                */
/*   EXJOUL06  LF  projection, RENAME, CONCAT, SST, FIFO,            */
/*                 cle guilde + pseudo                               */
/*   EXJOUL07  LF  JOINTURE joueur x classe (JFILE, JFLD, JDFTVAL)   */
/*   EXJOUL08  LF  MULTI-FORMAT : classe puis ses joueurs            */
/*   EXJOUL09  LF  inscription DESCEND + solde PvP ABSVAL DESCEND    */
/* Scripts SQL (QSQLSRC)                                             */
/*   EXJOUDTA  recharge EXCLASSE + 15 000 joueurs (valeurs           */
/*             deterministes : CTE recursive + MOD)                  */
/*   EXADMDTA  recharge le catalogue EXADMCMD                        */
/* Utilitaires ILE                                                   */
/*   EXUTIL    *SRVPGM : sndMsg, sndMsgId, clrMsg (messages du       */
/*             sous-fichier message), execCmd (QCMDEXC), modeEcran   */
/*             (QsnRtvMod), centrer. Prototypes : QRPGLESRC/EXUTILPR */
/*   EXBNDDIR  *BNDDIR contenant EXUTIL                              */
/*   EXMSGF    *MSGF messages des demonstrations DDS                 */
/*   QSRVSRC/EXUTIL  source de liage (STRPGMEXP) : signature         */
/*             DEMOAPP_EXUTIL_V (16 car. max) ; procedures F2 :      */
/*             encadreMasque, basculerEncadre, initEncadre           */
/*   EXDDSMC   CL qui (re)cree EXMSGF                                */
/* Menus                                                             */
/*   EXSTART   CL point d'entree (*LIBL + appel du menu)             */
/*   EXMNUD / EXMNUP  menus en double taille                         */
/* Themes (xxxxD = DSPF, xxxxP ou xxxx = programme)                  */
/*   EXADMD / EXADMP     administration (SQLRPGLE)                   */
/*   EXDDSD, EXDDS01D a EXDDS12D / EXDDSP   demonstrations DDS       */
/*   EXPFLFD / EXPFLFP   PF et LF (E/S natives)                      */
/*   EXCLD / EXCLP, EXCL01 a EXCL06, EXCL02E    CL                   */
/*   EXRPGD / EXR3P, EXR4P, EXRXP, EXRFP        RPG deux en un       */
/*   EXSF01D..EXSF10D / EXSF01P..EXSF10P        sous-fichiers        */
/*   (+ DSPF communs aux sous-fichiers "toutes options", voir le     */
/*   source EXSF06P)                                                 */
/*   EXSCH01 / EXSCH02 : ecrans de schema (formats de EXMNUD)        */
/* SQL natif (EXSQLP)                                                */
/*   EXSQLD, EXSQL1D a EXSQL5D ecrans ; EXSQLREQ, EXSQLCMD tables    */
/*   EXSQGUILD (GUILDE_DEMO), EXSQIX01, EXSQIX02 (EVI), EXSQVTOP     */
/*   (vue TOP100_JOUEURS), EXSQSTAT, EXSQTRV : crees par SQL         */
/*   (scripts QSQLSRC/EXSQLDDL et EXSQLDTA) ; journal EXSQJRN.       */
/*   ATTENTION : EXCLASSE porte une cle primaire EXSQ_PK_CLASSE      */
/*   et est journalisee (parent d'une cle etrangere CASCADE).        */
/* SQL embarque (EXSQEP)                                             */
/*   EXSQED, EXSQE1D a EXSQE8D ecrans ; EXSQEPS procedure SQL ;      */
/*   EXSQEFN fonction SQL ; EXSQETRV table de travail (journal       */
/*   EXSQEJRN).                                                      */
/* Environnement ILE (EXILEP)                                        */
/*   EXILEP = 2 modules (EXILEP + EXILEM1) lies par CRTPGM ;         */
/*   EXILESV *SRVPGM compteur statique (source de liage V1/V2) ;     */
/*   EXILEBD *BNDDIR ; EXILEA1 (CL, *CALLER), EXILEA2 (groupe        */
/*   EXILEAG) ; EXILED, EXILE1D a EXILE3D ecrans.                    */
/*                                                                   */
/* ================================================================= */
/* 5. LE FICHIER EXJOUEUR                                            */
/* ================================================================= */
/* PF sans cle (acces par RRN / sequentiel ; les cles sont dans les  */
/* LF). Format FJOUEUR, 155 zones :                                  */
/*   identite (id, pseudo, nom, classe, race, faction, guilde,       */
/*   serveur, pays, langue, sexe), progression (niveau, XP, rang,    */
/*   ligue, titre, quetes, succes), statistiques (PV, mana, force,   */
/*   agilite... resistances, % critique), economie (or, gemmes,      */
/*   premium), monde (position X/Y/Z, zone, arme, armure, monture,   */
/*   familier), PvP (victoires, defaites, eliminations, morts,       */
/*   solde signe, ratio), compte (statut A/I/S/B, date d'inscription */
/*   type L, derniere connexion type Z, temps de jeu, commentaire,   */
/*   horodatage et utilisateur de mise a jour pour le verrou         */
/*   optimiste) et INVENTAIRE : 30 cases x (objet JInnOB, quantite   */
/*   JInnQT, duree JInnDU) = 90 zones.                               */
/* Noms de zones sur 6 caracteres (limite du RPG III) + ALIAS long   */
/* pour SQL et le RPG full free :  SELECT PSEUDO, NIVEAU,            */
/* INV01_OBJET FROM DEMOAPP.EXJOUEUR                                 */
/*                                                                   */
/* ================================================================= */
/* 6. LES TROIS MODES DE SOUS-FICHIER                                */
/* ================================================================= */
/* C'est le rapport SFLSIZ / SFLPAG qui decide qui pagine :          */
/*   STATIQUE (load-all)   : tout est charge, SFLSIZ(9999) ; le      */
/*                           systeme pagine.                         */
/*   SEMI-DYNAMIQUE        : SFLSIZ > SFLPAG ; une page est AJOUTEE  */
/*                           a chaque Page suivante (ROLLUP), sans   */
/*                           SFLCLR ; le systeme gere le retour.     */
/*   DYNAMIQUE COMPLET     : SFLSIZ = SFLPAG ; SFLCLR et chargement  */
/*                           d'UNE page a chaque ROLLUP / ROLLDOWN,  */
/*                           geres par le programme.                 */
/* LIMITE : un sous-fichier contient au plus 9 999 enregistrements.  */
/* Avec 15 000 joueurs, les modes statique et semi-dynamique         */
/* s'arretent a 9 999 avec un message : seul le dynamique complet    */
/* parcourt tout le fichier. C'est voulu, pour la demonstration.     */
/* Regle verifiee : un format SFLCTL ne peut rien afficher sur les   */
/* lignes du sous-fichier (CPD7812) : l'encadre pedagogique a droite */
/* des lignes est donc une zone de chaque ligne du SFL.              */
/*                                                                   */
/* ================================================================= */
/* 7. CONVENTIONS                                                    */
/* ================================================================= */
/* Nommage : prefixe EX + theme ; D = DSPF, P = programme.           */
/* Appel : chaque programme recoit un parametre RETOUR *CHAR 1 ;     */
/*   '3' en sortie = F3 (quitter l'application), ' ' = F12 / retour. */
/* Charte SAA / CUA :                                                */
/*   ligne 1 : code ecran (bleu), titre centre (blanc), systeme,     */
/*             date ; ligne 2 : utilisateur, sous-titre, heure ;     */
/*   libelles et touches en bleu, saisie en vert soulignee, erreurs  */
/*   en rouge inverse video + curseur, encadre pedagogique turquoise */
/*   (col 98-131 en 27x132) ; touches ligne 25 (22-23 en 24x80) ;    */
/*   messages en derniere ligne (sous-fichier message SFLPGMQ).      */
/*   Statut joueur : A vert, I bleu, S jaune, B rouge.               */
/* Indicateurs : 03 F3, 12 F12, 04 F4, 05 F5, 06 F6, 11 F11,         */
/*   25/26 ROLLUP/ROLLDOWN, 30 SFLDSPCTL, 31 SFLDSP, 32 SFLCLR,      */
/*   33 SFLEND, 34 SFLNXTCHG, 35 SFLDROP, 40-49 erreurs,             */
/*   50-69 attributs, 88 grand ecran (menu), 90 SFLMSG.              */
/*   02 F2 (CF02 niveau fichier), 89 encadre masque (N89 sur les     */
/*   constantes, 89 DSPATR(ND) sur les zones d'un SFL).              */
/* Regle verifiee : les touches valides sont celles du DERNIER       */
/*   format ecrit -> touches declarees au niveau FICHIER.            */
/* Regle verifiee : avec ctl-opt main(x), x = nom du programme,      */
/*   sinon SFLPGMQ echoue (CPF2479 / CPF5189).                       */
/* Sources : lignes de 80 caracteres au plus, CCSID 1147.            */
/*                                                                   */
/* ================================================================= */
/* 8. RECREER L'APPLICATION (ordre de compilation)                   */
/* ================================================================= */
/*  1. CRTPF EXREF, puis EXJOUEUR, EXCLASSE, EXADMCMD                */
/*     (CRTPF FILE(DEMOAPP/x) SRCFILE(DEMOAPP/QDDSSRC))              */
/*  2. RUNSQLSTM SRCFILE(DEMOAPP/QSQLSRC) SRCMBR(EXJOUDTA)           */
/*       COMMIT(*NONE) NAMING(*SYS) DFTRDBCOL(DEMOAPP)               */
/*     idem SRCMBR(EXADMDTA)                                         */
/*  3. CRTLF EXJOUL01 a EXJOUL09                                     */
/*  4. CRTRPGMOD MODULE(DEMOAPP/EXUTIL) SRCFILE(DEMOAPP/QRPGLESRC)   */
/*     CRTSRVPGM SRVPGM(DEMOAPP/EXUTIL) EXPORT(*SRCFILE)             */
/*       SRCFILE(DEMOAPP/QSRVSRC) SRCMBR(EXUTIL)                     */
/*       BNDSRVPGM(QSYS/QSNAPI)                                      */
/*     CRTBNDDIR DEMOAPP/EXBNDDIR + ADDBNDDIRE (EXUTIL *SRVPGM)      */
/*  5. CALL DEMOAPP/EXDDSMC (fichier message EXMSGF)                 */
/*      RUNSQLSTM SRCMBR(EXSQLDDL) NAMING(*SQL), puis EXSQLDTA       */
/*      (section SQL), scripts EXSQEPS / EXSQEFN (SQL embarque),     */
/*      EXILESV + EXILEP (commandes en tete des sources ILE)         */
/*  6. CRTDSPF de tous les xxxxD (EXMNUD, EXADMD, EXDDS..., etc.)    */
/*  7. Programmes : CRTBNDRPG (RPGLE), CRTSQLRPGI OBJTYPE(*PGM)      */
/*     COMMIT(*NONE) (SQLRPGLE), CRTRPGPGM CVTOPT(*DATETIME)         */
/*     (EXR3P), CRTBNDCL (CL)                                        */
/*  8. CRTBNDCL PGM(BIB21/LANCEDEMO) SRCFILE(BIB21/QCLSRC)       */
/* Attention : recompiler un DSPF impose de recompiler le programme  */
/* qui l'utilise (controle de niveau LVLCHK, CPF4131).               */
/*                                                                   */
/* ================================================================= */
/* 9. REINITIALISER LES DONNEES                                      */
/* ================================================================= */
/* Menu principal, option 9 (confirmation en fenetre), ou :          */
/*   RUNSQLSTM SRCFILE(DEMOAPP/QSQLSRC) SRCMBR(EXJOUDTA)             */
/*     COMMIT(*NONE) NAMING(*SYS) DFTRDBCOL(DEMOAPP)                 */
/*   puis RUNSQLSTM SRCFILE(DEMOAPP/QSQLSRC) SRCMBR(EXSQLDDL)        */
/*     COMMIT(*NONE) NAMING(*SQL) ERRLVL(20)                         */
/*   (le DELETE de EXCLASSE vide GUILDE_DEMO par CASCADE : l'option  */
/*   9 rejoue donc aussi le DDL de la section SQL).                  */
/* Les valeurs sont deterministes : apres rechargement, les donnees  */
/* sont identiques a celles des supports de cours.                   */
/* ================================================================= */
             PGM

             DCL        VAR(&AJOUTEE) TYPE(*LGL) VALUE('0')
             DCL        VAR(&MSGID)   TYPE(*CHAR) LEN(7)
             DCL        VAR(&MSGDTA)  TYPE(*CHAR) LEN(256)
             DCL        VAR(&MSGF)    TYPE(*CHAR) LEN(10)
             DCL        VAR(&MSGFLIB) TYPE(*CHAR) LEN(10)

/* Toute erreur imprevue -> routine d'erreur en fin de programme     */
             MONMSG     MSGID(CPF0000 MCH0000) EXEC(GOTO CMDLBL(ERREUR))

/* 1. La bibliotheque DEMOAPP existe-t-elle ?                        */
             CHKOBJ     OBJ(QSYS/DEMOAPP) OBJTYPE(*LIB)
             MONMSG     MSGID(CPF9801 CPF9810) EXEC(DO)
                SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                             MSGDTA('La bibliotheque DEMOAPP est +
                             absente : l''application n''est pas +
                             installee sur ce systeme.') +
                             MSGTYPE(*ESCAPE)
             ENDDO

/* 2. DEMOAPP en tete de la *LIBL (CPF2103 = deja presente)          */
             ADDLIBLE   LIB(DEMOAPP) POSITION(*FIRST)
             MONMSG     MSGID(CPF2103) EXEC(GOTO CMDLBL(APPEL))
             CHGVAR     VAR(&AJOUTEE) VALUE('1')

/* 3. Point d'entree de l'application                                */
 APPEL:      CALL       PGM(DEMOAPP/EXSTART)

/* 4. Remise en etat de la *LIBL                                     */
             IF         COND(&AJOUTEE) THEN(DO)
                RMVLIBLE   LIB(DEMOAPP)
                MONMSG     MSGID(CPF0000)
             ENDDO
             RETURN

/* Routine d'erreur : le message recu est renvoye a l'appelant       */
 ERREUR:     RCVMSG     MSGTYPE(*EXCP) MSGDTA(&MSGDTA) MSGID(&MSGID) +
                          MSGF(&MSGF) SNDMSGFLIB(&MSGFLIB)
             MONMSG     MSGID(CPF0000)
             IF         COND(&AJOUTEE) THEN(DO)
                RMVLIBLE   LIB(DEMOAPP)
                MONMSG     MSGID(CPF0000)
             ENDDO
             IF         COND(&MSGID *NE ' ') THEN(DO)
                SNDPGMMSG  MSGID(&MSGID) MSGF(&MSGFLIB/&MSGF) +
                             MSGDTA(&MSGDTA) MSGTYPE(*ESCAPE)
                MONMSG     MSGID(CPF0000)
             ENDDO
             ENDPGM
```
