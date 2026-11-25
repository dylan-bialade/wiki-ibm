# STOCK : 3 versions differentes dans 3 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB02 | QBNDSRC | Autres/Service-programs | 97 | 100 % | ecran (WORKSTN), CHAIN, boucle DOW/DOU/FOR, procedures (dcl-proc), prototypes (dcl-pr), indicateurs *INxx | [STOCK.md](../../sources/Autres/Service-programs/BIB02/STOCK.md) |
| BIB20 | QDDSSRC | DDS | 5 | 0 % |  | [STOCK.md](../../sources/DDS/BIB20/STOCK.md) |
| BIB25 | QF_PFLF | DDS | 5 | 0 % | DDS (R/K/PFILE) | [STOCK.md](../../sources/DDS/BIB25/STOCK.md) |

## Differences

- **BIB02** en propre : ecran (WORKSTN), CHAIN, boucle DOW/DOU/FOR, procedures (dcl-proc), prototypes (dcl-pr), indicateurs *INxx
- **BIB25** en propre : DDS (R/K/PFILE)
- Langages / types differents : Autres/Service-programs, DDS

## Codes

### BIB02 (Autres/Service-programs, 97 lignes)

```text
       CTL-OPT option(*SRCSTMT) DFTACTGRP(*NO)
              BNDDIR('STOCKDIR');
     Fstockdsp  CF   E             workstn

     FentrepotlfUF A E           K disk    prefix(ent_)
     Dlistmois         S              9A   dim(12)
     dDtPres           S             17A

       DCL-PR color_red ind;
         fmt2qtp      packed(3);
       END-PR;
       // Tableau Mois
       listmois = %list('Janvier': 'Fevrier' : 'Mars' : 'Avril' : 'Mai' : 'Juin'
       : 'Juillet' : 'Aout' : 'Septembre' : 'Octobre' : 'Novembre' : 'Decembre'
       );

       // Tantque l'on n'appuie pas sur la touche F3  on boucle
       DOW NOT *IN03;
         // Affiche l'écran 1

         EXFMT FMT1;


         // Selon cas
         SELECT;

         // Quand F3 appuyer on quitte la boucle
         WHEN *IN03;
           *inlr=*on;
           LEAVE;

         // Quand on appuie sur F6
         WHEN *IN06;
           *inlr=*on;
           // On exécute la sous routine F6
           EXSR F6;

         // Quand on appuie sur F12
         WHEN *IN12;
           // On affiche l'écran 1 FMT1
           EXFMT fmt1;
           *inlr=*on;

         ENDSL;


         // récupère un enregistrement à partir de entrepotlf
         chain scodpro entrepotlf;
         // Si trouvé (cad si scodpro == entrepotlf codpro)
         IF %Found;
           fmt2codp = ent_codpro;
           fmt2nom = ent_nmpro;
           fmt2qtp = ent_qtpro;
           fmt2date = ent_dtdinv;
           *IN88 = color_red(fmt2qtp);
           EXSR NewDate;

           // Affiche ecran FMT2
           EXFMT fmt2;

           // SI *IN50 (SI il y a modification)
           IF *IN50;
             ent_codpro = fmt2codp;
             ent_nmpro = fmt2nom;
             ent_qtpro = fmt2qtp;
             ent_dtdinv =  fmt2date;
             // Mise à jour des données
             UPDATE entrepotf;
           ENDIF;
         ENDIF;

       ENDDO;


       *INLR = *ON;

       // Sous routine de la touche F6
       BEGSR F6;
         EXFMT fmt6;
         IF *IN50;
           ent_codpro = fmt6codp;
           ent_nmpro = fmt6nom;
           ent_qtpro = fmt6qtp;
           ent_dtdinv =  %date();

           WRITE entrepotf;
         ENDIF;
       ENDSR;

       // Sous routine date
       BEGSR NewDate;
         DtPres = %char(%SUBDT(ent_dtdinv:*D))+
         ' '+%trim(listmois(%dec(%SUBDT(ent_dtdinv:*M))))+
         ' '+%char(%SUBDT(ent_dtdinv:*Y));
         fmt2date2 = %TRIM(DtPres);

       ENDSR;
```

### BIB20 (DDS, 5 lignes)

```text
                R STOCKF
                  ID             6P 0
                  ID_PRODUIT     6P 0
                  QUANTITE       6P 0
                  DATE_MOUVE      L         DATFMT(*EUR)
```

### BIB25 (DDS, 5 lignes)

```text
     A          R FSTOCK
     A            ID             6S 0
     A            ID_PRODUIT     6S 0
     A            QUANTITE       6S 0
     A            DATE_M          L         DATFMT(*EUR)
```
