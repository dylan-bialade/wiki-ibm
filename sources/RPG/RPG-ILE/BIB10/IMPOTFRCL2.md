---
bibliotheque: BIB10
fichier_source: QRPGLESRC
membre: IMPOTFRCL2
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 78
modifie: 2026-11-16
---

# BIB10/QRPGLESRC/IMPOTFRCL2

```text
     fimpotdsp  cf   e             workstn

     d                 pi
     d nm                            10a
     d dta             s             10s 2 dtaara extfld(nm)
     dquotient         s              3  1 inz(0)
     dpart             s             10  3 inz(0)
     dimpot            s             11  3 inz(0)
     d
     c                   eval      *inlr=*on
     c     *inkc         doweq     *off
     c                   in        dta
     c                   eval      netimpot = dta
     c*                  out       dta
     c                   exfmt     fmt1
     c                   if        *inkc=*on
     c                   leave
     c                   endif
     c                   if        nbenf = 0 and marie = 0
     c                   iter
     c                   endif
     c                   exsr      calc
     c                   exsr      impots
     c                   exfmt     fmt2
      *
     c                   enddo


     c     calc          begsr
     c                   if        nbenf<=2
     c                   eval      quotient = nbenf*0.5 + marie
     c                   else
     c                   eval      quotient = 1+ (nbenf-2) + marie
     c                   endif
     c                   eval      part = netimpot / quotient
     c                   endsr

     c     impots        begsr

      *Tranche <= 10 064
     c                   if        part - 10064 <=0
     c                   eval      impot = 0
     c                   eval(h)   impotd = impot
     c                   eval      rest  = netimpot

      *Tranche <= 25 659
     c                   elseif    part - 25659 <= 0
     c                   eval      part = part - 10065
     c                   eval      impot = part *0.11
     c                   eval      impot = impot *quotient
     c                   eval(h)   impotd = impot
     c                   eval      rest = netimpot - impot

      *Tranche <= 73 369
     c                   elseif    part - 73369 <=0
     c                   eval      impot= 15594 * 0.11
     c                   eval      part = part - 25660
     c                   eval      impot =(impot + part*0.30)*quotient
     c                   eval(h)   impotd = impot
     c                   eval      rest = netimpot -impot

      *Tranche <= 157 806
     c                   elseif    part - 157806<=0
     c                   eval      impot= 15594 * 0.11 + 47709*0.3
     c                   eval      part = part - 73370
     c                   eval      impot = impot + part*0.41  *quotient
     c                   eval(h)   impotd = impot
     c                   eval      rest = netimpot -impot

      *Tranche > 157 806
     c                   else
     c                   eval      impot= 15594 * 0.11 + 47709*0.3+84436*0.45
     c                   eval      part = part - 157807
     c                   eval      impot =(impot + part*0.41) *quotient
     c                   eval(h)   impotd = impot
     c                   eval      rest = netimpot -impot
     c                   endif
     c                   endsr
```
