---
bibliotheque: BIB17
fichier_source: QDDSSRC
membre: BOOKJ
type: DDS
longueur_enregistrement: 80
lignes: 7
modifie: 2026-11-16
---

# BIB17/QDDSSRC/BOOKJ

```text
                R BOOKJFMT                  JFILE(AUTOR BOOK)
     A          J                           JOIN(1 2)
     A                                      JFLD(AUTORID AUTORID)
     A            AUTORID                   JREF(AUTOR)
     A            AUTOR_NAME                JREF(AUTOR)
     A                                      RENAME(NOM)
     A            BOOK_NOM                  RENAME(NOM) JREF(BOOK)
```
