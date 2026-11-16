---
bibliotheque: BIB10
fichier_source: QRPGLESRC
membre: TSTRPGLE
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 59
modifie: 2026-11-16
---

# BIB10/QRPGLESRC/TSTRPGLE

```text
     fmonfic    if   e           k disk

      *   declaration const
     Dalpha            c                   'Alpha'
     Dnum              c                   56.26

      *   Declaration variable

     Dalp              s             20a
     Dalp2             s             +5    like(alp)
     Dvarch            s             40    varying
     Dtot              s              9  2
     Df1               s              3  1 inz(44.5)
     Df2               s              2  0 inz(3)
     DMADATE           s              8  0 inz(20001012)
     DAN               s              4  0
      *   Nouveaux types
     Ddate             s               d   datfmt(*DMY)
     Dtime             s               t   timfmt(*HMS)
     Dhorod            s               z
     DSignEnt          s              5i 0
     DIndic            s              1n   inz(*on)
      *   Tableau chargé a la compil
     Dtab              s             10    dim(3) ctdata
     Dtab2             s              2    dim(5) ctdata perrcd(5)

      *   Data structures
     D DATEN           ds                                                       2026-10-21
     D AAAA                    1      4p 0
     D MM                      6      7p 0
     d DD                      9     10p 0
      *   Carte C
     c                   seton                                            lr
     c                   setoff                                           01
     c                   read      fmtfic
     c                   eval      alp='Hello la famille'
     c                   eval      tot = f1 + f2 +
     c                             f1 * 43
     c                   eval      alp = alp + %char(tot)
     c     tot           dsply

      *   Fichiers et BIF
     c     idfic         chain     fmtfic
     c                   if        %found                                       *on when chain found
     c                   endif
     c                   eval      AN = %dec(%subst(%char(Madate): 1: 4): 4: 0)
     c     madate        dsply
     c     an            dsply
     c                   read      fmtfic
     c                   if        not %eof
     c                   endif
      *
      *
**
talbeau
jean
tail
**
2020202020
```
