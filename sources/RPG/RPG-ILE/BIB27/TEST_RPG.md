---
bibliotheque: BIB27
fichier_source: QRPGLESRC
membre: TEST_RPG
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 29
modifie: 2026-11-25
---

# BIB27/QRPGLESRC/TEST_RPG

```text
     Fe_tptest  cf   e             workstn
     F                                     sfile(SF1:rang)
     Ftest_tp   uf a e           k disk
     C                   seton                                            lr
     c                   dow       *in03 = '0'
     c                   z-add     *zero         rang              4 0
     c                   seton                                            50
     c                   write     CTL1
     c                   setoff                                           50
     c                   if        e_srh <> *blanks
     c     e_srh         setll     TEST
     c                   else
     c     *loval        setll     TEST
     c                   endif
     c                   read      TEST                                   99
     c                   dow       *in99 = '0'
     c                   add       1             rang
     c                   write     SF1
     c                   read      test                                   99
     c                   enddo
     C                   SETON                                            49
     c                   if        rang > *zero
     c                   seton                                          5251
     c                   else
     c                   seton                                            52
     c                   endif
     c                   write     BAS
     c                   exfmt     CTL1
     c                   enddo
```
