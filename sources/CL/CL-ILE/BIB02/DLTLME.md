---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: DLTLME
type: CL/CL-ILE
longueur_enregistrement: 80
lignes: 23
modifie: 2026-11-16
---

# BIB02/QCLLESRC/DLTLME

```cl
/*----------------------------------------------------------------------------*/
/* Programme : DLTLME                                                         */
/* Libellé   : Supprimer LME                                                  */
/*----------------------------------------------------------------------------*/
/* Projet    : BIB02                                                         */
/* Auteur    : Sylvain BIB02                                                 */
/* Date      : 24/11/2022                                                     */
/*----------------------------------------------------------------------------*/
             PGM
             MONMSG     MSGID(CPF0000 TCP0000)
             ADDLIBLE   LIB(AFFTLIB)
             DIRCLN     DIR('/Aldon/AldonLM') RMVFILES(*ALL) +
                          RMVSYMLNK(*ALL) READONLY(*CLEAR)
             RMVDIR     DIR('/Aldon/AldonLM') SUBTREE(*ALL)
             AFFTAPYCST DROP(*YES) STPONERR(*NO) VERBOSE(*NO) TEST(*NO)
             ENDJRNPF   FILE(*ALL) JRN(AFFTCTL/AFFJRN)
             DLTJRN     AFFTCTL/AFFJRN
             AFFTAPYCST DROP(*YES) STPONERR(*NO) VERBOSE(*NO) TEST(*NO)
             RMVLIBLE   LIB(AFFTLIB)
             DLTLIB     LIB(AFFTCTL)
             DLTLIB     LIB(AFFTLIB)
             DLTUSRPRF  USRPRF(ALDONAFF) OWNOBJOPT(*DLT)
             ENDPGM
```
