---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: AGENCE3R
type: DDS
longueur_enregistrement: 100
lignes: 44
modifie: 2026-11-16
---

# BIB02/QDDSRC/AGENCE3R

```text
       // But du programme :
       // Imprimer dans un spool le contenu du fichier AGENCEL1.
       // Le fichier PRTF qui va générer le spoole est AGENCET. Les zones à imprimer
       // correspondent aux nom des zones d'AGENCE, préfixé par T.
     H DFTACTGRP(*NO)
     FAGENCET   O    E             PRINTER
     F
     FRACEL1    IF   E           K DISK

     DLigne            S              3  0

             *inlr = *ON;      // On commence par allumer l'indicateur de sortie finale
             Ligne = 1;        // On initialise le compteur de ligne.
              WRITE ENTETE;
              WRITE TITRE;

             // On se positionne en début de fichier ...
             SETLL *LOVAL RACEL1;

             // ... et on attaque la lecture séquentielle.
             READ RACEL1;

             // Tant qu'on est pas à la fin du fichier ...
             DOW NOT %EOF(RACEL1);
                    TNORACE = NORACE;
                    TDTRACE = DTRACE;
                    TTPRACE = TPRACE;
                    TGRRACE = GRRACE;
                    TNMRACE = NMRACE;
                    TDSRACE = DSRACE;
                    TT1RACE = T1RACE;
                    TP3RACE = P3RACE;
                    TAVRACE = AVRACE;
                    TFORME = FORME;
                    WRITE DETAIL;
                    LIGNE += 1;
                    READ RACEL1;
                    IF LIGNE  = 56;
                      WRITE EJECT;
                      WRITE ENTETE;
                      WRITE TITRE;
                      LIGNE = 5;
                    ENDIF;
              ENDDO;
```
