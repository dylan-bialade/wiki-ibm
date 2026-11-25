# MENUCL : 3 versions differentes dans 4 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB06 | QCLPSRC | CL/CL-procedural | 23 | 12 % | CL : DCLF | [MENUCL.md](../../sources/CL/CL-procedural/BIB06/MENUCL.md) |
| BIB10 | QCLPSRC | CL/CL-procedural | 23 | 12 % | CL : DCLF | [MENUCL.md](../../sources/CL/CL-procedural/BIB10/MENUCL.md) |
| BIB25 | QCLLESRC | CL/CL-ILE | 9 | 100 % | CL : DCLF | [MENUCL.md](../../sources/CL/CL-ILE/BIB25/MENUCL.md) |
| BIB27 | QCLSRC | CL/CL-procedural | 9 | 80 % | CL : DCLF | [MENUCL.md](../../sources/CL/CL-procedural/BIB27/MENUCL.md) |

## Differences

- Techniques communes : CL : DCLF
- Langages / types differents : CL/CL-ILE, CL/CL-procedural

## Codes

### BIB06 (CL/CL-procedural, 23 lignes)

```text
             PGM
/* DECLARATION DE FICHIER                     */
             DCLF       FILE(MENUFM)
/* TRAITEMENT PRINCIPAL                       */
 DEBUT:      SNDRCVF    RCDFMT(FMT1)
             CHGVAR     VAR(&IN99) VALUE('0')
             IF         COND(&OPT *EQ 1) THEN(WRKMBRPDM +
                          FILE(*CURLIB/QDDSSRC))
             IF         COND(&OPT *EQ 2) THEN(WRKMBRPDM +
                          FILE(*CURLIB/QCLPSRC))
             IF         COND(&OPT *EQ 3) THEN(STRSDA)
             IF         COND(&OPT *EQ 4) THEN(STRPDM)
             IF         COND(&OPT *EQ 5) THEN(WRKUSRJOB)
             IF         COND(&OPT *GT 5) THEN(CHGVAR VAR(&IN99) +
                          VALUE('1'))



             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FIN))
             GOTO       CMDLBL(DEBUT)

/* FIN DE TRAITEMENT                          */
 FIN:        ENDPGM
```

### BIB10 (CL/CL-procedural, 23 lignes)

```text
             PGM
/* DECLARATION DE FICHIER                     */
             DCLF       FILE(MENUFM)
/* TRAITEMENT PRINCIPAL                       */
 DEBUT:      SNDRCVF    RCDFMT(FMT1)
             CHGVAR     VAR(&IN99) VALUE('0')
             IF         COND(&OPT *EQ 1) THEN(WRKMBRPDM +
                          FILE(*CURLIB/QDDSSRC))
             IF         COND(&OPT *EQ 2) THEN(WRKMBRPDM +
                          FILE(*CURLIB/QCLPSRC))
             IF         COND(&OPT *EQ 3) THEN(STRSDA)
             IF         COND(&OPT *EQ 4) THEN(STRPDM)
             IF         COND(&OPT *EQ 5) THEN(WRKUSRJOB)
             IF         COND(&OPT *GT 5) THEN(CHGVAR VAR(&IN99) +
                          VALUE('1'))



             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FIN))
             GOTO       CMDLBL(DEBUT)

/* FIN DE TRAITEMENT                          */
 FIN:        ENDPGM
```

### BIB25 (CL/CL-ILE, 9 lignes)

```text
             PGM
             DCLF       FILE(*LIBL/EMENUCL)
 BOUCLE:     SNDRCVF    RCDFMT(FMT1)
             IF         COND(&iN03 *EQ '1') THEN(GOTO CMDLBL(FIN))
             IF         COND(&SAISIE *EQ '1') THEN(WRKSPLF)
             IF         COND(&SAISIE *EQ '2') THEN(STRPDM)
             IF         COND(&SAISIE *EQ '3') THEN(GOTO CMDLBL(FIN))
             GOTO       CMDLBL(BOUCLE)
 FIN:        ENDPGM
```

### BIB27 (CL/CL-procedural, 9 lignes)

```text
             PGM
             DCLF       FILE(*LIBL/ECRAN1)
 BOUCLE:     SNDRCVF    RCDFMT(FMT1)
             IF         COND(&iN03 *EQ '1') THEN(GOTO CMDLBL(FIN))
             IF         COND(&SAISIE *EQ '1') THEN(WRKSPLF)
             IF         COND(&SAISIE *EQ '2') THEN(STRPDM)
             IF         COND(&SAISIE *EQ '3') THEN(GOTO CMDLBL(FIN))
             GOTO       CMDLBL(BOUCLE)
 FIN:        ENDPGM
```
