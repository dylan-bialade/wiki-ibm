---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: EX_RUNSQL
type: CL/CL-ILE
longueur_enregistrement: 80
lignes: 9
modifie: 2026-11-16
---

# BIB02/QCLLESRC/EX_RUNSQL

```cl
             PGM
    /* Suppression de la table ANIMAUX9 si elle existe */
             RUNSQL     SQL('DROP TABLE ANIMAUX9') COMMIT(*NONE)

             MONMSG     MSGID(SQL9010) EXEC(DO)
        /* Message si erreur commande RUNSQL */
                SNDPGMMSG  MSG('Erreur sur la commande RUNSQL.')
             ENDDO
             ENDPGM
```
