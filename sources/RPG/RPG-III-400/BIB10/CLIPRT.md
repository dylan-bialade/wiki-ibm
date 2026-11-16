---
bibliotheque: BIB10
fichier_source: QRPGSRC
membre: CLIPRT
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 60
modifie: 2026-11-16
---

# BIB10/QRPGSRC/CLIPRT

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
     FQPRINT  O   F      51            PRINTER
     E                    TBL     1  11 50
     C                     SETON                         LR
     C           *ENTRY    PLIST
     C                     PARM           CLIDCL
      *
     C           CLIDCL    CHAINCLIENTSF             90
     C                     MOVELCLMACL    MAIL   37
     C                     TESTN          CLTECL     88
     C   88                MOVE CLTECL    TEL    100
     C  N88                MOVE *ZEROS    TEL    100
     C  N90                EXCPTDTA
     OQPRINT  E  1             DTA
     O                         TBL,1
     OQPRINT  E  1             DTA
     O                         TBL,2
     OQPRINT  E  1             DTA
     O                         TBL,3
     OQPRINT  E  1             DTA
     O                         TBL,4
     O                         CLIDCL    17
     OQPRINT  E  1             DTA
     O                         TBL,5
     O                         CLNOCL    30
     OQPRINT  E  1             DTA
     O                         TBL,6
     O                         CLADCL    30
     OQPRINT  E  1             DTA
     O                         TBL,7
     O                         CLCPCL    16
     O                         CLVICL    45
     OQPRINT  E  1             DTA
     O                         TBL,8
     O                         TEL       26 '0  .  .  .  .  '
     OQPRINT  E  1             DTA
     O                         TBL,9
     O                         CLSICL    29
     OQPRINT  E  1             DTA
     O                         TBL,10
     O                         MAIL      48
     OQPRINT  E  1             DTA
     O                         TBL,11
**
+================================================+                     ========+
|                 FICHE CLIENT                   |                            |
+================================================+
| ID     : XXXXXX                                |
| NOM    : XXXXXXXXXXXXXXXXXXXX                  |
| ADRESSE: XXXXXXXXXXXXXXXXXXXX                  |
| CP     : XXXXX  VILLE: XXXXXXXXXXXXXXXXXXXX    |
| TEL    : XX.XX.XX.XX.XX                        |
| SIRET  : XXX XXX XXX XXXXX                     |
| EMAIL  : XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX |
+================================================+
```
