# TP3 : 3 versions differentes dans 3 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB05 | QRPGLESRC2 | RPG/RPG-ILE | 35 | 0 % | ecran (WORKSTN), CHAIN, boucle DOW/DOU/FOR | [TP3.md](../../sources/RPG/RPG-ILE/BIB05/TP3.md) |
| BIB25 | QILETP | RPG/RPG-III-400 | 8 | 100 % |  | [TP3.md](../../sources/RPG/RPG-III-400/BIB25/TP3.md) |
| BIB25 | QRPGLESRC | RPG/RPG-ILE | 17 | 0 % | boucle DOW/DOU/FOR | [TP3.md](../../sources/RPG/RPG-ILE/BIB25/TP3.md) |
| BIB27 | QRPGSRC | RPG/RPG-III-400 | 17 | 0 % | boucle DOW/DOU/FOR | [TP3.md](../../sources/RPG/RPG-III-400/BIB27/TP3.md) |

## Differences

- **BIB05** en propre : ecran (WORKSTN), CHAIN, boucle DOW/DOU/FOR
- **BIB25** en propre : boucle DOW/DOU/FOR
- **BIB27** en propre : boucle DOW/DOU/FOR
- Langages / types differents : RPG/RPG-III-400, RPG/RPG-ILE

## Codes

### BIB05 (RPG/RPG-ILE, 35 lignes)

```text
     FLIVRESL   IF   E           K Disk
     FLIVDSP    CF   E             Workstn
      /free
       // Boucle principale tant que l'utilisateur n'appuie pas sur la touche F3
       DOW  *inkc = *off ;

         // Affichage de l'écran FMT1 pour que l'utilisateur saisisse un ISBN
         exfmt fmt1;

         //Si l'utilisateur n'a pas appuyé sur F3
         IF  *INKC = *off ;

         // Lecture du livre dans le fichier logique LIVRESL en fonction de l'ISBN saisi
           chain ISBN LIVRESL;

           // Si le livre est trouvé
           IF (%found);

            // Nouvelle boucle d'affichage de l'écran FMT2, tant que l'utilisateur
             // n'appuie ni sur F12 (INKL) ni sur F3 (INKC)
             DOW  *INKL = *off and *INKC = *off ;

               // Affiche l'écran FMT2 pour afficher/modifier les infos du livre
               exfmt fmt2;

             ENDDO;  // Fin de boucle écran FMT2

           ENDIF;     // Fin du IF %FOUND

         ENDIF;     // Fin du IF INKC = *OFF

       ENDDO;      // Fin de boucle principale (tant que F3 non pressé)

       *INLR = *on;
      /end-free
```

### BIB25 (RPG/RPG-III-400, 8 lignes)

```text
Mise en situation n°2 : ILE IBM i
1- Modifier le une procéddure parmis les 3 de TP1MOD

2- Faire en sorte que les anciens programmes TP1ILE et TP2ILE fonctionne
   encore. (utilisation des signatures)

3- Faire un programme TP3ILE qui prendra un paramètre et qui utilisera
   la nouvelle version de notre procédure modifié.
```

### BIB25 (RPG/RPG-ILE, 17 lignes)

```text
     *********** déclaratives **********
     ** datastructure sous zone 'zone'=> tableau de 10 *10 *********
     Di                s              2  0 inz(1)
     Ddtarea           ds                  dtaara(dt100)
     Dzone                           10    dim(10)
     ************ traitement ***********
     c                   seton                                            lr
     c                   in        dtarea
     C                   for       I to 10
     c                   if        %scan('FIN': zone(i)) > 0
     c     zone(i)       dsply
     c                   leave
     c                   else
     c     zone(i)       dsply
     c                   endif
     C                   endfor
     C                   eval      *inlr=*on
```

### BIB27 (RPG/RPG-III-400, 17 lignes)

```text
     *********** déclaratives **********
     ** datastructure sous zone 'zone'=> tableau de 10 *10 *********
     Di                s              2  0 inz(1)
     Ddtarea           ds                  dtaara(dt100)
     Dzone                           10    dim(10)
     ************ traitement ***********
     c                   seton                                            lr
     c                   in        dtarea
     C                   for       I to 10
     c                   if        %scan('FIN': zone(i)) > 0
     c     zone(i)       dsply
     c                   leave
     c                   else
     c     zone(i)       dsply
     c                   endif
     C                   endfor
     C                   eval      *inlr=*on
```
