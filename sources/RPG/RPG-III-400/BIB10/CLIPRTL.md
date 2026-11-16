---
bibliotheque: BIB10
fichier_source: QRPGSRC
membre: CLIPRTL
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 51
modifie: 2026-11-16
---

# BIB10/QRPGSRC/CLIPRTL

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
     FFICCLI  IF  E           K        DISK
     FQPRINT  O   F     132            PRINTER
     E                    SEP     1   2 66
     C                     SETON                         LR
     C           SEP,1     CAT  SEP,1     SEP1  132
     C           SEP,2     CAT  SEP,2     SEP2  132
     C                     EXCPTENT
     C           *LOVAL    SETLLCLIENTSF
     C                     READ CLIENTSF                 90
     C           *IN90     DOWEQ*OFF
     C                     EXCPTDTA
     C*                    EXCPTDTA2
     C                     READ CLIENTSF                 90
     C                     ENDDO
     OQPRINT  E  1             ENT
     O                                    3 'ID'
     O                                   11 'NOM'
     O                                   36 'ADRESSE'
     O                                   52 'CP'
     O                                   61 'VILLE'
     O                                   80 'TEL'
     O                                   93 'SIRET'
     OQPRINT  E                ENT
     O                         SEP1     132
     OQPRINT  E                DTA
     O                         CLIDCL     7
     O                                    8 '|'
     O                         CLNOCL    28
     O                                   29 '|'
     O                         CLADCL    49
     O                                   50 '|'
     O                         CLCPCL    55
     O                                   56 '|'
     O                         CLVICL    76
     O                                   77 '|'
     O                         CLTECL    87
     O                                   88 '|'
     O                         CLSICL   102
     O                                  103 '|'
     OQPRINT  E                DTA
     O                         SEP2     132
     O*PRINT  E  2             DTA2
     O*                        CLMACL   101
**
==================================================================
------------------------------------------------------------------
```
