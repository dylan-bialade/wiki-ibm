---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: CLIDPF
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 63
modifie: 2026-11-16
---

# BIB17/QRPGSRC/CLIDPF

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FFICCLI  IF  E           K        DISK
     FQPRINT  O   F     132            PRINTER
      *
     C           *ENTRY    PLIST
     C                     PARM           CLIDCL
     *  IMPRESSION DE ENTETE
      *
     C*          CLIDCL    SETLLCLIENTSF
     C*                    READECLIENTSF                 99
     C           CLIDCL    CHAINCLIENTSF             99
     C           *IN99     IFEQ '0'
     C                     EXCPTDET
     C                     ENDIF
     C                     SETON                     LR
      *
     *   LIGNE ID - ID 6 DE LONG
     OQPRINT  E                DET
     O                                    3 'ID'
     O                                   10 ':'
     O                         CLIDCL    17
      *
     *   LIGNE NOM - 20 DE LONG
     OQPRINT  E                DET
     O                                    4 'NOM'
     O                                   10 ':'
     O                         CLNOCL    31
      *
     *   LIGNE ADRESSE - 20 DE LONG
     OQPRINT  E                DET
     O                                    8 'ADRESSE'
     O                                   10 ':'
     O                         CLADCL    31
      *
     *   LIGNE CODE POSTAL - 5 DE LONG
     OQPRINT  E                DET
     O                                    3 'CP'
     O                                   10 ':'
     O                         CLCPCL    16
      *
     *   LIGNE VILLE -20 DE LONG
     OQPRINT  E                DET
     O                                    6 'VILLE'
     O                                   10 ':'
     O                         CLVICL    31
      *
     *   LIGNE TELEPHONE - 10 LONG
     OQPRINT  E                DET
     O                                    4 'TEL'
     O                                   10 ':'
     O                         CLTECL    21
      *
     *   LIGNE TELEPHONE - 100 LONG
     OQPRINT  E                DET
     O                                    5 'MAIL'
     O                                   10 ':'
     O                         CLMACL   111
      *
     *   LIGNE SIRET  - 14 LONG
     OQPRINT  E                DET
     O                                    6 'SIRET'
     O                                   10 ':'
     O                         CLSICL    25
      *
```
