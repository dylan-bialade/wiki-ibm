---
bibliotheque: BIB19
fichier_source: QCMDSRC
membre: STRIDBG
type: Autres/Commandes
longueur_enregistrement: 80
lignes: 29
modifie: 2026-11-16
---

# BIB19/QCMDSRC/STRIDBG

```text
/* BIB19 - Demarrer IDBG (debogueur RPGLE facon ISDB)                  */
/* Licence MIT      */
             CMD        PROMPT('Démarrer IDBG')
             PARM       KWD(PGM) TYPE(QPGM) MIN(1) PROMPT('Programme')
             PARM       KWD(UPDPROD) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*YES *NO) +
                          PROMPT('MàJ fichiers de production')
             PARM       KWD(INVPGM) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*YES *NO *CMD) +
                          PROMPT('Appeler le programme')
             PARM       KWD(PARM) TYPE(*CHAR) LEN(256) MAX(25) +
                          CASE(*MIXED) PMTCTL(*PMTRQS) +
                          PROMPT('Paramètres d''appel')
             PARM       KWD(SRCMBR) TYPE(*NAME) LEN(10) DFT(*PGM) +
                          SPCVAL((*PGM)) PMTCTL(*PMTRQS) +
                          PROMPT('Membre source')
             PARM       KWD(SRCFILE) TYPE(QSRC) PMTCTL(*PMTRQS) +
                          PROMPT('Fichier source')
             PARM       KWD(JOB) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*) VALUES(*) PMTCTL(*PMTRQS) +
                          PROMPT('Travail à traiter')
 QPGM:       QUAL       TYPE(*NAME) LEN(10) MIN(1)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) +
                          PROMPT('Bibliothèque')
 QSRC:       QUAL       TYPE(*NAME) LEN(10)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) +
                          PROMPT('Bibliothèque')
```
