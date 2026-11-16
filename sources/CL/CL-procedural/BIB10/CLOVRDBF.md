---
bibliotheque: BIB10
fichier_source: HINTSRC19
membre: CLOVRDBF
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 31
modifie: 2026-11-16
---

# BIB10/HINTSRC19/CLOVRDBF

```cl
             PGM
  /**********************************************************/
  /*             OVERDBF SUBSTITUTION DE FICHIER           */
  /*--------------------------------------------------------*/
  /* FICHIER:                                               */
  /* FEXT FICHIER EXISTANT (PF DEJA CRÉÉ OU PFSYSTEME     */
  /* WWW.IBM.COM/DOCS/FR/I/7.5.0?TOPIC=WFICPP-OVERRIDING-DATABA +
  /* SE-FILES-IN-CL-PROCEDURE-PROGRAM-OVRDBF-COMMAND        */
  /*                                                        */
  /* FCRT FICHIER CRÉÉ DANS LE CL                         */
  /*--------------------------------------------------------*/
  /* INDICATEURS:                                           */
  /*                                                        */
  /*                                                        */
  /**********************************************************/

  /*DECLARATION DE FICHIER                                 */
             DCLF       FILE(FEXT)

  /*CREATION DU FICHIER DE TRAVAIL                         */
             DSPOBJD    OBJ(*ALL) OBJTYPE(*ALL) OUTPUT(*OUTFILE) +
                          OUTFILE(QTEMP/FCRT)

  /*OVERDBF                                                 */
             OVRDBF     FILE(FEXT) TOFILE(FCRT)
  /*TRAITEMENT                                             */


  /*FIN DU PROGRAM                                         */
 FIN:        DLTOVR     FILE(*ALL)  /* SUPPRESSION DE L'OVR */
             ENDPGM
```
