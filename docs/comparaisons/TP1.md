# TP1 : 3 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB25 | QILESRC | RPG/RPG-ILE | 29 | 0 % | full free, prototypes (dcl-pr), structure de donnees | [TP1.md](../../sources/RPG/RPG-ILE/BIB25/TP1.md) |
| BIB25 | QRPGLESRC | RPG/RPG-ILE | 23 | 100 % | boucle DOW/DOU/FOR | [TP1~QRPGLESRC.md](../../sources/RPG/RPG-ILE/BIB25/TP1~QRPGLESRC.md) |
| BIB27 | QRPGSRC | RPG/RPG-III-400 | 23 | 100 % | boucle DOW/DOU/FOR | [TP1.md](../../sources/RPG/RPG-III-400/BIB27/TP1.md) |
| BIB27 | QFREESRC | RPG/RPG-ILE | 25 | 0 % | full free, ecran (WORKSTN), boucle DOW/DOU/FOR, indicateurs *INxx | [TP1.md](../../sources/RPG/RPG-ILE/BIB27/TP1.md) |
| BIB27 | QRPGLESRC | RPG/RPG-ILE | 23 | 100 % | boucle DOW/DOU/FOR | [TP1~QRPGLESRC.md](../../sources/RPG/RPG-ILE/BIB27/TP1~QRPGLESRC.md) |

## Differences

- **BIB25** en propre : full free, prototypes (dcl-pr), structure de donnees
- **BIB25** en propre : boucle DOW/DOU/FOR
- **BIB27** en propre : boucle DOW/DOU/FOR
- **BIB27** en propre : full free, ecran (WORKSTN), boucle DOW/DOU/FOR, indicateurs *INxx
- **BIB27** en propre : boucle DOW/DOU/FOR
- Langages / types differents : RPG/RPG-III-400, RPG/RPG-ILE

## Codes

### BIB25 (RPG/RPG-ILE, 29 lignes)

```text
**free

// Déclaration de notre répertoire de liage
CTL-OPT ACTGRP(*CALLER) STGMDL(*INHERIT) BNDDIR('REP1');

DCL-S ID int(10);

DCL-DS DSClients QUALIFIED;
  id int(10);
  nom varchar(50);
  prenom varchar(50);
  age packed(2:0);
  email varchar(100);
END-DS;

// Déclaration de notre procédure (elle se situe dans notre module)
DCL-PR ReturnInfoClients LIKEDS(DSClients) ;
   id int(10);
END-PR;

id = 1;

DSClients = ReturnInfoClients(id);

dsply DSClients.nom;

return;
```

### BIB25 (RPG/RPG-ILE, 23 lignes)

```text
     Djsemaine         s              8a   dim(7) ctdata
     Dcmdos400         s             70a   dim(3) ctdata
     Dlong             S             15  5 inz(50)
     DI                s              2  0 inz(1)
     C                   for       I TO 7
     C     jsemaine(I)   Dsply
     c                   ENDFOR
     C                   CALL      'QCMDEXC'
     C                   parm                    cmdos400(1)
     c                   parm                    long
     C                   eval      *inlr=*on
**ctdata jsemaine
lundi
mardi
mercredi
jeudi
vendredi
samedi
dimanche
**ctdata cmdos400
?wrkobj
SNDMSG MSG(deux) TOUSR(leo2)
SNDMSG MSG(trois) TOUSR(leo2)
```

### BIB27 (RPG/RPG-III-400, 23 lignes)

```text
     Djsemaine         s              8a   dim(7) ctdata
     Dcmdos400         s             70a   dim(3) ctdata
     Dlong             S             15  5 inz(50)
     DI                s              2  0 inz(1)
     C                   for       I TO 7
     C     jsemaine(I)   Dsply
     c                   ENDFOR
     C                   CALL      'QCMDEXC'
     C                   parm                    cmdos400(1)
     c                   parm                    long
     C                   eval      *inlr=*on
**ctdata jsemaine
lundi
mardi
mercredi
jeudi
vendredi
samedi
dimanche
**ctdata cmdos400
?wrkobj
SNDMSG MSG(deux) TOUSR(leo2)
SNDMSG MSG(trois) TOUSR(leo2)
```

### BIB27 (RPG/RPG-ILE, 25 lignes)

```text
**free

// déclaration ecran
dcl-f e_tp1 workstn;

// programmation

dow *in03 = *off;
  exfmt record1;
  select;
  when *in08 = *on;
    result = nbr1 * nbr2;
  when *in07 = *on;
    result = nbr1 - nbr2;
  when *in05 = *on;
    nbr1 = 0;
    nbr2 = 0;
    result = 0;
  // clear record1;
  other;
    result = nbr1 + nbr2 ;
  ENDSL;
ENDDO;

*inlr = *on;
```

### BIB27 (RPG/RPG-ILE, 23 lignes)

```text
     Djsemaine         s              8a   dim(7) ctdata
     Dcmdos400         s             70a   dim(3) ctdata
     Dlong             S             15  5 inz(50)
     DI                s              2  0 inz(1)
     C                   for       I TO 7
     C     jsemaine(I)   Dsply
     c                   ENDFOR
     C                   CALL      'QCMDEXC'
     C                   parm                    cmdos400(1)
     c                   parm                    long
     C                   eval      *inlr=*on
**ctdata jsemaine
lundi
mardi
mercredi
jeudi
vendredi
samedi
dimanche
**ctdata cmdos400
?wrkobj
SNDMSG MSG(deux) TOUSR(leo2)
SNDMSG MSG(trois) TOUSR(leo2)
```
