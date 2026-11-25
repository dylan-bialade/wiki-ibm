---
bibliotheque: BIB27
fichier_source: QRPGSRC
membre: SFD_BONBON
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 70
modifie: 2026-11-25
---

# BIB27/QRPGSRC/SFD_BONBON

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     ************   declaratives ****************
     Fe_sfdb    cf   e             workstn
     F                                     sfile(sf01:rang)
     Fbonbonl1  uf a e           k disk
     ************    programme   ****************

     ************* INDICATEURS ************
     *  *IN51 = affichage ctl
     *  *IN50 = affichage sf
     *  *IN53 = 'a suivre ' du sf
     *  *IN52 = clear sf
     *  *IN59 = rollup

     *  seton lr pour sortir du prog
     c                   seton                                            lr

     *  decl de rang et init à 0 et de cpt à 0
     c                   z-add     *zero         rang              4 0

     * mise en place des indicateurs
     c                   setoff                                           52
     c                   setoff                                           53
     c                   seton                                            59
     c                   seton                                            51
     c                   seton                                            50

     * boucle globale (f3 = quit)
     c                   dow       *in03 = '0'
     c                   read      rbonbon                                99

     * pas d'affichage si zero enrg

     c                   if        *in99 = *on
     c                   seton                                            51
     c                   setoff                                           50
     c                   exfmt     ctl01
     c                   return
     c                   endif

     * quand 53 allumé fin de pagination: ici 53 est off (indicateurs)

     c                   dow       ( not *in53 ) and *in59
     c                   z-add     *zero         cpt               4 0
     c                   dow       cpt < 10
     c                   add       1             rang
     c                   add       1             cpt
     c                   move      prix          eprix
     c                   move      nom           enom
     c                   move      marque        emarque
     c                   move      couleur       ecouleur
     c                   write     sf01
     c                   read      rbonbon                                99
     c                   if        *in99 = '1'
     c                   seton                                            53
     c                   leave
     c                   endif
     c                   enddo
     c                   if        rang > 0
     c                   exfmt     ctl01
     c                   if        *in03 = '1'
     c                   return
     c                   endif
     c                   if        *in59 and not *in53
     c                   iter
     c                   else
     c                   leave
     c                   endif
     c                   endif
     c                   enddo
     c                   enddo
```
