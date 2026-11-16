---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: CR6LE
type: DDS
longueur_enregistrement: 100
lignes: 144
modifie: 2026-11-16
---

# BIB02/QDDSRC/CR6LE

```text
       DCL-S K packed(1:0);
       DCL-S ECOTIS char(8);
       DCL-S EDATE packed(16:0);
       DCL-S DATE1 packed(4:0);
       DCL-S DATE2 packed(4:0);
       DCL-S D11 packed(2:0);
       DCL-S D12 packed (2:0);
       DCL-S D11B packed(4:0);
       DCL-S D12B packed(4:0);
       DCL-S DATE8 packed(8:0);
       DCL-S CDER packed(4:0);
       DCL-S RAN packed(2:0);
       DCL-S COL packed(2:0);

       DCL-DS *N;
         CLEPT char(16);
         CLECLI packed(6:0);
         CLECAI packed(8:0);
         CLEDTV packed (16:0);
       END-DS;

       IF *IN81 = '1';
         EXFMT CR6055FM;
       ENDIF;
       IF *IN81 = '0';
         *in81 = *On;
       ENDIF;

       *In99 = *Off;

       DOW NOT *IN03;
         SELECT;
         WHEN N01 AND N02;
           EXSR TR00;
         WHEN *IN01;
           EXSR TR01;
         WHEN *IN02;
           EXSR TR02;
         WHEN *IN99;
           EXSR ERREUR;
         ENDSL;
       ENDDO;

       // FIN TAG
       //
       // SOUS PROGRAMMES


       // Sous PG Traitement écran de départ à blanc
       BEGSR TR00;
         *InU1 = *Off;
         ECOTIS = 0;
         EDATE = 0;
         EXCEPT EC1;
       ENDSR;

       // Sous PG Traitement écran 1
       BEGSR TR01;
         DOW  i < 1;
           IF *In07 = *On;
             *Inlr = *On;
             CLECL = %SUBST(ECOTIS: 1 : 8);
             CHAIN CLECL CLI01L;
             K = 1;
             leave;
             IF CLREGI <> 'R';
               *In99 = *Off;
             ENDIF;
             IF CLREGI = 'A';
               *In99 = *On;
               K = 2;
             ENDIF;
             IF CLREGI = 'T';
               *In99 = *on;
               K = 3;
               EXSR CTDATE;
               EXSR CTDTSP;
               EXCEPT EC2;
             ENDIF;
           ENDIF;
           i += 1;
         ENDDO;
       ENDSR;

       // Sous PG Traitement écran 2
       BEGSR TR02;
         IF not *in07 and not *in10;
           EXCEPT EC2;
         ENDIF;
         *inlr = *in07;
         *inlr = *in10;
         *inu1 = *in10;
       ENDSR;

       // Sous PG contrôle de date
       BEGSR CTDATE;
         DOW  i < 1;

           DATE1 = %SUBST(EDATE: 1 : 4);  // JJMM
           DATE2 = %SUBST(EDATE:5);
           D11 = %SUBST(DATE1:1:2);
           D12 = %SUBST(DATE1:3);
           IF D12 > 12 OR D12 < 1;
             *IN99 = *on;
             K = 4;
             leave;
           ENDIF;
           IF D12 > 12 ;
             *in99 = *off;
           ENDIF;

           IF D11 > TM AND D11 > D12;
             K = K + 4;
             leave;
           ENDIF;
           *DATE = D11B;
           DATE2 = D12B;
           IF D12B = D11B;
             K = K + 5;
             leave;
           ENDIF;
           D11B = D11B - 1;


           i += 1;
           leave;
         ENDDO;

       ENDSR;

       // Sous PG contrôle date saisie : >= date versement du dernier mouvement
       BEGSR CTDTSP;
         DATE2 = EDATE;
         %subst(DATE2 : 1 : 2) = DATE8;
         %subst(EDATE : 1 : 2) = DATE1;
         %subst(DATE1: 1: 2) = D11;


       ENDSR;

       // Sous PG gestion d'erreur
       BEGSR ERREUR;

       ENDSR;
```
