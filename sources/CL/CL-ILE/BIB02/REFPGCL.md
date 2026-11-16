---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: REFPGCL
type: CL/CL-ILE
longueur_enregistrement: 152
lignes: 10
modifie: 2026-11-16
---

# BIB02/QCLLESRC/REFPGCL

```cl
/*----------------------------------------------------------------------------*//* Programme : REFPGCL
      *//* Libellé   : CL                                                             *//*--------------------------------------------------------------
--------------*//* Projet    : BIB02                                                         *//* Auteur    : Sylvain BIB02
                      *//* Date      : 14/11/2022                                                     *//*----------------------------------------------
------------------------------*/             PGM                                                                             COPYRIGHT  TEXT('(C) ARMONI
E 2022.')                                            DSPPGMREF  PGM(BIB02/*ALL) OUTPUT(*OUTFILE) OBJTYPE(*ALL) +                                 OUTFIL
E(QTEMP/OUTFILE2)                                            CHGPF      FILE(QTEMP/OUTFILE2) SIZE(*NOMAX)                                    CLRPFM
FILE(QTEMP/OUTFILE2)                                                 DSPPGMREF  PGM(*ALLUSR/*ALL) OUTPUT(*OUTFILE) OBJTYPE(*ALL) +
          OUTFILE(QTEMP/OUTFILE2)                                            CALL       PGM(*LIBL/REFPGM)
     ENDPGM
```
