---
bibliotheque: BIB10
fichier_source: HINTSRC19
membre: CLECRETPF
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 24
modifie: 2026-11-16
---

# BIB10/HINTSRC19/CLECRETPF

```cl
             PGM
  /**********************************************************/
  /*             DECLARATION D'UN ECRAN ET UN PF           */
  /*--------------------------------------------------------*/
  /* FICHIER:                                               */
  /*  ECRAN DSPF                                            */
  /*                                                        */
  /*                                                        */
  /*  DATA FICHIER DATA                                     */
  /*                                                        */
  /*--------------------------------------------------------*/
  /* SI ON DECLARE PLUSIEURS FICHIER ON DOIT UTILISER DES   */
  /* OPNID. ON APPELERA LES FICHIERS PAR LEURS OPNID DANS   */
  /* LE RESTE DU CODE.                                      */
  /* PRIVILEGIER L'OPNID SUR LES FICHIERS DATA              */
  /**********************************************************/

  /*DECLARATION DE FICHIER                                 */
             DCLF       FILE(ECRAN)
             DCLF       FILE(DATA) OPNID(D)


  /*FIN DU PROGRAMME                                       */
 FIN:        ENDPGM
```
