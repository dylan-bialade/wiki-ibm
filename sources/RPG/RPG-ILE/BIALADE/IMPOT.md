---
bibliotheque: BIALADE
fichier_source: QRPGLESRC
membre: IMPOT
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 91
modifie: 2026-11-16
---

# BIALADE/QRPGLESRC/IMPOT

```rpg
     FIMP       CF   E             WORKSTN
     dImpot            S             15P 4 inz(0)
     dReste            S             15P 4 inz(0)
     dNBpartfisc       S              9P 4 inz(1)
     dCalculTranche    S             15P 4 inz(0)
     C* =====================================================================
     C* BOUCLE PRINCIPALE (F3 = quitter)
     C* =====================================================================
     C                   dou       *in03
     C                   exfmt     fmt1
     C                   if        *in03
     C                   leave
     C                   endif
     C* =====================================================================
     C* 1. PARTS FISCALES
     C* =====================================================================
     C                   eval      NBpartfisc = 1.0
     C* CHOICE : 1 = NON, 2 = OUI (marié ou pacsé)
     C                   if        CHOICE = 2
     C                   eval      NBpartfisc = 2.0
     C                   endif
     C* 2 premiers enfants : 0.5 part chacun, ensuite 1 part chacun
     C                   if        NBENFANT > 0
     C                   if        NBENFANT <= 2
     C                   eval      NBpartfisc = NBpartfisc + (NBENFANT * 0.5)
     C                   else
     C                   eval      NBpartfisc = NBpartfisc + 1.0
     C                                        + (NBENFANT - 2)
     C                   endif
     C                   endif
     C* =====================================================================
     C* 2. QUOTIENT FAMILIAL
     C* =====================================================================
     C                   eval      CalculTranche = REVIMP / NBpartfisc
     C                   eval      Impot = 0
     C* On retire d'abord la tranche à 0 % (jusqu'à 10 064)
     C                   if        CalculTranche > 10065
     C                   eval      Reste = CalculTranche - 10065
     C                   else
     C                   eval      Reste = 0
     C                   endif
     C* =====================================================================
     C* 3. BARÈME PROGRESSIF 2020
     C* =====================================================================
     C* Tranche 11 % (largeur 15 595)
     C                   if        Reste > 0
     C                   if        Reste > 15595
     C                   eval      Impot = Impot + (15594 * 0.11)
     C                   eval      Reste = Reste - 15595
     C                   else
     C                   eval      Impot = Impot + (Reste * 0.11)
     C                   eval      Reste = 0
     C                   endif
     C                   endif
     C* Tranche 30 % (largeur 47 710)
     C                   if        Reste > 0
     C                   if        Reste > 47709
     C                   eval      Impot = Impot + (47709 * 0.30)
     C                   eval      Reste = Reste - 47709
     C                   else
     C                   eval      Impot = Impot + (Reste * 0.30)
     C                   eval      Reste = 0
     C                   endif
     C                   endif
     C* Tranche 41 % (largeur 84 437)
     C                   if        Reste > 0
     C                   if        Reste > 84436
     C                   eval      Impot = Impot + (84436 * 0.41)
     C                   eval      Reste = Reste - 84436
     C                   else
     C                   eval      Impot = Impot + (Reste * 0.41)
     C                   eval      Reste = 0
     C                   endif
     C                   endif
     C* Tranche 45 % (au-delà)
     C                   if        Reste > 0
     C                   eval      Impot = Impot + (Reste * 0.45)
     C                   endif
     C* =====================================================================
     C* 4. SORTIE (ÉCRAN 2)
     C* =====================================================================
     C                   eval(h)   IMPREVO = Impot * NBpartfisc
     C                   eval      SALNETIMP = REVIMP
     C                   eval      REST = SALNETIMP - IMPREVO
     C                   exfmt     fmt2
     C                   if        *in03
     C                   leave
     C                   endif
     C                   enddo
     C
     C                   eval      *inlr = '1'
```
