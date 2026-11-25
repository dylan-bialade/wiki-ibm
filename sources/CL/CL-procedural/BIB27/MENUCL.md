---
bibliotheque: BIB27
fichier_source: QCLSRC
membre: MENUCL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 9
modifie: 2026-11-25
---

# BIB27/QCLSRC/MENUCL

```cl
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
