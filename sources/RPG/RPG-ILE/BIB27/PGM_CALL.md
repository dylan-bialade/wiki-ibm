---
bibliotheque: BIB27
fichier_source: QRPGLESRC
membre: PGM_CALL
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 62
modifie: 2026-11-25
---

# BIB27/QRPGLESRC/PGM_CALL

```text
     ******** déclaratives ***************
     Fe_student cf   e             workstn
     fstudent   uf a e           k disk
     ********   programme   *************
     c     *entry        plist
     c                   parm                    enom
     c                   parm                    opt
     c                   parm                    msg               1 0
     c                   seton                                            lr
     c                   if        opt = '5'
     c                   seton                                            61
     c                   seton                                            62
     c                   seton                                            60
     c                   seton                                            63
     c                   exsr      affichage
     c                   elseif    opt = '2'
     c                   seton                                            62
     c                   seton                                            63
     c                   exsr      affichage
     c                   if        *in22 = '1'
     c                   exsr      modif
     c                   seton                                            63
     c                   endif
     c                   elseif    opt = '4'
     c                   seton                                            61
     c                   seton                                            60
     c                   seton                                            63
     c                   exsr      affichage
     c                   if        *in23 = '1'
     c                   exfmt     win
     c                   if        valid = 'yes'
     c                   exsr      delete
     C                   move      4             msg
     c                   endif
     c                   endif
     c                   endif

     * sous routines d'affichages *******
     c     affichage     begsr
     c     enom          chain     fmt
     c                   move      name          e1name
     c                   move      species       e1species
     c                   move      gender        e1gender
     c                   move      house         e1house
     c                   move      actor         e1actor
     c                   exfmt     fmt1
     c                   endsr

     * sous routines modif
     c     modif         begsr
     c                   move      e1name        name
     c                   move      e1species     species
     c                   move      e1gender      gender
     c                   move      e1house       house
     c                   move      e1actor       actor
     c                   update    fmt
     c                   endsr

     * sous routine suppression ********
     c     delete        begsr
     c     e1name        delete    fmt
     c                   endsr
```
