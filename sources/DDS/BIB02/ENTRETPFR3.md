---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: ENTRETPFR3
type: DDS
longueur_enregistrement: 100
lignes: 89
modifie: 2026-11-16
---

# BIB02/QDDSRC/ENTRETPFR3

```text
     Fentredsp2 CF   E             workstn
     FentrepotlfUF A E           K disk    prefix(ent_)
     Dlistmois         S              9A   dim(12)
     dDtPres           S             17A


       // Tableau Mois
       listmois = %list('Janvier': 'Fevrier' : 'Mars' : 'Avril' : 'Mai' : 'Juin'
       : 'Juillet' : 'Aout' : 'Septembre' : 'Octobre' : 'Novembre' : 'Decembre'
       );

       // Tantque l'on n'appuie pas sur la touche F3  on boucle
       DOW NOT *IN03;
         // Affiche l'écran 1
         EXSR F6;


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
         chain codpros entrepotlf;
         // Si trouvé (cad si codpros == entrepotlf codpro)
         IF %Found;
             fmt2codp = ent_codpro;
             fmt2nom = ent_nmpro;
             fmt2qtp = ent_qtpro;
             fmt2date = ent_dtdinv;
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
