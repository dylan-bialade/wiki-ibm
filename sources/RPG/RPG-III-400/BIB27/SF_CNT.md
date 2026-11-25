---
bibliotheque: BIB27
fichier_source: QRPGSRC
membre: SF_CNT
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 91
modifie: 2026-11-25
---

# BIB27/QRPGSRC/SF_CNT

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     ************   declaratives ****************
     Fe_sfcnt   cf   e             workstn
     F                                     sfile(sf01:rang)
     Fpays      uf a e           k disk
     ************    programme   ****************

     ************* INDICATEURS ************
     *  *IN40 = zone protégé
     *  *IN41 = gestion affichage f23 = delete
     *  *IN42 = gestion affichage f22 = update

     *  seton lr pour sortir du prog
     c                   seton                                            lr

     *  decl de rang et init à 0
     c                   z-add     *zero         rang              4 0

     * boucle globale (f3 = quit)
     c                   dow       *in03 = '0'
     c                   exsr      trt_pays
     c                   write     fmt1
     c                   write     fmt2
     c                   exfmt     ctl01
     c                   readc     sf01                                   98
     c                   dow       *in98 = '0'
     c                   setoff                                           42
     c                   if        opt = '2'
     c                   exsr      trt_modif
     c                   endif
     c                   readc     sf01                                   98
     c                   enddo
     c                   enddo

     ************   sous routine  *************
     ** TRT pays sous fichier **
     c     trt_pays      begsr
     * mis a zéro du sous fichier
     * sur format de contôle car indicateurs placé sur celui-ci
     c                   seton                                            52
     c                   WRITE     CTL01
     c                   setoff                                           52

     *  lecture et ecriture du sous fichier
     c                   z-add     0             rang
     c     *loval        setll     paysf
     c                   read      paysf                                  99
     c                   dow       *in99 = '0'
     c                   add       1             rang
     c                   movel     paylib        epaylib
     c                   movel     paycod        epaycod
     c                   write     sf01
     c                   read      paysf                                  99
     c                   enddo

     c                   seton                                            51
     c                   if        rang <> *zero
     c                   seton                                            50
     c                   seton                                            53
     c                   endif
     c                   endsr

     * trt_modif : modif des du nom du pays
     c     trt_modif     begsr
     c                   exsr      trt_affichage
     c                   if        *in22 = '1'
     c     *loval        setll     paysf
     c                   read      paysf                                  97
     c                   dow       *in97 = '0'
     c                   if        paycod = e3paycod
     c                   eval      erreur = 'code pays existe déjà'
     c                   endif
     c                   read      paysf                                  97
     c                   enddo
     c                   if        erreur = *blanks
     c                   move      e3paycod      paycod
     c                   move      e3paylib      paylib
     c                   update    paysf
     c                   else
     c                   exfmt     fmt3
     c                   endif
     c                   endif
     c                   endsr

     * trt_affichage : affichage des infos sur un format
     c     trt_affichage begsr
     c     epaycod       chain     paysf
     c                   move      paycod        e3paycod
     c                   move      paylib        e3paylib
     c                   exfmt     fmt3
     c                   eval      opt = ' '
     c                   endsr
```
