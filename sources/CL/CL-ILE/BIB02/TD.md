---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: TD
type: CL/CL-ILE
longueur_enregistrement: 160
lignes: 4
modifie: 2026-11-16
---

# BIB02/QCLLESRC/TD

```cl
             PGM                                                                             CRTLIB     LIB(aaa) TEXT('Ma bibliothèque')
             MONMSG     MSGID(CPF2100) EXEC(DO)                                       /* La bibliothèque existe déjà, afficher un message d'erreur */
                SNDPGMMSG  MSG('La bibliothèque existe déjà.') MSGTYPE(*INFO)                   RETURN
             ENDDO                                                                           ENDPGM
```
