---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: EX_RUNSQLS
type: CL/CL-ILE
longueur_enregistrement: 160
lignes: 5
modifie: 2026-11-16
---

# BIB02/QCLLESRC/EX_RUNSQLS

```cl
             PGM                                                                    /* Exécution du script SQL pour créer la table TOTO */
             RUNSQLSTM  SRCFILE(BIB02/QSQLSRC) SRCMBR(TESTSQL) COMMIT(*NONE)                MONMSG     MSGID(SQL9010) EXEC(DO)
        /* Message à afficher en cas d'erreur */                                                SNDPGMMSG  MSG('Erreur lors de la création de la table +
                             ANIMAUX9.')                                                     ENDDO
             ENDPGM
```
