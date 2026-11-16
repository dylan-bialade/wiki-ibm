---
bibliotheque: BIALADE2
fichier_source: QCLPSRC
membre: CLIENTCRT
type: CL\CL-procedural
longueur_enregistrement: 80
lignes: 17
modifie: 2026-11-16
---

# BIALADE2/QCLPSRC/CLIENTCRT

```cl
             PGM
             /* Variables */
             DCL        VAR(&SQL) TYPE(*CHAR) LEN(256)
             /* Changement current lib pour création */
             CHGCURLIB  CURLIB(PHAN)
             MONMSG     MSGID(CPF0000)
             /* possibilité de CHECK OBJ pour vérif. existence */
             /* avec envoie d'un message par exemple */
             /* Création de la requête */
             CHGVAR     VAR(&SQL) VALUE('create table clients ( ID +
                          INTEGER  NOT NULL GENERATED ALWAYS AS +
                          IDENTITY , nom char(35) , prenom char(35) +
                          , age decimal(3, 0))')
             /* exécution */
             RUNSQL     SQL(&SQL) COMMIT(*NONE)
             MONMSG     MSGID(CPF0000)
             ENDPGM
```
