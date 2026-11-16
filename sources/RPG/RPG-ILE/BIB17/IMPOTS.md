---
bibliotheque: BIB17
fichier_source: QRPGLESRC
membre: IMPOTS
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 130
modifie: 2026-11-16
---

# BIB17/QRPGLESRC/IMPOTS

```text
     *================================================================
     * OBJET       : Calculateur d'impot sur le revenu (bareme 2020).
     *               Saisie du revenu net imposable, de la situation
     *               (marie / pacse) et du nombre d'enfants, puis
     *               affichage de l'impot et du revenu restant.
     *----------------------------------------------------------------
     * REGLES      : - Parts : 1, +1 si marie ou pacse,
     *                 +0,5 pour chacun des 2 premiers enfants,
     *                 +1 a partir du 3e enfant.
     *               - Quotient familial = revenu / parts.
     *               - Impot progressif : chaque tranche est imposee
     *                 a son propre taux sur la part du quotient qui
     *                 s'y trouve (borne basse = debut de tranche).
     *               - Impot total = impot par part x parts, arrondi
     *                 au centime en fin de calcul uniquement.
     *----------------------------------------------------------------
     * FICHIERS    : IMPOTDSP (CF) ecran : FMT1 saisie, FMT2 resultat
     *----------------------------------------------------------------
     * TABLEAUX    : tranches  bornes hautes des tranches (croissantes)
     *               taux      taux de chaque tranche, en %
     *----------------------------------------------------------------
     * VARIABLES   : i index iteration
     *               tauxTranche taux de la tranche en cours
     *               baseTranche base de la tranche en cours
     *               impotTranche impot de la tranche en cours
     *               impot      impot total
     *               reste      revenu restant apres impot
     *               parts      nombre de parts
     *               quotfam    quotient familial
     *               revnet     revenu net imposable
     *               revDta     revenu net imposable recupere du DTA
     *----------------------------------------------------------------
     * TOUCHES     : FMT1 : Entree = calculer     F3 = quitter
     *               FMT2 : Entree/F12 = retour   F3 = quitter
     *================================================================
      *
     fimpotdsp  cf   e             workstn
      *
     dtranches         s              8  2 dim(5) ASCEND
     dtaux             s              2  0 dim(5)
     di                s             10i 0
     DtauxTranche      S              2  0
     DimpotTranche     S              8  2
     Dparts            s              3  1 inz(1)
     Dquotfam          S              8  2
     DbaseTranche      S              8  2
     DrevDta           S              8  2 DTAARA(*VAR : dtaNom)
     Dimpots           pi
     DdtaNom                         10a
      *
      *
     c     *in03         doweq     *off
     c                   exfmt     fmt1
     C                   IF        *IN03
     C                   LEAVE
     C                   ENDIF
      *
     C                   exsr      calcparts
     c                   exsr      calc
      *
     c                   exfmt     fmt2
      *
     c                   enddo
     c                   eval      *inlr = *on
      *
     *=========INIT tableaux
     C     *INZSR        BEGSR
     C                   EVAL      tranches(1) = 10065
     C                   EVAL      tranches(2) = 25659
     C                   EVAL      tranches(3) = 73369
     C                   EVAL      tranches(4) = 157807
     C                   EVAL      tranches(5) = 999999,99
     C                   EVAL      taux(1) = 0
     C                   EVAL      taux(2) = 11
     C                   EVAL      taux(3) = 30
     C                   EVAL      taux(4) = 41
     C                   EVAL      taux(5) = 45
     C                   IN        revDta                               99
     C                   IF        NOT *IN99
     C                   EVAL      revnet = revDta
     C                   ENDIF
     C                   ENDSR
      *
     * ======== Sous routine calcul impots=========================================================
     c     calc          BEGSR
     * On recupere l'index de la tranche au dessus du revnet entré
     c                   eval      i = %LOOKUPGE(quotfam : tranches)
      *
     * Raz des bases avant calcul
     C                   eval      IMPOT = 0
     C                   eval      reste = revnet
      *
     * Si taux(i)==0 non imposable, on sort de la sous routine
     C                   if        taux(i) > 0
      *
     C                   for       i = i downto 2
     c                   eval      tauxTranche = taux(i)
     C                   eval      baseTranche = quotfam - tranches(i-1)
     C                   eval(h)   impotTranche = baseTranche * tauxTranche/100
     C                   eval      impot = impot + impotTranche
     C                   eval      quotfam = tranches(i-1)
     C                   endfor
      *
      *
     c                   eval(h)   IMPOT = impot * parts
     c                   eval      reste = revnet - impot
      *
     C                   endif
     c                   endsr
      *
     *=========== Sous routine calcul quotient=====================================================
     c     calcparts     begsr
     C                   eval      parts = 1
     * Si marié =1 oui on ajoute une part
     c                   if        choix = 1
     c                   eval      parts = parts + 1
     c                   endif
      *
     * Ajout du nombre de parts enfants: 0.5/enf puis 1/enf au dessus de 2
     C                   for       i = 1 to nbenf
     c                   if        i>2
     c                   eval      parts = parts +1
     c                   else
     c                   eval      parts = parts + 0,5
     c                   endif
     C                   endfor
      *
     * Calcul de la base de quotient familial
     C                   eval(h)   quotfam = revnet / parts
     c                   endsr
```
