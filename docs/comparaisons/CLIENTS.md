# CLIENTS : 6 versions differentes dans 7 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB05 | QRPGSRC | RPG/RPG-III-400 | 5 | 11 % |  | [CLIENTS.md](../../sources/RPG/RPG-III-400/BIB05/CLIENTS.md) |
| BIB06 | QDDSSRC | DDS | 5 | 100 % |  | [CLIENTS.md](../../sources/DDS/BIB06/CLIENTS.md) |
| BIB09 | QSOURCES | DDS | 11 | 0 % | DDS (R/K/PFILE) | [CLIENTS.md](../../sources/DDS/BIB09/CLIENTS.md) |
| BIB10 | QDDSSRC | DDS | 5 | 11 % |  | [CLIENTS.md](../../sources/DDS/BIB10/CLIENTS.md) |
| BIB17 | QDDSSRC | DDS | 5 | 0 % |  | [CLIENTS.md](../../sources/DDS/BIB17/CLIENTS.md) |
| BIB25 | QDDSSRC | DDS | 7 | 0 % |  | [CLIENTS.md](../../sources/DDS/BIB25/CLIENTS.md) |
| BIB27 | QDDSSRC | DDS | 7 | 0 % |  | [CLIENTS.md](../../sources/DDS/BIB27/CLIENTS.md) |

## Differences

- **BIB09** en propre : DDS (R/K/PFILE)
- Langages / types differents : DDS, RPG/RPG-III-400

## Codes

### BIB05 (RPG/RPG-III-400, 5 lignes)

```text
                R CLIENTS
                  IDCLI          3S
                  NOMCLI        30A
                  PRECLI        30A
                  AGE            3S
```

### BIB06 (DDS, 5 lignes)

```text
                                            REF(EMPLOYES)
                R CLIENTS
     A            NOMCLI        20A
     A            NRTRANS       30S 0       COLHDG('NUM TRANSACTION')
     A            IDEMPL    R               REFFLD(IDEMP EMPLOYES)
```

### BIB09 (DDS, 11 lignes)

```text
     A                                      UNIQUE
     A          R FCLIENTS
     A            CLINUM         7S 0       COLHDG('Numero' 'Client')
     A            CLINOM        40A         COLHDG('Nom Complet')
     A            CLIPAY        30A         COLHDG('Pays de' 'Residence')
     A            CLIFOR        15S 2       COLHDG('Fortune' 'Millions EUR')
     A            CLICAT         1A         COLHDG('Categorie')
     A                                      VALUES('P' 'D' 'G')
     A            CLIDAT          L         COLHDG('Date' 'Inscription')
     A                                      DATFMT(*ISO)
     A          K CLINUM
```

### BIB10 (DDS, 5 lignes)

```text
                R CLIENTS
     A            IDCLI          6  0
     A            NOMCLI        30A
     A            PRECLI        30A
                  AGE            3  0
```

### BIB17 (DDS, 5 lignes)

```text
                R CLIFMT
                  IDCLI          5P
                  NOMCLI        20A
                  PRECLI        20A
                  AGE            3P
```

### BIB25 (DDS, 7 lignes)

```text
                                            UNIQUE
                R FRTCLI
                  NUM_CLI        6S         COLHDG('NUMÉRO CLIENT')
                  NOM           20A         COLHDG('NOM DU CLIENT')
                  PRENOM        20A         COLHDG('PRENOM DU CLIENT')
                  VILLE         50A         COLHDG('VILLE RESIDENCE')
                K NUM_CLI
```

### BIB27 (DDS, 7 lignes)

```text
                                            UNIQUE
                R FRTCLI
                  NUM_CLI        6S         COLHDG('NUMÉRO CLIENT')
                  NOM           20A         COLHDG('NOM DU CLIENT')
                  PRENOM        20A         COLHDG('PRENOM DU CLIENT')
                  VILLE         50A         COLHDG('VILLE RESIDENCE')
                K NUM_CLI
```
