---
bibliotheque: BIB06
fichier_source: QDDSSRC
membre: SNDCLIMB
type: DDS
longueur_enregistrement: 80
lignes: 10
modifie: 2026-11-16
---

# BIB06/QDDSSRC/SNDCLIMB

```text
                R SNDCLIMB
     A            NOM           25A         COLHDG('NOM DE LA VOIE')
                                            VARLEN(10)
     A            CODEFAL        3A         COLHDG('CODE DE LA FALAISE')
     A            DATE            L         DATFMT(*EUR)
     A            FLASH          3A         VALUES('OUI' 'NON') DFT('NON')
     A            ESSAIE         3  0       COLHDG('NOMBRE D ESSAI')
     A            DUREE           T         COLHDG('TEMPS D ASCENTION')
     A            LONGUEUR       4S 1       COLHDG('LONGUEUR DE LA VOIE')
     A                                      COMP(LT 99.9)
```
