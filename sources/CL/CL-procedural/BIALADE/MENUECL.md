---
bibliotheque: BIALADE
fichier_source: QCLPSRC
membre: MENUECL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 18
modifie: 2026-11-16
---

# BIALADE/QCLPSRC/MENUECL

```cl
PGM
             DCLF       FILE(BIALADE/MENUFM)

 DEBUT:      SNDRCVF    RCDFMT(FMT1)
             QSYS/CHGVAR VAR(&IN99) VALUE('0')
             IF         COND(&OPT *EQ 9) THEN(GOTO CMDLBL(FIN))
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FIN))
             IF         COND(&IN09 *EQ '1') THEN(DO)
             DLTSPLF FILE(*SELECT)
             CHGVAR  VAR(&IN99) VALUE('1')
             ENDDO
             GOTO       CMDLBL(DEBUT)





 FIN:        ENDPGM
```
