# CLSQL : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB02 | QCLLESRC | CL/CL-ILE | 21 | 100 % | gestion d erreur | [CLSQL.md](../../sources/CL/CL-ILE/BIB02/CLSQL.md) |
| BIB20 | QDDSSRC | DDS | 44 | 3 % |  | [CLSQL.md](../../sources/DDS/BIB20/CLSQL.md) |

## Differences

- **BIB02** en propre : gestion d erreur
- Langages / types differents : CL/CL-ILE, DDS

## Codes

### BIB02 (CL/CL-ILE, 21 lignes)

```text
             PGM
             /* Exécution du script SQL pour créer la table CLUB */

             /* Monitor message erreur */

             /* Message à afficher en cas d'erreur de création de CLUB */

             /* Exécution du script SQL pour créer la table JOUEURS */

             /* Monitor message erreur */

             /* Message à afficher en cas d'erreur de création de JOUEURS */

             /* Exécution du script SQL pour insérer les données dans CLUB */
             /*et         JOUEURS */

             /* Monitor message erreur */

             /* Message à afficher en cas d'erreur d'insertion de données */

             ENDPGM
```

### BIB20 (DDS, 44 lignes)

```text
             PGM        PARM(&IDE &NOME &PRENOME)

             DCL        VAR(&IDE) TYPE(*DEC) LEN(2)
             DCL        VAR(&IDECHAR) TYPE(*CHAR)
             DCL        VAR(&NOME) TYPE(*CHAR) LEN(10)
             DCL        VAR(&NOMCHAR) TYPE(*CHAR)
             DCL        VAR(&PRENOMCHAR) TYPE(*CHAR)
             DCL        VAR(&PRENOME) TYPE(*CHAR) LEN(10)
             DCL        VAR(&REQUETE) TYPE(*CHAR) LEN(1000)
             DCL        VAR(&REQBASE) TYPE(*CHAR) LEN(1000) +
                          VALUE('INSERT INTO BIB20.COMMEVOULE +
                          VALUES (')
             DCL        VAR(&VALUES) TYPE(*CHAR)

             CHGVAR     VAR(&IDECHAR) VALUE(%CHAR(&IDE))
             CHGVAR     VAR(&NOMCHAR) VALUE(',''' *TCAT &NOME +
                          *TCAT '''')
             CHGVAR     VAR(&PRENOMCHAR) VALUE(',''' *TCAT +
                        &PRENOME *TCAT '''')

             CHGVAR     VAR(&VALUES) VALUE(&IDECHAR *TCAT &NOMCHAR +
                        *TCAT &PRENOMCHAR *TCAT ')')

             CHGVAR     VAR(&REQUETE) VALUE(&REQBASE)


             CHGVAR     VAR(&REQUETE) VALUE(&REQUETE *TCAT &VALUES)

             CHGVAR     VAR(&REQUETE) VALUE(&REQUETE)



             RUNSQL     SQL(&REQUETE)










             ENDPGM
```
