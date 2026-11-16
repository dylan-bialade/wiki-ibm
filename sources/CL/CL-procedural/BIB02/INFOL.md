---
bibliotheque: BIB02
fichier_source: QSRC
membre: INFOL
type: CL/CL-procedural
longueur_enregistrement: 100
lignes: 13
modifie: 2026-11-16
---

# BIB02/QSRC/INFOL

```cl
/*              PROGRAMME  : INFOLIB_CL                                       */
/*              Pour       supprimer les libs d'Agrion                        */
/*              Date       : 03/01/23                                         */
/*                                                                            */
             PGM
             MONMSG     MSGID(CPF0000)
             DLTOBJ     OBJ(QTEMP/INFOLIB) OBJTYPE(*FILE)
             DSPOBJD    OBJ(*ALL/*ALL) OBJTYPE(*LIB) OUTPUT(*OUTFILE) OUTFILE(QTEMP/INFOLIB)
             CALL       PGM(BIB02/INFOLIB_P)



             ENDPGM
```
