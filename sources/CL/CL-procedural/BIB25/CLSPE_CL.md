---
bibliotheque: BIB25
fichier_source: QMEP
membre: CLSPE_CL
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 41
modifie: 2026-11-25
---

# BIB25/QMEP/CLSPE_CL

```cl
             PGM
             DCL        VAR(&MBNAME) TYPE(*CHAR) LEN(10)
/* Déclaration du fichier TYPE MBRLIST DSPFD                       */
             DCLF       FILE(QSYS/QAFDMBR) OPNID(F)

/* Copie des sources vers l'environnement de production            */
             CPYF       FROMFILE(VINCIV8R/QCLSRC) +
                          TOFILE(AXASP030/QCLSRC) MBROPT(*REPLACE)

/* Clear de QTEMP                                                  */
             CLRLIB     LIB(QTEMP)

/* DSPFD AXASP030/QCLSRC = MBRLIST                                 */
             DSPFD      FILE(AXASP030/QCLSRC) TYPE(*MBR) +
                          OUTPUT(*OUTFILE) OUTFILE(QTEMP/DSPFD)

/* OVRDBF sur le fichier généré                                    */
             OVRDBF     FILE(QAFDMBR) TOFILE(DSPFD/QSYS) MBR(QTEMP)

/* Mise en place de la liste de bib de production                  */
             CALL       PGM(AXSPE030/LSTLIB)

/* Lecture des membres du fichier                                  */
 BOUCLE:     RCVF       OPNID(F)
             MONMSG     MSGID(CPF0864) EXEC(DO)
             CLOSE      OPNID(F)
             GOTO       CMDLBL(FIN)
             ENDDO
/* Changement en CLLE                                              */
             CHGPFM     FILE(AXASP030/QCLSRC) MBR(&MBNAME) +
                          SRCTYPE(CLLE)
/* Compilation dans l'environnement de production                  */
             CRTBNDCL   PGM(AXSPE030/&MBNAME) +
                          SRCFILE(AXASP030/QCLSRC) SRCMBR(&MBNAME)
/* Gestion des erreurs de compilation                              */
             MONMSG     MSGID(CPF0000) EXEC(DO)
/*           CALL       PGM(ORGFORM/ERREUR) PARM((&MBNAME (*CHAR 10)))*/
             ENDDO
             GOTO       CMDLBL(BOUCLE)

 FIN:        ENDPGM
```
