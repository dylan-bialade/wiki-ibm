---
bibliotheque: BIB27
fichier_source: QRPGSRC
membre: RPGTP5
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 74
modifie: 2026-11-25
---

# BIB27/QRPGSRC/RPGTP5

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     *********************       déclaratives     *********************

     fracel1    uF a E           K DISK    prefix(lf_)
     Fetp5      cf   e             workstn

     *************     debut du programme   *****************************
     C                   SETON                                            LR
     C                   dow       *in03 = '0'

     c                   clear                   e1norace
     c                   exfmt     fmt1
     c                   setoff                                       51
     c                   setoff                                       52
     c                   setoff                                       53
     c                   if        *in03 = '1'
     c                   leave
     c                   endif
     c     e1norace      chain     racefmt
     c                   if        %found
     c                   exsr      trt_ecran2
     c                   else
     c                   exsr      trt_ecran3
     c                   endif
     c                   enddo

     **************  sous routines ******************
     c     trt_ecran2    begsr
     c                   move      lf_norace     e2norace
     c                   move      lf_dtrace     e2dtrace
     c                   move      lf_tprace     e2tprace
     c                   move      lf_nmrace     e2nmrace
     c                   move      lf_grrace     e2grrace
     c                   move      lf_dsrace     e2dsrace
     c                   move      lf_t1race     e2t1race
     c                   move      lf_p3race     e2p3race
     c                   move      lf_avrace     e2avrace
     c                   move      lf_forme      e2forme
     c                   exfmt     fmt2
     c                   if        *in23 = '1'
     c                   delete    racefmt
     c                   seton                                        51
     c                   endif
     c                   if        *in22 = '1'
     c                   move      e2dtrace      lf_dtrace
     c                   move      e2tprace      lf_tprace
     c                   move      e2nmrace      lf_nmrace
     c                   move      e2grrace      lf_grrace
     c                   move      e2dsrace      lf_dsrace
     c                   move      e2t1race      lf_t1race
     c                   move      e2p3race      lf_p3race
     c                   move      e2avrace      lf_avrace
     c                   move      e2forme       lf_forme
     c                   update    racefmt
     c                   seton                                        52
     c                   endif
     c                   endsr
     c     trt_ecran3    begsr
     c                   move      e1norace      e3norace
     c                   exfmt     fmt3
     c                   if        *in23 = '1'
     c                   move      e3norace      lf_norace
     c                   move      e3dtrace      lf_dtrace
     c                   move      e3tprace      lf_tprace
     c                   move      e3nmrace      lf_nmrace
     c                   move      e3grrace      lf_grrace
     c                   move      e3dsrace      lf_dsrace
     c                   move      e3t1race      lf_t1race
     c                   move      e3p3race      lf_p3race
     c                   move      e3avrace      lf_avrace
     c                   move      e3forme       lf_forme
     c                   write     racefmt
     c                   seton                                            53
     c                   endif
     c                   endsr
```
