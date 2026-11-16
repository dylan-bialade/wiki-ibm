---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: STRRDOI
type: CL/CL-ILE
longueur_enregistrement: 120
lignes: 10
modifie: 2026-11-16
---

# BIB02/QCLLESRC/STRRDOI

```cl
/*----------------------------------------------------------------------------*//* Projet    : BIB02
                                      *//* Auteur    : Sylvain BIB02                                                 */
/* Date      : 11/05/2023                                                     *//*--------------------------------------
--------------------------------------*/             PGM
             MONMSG     MSGID(CPF0000 TCP0000)                                               CHGJOB     CCSID(37)
                                                     ADDLIBLE   LIB(ACMSLIB) POSITION(*LAST)
             ADDLIBLE   LIB(ACMSCTL) POSITION(*LAST)                                         STRSBS     SBSD(ACMSCTL/ALD
ONDMI)                                               DLYJOB     DLY(90)
             STRSBS     SBSD(ACMSCTL/ALDONLMI)                                               DLYJOB     DLY(30)
                                                     ENDPGM
```
