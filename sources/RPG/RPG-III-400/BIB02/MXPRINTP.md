---
bibliotheque: BIB02
fichier_source: QRPGSRC
membre: MXPRINTP
type: RPG/RPG-III-400
longueur_enregistrement: 100
lignes: 694
modifie: 2026-11-16
---

# BIB02/QRPGSRC/MXPRINTP

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
       Ctl-Opt DFTACTGRP(*NO) ACTGRP(*NEW) BNDDIR('QC2LE') BNDDIR('IFSTEXT');
       Ctl-Opt Option (*NoDebugio) datfmt(*eur) timfmt(*hms) datedit(*dmy);

       // MAX 2009_2010    EDITION ETIQUETTE 02
       //                  INDIVIDUEL FRANCE
       //                  CIRCUIT 4

       Dcl-F colis_a    Keyed;
       Dcl-F colis_l    Keyed;
       Dcl-F abo_adr    Keyed;
       Dcl-F work_rc4   Keyed;
       Dcl-F max_club   Keyed;
       Dcl-F hcol_rc    Keyed;
       Dcl-F work_cl    Usage(*Update:*Delete) Keyed;
       Dcl-F cpr_edi    Usage(*Output) rename(cpr_edi:forcpr);
       Dcl-F cpr_ri     Usage(*Update:*Delete:*Output) Keyed
                        rename(mx_ri:forri);
       Dcl-F cpr_colot  Usage(*Update:*Delete:*Output) Keyed
                        rename(mx_fpr:forlot);
       Dcl-F cpr_colis  Usage(*Update:*Delete) rename(cpr_colis:forcol);
       Dcl-F cpr_st     Keyed rename(cpr_st:forst);
       Dcl-F cpr_dpt    Keyed rename(cpr_dpt:fordpt);

       Dcl-Ds par DtaAra(*Auto:*UsrCtl:*LDA);
         numtir          Zoned(2:0);
         datetrai        Date(*eur);
         numlot          Zoned(6:0);
         cli_col         Char(7);
         colis_num       Zoned(7:0);
       End-Ds;

       Dcl-Ds *n;
         cli_lot         Zoned(6:0)      Pos(1);
         lot1            Zoned(1:0)      Pos(1);
         lot2            Zoned(6:0)      Pos(1);
       End-Ds;
       Dcl-Ds *n;
         ri_10;
         ri_20;
         ri_30;
         ri_40;
         ri_50;
         ri_60;
         ri_70;
         ri_80;
         ri              Zoned(5:0)      Pos(1) dim(8) inz(*zero);
       End-Ds;

       Dcl-Ds *n;
         cli_clu         Zoned(2:0)      Pos(1) inz(*zero);
         c               Zoned(1:0)      Pos(1) inz(*zero);
       End-Ds;

       Dcl-Ds *n;
         fpr_10;
         fpr_20;
         fpr_30;
         fpr_40;
         fpr_50;
         fpr_60;
         fpr_70;
         fpr_80;
         fpr_club        Zoned(5:0)      Pos(1) dim(8) inz(*zero);
       End-Ds;

       Dcl-S exp             Zoned(2:0)      inz(00);
       Dcl-S pro             Char(4)         inz('    ');

       Dcl-Ds *n;
         datejob         Date(*eur)      inz(*job);
         date_jj         Zoned(2:0)      Pos(1);
         date_mm         Zoned(2:0)      Pos(4);
         date_aa         Zoned(4:0)      Pos(7);
       End-Ds;

       Dcl-Ds *n;
         date            Char(10)        Pos(1);
         date_jj2        Zoned(2:0)      Pos(1);
         date_slash1     Char(1)         Pos(3);
         date_mm2        Zoned(2:0)      Pos(4);
         date_slash2     Char(1)         Pos(6);
         date_aa2        Zoned(4:0)      Pos(7);
       End-Ds;

       Dcl-S r1              Zoned(8:0)      inz(*zero);
       Dcl-S r2              Zoned(8:0)      inz(*zero);
       Dcl-S r3              Zoned(8:0)      inz(*zero);

       Dcl-Ds *n;
         r4              Zoned(8:0)      Pos(1) inz(*zero);
         r4_1            Zoned(1:0)      Pos(8);
       End-Ds;

       Dcl-Ds *n;
         r5              Zoned(8:0)      Pos(1) inz(*zero);
         r5_1            Zoned(1:0)      Pos(8);
       End-Ds;

       //  code barre suivi
       Dcl-Ds *n;
         sui_cod         Char(2)         Pos(1) inz('8W');
         colis           Zoned(10:0)     Pos(3) inz(*zero);
         r10             Zoned(1:0)      Pos(3) dim(10);
         cle             Zoned(1:0)      Pos(13) inz(*zero);
         cle_alp         Char(1)         Pos(13);
         cpr_cb          Char(17)        Pos(1);
         cpr_t1          Char(5)         Pos(3);
         cpr_t2          Char(5)         Pos(8);
         sui_12          Zoned(1:0)      Pos(12);
       End-Ds;

       //  code barre prise en charge
       Dcl-Ds *n;
         pec_cod         Char(2)         Pos(1) inz('8W');
         pec_tri         Zoned(1:0)      Pos(3) inz(1);
         pec_ptt         Char(5)         Pos(4);
         pec_pttnum      Zoned(5:0)      Pos(4);
         pec_dpt         Zoned(2:0)      Pos(4);
         pec_cli         Zoned(6:0)      Pos(9);
         pec_clia        Char(6)         Pos(9);
         pec_poi         Zoned(4:0)      Pos(15);
         pec_poia        Char(4)         Pos(15);
         pec_res         Zoned(2:0)      Pos(19) inz(00);
         pec_nme         Zoned(1:0)      Pos(21) inz(0);
         pec_crbt        Zoned(1:0)      Pos(22) inz(0);
         pec_12          Zoned(1:0)      Pos(23);
         r15             Zoned(1:0)      Pos(9) dim(15);
         pec_cle         Zoned(1:0)      Pos(24) inz(*zero);
         pec_cle_alp     Char(1)         Pos(24);
         pec_3           Char(3)         Pos(1);
         pec_22          Char(22)        Pos(3);
         pec_6           Char(6)         Pos(19);
         cpr_pec         Char(24)        Pos(1);
       End-Ds;

       Dcl-Ds *n;
         etb5            Char(40)        Pos(1);
         cpo             Char(5)         Pos(1);
         vil             Char(34)        Pos(7);
       End-Ds;

       Dcl-Ds *n;
         nl              Zoned(6:0)      Pos(1);
         alp_lot         Char(6)         Pos(1);
       End-Ds;

       Dcl-Ds *n;
         rco_ptt         Zoned(5:0)      Pos(1);
         ptt             Char(5)         Pos(1);
       End-Ds;

       Dcl-Ds *n;
         wrk_etb1        Char(32);
         wrk_etb2        Char(32);
         wrk_etb3        Char(32);
         wrk_etb4        Char(32);
         wrk_etb5        Char(32);
         wrk_etb6        Char(32);
         wrk_etb         Char(32)        Pos(1) inz(*blanks) dim(6);
       End-Ds;
       Dcl-Ds *n;
         cad_etb1;
         cad_etb2;
         cad_etb3;
         cad_etb4;
         cad_etb5;
         cad_etb6;
         cadetb          Char(40)        Pos(1) inz(*blanks) dim(6);
       End-Ds;

       Dcl-Ds *n;
         numlot_alp      Zoned(6:0)      Pos(1);
         nlot            Char(6)         Pos(1);
       End-Ds;

       Dcl-Ds *n;
         cpr_poi         Char(5)         Pos(1);
         poi             Zoned(4:0)      Pos(2);
         poi_2           Zoned(4:2)      Pos(2);
       End-Ds;


      /copy MAX/QRPGLESRC,IFSIO_H
      /copy MAX/QRPGLESRC,ERRNO_H
      /copy MAX/QRPGLESRC,IFSTEXT_H

       Dcl-Pr cmd ExtPgm('QCMDEXC');
         command         Char(200)       const;
         len             Packed(15:5)    const;
       End-Pr;

       Dcl-S fd              Int(10);
       Dcl-S line            Char(100);
       Dcl-S len             Int(10);
       Dcl-S msg             Char(52);
       Dcl-S err             Int(10);
       Dcl-C M               '!M "individuel france"';
       Dcl-C R               '!R';
       Dcl-C P               '!p1';
       Dcl-S nfile           Char(30);
       Dcl-S compteur        Zoned(6:0)      inz(*zero);
       Dcl-S cod             Char(3)         inz('cpr');
       Dcl-S i               Zoned(8:0)      inz(*zero);
       Dcl-S j               Zoned(8:0)      inz(*zero);
       Dcl-S site_nom        Char(30)        inz(*blanks);
       Dcl-S site            Zoned(2:0)      inz(*zero);
       Dcl-S text40          Char(70)        inz(*blanks);



           in par;

           date_jj2=date_jj;
           date_mm2=date_mm;
           date_aa2=date_aa;
           date_slash1='/';
           date_slash2='/';

           chain cli_col colis_a;       // colis adresse
           if not %found;
              *inh1=*on;
           endif;

           chain colis_num hcol_rc;       // récap colis
           if not %found;
              *inh8=*on;
           endif;

           chain cad_etb abo_adr;            // Adresse
           if not %found;
              *inh3=*on;
           endif;

           chain colis_num work_rc4;      // Récap Colis
           if not %found;
              *inh2=*on;
           endif;

           chain (cli_col:1) colis_l;
           if not %found;
              *inh3=*on;
           endif;

           chain (cli_clu) max_club;       // nom du club
           if not %found;                  // 20 caracteres
              *inh4=*on;
           endif;

           exsr edi;
           exsr maj_ri;
              exsr maj_lot;

              numlot_alp = numlot;

             chain numlot_alp work_cl;
           if %found(work_cl);
             compteur = cl_docet;
           endif;

              nfile = '/BL/' + %trim(nlot)
                    + %trim(cli_col) + %trim('.ETQ');

              exsr MakeFile;

              exsr WriteFile;
              exsr CloseFile;

        *inlr=*on;


     CLR                 If        *InLR
       Exsr finlbl;
     CLR                 EndIf


        begsr edi;

             chain 1 cpr_colis;
             if %found(cpr_colis);
                col_der=col_der+1;
                colis  =col_der;
                update forcol;
                pec_cli=col_cli;
             endif;

             cpr_ori ='IND';
             cpr_col =colis;       // colispr EDI
             cpr_doc =colis_num;
             cpr_clu =cli_clu;
             cpr_lot =cad_lot;
             cpr_tir =rco_tir;

             wrk_etb=*blanks;
             j=*zero;
             i=*zero;
             for i=1 to 4;
                if cadetb(i)<>*blanks;
                   j=j+1;
                   wrk_etb(j)=cadetb(i);
                endif;
             endfor;

             cpr_civ ='.';
             cpr_pre='.';
             cpr_nom =wrk_etb1;
             cpr_ad1 =wrk_etb2;
             cpr_ad2 =wrk_etb3;
             cpr_ad3 =wrk_etb4;
             cpr_ad4 ='.';
             if cpr_ad1=*blanks;
                cpr_ad1='.';
             endif;
             if cpr_ad2=*blanks;
                cpr_ad2='.';
             endif;
             if cpr_ad3=*blanks;
                cpr_ad3='.';
             endif;

             etb5   =cad_etb5;

             cpr_cp  = cpo;
             cpr_vil = vil;
             cpr_pay = 'FR';
             cpr_hsp = 'NON';
             cpr_tar = *blanks;
             cpr_dt1 = datejob;

             // code barre suivi

             r1=r10(10)+r10(8)+r10(6)+r10(4)+r10(2);  // code barre suivi
             r2=r1*3;
             r3=r10(9)+r10(7)+r10(5)+r10(3)+r10(1);
             r4=r2+r3;
             if r4_1=*zero;
                r5=r4;
             endif;
             if r4_1<>*zero;
                r5=r4;
                r5=r5+10;
                r5_1=0;
             endif;
             cle=r5-r4;

             // code barre prise en charge

             eval(h) pec_poi=rco_pot/10;
             poi = pec_poi;
             pec_12 =sui_12;
             pec_ptt=ptt;

             r1=r15(15)+r15(13)+r15(11)+r15(9)+r15(7)+r15(5)+r15(3)+r15(1);
             r2=r1*3;
             r3=r15(14)+r15(12)+r15(10)+r15(8)+r15(6)+r15(4)+r15(2);
             r4=r2+r3;
             if r4_1=*zero;
                r5=r4;
             endif;
             if r4_1<>*zero;
                r5=r4;
                r5=r5+10;
                r5_1=0;
             endif;
             pec_cle=r5-r4;

             exsr site_tri;  // récupération site_nom;
             cpr_nst=site_nom;
             cpr_cst=site;

             write forcpr;

        endsr;

        begsr maj_ri;            // recap expedition
           chain (cli_nt:cod) cpr_ri;
           if not %found(cpr_ri);
              clear forri;
           endif;
           ri_tir=cli_nt;
           ri_cod=cod;
           ri_dat=datejob;
           if c>=1 and c<=8;
              ri(c)=ri(c)+1;
           endif;
           if not %found(cpr_ri);
              write forri;
           endif;
           if %found(cpr_ri);
              update forri;
           endif;
        endsr;

        begsr maj_lot;          // consignation lot

           if rco_tg3='1';   // complémentaire colispr
              lot1=1;
              fpr_lot=cli_lot;
           endif;

           if rco_tg3='2';   // complémentaire urgent colispr
              fpr_lot=cli_lot;
           endif;

           chain cli_lot  cpr_colot;
           if not %found(cpr_colot);
              clear forlot;
           endif;

           if rco_tg3=' ';   //
              fpr_lot=cli_lot;
           endif;

           if rco_tg3='1';   // complémentaire colispr
              lot1=1;
              fpr_lot=cli_lot;
           endif;

           if rco_tg3='2';   // complémentaire urgent colispr
              fpr_lot=cli_lot;
           endif;

           fpr_ori='IND';
           fpr_dat=datejob;
           fpr_nbr=fpr_nbr+1;
           fpr_club(1)=fpr_club(1)+rco_beb_bc;
           fpr_club(2)=fpr_club(2)+rco_tit_bc;
           fpr_club(3)=fpr_club(3)+rco_min_bc;
           fpr_club(4)=fpr_club(4)+rco_kil_bc;
           fpr_club(5)=fpr_club(5)+rco_ani_bc;
           fpr_club(6)=fpr_club(6)+rco_max_bc;
           fpr_club(7)=fpr_club(7)+rco_sup_bc;
           fpr_club(8)=fpr_club(8)+rco_med_bc;
           if not %found(cpr_colot);
              write forlot;
           endif;
           if %found(cpr_colot);
              update forlot;
           endif;
        endsr;

        begsr site_tri;
           site_nom=*blanks;
           site    =*zero;
         //if pec_dpt<>20;   // autre corse
              chain pec_dpt cpr_dpt;
              if %found(cpr_dpt);
                 chain dpt_sit cpr_st;
                 if %found(cpr_st);
                    site_nom=st_lib;
                    site    =st_cod;
                 endif;
              endif;
         //endif;
         //if pec_dpt=20;   // corse
         //   if pec_pttnum>=20000 and pec_pttnum<=20199
         //   or pec_pttnum>=20300 and pec_pttnum<=20399
         //   or pec_pttnum>=20500 and pec_pttnum<=20599
         //   or pec_pttnum>=20700 and pec_pttnum<=20799
         //   or pec_pttnum>=20900 and pec_pttnum<=20999;
         //      site=6;
         //   endif;
         //   if pec_pttnum>=20200 and pec_pttnum<=20299
         //   or pec_pttnum>=20400 and pec_pttnum<=20499
         //   or pec_pttnum>=20600 and pec_pttnum<=20699
         //   or pec_pttnum>=20800 and pec_pttnum<=20899;
         //      site=7;
         //   endif;
         //   chain site cpr_st;
         //   if %found(cpr_st);
         //      site_nom=st_lib;
         //   endif;
         //endif;
        endsr;
       BegSr MakeFile;
         If unlink (nfile) < 0;
           err = errno;
           If err <> ENOENT;
             die('unlink(): ' + %str(strerror(err)));
           EndIf;
         EndIf;
         //
         fd = open (nfile:
                  O_CREAT+O_WRONLY+O_CODEPAGE:
                  S_IRWXU+S_IRWXG+S_IRWXO:
                  1252);

         If fd < 0;
           die('open(): ' + %str(strerror(errno)));
         EndIf;
         CallP close(fd);
         //
         fd = open(nfile :
                       O_WRONLY+O_TEXTDATA);
         If fd < 0;
           die('open(): ' + %str(strerror(errno)));
         EndIf;
       EndSr;
       BegSr WriteFile;
         //*********** Appel Masque *************************
         //
         line = M;
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //***********  Raz variable ************************
         //
         line = R;
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //***********  variable 1 ref cient       *********
         //
         line = %trim('!W1')+ ' ' +
                    '"' + %char(colis_num) + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //***********  variable 2 compte client   *********
         //
         line = %trim('!W2')+ ' ' +
                    '"'+ pec_clia + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //
         //***********  variable 3 Site de prise en charge *********
         //
         line = %trim('!W3')+ ' ' +
                   '"' + 'ROUBAIX PFC' + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //***********  variable 4 N° de colis *********
         //
         line = %trim('!W4')+ ' ' +
                   '"' + sui_cod + ' ' + cpr_t1
                  + ' ' + cpr_t2 + cle_alp + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //***********  variable 5 poids      *********
         //
         line = %trim('!W5')+ ' ' +
                   '"' + %editw(poi_2:'0 ,  ') + ' '
                   + 'Kg' + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //***********  variable 6 edité le   *********
         //
         line = %trim('!W6')+ ' ' +
                   '"' + date + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //***********  variable 7 exped      *********
         //
         line = %trim('!W7')+ ' ' +
                   '"' + %trim(clu_nom) + ' ' + '/'
                  + ' ' + 'L''ECOLE DES LOISIRS' + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //
         //***********  variable 8 exped      *********
         //
         line = %trim('!W8')+ ' ' +
                   '"' + '11 RUE DE SEVRES' + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //***********  variable 9 exped       *********
         //
         line = %trim('!W9')+ ' ' +
                   '"' + '75006 PARIS' + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //***********  variable 10 N° de colis *********
         //
         line = %trim('!W10')+ ' ' +
                   '"' + sui_cod + ' ' + cpr_t1
                  + ' ' + cpr_t2 + cle_alp + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //***********  variable 22 code barre  *********
         //
         // ne prend pas les 0 du debut si compteur commence par 0 en CAB
         //                                  '"' + sui_cod + %char(colis)
         //                                 + %trim(%editw(colis:'0         '))
         line = %trim('!W22')+ ' ' +
                   '"' + sui_cod
                  + cpr_t1 + cpr_t2
                  + cle_alp + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //***********  variable 19 N° de colis *********
         //
         line = %trim('!W19')+ ' ' +
                   '"' + %char(cpr_cst) + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //***********  variable 12 nom         *********
         //
         line = %trim('!W12')+ ' ' +
                   '"' + cpr_nom + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //
         //
         //***********  variable 13 adr1        *********
         //
         line = %trim('!W13')+ ' ' +
                   '"' + cpr_ad1 + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //***********  variable 14 adr2       *********
         //
         line = %trim('!W14')+ ' ' +
                   '"' + cpr_ad2 + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //***********  variable 15 adr3        *********
         //
         line = %trim('!W15')+ ' ' +
                   '"' + cpr_ad3 + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //
         //***********  variable 16 adr4        *********
         //
         line = %trim('!W15')+ ' ' +
                   '"' + ' '     + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //***********  variable 17 cdp         *********
         //
         line = %trim('!W17')+ ' ' +
                   '"' + cpr_cp + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //
         //***********  variable 18 ville       *********
         //
         line = %trim('!W18')+ ' ' +
                   '"' + cpr_vil + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //***********  variable 11 code BAR spe *********
         //
         line = %trim('!W11')+ ' ' +
                   '"' + pec_cod + pec_22 + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         //
         //***********  variable 21 N° PCH       *********
         //
         line = %trim('!W21')+ ' ' +
                   '"' + pec_3 + ' ' + pec_ptt + ' ' +
                   %char(pec_cli) + ' ' + pec_poia +  ' '
                  + pec_6 + '"';
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
       EndSr;
       BegSr CloseFile;
         //***********  fin etiquette    *********
         //
         line = P;
         len = %len(%trimr(line));
         writeline(fd: %addr(line): len);
         //
         CallP close(fd);
         compteur = compteur + 1;
       EndSr;
       BegSr finlbl;
            chain numlot_alp work_cl;
          if %found(work_cl);
            cl_docet = compteur;
            update forcl;
          endif;
       EndSr;
      /DEFINE ERRNO_LOAD_PROCEDURE
      /COPY MAX/QRPGLESRC,ERRNO_H
```
