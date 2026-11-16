---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: CLIMPF
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 38
modifie: 2026-11-16
---

# BIB17/QRPGSRC/CLIMPF

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FFICCLI  IF  E           K        DISK
     FQPRINT  O   F     132            PRINTER
      *
     *  IMPRESSION DE ENTETE
     C                     EXCPTENT
      *
     C           *LOVAL    SETLLCLIENTSF
     C                     READ CLIENTSF                 99
     C           *IN99     DOWEQ'0'
     C                     EXCPTDET
     C                     EXCPTDET2
     C                     READ CLIENTSF                 99
     C                     ENDDO
     C                     SETON                     LR
      *
     *   ENTETE DE L'IMPRESSION
     OQPRINT  E                ENT
     O                                    3 'ID'
     O                                   11 'NOM'
     O                                   36 'ADRESSE'
     O                                   52 'CP'
     O                                   61 'VILLE'
     O                                   80 'TEL'
     O                                   93 'SIRET'
      *
     * CORPS DE L'IMPRESSION LISTE CLIENTS
     OQPRINT  E                DET
     O                         CLIDCL     7
     O                         CLNOCL    28
     O                         CLADCL    49
     O                         CLCPCL    55
     O                         CLVICL    76
     O                         CLTECL    87
     O                         CLSICL   102
      *
     * ZONE IMPRESSION EMAIL
     OQPRINT  E  2             DET2
     O                         CLMACL   101
```
