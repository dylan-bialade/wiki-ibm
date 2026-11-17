# CLIMPF : 3 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB05 | QRPGSRC2 | RPG/RPG-III-400 | 29 | 100 % | SETLL / READ, boucle DOW/DOU/FOR, indicateurs *INxx | [CLIMPF.md](../../sources/RPG/RPG-III-400/BIB05/CLIMPF.md) |
| BIB05 | QRPGLESRC | RPG/RPG-ILE | 29 | 65 % | SETLL / READ, boucle DOW/DOU/FOR, indicateurs *INxx | [CLIMPF.md](../../sources/RPG/RPG-ILE/BIB05/CLIMPF.md) |
| BIB17 | QRPGSRC | RPG/RPG-III-400 | 38 | 82 % | SETLL / READ, boucle DOW/DOU/FOR, indicateurs *INxx | [CLIMPF.md](../../sources/RPG/RPG-III-400/BIB17/CLIMPF.md) |

## Differences

- Techniques communes : SETLL / READ, boucle DOW/DOU/FOR, indicateurs *INxx
- Langages / types differents : RPG/RPG-III-400, RPG/RPG-ILE

## Codes

### BIB05 (RPG/RPG-III-400, 29 lignes)

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

### BIB05 (RPG/RPG-ILE, 29 lignes)

```text
     FCLIENF    IF   E           K DISK
     FQPRINT    O    F  132        PRINTER
     C                   EXCEPT    ENT
     C     *LOVAL        SETLL     CLIENTSF
     C                   READ      CLIENTSF                               99
     C     *IN99         DOWEQ     '0'
     C                   EXCEPT    DET
     C                   EXCEPT    DET2
     C                   READ      CLIENTSF                               99
     C                   ENDDO
     C                   SETON                                        LR
     OQPRINT    E            ENT
     O                                            3 'ID'
     O                                           11 'NOM'
     O                                           36 'ADRESSE'
     O                                           52 'CP'
     O                                           61 'VILLE'
     O                                           80 'TEL'
     O                                           93 'SIRET'
     OQPRINT    E            DET
     O                       CLIDCL               7
     O                       CLNOCL              28
     O                       CLADCL              49
     O                       CLCPCL              55
     O                       CLVICL              76
     O                       CLTECL              87
     O                       CLSICL             102
     OQPRINT    E            DET2           2
     O                       CLMACL             101
```

### BIB17 (RPG/RPG-III-400, 38 lignes)

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
