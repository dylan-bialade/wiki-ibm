---
bibliotheque: BIB02
fichier_source: QSRC
membre: MEPDEV
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 102
modifie: 2026-11-16
---

# BIB02/QSRC/MEPDEV

```text
       CTL-OPT OPTION(*SRCSTMT)  OPTIMIZE(*FULL)
       DATFMT(*ISO) TIMFMT(*ISO) ALLOC(*STGMDL)
       STGMDL(*INHERIT) THREAD(*SERIALIZE);

       //*****************************************************************
       // BIB02 SYLVAIN - PGM DE MISE EN PROD (sur la prod)
       // Copyright - ORGFORM
       //*****************************************************************

       //**********************************************************************//
       // Déclaration des fichiers                                             //
       //**********************************************************************//
       DCL-F MEPFM2 WORKSTN;

       //**********************************************************************//
       // Déclaration des prototypes                                           //
       //**********************************************************************//
       DCL-PR QCMDEXC extpgm('QCMDEXC');
         pr_cmdstr       Char(4096)      const options(*varsize);
         pr_cmdstrlen    Packed(15:5)    const;
       END-PR;

       //**********************************************************************//
       // Déclaration des variables                                            //
       //**********************************************************************//
       DCL-S pr_cmdstr       Char(4096)      inz(*blanks);
       DCL-S pr_cmdstrlen    Zoned(15:5)     inz(42);
       DCL-S MES             char(60)        inz(*blanks);
       DCL-S IND             Zoned(2:0)      inz(0);

       *Inlr = *On;

       DOW NOT *IN03;

         exfmt f1;
         EXSR CRTSAVF;



         IF IND = 1 ;
           MES = *blanks;
           exfmt f2;

           SELECT;
             WHEN *IN04;
               EXSR DSPSAVF;
             OTHER;
               EXSR SAVOBJ;
           ENDSL;

         ENDIF;

       ENDDO;


       //**********************************************************************//
       // Sous Routine de création du SAVF                                     //
       //**********************************************************************//
       BEGSR CRTSAVF;
         pr_cmdstr='CRTSAVF FILE(BIB02/'+ NAMEMEP + ')';
         callp(e) QCMDEXC(pr_cmdstr:%len(%trimr(pr_cmdstr)));
         If %error();
           MES = 'Le fichier ' + NAMEMEP + 'existe déjà ';
           leavesr;
         EndIf;

         pr_cmdstr = *blanks;
         pr_cmdstr='CRTSAVF FILE(BIB02/'+ NAMESAV + ')';
         callp(e) QCMDEXC(pr_cmdstr:%len(%trimr(pr_cmdstr)));
         If %error();
           MES = 'Le fichier ' + NAMESAV + 'existe déjà';
           leavesr;
         EndIf;
         ind = 1;
       ENDSR;

       //**********************************************************************//
       // Sous Routine du SAVOBJ                                               //
       //**********************************************************************//
       BEGSR SAVOBJ;
         pr_cmdstr=*blanks;
         pr_cmdstr='SAVOBJ OBJ('+ BADE9 + BADE2 + BADE3 + BADE4 + BADE5
         + BADE6 + BADE7 + BADE8 + BADE10 + BADE11 + BADE12 +
          BADE13 + BADE14 + BADE15 + BADE16 + BADE17
          + BADE18 + BADE19+ BADE20 + BADE21 + ') LIB(' + LIBE1 + ') +
         DEV(*SAVF) OBJTYPE(' + OBJT + ') SAVF(BIB02/' + NAMESAV + ')';
         callp(e) QCMDEXC(pr_cmdstr:%len(%trimr(pr_cmdstr)));
         If %error();
          MES = 'Erreur votre savobj ne fonctionne pas ! veuillez recommencer';
           leavesr;
         EndIf;
         *IN03=*ON;
       ENDSR;

       //**********************************************************************//
       // Sous Routine du DSPSAVF                                              //
       //**********************************************************************//
       BEGSR DSPSAVF;
         pr_cmdstr = *blanks;
         pr_cmdstr='DSPSAVF FILE(BIB02/' + NAMESAV +')';
         callp(e) QCMDEXC(pr_cmdstr:%len(%trimr(pr_cmdstr)));
       ENDSR;
```
