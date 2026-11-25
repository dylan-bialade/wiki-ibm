---
bibliotheque: BIB25
fichier_source: QFACTURE
membre: CLFACT
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 19
modifie: 2026-11-25
---

# BIB25/QFACTURE/CLFACT

```cl
             PGM

/* Ajout de la CURLIB                                               */
             CHGCURLIB  CURLIB(BIB25)

/* Création du fichier en sortie (fichier de travail)               */
             CRTPF      FILE(WFACT) SRCFILE(BIB25/QTPSRC) +
                          SRCMBR(FACTURES)

/* Fichier non créé                                                 */
             MONMSG     MSGID(CPF7302)

/* Mise à blanc du fichier de travail                               */
             CLRPFM     FILE(*CURLIB/WFACT)

/* Appel du programme de récupération des données                   */
             CALL       PGM(*CURLIB/RPGFACT)

             ENDPGM
```
