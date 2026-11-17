# CLIENTL : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB05 | QRPGSRC | RPG/RPG-III-400 | 5 | 100 % |  | [CLIENTL.md](../../sources/RPG/RPG-III-400/BIB05/CLIENTL.md) |
| BIB10 | QDDSSRC | DDS | 5 | 29 % |  | [CLIENTL.md](../../sources/DDS/BIB10/CLIENTL.md) |

## Differences

- Langages / types differents : RPG/RPG-III-400, DDS

## Codes

### BIB05 (RPG/RPG-III-400, 5 lignes)

```text
                R CLIFMT                     PFILE(CLIENTS)                                       NOMCLI
                                                                  AGE
                                  PRECLI
K PRECLI                                                                        K AGE
                                                K NOMCLI
```

### BIB10 (DDS, 5 lignes)

```text

                R CLFMT                     PFILE(CLIENTS)
                  NOMCLI
                  PRECLI
                K NOMCLI
```
