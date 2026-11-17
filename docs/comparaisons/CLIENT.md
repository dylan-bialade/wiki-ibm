# CLIENT : 3 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB09 | QSOURCES | DDS | 8 | 0 % | DDS (R/K/PFILE) | [CLIENT.md](../../sources/DDS/BIB09/CLIENT.md) |
| BIB20 | QDDSSRC | DDS | 4 | 0 % |  | [CLIENT~QDDSSRC.md](../../sources/DDS/BIB20/CLIENT~QDDSSRC.md) |
| BIB20 | QDDSLESRC | DDS | 7 | 100 % | DDS (R/K/PFILE) | [CLIENT.md](../../sources/DDS/BIB20/CLIENT.md) |

## Differences

- **BIB09** en propre : DDS (R/K/PFILE)
- **BIB20** en propre : DDS (R/K/PFILE)

## Codes

### BIB09 (DDS, 8 lignes)

```text
     A          R CLIENTSFMT                  TEXT('Fichier Clients')
     A            CLICOD         6S 0         COLHDG('Code' 'Client')
     A            CLINOM        30            COLHDG('Nom')
     A            CLIPRE        30            COLHDG('Prenom')
     A            CLIADR        50            COLHDG('Adresse')
     A            CLIVILLE      30            COLHDG('Ville')
     A            CLITEL        15            COLHDG('Telephone')
     A          K CLICOD
```

### BIB20 (DDS, 4 lignes)

```text
                                            REF(EMPLOYE)
                R CLIENT
                  NOMEMP    R
                  NOMCLI        50A
```

### BIB20 (DDS, 7 lignes)

```text
                                            UNIQUE
     A          R FCLIENT
     A            ID             2S 0
     A            NOM           30A
     A            PRENOM        30A
     A            FONCTION      30A
                K ID
```
