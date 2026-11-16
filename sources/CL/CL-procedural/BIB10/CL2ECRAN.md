---
bibliotheque: BIB10
fichier_source: HINTSRC19
membre: CL2ECRAN
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 36
modifie: 2026-11-16
---

# BIB10/HINTSRC19/CL2ECRAN

```cl
             PGM
  /**********************************************************/
  /*             AFFICHAGE DE 2 ECRANS                    */
  /*--------------------------------------------------------*/
  /* ECRAN: MONECRAN (DSPF)                                 */
  /*  FMT1  (FORMAT DE MONECRAN)                            */
  /*  FMT2  (FORMAT DE MONECRAN)                            */
  /*--------------------------------------------------------*/
  /* INDICATEURS:                                           */
  /* &IN03: SORTIE PGM (CONF CF03 SUR LES 2 FORMAT D'ECRAN  */
  /* &IN12: RETOUR A L'ECRAN1 (CONF CF12 SUR FMT2           */
  /**********************************************************/

  /*DECLARATION DE FICHIER                                 */
             DCLF       FILE(MONECRAN)  /* ECRAN A AFFICHER */

  /*DECLARATION DE VARIABLE                                */
             DCL        VAR(&VAR) TYPE(*CHAR) LEN(10)
             DCL        VAR(&VAR1) TYPE(*DEC) LEN(5 2)

  /*BOUCLE D'AFFICHAGE DE L'ÉCRAN1                         */
 ECRAN1:     SNDRCVF    RCDFMT(FMT1)    /* FMT1 = FORMAT DE L'ECRAN*/
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FIN))

  /* TRAITEMENT PRINCIPAL                                  */

    /*GESTION DES ACTION ET RENVOI SUR L'ECRAN1 OU 2 EN FONCTION */
    /*EX. AFFICHAGE DES RESULTAT D'UNE CMD                 */

  /*BOUCLE D'AFFICHAGE DE L'ÉCRAN2                         */
 ECRAN2:     SNDRCVF    RCDFMT(FMT2)    /* FMT2 = FORMAT DE L'ECRAN*/
             IF         COND(&IN03 *EQ '1') THEN(GOTO CMDLBL(FIN))
             IF         COND(&IN12 *EQ '1') THEN(GOTO CMDLBL(ECRAN1))
             GOTO       CMDLBL(FIN)
  /*FIN DU PROGRAM                                         */
 FIN:        ENDPGM
```
