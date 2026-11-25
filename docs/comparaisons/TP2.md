# TP2 : 2 versions differentes dans 3 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB05 | QRPGLESRC2 | RPG/RPG-ILE | 14 | 0 % | CHAIN | [TP2.md](../../sources/RPG/RPG-ILE/BIB05/TP2.md) |
| BIB25 | QRPGLESRC | RPG/RPG-ILE | 14 | 100 % |  | [TP2.md](../../sources/RPG/RPG-ILE/BIB25/TP2.md) |
| BIB27 | QRPGSRC | RPG/RPG-III-400 | 14 | 100 % |  | [TP2.md](../../sources/RPG/RPG-III-400/BIB27/TP2.md) |

## Differences

- **BIB05** en propre : CHAIN
- Langages / types differents : RPG/RPG-III-400, RPG/RPG-ILE

## Codes

### BIB05 (RPG/RPG-ILE, 14 lignes)

```text
     FCLIENT    IF   E           K Disk
     DNMCLI            S              5S 0
      * Début du programme principal
      /free
       NMCLI = 2;            // On affecte la valeur 2 à la variable NMCLI (on cherche le client n°2

       Chain NMCLI CLIENT;   // On cherche dans le fichier CLIENT lenregistrement correspondant à N

       If %found;           // Si un client avec ce numéro existe...
         dsply PRECLI;       // On affiche à l'écran le nom du client (zone PRECLI issue du fichier
       endif;

       *inlr = *on;     // Fin du programme
      /end-free
```

### BIB25 (RPG/RPG-ILE, 14 lignes)

```text
     ************   déclaratives ************
     ** déclaration data structure => changer une zone de la data **
     Ddtarea           ds                  dtaara(tp2)
     Dzone1                           1
     dzone2                           1
     dzone3                           1
     ************   traitement   ************
     ** changement du caractère 3 dans la data **
     C                   eval      *inlr=*on
     c                   seton                                            lr
     C     *lock         in        dtarea
     C                   eval      zone3 = '3'
     C     *lock         out       dtarea
     c                   unlock    dtarea
```

### BIB27 (RPG/RPG-III-400, 14 lignes)

```text
     ************   déclaratives ************
     ** déclaration data structure => changer une zone de la data **
     Ddtarea           ds                  dtaara(tp2)
     Dzone1                           1
     dzone2                           1
     dzone3                           1
     ************   traitement   ************
     ** changement du caractère 3 dans la data **
     C                   eval      *inlr=*on
     c                   seton                                            lr
     C     *lock         in        dtarea
     C                   eval      zone3 = '3'
     C     *lock         out       dtarea
     c                   unlock    dtarea
```
