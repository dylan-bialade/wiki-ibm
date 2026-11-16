---
bibliotheque: BIB05
fichier_source: QRPGSRC2
membre: BEERPF
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 29
modifie: 2026-11-16
---

# BIB05/QRPGSRC2/BEERPF

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FCLIENF  IF  E           K        DISK
     FQPRINT  O   F     132            PRINTER
     C                     EXCPTENT
     C           *LOVAL    SETLLCLIENTSF
     C                     READ CLIENTSF                 99
     C           *IN99     DOWEQ'0'
     C                     EXCPTDET
     C                     EXCPTDET2
     C                     READ CLIENTSF                 99
     C                     ENDDO
     C                     SETON                     LR
     OQPRINT  E                ENT
     O                                    3 'ID'
     O                                   11 'NOM'
     O                                   36 'ADRESSE'
     O                                   52 'CP'
     O                                   61 'VILLE'
     O                                   80 'TEL'
     O                                   93 'SIRET'
     OQPRINT  E                DET
     O                         CLIDCL     7
     O                         CLNOCL    28
     O                         CLADCL    49
     O                         CLCPCL    55
     O                         CLVICL    76
     O                         CLTECL    87
     O                         CLSICL   102
     OQPRINT  E  2             DET2
     O                         CLMACL   101
```
