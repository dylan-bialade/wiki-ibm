---
bibliotheque: BIB10
fichier_source: HINTSRC19
membre: CLOVRDBFMB
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 27
modifie: 2026-11-16
---

# BIB10/HINTSRC19/CLOVRDBFMB

```cl
             PGM
  /**********************************************************/
  /*             OVERDBF SUBSTITUTION DE MEMBRES           */
  /*--------------------------------------------------------*/
  /* FICHIER:                                               */
  /* MONPF: PF MULTIMEMBRES                                 */
  /*  -MBR1 (*FIRST DANS LE PF)                             */
  /*  -MBR2                                                 */
  /*                                                        */
  /*                                                        */
  /*--------------------------------------------------------*/
  /* INDICATEURS:                                           */
  /*                                                        */
  /*                                                        */
  /**********************************************************/

  /*DECLARATION DE FICHIER                                 */
             DCLF       FILE(MONPF)

  /*OVERDBF                                                 */
             OVRDBF     FILE(MONPF) TOFILE(MONPF) MBR(MBR2)
  /*TRAITEMENT                                             */


  /*FIN DU PROGRAM                                         */
 FIN:        DLTOVR     FILE(*ALL)  /* SUPPRESSION DE L'OVR */
             ENDPGM
```
