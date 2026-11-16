---
bibliotheque: BIB10
fichier_source: QRPGSRC
membre: BONPRT
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 53
modifie: 2026-11-16
---

# BIB10/QRPGSRC/BONPRT

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      *=================================================*
      *              IMPRESSION FICHIER FICCLI        *
      * CONCATENATION DE STRING ET PYSPLAY SUR MESSAGE*
      *=================================================*
      *
     H            D
     FBONBONF IF  E           K        DISK
     FQPRINT  O   F      75     OA    LPRINTER
     E                    TBL     1   4 75
     E                    MSG     1   1 50
     LQPRINT   16FL 14OL
     IFBONBON
     I              COULEUR                         COUL
     C                     SETON                         LR
     C                     EXCPTENT
     C           *LOVAL    SETLLFBONBON
     C                     READ FBONBON                  90
     C           *IN90     DOWEQ*OFF
     C   OA                EXCPTENT
     C                     EXCPTDTA
     C                     READ FBONBON                  90
     C                     ENDDO
     C                     EXCPTFTP
     C           MSG,1     DSPLY
     OQPRINT  E  1 1           ENT
     O                                   43 'LISTE DES BONBON'
     O                                   59 'EDITÉ LE :'
     O                         UDATE Y   69
     OQPRINT  E  3             ENT
     O                                   43 '================'
      *
     OQPRINT  E  1             ENT
     O                         TBL,1
     OQPRINT  E  1             ENT
     O                         TBL,2
     OQPRINT  E  1             ENT
     O                         TBL,3
      *
     OQPRINT  E                DTA
     O                         TBL,2
     O                         NUMBER     8
     O                         NOM       30
     O                         MARQUE    52
     O                         COUL      64
     O                         PRIX      74 '  0 ,  &€'
     OQPRINT  E                FTP
     O                         TBL,1
**
+=========================================================================+
| NUMERO| NOM                 | MARQUE              | COULEUR   | PRIX    |
+-------------------------------------------------------------------------+
**
IMPRESSION DISPONIBLE DANS LES SPOOLS
```
