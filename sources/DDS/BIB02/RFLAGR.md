---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: RFLAGR
type: DDS
longueur_enregistrement: 100
lignes: 208
modifie: 2026-11-16
---

# BIB02/QDDSRC/RFLAGR

```text
       Ctl-Opt DECEDIT('0,') DFTNAME(PRIRRF) DATEDIT(*DMY.); //1
       //****************************************************************
       //RÉCUPÉRATION DES RÉCEPTIONS FOURNISSEURS
       //   TOP VALIDATION STKDUC PAR ACTIVITÉ ***** ENLEVÉ *****
       //****************************************************************
       Dcl-F RFLXRFNCO Usage(*Update:*Delete:*Output) Keyed;
       Dcl-F RECEPTTR  Usage(*Output) Keyed USROPN;
       Dcl-F STKEMPTR  Usage(*Update:*Delete:*Output) Keyed;
       Dcl-F STKDUCCO  Usage(*Update:*Delete:*Output) Keyed USROPN;
       Dcl-F ARTICLCO  Usage(*Update:*Delete:*Output) Keyed;
       Dcl-F ARTV3DV2  Usage(*Update:*Delete:*Output) Keyed;
       Dcl-F RAYONCO   Usage(*Input) Keyed;
       //.....Commande RCLRSC  (Nouveau: //pgms externes)
       Dcl-S RCLRSC       Char(40)   DIM(1) CTDATA PERRCD(1);
       Dcl-S TCAM         Char(3)    DIM(100); //      Table Camions
       //   N° DE CAMION
       Dcl-DS *N;
         SMWCAM         Char(12)   Pos(1);
         WPALTR         Char(3)    Pos(1);
         WPALCA         Char(4)    Pos(4);
       End-DS;
       //   CAB FORMAT AS400
       Dcl-DS *N;
         RR1            Char(29)   Pos(1);
         RR1CAB         Char(18)   Pos(1);
         RR1CDE         Char(8)    Pos(19);
         RR1LIG         Char(3)    Pos(27);
       End-DS;
       //   DEFINITION DES CLES
       //   DEFINITION DES VARIABLES
       //   RECUPERATION DE LA DATE DU JOUR EN FORMAT (AAAAMMJJ) ------
       XRTVDTJ(); //          |
       //          |
       //   -----------------------------------------------------------
       //RÉCEPTION DES PARAMÈTRES
       //========================
       //INITIALISATION
       %Subst(PDEP:1:4) = '9988';
       I = 0 + 0;
       %Subst(TCAM:1:undefined) = %Char(*BLANK);
       %Subst(RRCOD:1:1) = 'T';
       RR30 = *BLANK;
       RR35 = *BLANK;
       OPEN RECEPTTR;
       //LECTURE DU FICHIER REFLEX
       //-------------------------
       %Subst(*IN99:1:1) = '0';
       RFLNFI = PNFIC;
       If PNFIC = *BLANK;
         SETLL *LOVAL RFLXRFNCO;
       ELSE;
         SETLL PNFIC RFLXRFNCO;
       ENDIF; //C = ' '
       Dow *IN99 = '0';
         If PNFIC = *BLANK;
           READ RFLXRFNCO;
         ELSE;
           READE PNFIC RFLXRFNCO;
         ENDIF; //C = ' '
         If *IN99 = '0' AND RFLDT2 = 0 AND ERRNCD = *BLANK AND ERRGCO =
         *BLANK AND ERRCDF = *BLANK AND ERRGC2 = *BLANK;
           //   PAS DE TRAITEMENT DES MANQUANTS
           If RFLMOT = *BLANK AND RFLNBC <> 0;
             //   MISE À JOUR ARTICL & ARTV3D SI POIDS ET DIMENSIONS RENSEIGNÉS
             If RFLPDS <> 0;
               CHAIN RFLART ARTICLCO;
               If NOT *In90;
                 ARTPDS = RFLPDS / 1000;
               Endif;
               If NOT *In90;
                 UPDATE RARTICL;
               Endif;
               %Subst(*IN98:1:1) = '0';
               SETLL (RFLART:RFLVA2:RFLVA3) ARTV3DV2;
               Dow *IN98 = '0';
                 READE (RFLART:RFLVA2:RFLVA3) ARTV3DV2;
                 If *IN98 = '0';
                   V3DPOI = RFLPDS / 1000;
                   V3DHBT = 0 + RFLHBT;
                   V3DLBT = 0 + RFLLBT;
                   V3DPBT = 0 + RFLPBT;
                   V3DVBT=(V3DHBT*V3DLBT*V3DPBT)/1000000;
                   V3DHCO = 0 + RFLHCO;
                   V3DLCO = 0 + RFLLCO;
                   V3DPCO = 0 + RFLPCO;
                   V3DVCO=(V3DHCO*V3DLCO*V3DPCO)/1000000;
                   %Subst(V3DUTI:1:8) = 'RFLRRCF1';
                   ZDTMAJ = 0;
                   ZDTMAJ = PUDATE;
                   UPDATE RARTV3D;
                 ENDIF; //*IN98 = '0'
               ENDDO; //*IN98 DW= '0'
             ENDIF; //RFLPDS <> 0
             %Subst(SMWCAM:1:6) = %Char(RFLMAG);
             //
             //   RENSEIGNEMENT N° CDE ET N° LIGNE
             %Subst(RRCAM:1:%Len(SMWCAM)) = SMWCAM;
             %Subst(RR1CAB:1:6) = %Char(RFLCAB);
             %Subst(RR1CDE:1:6) = %Char(RFLNCD);
             %Subst(RR1LIG:1:3) = '001';
             %Subst(RR30:%Len(RR30)-1) = '0';
             TRSQTE = RFLNBC;
             //   MISE À JOUR STOCK EMPLACEMENT
             SMADEP = PDEP;
             %Subst(STKTRV:1:%Len(WPALTR)) = WPALTR;
             %Subst(STKCAS:1:%Len(WPALCA)) = WPALCA;
             ARTCOD = RFLART;
             STKVA1 = RFLVA1;
             STKVA2 = RFLVA2;
             STKVA3 = RFLVA3;
             STKVA4 = RFLVA4;
             STKNBU = 0;
             CHAIN (SMADEP:STKTRV:STKCAS:ARTCOD:STKVA1:STKVA2:STKVA3:
             STKVA4:STKNBU)
              STKEMPTR;
             If *In91;
               STKQTE = 0;
             Endif;
             If *In91;
               STKQTR = 0;
             Endif;
             If *In91;
               STKQTP = 0;
             Endif;
             If *In91;
               STKQTI = 0;
             Endif;
             If RFLCOB = 'C';
               STKQTP = STKQTP + RFLNBC;
             ELSE;
               STKQTP = STKQTP + RFLQTR;
             ENDIF;
             ZDTMAJ = 0;
             ZDTMAJ = PUDATE;
             If *In91;
               WRITE RSTKEMP;
             Endif;
             If NOT *In91;
               UPDATE RSTKEMP;
             Endif;
             //
     C     ECRTSI        TAG
             %Subst(*IN91:1:1) = '0';
             WRITE RRECEP;
     C   91              GOTO      ECRTSI
             //   MISE EN TABLE DES CAMIONS TAITÉS
             J = 0 + 1;
             %Subst(*IN90:1:1) = '0';
             *In90 = (%Lookup(WPALTR:TCAM(J)) > 0);
             If NOT *In90;
               I = I + 1;
             Endif;
             %Subst(TCAM(I):1:%Len(WPALTR)) = WPALTR;
           ENDIF; //RFLMOT <> 'MQN'
           RFLDT2 = 0 + PUDATE;
           RFLHR2 = %Time();
           UPDATE RRFLXRFN;
         ENDIF; //*IN99 = '0'
       ENDDO; //*IN99 DW= '0'
       CLOSE RECEPTTR;
       //   LANCEMENT GÉNÉ STKDUC
       //   ---------------------
       J = 0 + 1;
       Dow J <= I;
         PCAM = TCAM(J);
         TSIRECRD();
         J = J + 1;
       ENDDO; //J DWLE I
       //
       //   TOP VALIDATION STKDUC PAR ACTIVITÉ
       //   ----------------------------------
       %Subst(*IN98:1:1) = '0';
       SETLL *LOVAL RAYONCO;
       Dow *IN98 = '0';
         READ RAYONCO;
         If *IN98 = '0';
           PFCT1 = 'REFLEX_RCF';
           FCTRTV();
           //NOM FONCTION
           //ACTIVITÉ
           //RETOUR OUI/NON
           //ADRESSE MAIL
           If PFCT4 <> *BLANK;
             //   CONTRÔLE LIGNES NON VALIDÉES --> ENVOI MAIL VALIDATION MANUELLE
             //   ---------------------------------------------------------------
             OPEN STKDUCCO;
             STDDAT = 0 + PUDATE;
             %Subst(*IN90:1:1) = '0';
             SETLL (STDRAY:STDDAT:PUDATE) STKDUCCO;
             Dow *IN90 = '0';
               READE(N) (STDRAY:STDDAT:PUDATE) STKDUCCO;
               If *IN90 = '0' AND STDVRC <> *BLANK;
                 RADTS2$C();
                 %Subst(*IN90:1:1) = '1';
               ENDIF; //*IN90 = '0'
             ENDDO; //*IN90 DW= '0'
             CLOSE STKDUCCO;
           ENDIF; //PFCT4 <> ' '
         ENDIF; //*IN98 = '0'
       ENDDO; //*IN98 DW= '0'
       //
       //++++++++++++++++++++++++++++++++++++++++++
       //+  Fermeture des fichiers laissés ouverts
       //++++++++++++++++++++++++++++++++++++++++++
     C     FIN           TAG
       QCMDEXC();
       //
       *InLR = *On;
```
