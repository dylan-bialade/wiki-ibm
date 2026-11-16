---
bibliotheque: BIB17
fichier_source: QRPGLESRC
membre: DSPJEUX
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 14
modifie: 2026-11-16
---

# BIB17/QRPGLESRC/DSPJEUX

```text
     fJEUX      if   e           k disk
      *
      *
     C     *LOVAL        SETLL     JEUF
     C                   READ      JEUF
     C                   DOW       NOT %EOF(JEUX)
     C                   IF        TITJEU = 'Mass Effect'
     C     'RIP Bioware' DSPLY
     C                   ELSE
     C     TITJEU        DSPLY
     C                   ENDIF
     C                   READ      JEUF
     C                   ENDDO
     C                   EVAL      *INLR = *ON
```
