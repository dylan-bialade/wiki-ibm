---
bibliotheque: BIB27
fichier_source: QRPGSRC
membre: SFTEST
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 32
modifie: 2026-11-25
---

# BIB27/QRPGSRC/SFTEST

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     ***********     déclaratives       ***************
     Fecransf   cf   e             workstn
     F                                     sfile(cl01:rang)
     Fbonbon    uf a e           k disk

     *********** Traitement   ********************
     c                   seton                                            lr
     c                   z-add     *zero         rang              4 0
     c                   dow       *in03 = '0'
     c                   exsr      traitement_sf
     c                   write     fmt1
     c                   write     fmt2
     c                   exfmt     ctl01
     c                   enddo

     ********** sous routines   *******************
     c     traitement_sf begsr
     c                   seton                                            52
     c                   write     rbonbon
     c                   setoff                                           52
     c                   read      rbonbon                                99
     c                   dow       *in99 = '0'
     c                   add       1             rang
     c                   write     cl01
     c                   read      rbonbon                                99
     c                   enddo
     c                   seton                                            51
     c                   if        rang > *zero
     c                   seton                                            50
     c                   seton                                            53
     c                   endif
     c                   endsr
```
