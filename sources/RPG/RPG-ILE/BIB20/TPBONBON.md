---
bibliotheque: BIB20
fichier_source: QSQLRPGLE
membre: TPBONBON
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 418
modifie: 2026-11-16
---

# BIB20/QSQLRPGLE/TPBONBON

```text
       CTL-OPT DFTACTGRP(*NO) option(*srcstmt);

       DCL-F EBONSFLOPT WORKSTN SFILE(EBONSFLF:RANG);
       DCL-F BONPRT PRINTER OFLIND(*in60);

******* DECLARATION VARIABLE

       DCL-S i zoned(2:0) INZ(1);     // sert a boucler
       DCL-S LASTRANK zoned(4:0) INZ(0);     // contient le dernier rang generer
       DCL-S LASTSCROLL zoned(5:0) INZ(0);   // contient le scroll de l'utilisateur pour rafriachir
       DCL-S REQUETECURSOR char(1024);       // contient la requete pour le cursor
       DCL-S saverang zoned(5:0);
       DCL-S commande varchar(80);   // commande pour qcmdexc
       DCL-DS ODBF;          // ds pour contenir commande ovrdbf
           ODBF1 char(27) inz('OVRDBF FILE(bonbon) TOFILE(');
           ODBF3 char(1) inz('/');
           ODBF5 CHAR(1) inz(')');
       END-DS;
       DCL-PR CREATE EXTPGM('CREABONBON');
       END-PR;
       DCL-PR PRINT EXTPGM('BONRPGFREE');
       END-PR;
       DCL-PR QCMDEXC Extpgm;
            *n char(1000) Const options(*Varsize);
            *n packed(15:5) Const;
       END-PR;

******** CODE ***********
       exec sql
         set option commit = *none;     // permet update delete

       DOW NOT *IN03;
         WRITE EXIT;      // pied de page
         EXFMT EBONCTL;

         // L'indicateur 55 est utilisé pour afficher le message à l'écran
         CLEAR MSGTEXT;

         SELECT;
           WHEN *IN03;       // quand il quitte
             LEAVE;
           WHEN *IN06;       // quand il crée
             CREATE ();
           WHEN *IN29;       // quand il pagine vers le bas
             REMP();
           WHEN *IN07;       // lancement de l'impression
             PRINTin();
             MSGTEXT = '------------- L''impression a été lancé. ------------';
           WHEN *IN13;       // quand il veux changer de fichier
             changeFile();
             if not (bib <> *blanks and file = *blanks);
               exsr *inzsr;
             ENDIF;
             if *in12 or *in03;
               *in12 = *off;
               iter;
             ENDIF;
             c1();
             nettoyer();
             remp();
           WHEN SEARCH <> *BLANKS or trimarque <> *blanks
            or tricouleu <> *blanks;                    // quand il y a un tri
             C1SEARCH();
             NETTOYER();
             REMP();
           OTHER;
             DOU NOT %EOF();
               READC EBONSFLF;     // lis les option

               SELECT;
                 WHEN %EOF();
                   RANG = SCROLL;       // permet de remettre sur la page du dernier option
                   LEAVE;
                 WHEN *IN03;
                   LEAVE;
                 WHEN OPT = 2;
                   MODIFIER();
                 WHEN OPT = 4;
                   SUPPRIMER();
                 WHEN OPT = 5;
                   AFFICHER();
               ENDSL;

               CLEAR OPT;
             ENDDO;
             NEWPLACE();    // met a blanc pour rafraichir
         ENDSL;


         IF MSGTEXT = *BLANKS;
           // L'indicateur 55 est utilisé pour afficher le message à l'écran
           *IN55 = *OFF;
         ELSE;
           *IN55 = *ON;
         ENDIF;
       ENDDO;
       exec sql close c1;          // ferme le cursor
       *INLR = *ON;

       //********* BEGSR INITILISATION
       BEGSR *INZSR;
         *IN30 = *ON;
         *IN31 = *ON;
         NETTOYER();
         exec sql
         set current schema BIB21;
         c1();
         REMP();
       ENDSR;

       //*********  PROC NETTOYER

       DCL-PROC NETTOYER;
         RANG = 0;
         LASTRANK = 0;
         *IN32 = *ON;
         WRITE EBONCTL;
         *IN32 = *OFF;
       END-PROC;

       //********* PROC REMPLISSAGE
       DCL-PROC REMP;

         RANG = LASTRANK;
         FOR i = 1 to 12;
           exec sql
           fetch c1
           into :numbb, :nom, :marque, :couleu;

           IF SQLCODE = 100;     // fin de fichier
             *IN33 = *ON;
             LEAVE;
           ENDIF;

           RANG += 1;

           marqueRed();  // active l'ind 50 si marque exite dans l'autre pf

           WRITE EBONSFLF;

           *IN50 = *OFF;   // couleur rouge sur numbb desactivé
         ENDFOR;
         LASTRANK = RANG;

         verifEmpty();
       END-PROC;

       // ******** PROC Verif SFL VIDE
       // Si il est vide, remplis d'une donnée factice pour éviter erreur
       dcl-proc verifEmpty;
         if rang = 0;
           clear LASTRANK;
           SCROLL = 0;
           LASTSCROLL = 1;
           *in30 = *off; //désaffiche le sfl
           MSGTEXT = 'Aucune donnée pour la recherche effectué.';
         ELSE;
           *in30 = *on;
         ENDIF;
       END-PROC;


       //********* PROC MODIFIER

       DCL-PROC MODIFIER;
         exec sql
         select numbb, nom, marque, couleu, prix
           into :numbb, :nom, :marque, :couleu, :prix
           from lfbonbon
           where numbb = :numbb;
         EXFMT MODIF;

         exec sql
         update bonbon
         set nom = :nom
         where numbb like :numbb;

         marqueRed();
         UPDATE EBONSFLF;
         *in50 = *off;
       END-PROC;

       //********* PROC SUPPRIMER

       DCL-PROC SUPPRIMER;
         exec sql
         delete from bonbon where numbb like :numbb;
         MSGTEXT = 'Le bonbon ' + %trim(NOM) + ' a été supprimé.';
         CLEAR OPT;
         NEWPLACE();
       END-PROC;

       //********* PROC AFFICHER

       DCL-PROC AFFICHER;
         EXFMT AFFICHE;
         CLEAR OPT;
       END-PROC;

       //********* PROC RAFRAICHISSEMENT DE LA PAGE JUSQU'AU SCROLL

       DCL-PROC NEWPLACE;
         IF SCROLL <> *ZERO AND SCROLL < LASTRANK;
         LASTSCROLL = SCROLL;   // save le scroll
         endif;
         NETTOYER();
         c1();      // repars sur du propre

         DOW RANG < LASTSCROLL;      // fais le remplissage jusqu'au scroll
           REMP();
         ENDDO;
       END-PROC;

       // **************  PROC CURSOR 1

       DCL-PROC C1;  // cursor classique sans les filtres

         REQUETECURSOR = 'select numbb, nom, marque, couleu' +
                           ' from bonbon order by nom';

         cursordyn(); // close et prepare stmt 1 pour le cursor c1

         EXEC sql
           declare c1 cursor for stmt1;

           exec sql open c1;
       END-PROC;

       // **************  PROC CURSORDYN
       //
       DCL-PROC cursordyn;    // close c1 et prepare le stmt1 pour cursor

         exec sql close c1;
         exec sql prepare stmt1 from :requetecursor;
       END-PROC;

       //*************** PROC CURSOR SEARCH

       DCL-PROC C1SEARCH;
               // construction du debut de la requete
         REQUETECURSOR = 'select numbb, nom, marque, couleu' +
                           ' from bonbon' +
                           ' where numbb <> -1 and';

         if search <> *blanks;  // la recherche n'est pas vide
           constructRequestWhere('nom' : search);  // construit la suite de la requete
           if trimarque <> *blanks or tricouleu <> *blanks;
             REQUETECURSOR = %trim(REQUETECURSOR) + ' and';     // ajoute and dans la requete
           ENDIF;
         ENDIF;

         if trimarque <> *blanks;
           constructRequestWhere('marque' : trimarque); // construit la suite de la requete
           if tricouleu <> *blanks;
             REQUETECURSOR = %trim(REQUETECURSOR) + ' and';
           ENDIF;
         ENDIF;

         if tricouleu <> *blanks;
           constructRequestWhere('couleu' : tricouleu);  // construit la suite de la requete
         ENDIF;
                                         // finit la requete avec un order by
         REQUETECURSOR = %trim(REQUETECURSOR) + ' order by nom';

         cursordyn();  // close et prepare pour le cursor avant open

           exec sql open c1;
       END-PROC;


       // ******** PROC CONSTRUCTION REQUETE WHERE
       //
       dcl-proc constructRequestWhere; // recois 2 variables en char
         dcl-pi *N;
            zoneBDD char(10) const;  // la zone de la table a filtrer
           variable char(30) const;  // contenu de la comparasion du filtre
         END-PI;

         REQUETECURSOR = %trim(REQUETECURSOR) + ' upper('+ zoneBDD +') ';

         if zoneBDD = 'nom';      // si cela vient de la recherche
               // n'affiche pas seulement ceux qui sont egaux
           REQUETECURSOR = %trim(REQUETECURSOR) + ' >= ';
         ELSE;
           REQUETECURSOR = %trim(REQUETECURSOR) + ' = ';
         ENDIF;
                  // compare la zone en majuscule avec le filtre en majuscule pour eviter quiproquo
         REQUETECURSOR = %trim(REQUETECURSOR) + ' upper(''' + variable +
                          ''') ';

       END-PROC;

       // ******** PROC POUR LA MARQUE SI ELLE EXISTE
       //  si la marque existe dans le fichier marqp, le numbb s'affiche en rouge
       dcl-proc marqueRed;
         exec sql
           select *
             into :marque
             from marqp
             where marque = :marque;
           IF SQLCODE <> 0;
             *IN50 = *ON;
           ENDIF;
       END-PROC;


       // ******** PROC PRINT
       dcl-proc printin;

         saverang = rang;

         addNXTCHG();

         write titre;
         write entete;

         rang = 1;

         dow 1=1;
           readc EBONSFLF;


           if %eof();
             leave;
           ENDIF;

           *in77 = *off;
           update EBONSFLF;

           prix *= 5;

           if *in95;
             write etoile;
             *in95 = *off;
           ENDIF;

           write details;

           if *in60;
             write eject;
             write titre;
             write entete;
             *in60 = *off;
           ENDIF;
         ENDDO;

         rang = saverang;
       END-PROC;


       // ******** PROC ajoute le nxtchg a l'enregistrement

       dcl-proc addNXTCHG;
         exec sql close c1;
         nettoyer();
         *in77 = *on;
         exec sql open c1;
         dow sqlcode <> 100;
           remp();
         enddo;
       END-PROC;

       // ************* PROC CHANGE FILE

       dcl-proc changeFile;
             exfmt CHOOSEFILE;
             if *in12 = *off and *in03 = *off;
                   exec sql close c1;

               if FILE = *BLANKS; // lorsque le nom du fichier est vide;

                 if BIB <> *BLANKS;
                   exec sql set current schema :BIB;   // change la bib;
                 ENDIF;

               else;
                 commande = 'ADDLIBLE lib(BIB21)';

                 monitor ;          // monitor pour catch les message d'erreur
                   callp QCMDEXC(commande:%len(commande));
                 on-error ;
                   if %status() = 201;
                     DSPLY 'La BIB BIB21 n''existe plus.';
                   ENDIF;
                 endmon ;


                 commande = 'CHKOBJ OBJ('+
                   %trim(bib)+'/'+ %trim(file) + ') OBJTYPE(*FILE)';
                 monitor ;          // monitor pour catch les message d'erreur
                   callp QCMDEXC(%trim(commande):%len(%trim(commande)));
                  on-error;
                    MSGTEXT = 'Le fichier n''existe pas dans la lib ' + bib;
                 endmon ;

                 dow 1=1;
                   commande = odbf1 + %TRIM(bib) +odbf3 + %trim(file) + odbf5;

                   if %status() <> 202;
                     monitor ;          // monitor pour catch les message d'erreur
                       callp QCMDEXC(%trim(commande):%len(%trim(commande)));
                      on-error;
                        MSGTEXT = 'Le fichier n''existe pas dans la lib ' + bib;
                        bib = 'BIB20';
                        file = 'bonbon';
                        iter;
                     endmon ;
                   endif;
                   leave;
                 enddo;

                 commande = 'rmvLIBLE lib(BIB21)';
                 callp QCMDEXC(commande:%len(commande));

               ENDIF;

             ENDIF;
       END-PROC;
```
