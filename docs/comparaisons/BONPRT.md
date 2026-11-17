# BONPRT : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB10 | QRPGSRC | RPG/RPG-III-400 | 53 | 100 % | SETLL / READ, boucle DOW/DOU/FOR, indicateurs *INxx | [BONPRT.md](../../sources/RPG/RPG-III-400/BIB10/BONPRT.md) |
| BIB20 | QPRTSRC | DDS | 19 | 0 % |  | [BONPRT.md](../../sources/DDS/BIB20/BONPRT.md) |

## Differences

- **BIB10** en propre : SETLL / READ, boucle DOW/DOU/FOR, indicateurs *INxx
- Langages / types differents : RPG/RPG-III-400, DDS

## Codes

### BIB10 (RPG/RPG-III-400, 53 lignes)

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

### BIB20 (DDS, 19 lignes)

```text
                R TITRE
                                        2 50'LISTE DES BONBONS'
                R ENTETE
                                            SPACEB(001)
                                          10'N°'
                                          25'NOM'
                                          55'MARQUE'
                                          85'PRIX EXPORT'
                R DETAILS
                                            SPACEB(001)
                  NUMBB          6S 0      5
                  NOM           20A       20
                  MARQUE        20A       50
                  PRIX           5S 2     89
                R ETOILE
                                          50'********************'
                R EJECT
                                            SKIPA(1)
                                         105'A SUIVRE......'
```
