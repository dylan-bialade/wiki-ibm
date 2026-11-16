---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: CLTP
type: CL/CL-ILE
longueur_enregistrement: 160
lignes: 6
modifie: 2026-11-16
---

# BIB02/QCLLESRC/CLTP

```cl
             PGM
    /* Étape 1 : Création du fichier physique à partir du DDS */                 CRTFILE:    CRTPF      FILE(BIB02/CLT) SRCFILE(BIB02/QCLLESRC) MBR(CLT)
             MONMSG     MSGID(CPF7302)                                              /* Étape 2 : Insertion des données via SQL */
             RUNSQLSTM  SRCFILE(*LIBL/QSQLSRC) SRCMBR(INSERTCLT) COMMIT(*NONE)
    /* Étape 3 : Affichage des données insérées */                                           DSPPFM     FILE(*LIBL/CLT)
             ENDPGM
```
