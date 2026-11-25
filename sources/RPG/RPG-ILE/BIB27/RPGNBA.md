---
bibliotheque: BIB27
fichier_source: QTESTSRC
membre: RPGNBA
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 31
modifie: 2026-11-25
---

# BIB27/QTESTSRC/RPGNBA

```text
     **********************      déclaratives    ***************************

     fl1nba     uf a e           k disk    prefix(lf_)
     fdnba      cf   e             workstn

     **********************      programme       ***************************

     c                   seton                                            lr

     c                   dow       *in03 = '0'

     c                   clear                   e1nbrtitre
     c                   exfmt     fmt1

     c                   if        *in03 = '1'
     c                   leave
     c                   endif

     c                   exsr      trt_ecran2

     c                   enddo
     c     trt_ecran2    begsr
     c     e1nbrtitre    chain     joueursnba
     c                   if        %found
     c                   dow       1 = 1
     c     e1nbrtitre    chain     joueursnba
     c                   move      lf_nom        e2nom
     c                   exfmt     fmt2
     c                   enddo
     c                   endif
     c                   endsr
```
