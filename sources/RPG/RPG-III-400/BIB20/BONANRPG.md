---
bibliotheque: BIB20
fichier_source: QRPGSRC
membre: BONANRPG
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 166
modifie: 2026-11-16
---

# BIB20/QRPGSRC/BONANRPG

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      ***************************************************
      *
      *       DEFILEMENT DE DONNEES SUR L'ECRAN
      *
      *       PROCEDURE  D' APPEL : LE PROGRAMME
      *       T.  GODEC        LE : 07.08.89
      *
      *       AJOUT : PAUSE ENTRE CHAQUE AFFICHAGE
      *               (APPEL DU CLLE PAUSE, EN MS)
      *
      ***************************************************
     FBFFM    O   E                    WORKSTN
     E                    T1      1   7 80
     E                    T2      1   7 80
     E                    WT         80  1
      ******************************************
      *  DELAI ENTRE DEUX IMAGES (MILLISECONDES)
      ******************************************
     C                     Z-ADD50        DELAI   50
      ******************************************
      *  TRAITEMENT  DU  TABLEAU
      ******************************************
B1   C           *IN01     DOUEQ'1'
      *
     C                     ADD  1         I       20
     C           80        SUB  I         J       20
B2   C           J         IFGT 0
      *
     C                     MOVEAT1,1      WT,J
     C                     MOVEAWT        L11
      *
     C                     MOVEAT1,2      WT,J
     C                     MOVEAWT        L12
      *
     C                     MOVEAT1,3      WT,J
     C                     MOVEAWT        L13
      *
     C                     MOVEAT1,4      WT,J
     C                     MOVEAWT        L14
      *
     C                     MOVEAT1,5      WT,J
     C                     MOVEAWT        L15
      *
     C                     MOVEAT1,6      WT,J
     C                     MOVEAWT        L16
      *
     C                     MOVEAT1,7      WT,J
     C                     MOVEAWT        L17
      *
     C                     MOVEAT2,1      WT,J
     C                     MOVEAWT        L21
      *
     C                     MOVEAT2,2      WT,J
     C                     MOVEAWT        L22
      *
     C                     MOVEAT2,3      WT,J
     C                     MOVEAWT        L23
      *
     C                     MOVEAT2,4      WT,J
     C                     MOVEAWT        L24
      *
     C                     MOVEAT2,5      WT,J
     C                     MOVEAWT        L25
      *
     C                     MOVEAT2,6      WT,J
     C                     MOVEAWT        L26
      *
     C                     MOVEAT2,7      WT,J
     C                     MOVEAWT        L27
      *
X2   C                     ELSE
     C                     MOVE '1'       *IN01
E2   C                     END
      ******************************************
      * AFFICHAGE
      ******************************************
B2   C           *IN01     IFEQ '1'
      *    FIN DE L'ALLER : MAINTIEN ~3 SECONDES
     C                     WRITEECRAN1
     C                     Z-ADD900       DELAI
B3   C                     DO   3
     C                     EXSR PAUSE
E3   C                     END
     C                     Z-ADD50        DELAI
X2   C                     ELSE
     C                     WRITEECRAN1
     C                     EXSR PAUSE
E2   C                     END
E1   C                     END
      ******************************************
     C                     MOVE '0'       *IN01
      *
B1   C           1         DO   80        J
      *
     C                     MOVEAT1,1      WT,1
     C                     MOVEAWT,J      L11
      *
     C                     MOVEAT1,2      WT,1
     C                     MOVEAWT,J      L12
      *
     C                     MOVEAT1,3      WT,1
     C                     MOVEAWT,J      L13
      *
     C                     MOVEAT1,4      WT,1
     C                     MOVEAWT,J      L14
      *
     C                     MOVEAT1,5      WT,1
     C                     MOVEAWT,J      L15
      *
     C                     MOVEAT1,6      WT,1
     C                     MOVEAWT,J      L16
      *
     C                     MOVEAT1,7      WT,1
     C                     MOVEAWT,J      L17
      *
     C                     MOVEAT2,1      WT,1
     C                     MOVEAWT,J      L21
      *
     C                     MOVEAT2,2      WT,1
     C                     MOVEAWT,J      L22
      *
     C                     MOVEAT2,3      WT,1
     C                     MOVEAWT,J      L23
      *
     C                     MOVEAT2,4      WT,1
     C                     MOVEAWT,J      L24
      *
     C                     MOVEAT2,5      WT,1
     C                     MOVEAWT,J      L25
      *
     C                     MOVEAT2,6      WT,1
     C                     MOVEAWT,J      L26
      *
     C                     MOVEAT2,7      WT,1
     C                     MOVEAWT,J      L27
      *
     C           J         COMP 60                   02
     C                     WRITEECRAN1
     C                     EXSR PAUSE
      *
E1   C                     END
      ******************************************
     C                     MOVE '1'       *INLR
      ******************************************
      *  PAUSE : ATTENTE DE DELAI MILLISECONDES
      ******************************************
     C           PAUSE     BEGSR
     C                     CALL 'PAUSE'
     C                     PARM           DELAI
     C                     ENDSR
**
   BBBBBBBBB       OOOOOO      NNNN     N    NNNN     N    EEEEEEEEEE
   BBBB     B     OOO    O     NNNNN    N    NNNNN    N    EEEE
   BBBB     B    OOOO     O    NNNN N   N    NNNN N   N    EEEE
   BBBBBBBBB     OOOO     O    NNNN  N  N    NNNN  N  N    EEEEEEEE
   BBBB     B    OOOO     O    NNNN   N N    NNNN   N N    EEEE
   BBBB     B     OOO    O     NNNN    NN    NNNN    NN    EEEE
   BBBBBBBBB       OOOOOO      NNNN     N    NNNN     N    EEEEEEEEEE
**
      AAAA       NNNN     N    NNNN     N    EEEEEEEEEE    EEEEEEEEEE
     AAAA A      NNNNN    N    NNNNN    N    EEEE          EEEE
    AAAA   A     NNNN N   N    NNNN N   N    EEEE          EEEE
   AAAA     A    NNNN  N  N    NNNN  N  N    EEEEEEEE      EEEEEEEE
   AAAAAAAAAA    NNNN   N N    NNNN   N N    EEEE          EEEE
   AAAA     A    NNNN    NN    NNNN    NN    EEEE          EEEE
   AAAA     A    NNNN     N    NNNN     N    EEEEEEEEEE    EEEEEEEEEE
```
