---
bibliotheque: BIB10
fichier_source: QCLPSRC
membre: SRCLST
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 19
modifie: 2026-11-16
---

# BIB10/QCLPSRC/SRCLST

```cl
             PGM
/*declaration de fichier */
             DCLF       FILE(QAFDMBR) RCDFMT(QWHFDMBR) OPNID(W)

/* RECHERCHE FICHIER  */
             DSPFD      FILE(&PBIB/&PFIC) TYPE(*MBR) +
                          OUTPUT(*OUTFILE) OUTFILE(QTEMP/MBRF)

/* TRAITEMENT FICHIER */
             OVRDBF     FILE(QAFDMBR) TOFILE(QTEMP/MBRF)
 LOOP:       RCVF       OPNID(W)
             RTVMBRD    QAFDMBR
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(ECRAN2))
             CPYTOSTMF  FROMMBR(&MBR_ACS) TOSTMF(&FILE_PATH) +
                          STMFOPT(*REPLACE) STMFCCSID(1208)
             ENDDO
             GOTO       CMDLBL(LOOP)
  FIN:       DLTOVR     FILE(*ALL)
             ENDPGM
```
