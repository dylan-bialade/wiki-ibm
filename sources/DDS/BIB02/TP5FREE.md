---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: TP5FREE
type: DDS
longueur_enregistrement: 100
lignes: 34
modifie: 2026-11-16
---

# BIB02/QDDSRC/TP5FREE

```text
F************************************************************
     F************************************************************
     FENTREPOT  UF A E           K DISK    PREFIX(ENT_)
     FINVENLF   IF   E           K DISK    PREFIX(INV_)
     DQT_CALC          S              4  0
      ************************************************************
      *                  DEBUT PROG
      ************************************************************
     C/free
       *INLR = *ON;
       // Lit le fichier physique Entrepot
       READ ENTREPOT;

       // Tantque l'on atteint pas la fin du fichier on boucle
       DOW NOT %EOF(ENTREPOT);
         // On se positionne  sur ent_codpro
         SETLL ENT_CODPRO INVENLF;
        // Lit le fichier
         READE ENT_CODPRO INVENLF;
         // Tantque l'on atteint pas la fin du fichier Logique INVENLF on boucle
         DOW NOT %EOF(INVENLF);
           QT_CALC = QT_CALC + INV_QTINV;
           READE ENT_CODPRO INVENLF;
         ENDDO;
         IF QT_CALC <> 0;
           ENT_QTPRO = ENT_QTPRO + QT_CALC;
           UPDATE ENTREPOTF;
           ENT_DTDINV = %DATE();
         ENDIF;
         READ ENTREPOT;
        // Réinitialise la boucle à 0
         QT_CALC = 0;
       ENDDO;
       /end-free
```
