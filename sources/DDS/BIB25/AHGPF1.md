---
bibliotheque: BIB25
fichier_source: QAHGSRC
membre: AHGPF1
type: DDS
longueur_enregistrement: 80
lignes: 12
modifie: 2026-11-25
---

# BIB25/QAHGSRC/AHGPF1

```text
     A                                      UNIQUE
     A          R FMT1
     A            ID             6S 0       COLHDG('IDENTIFIANT')
     A                                      COMP(NE 0)
     A            NOM           25A         COLHDG('NOM CLIENT')
     A                                      ALWNULL
     A                                      VARLEN
     A            DATE1           L         COLHDG('DATE N°1')
     A                                      DATFMT(*DMY)
     A                                      DATSEP('.')
     A            DATE2     R               REFFLD(DATE1 *SRC)
     A          K ID
```
