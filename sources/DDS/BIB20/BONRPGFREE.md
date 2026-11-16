---
bibliotheque: BIB20
fichier_source: QPRTSRC
membre: BONRPGFREE
type: DDS
longueur_enregistrement: 80
lignes: 34
modifie: 2026-11-16
---

# BIB20/QPRTSRC/BONRPGFREE

```text
       ctl-opt dftactgrp(*no);
       DCL-F LFBONBON USAGE(*INPUT) keyed;
       DCL-F BONPRT PRINTER OFLIND(*in60);
       DCL-F MARQP USAGE(*INPUT) keyed;

       ///////  CODE ///////////
       SETLL NUMBB LFBONBON;
       READ LFBONBON;
       dow not %eof(lfbonbon);
         prix *= 5;

         if *in95;
           write etoile;
           *in95 = *off;
         ENDIF;

         write details;

         if *in60;
           write eject;
           write titre;
           write entete;
           *in60 = *off;
         ENDIF;

         read lfbonbon;
       ENDDO;

       *inlr = *on;

       begsr *inzsr;
         write titre;
         write entete;
       ENDSR;
```
