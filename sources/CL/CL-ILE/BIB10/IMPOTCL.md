---
bibliotheque: BIB10
fichier_source: QCLLESRC
membre: IMPOTCL
type: CL/CL-ILE
longueur_enregistrement: 100
lignes: 19
modifie: 2026-11-16
---

# BIB10/QCLLESRC/IMPOTCL

```cl
             PGM        PARM(&MONTANT)
             DCL        VAR(&MONTANT) TYPE(*DEC) LEN(10 2)
     /* création dtaara          */
             CRTDTAARA  DTAARA(BIB10/IMPOT) TYPE(*DEC) LEN(10 2)
             MONMSG     MSGID(CPF1008 CPF1023)

     /* fill dtaara                     */
             CHGDTAARA  DTAARA(BIB10/IMPOT *ALL) VALUE(&MONTANT)


     /* appel rpgpgm               */
             CALL       PGM(BIB10/IMPOTFRCL) PARM(('IMPOT'))






             ENDPGM
```
