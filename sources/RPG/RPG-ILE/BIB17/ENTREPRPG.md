---
bibliotheque: BIB17
fichier_source: QRPGLESRC
membre: ENTREPRPG
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 167
modifie: 2026-11-16
---

# BIB17/QRPGLESRC/ENTREPRPG

```text
     H*================================================================
     H* PROGRAMME   : <ENTREPRPG>
     H* AUTEUR      : Remy
     H* DATE        : 23/10/2026
     H*----------------------------------------------------------------
     H* OBJET       : Gestion des entrepots - liste en sous-fichier
     H*               avec positionnement sur le code, creation,
     H*               modification, suppression et affichage.
     H*----------------------------------------------------------------
     H* FICHIERS    : ENTREPDSP  (CF)    ecran : SFL1 / CTL1 / FOOT,
     H*                                  FMTMOD (saisie), WDWAFF (fenetre)
     H*               ENTREPOTL  (UF A)  logique des entrepots, par cle
     H*----------------------------------------------------------------
     H* OPTIONS     : 2 = modifier   4 = supprimer   5 = afficher
     H* TOUCHES     : liste  : F3 = quitter   F6 = creer
     H*               saisie : F24 = valider  F12 = retour  F3 = quitter
     H*----------------------------------------------------------------
     H* INDICATEURS : 30 SFLCLR    31 SFLDSPCTL   32 SFLDSP
     H*               33 SFLEND    70 positionnement modifie (CHANGE)
     H*               *INKC F3   *INKF F6   *INKL F12   *INKX F24
     H*----------------------------------------------------------------
     H* MODIFICATIONS :
     H*   JJ/MM/AAAA  <auteur>  <description>
     H*================================================================
     fentrepdsp cf   e             workstn sfile(sfl1 : rang)
     fENTREPOTL uf a e           k disk

     d rang            s              4p 0 INZ(0)
     d                SDS
     dpgm                *proc

     dmaj              s              1a

     c                   eval      nmpgm = pgm
     c                   exsr      inzsf1
     c                   exsr      lodsf1

     c                   dow       *inkc = *off
     c                   write     foot
     c                   exfmt     ctl1

     c                   select
      * F3 QUITTER
     c                   when      *inkc
      * F6 CREER
     c                   when      *inkf
     C                   exsr      srcreate
     c                   other
     c                   exsr      sropt
     c                   endsl

     c                   if        *in70 = *on or maj = '1'
     c                   exsr      inzsf1
     c                   exsr      lodsf1
     c                   endif


     c                   enddo
     c                   eval      *inlr = *on

     * Sous routine init sous fichier=================================================
     c     inzsf1        begsr
     * Allumer in30 et eteidre 31 32 33 grace au tableau
     c                   eval      %subarr(*in : 31 : 3) = *off
     c                   eval      *in30 = *on
     c                   write     ctl1
     c                   eval      *in30 = *off
     c                   eval      rang = 0
     c                   eval      maj = '0'
     c                   eval      modeed = *blanks
     c                   endsr

     * Sous routine load du sous fichier
     c     lodsf1        begsr
     c                   if        fltcod <> *blank
     c     fltcod        setll     ENTREPOTF
     c                   else
     c     *loval        setll     ENTREPOTF
     c                   endif
     c                   read      entrepotf

     c                   dow       not %eof(entrepotl) and rang < 9999
     c                   eval      rang +=1
     c                   write     sfl1
     c                   read      entrepotf
     c                   enddo

     c                   eval      *in32 = (rang >0)
     c                   eval      *in31 = *on
     c                   eval      *in33 = *on

     c                   endsr

     * Sous routine de creation
     c     srcreate      begsr
     c                   eval      modeed = 'Creation'
     c                   eval      codpro = *zero
     c                   eval      nomprod = *blanks
     c                   eval      quantstock = *zero
     c                   eval      DINVDATE = %DATE()


     c                   eval      *inkl = *off
     c                   dow       not *inkc and not *inkl
     c                   exfmt     fmtmod
     c                   if        *inkx
     c                   write     entrepotf
     c                   eval      maj = '1'
     c                   leave
     c                   endif
     c                   enddo
     c                   endsr

     * Sous routine traitement option
     c     sropt         begsr
     c                   readc     sfl1
     c                   dow       not %eof(entrepdsp) and not *inkc

     * Option 2 = modifier
     c                   select
     c                   when      opt = 2
     c                   exsr      optmod

     * Option 4 = supprimer
     c                   when      opt = 4
     c                   exsr      optdel
     * Option 5 = afficher
     c                   when      opt = 5
     c                   exsr      optaff
     c                   endsl

     c                   eval      opt = 0
     c                   update    sfl1
     c                   readc     sfl1

     c                   enddo
     c                   endsr

     * Sous routine de modification
     c     optmod        begsr
     c                   eval      modeed = 'Modification'
     c     codpro        chain     entrepotf
     c                   if        %found(entrepotl)
     c                   eval      *inkl = *off
     c                   dow       not *inkc and not *inkl
     c                   exfmt     fmtmod
     c                   if        *inkx
     c                   update    entrepotf
     c                   leave
     c                   endif
     c                   enddo
     c                   endif
     c                   endsr

     * Sous routine de delete
     c     optdel        begsr
     c     codpro        chain     entrepotf
     c                   if        %found(entrepotl)
     c                   delete    entrepotf
     c                   eval      maj = '1'
     c                   endif
     c                   endsr

     * Sous routine de delete
     c     optaff        begsr
     c                   exfmt     wdwaff
     c                   endsr
```
