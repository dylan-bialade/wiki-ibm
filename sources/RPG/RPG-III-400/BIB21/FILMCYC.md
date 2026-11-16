---
bibliotheque: BIB21
fichier_source: QEXOSRC
membre: FILMCYC
type: RPG/RPG-III-400
longueur_enregistrement: 100
lignes: 186
modifie: 2026-11-16
---

# BIB21/QEXOSRC/FILMCYC

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      *=================================================================
      * FILMCYC  : CATALOGUE DES FILMS PAR PAYS ET PAR GENRE
      *            Programme a CYCLE RPG (style RPG II, colonnes)
      *-----------------------------------------------------------------
      * Fichier primaire : FILMCAST (une ligne par acteur du casting,
      *   cle PAYS / GENRE / TITRE / IDFILM / ORDRE).
      * Aucun READ, aucune boucle : le cycle lit le fichier primaire
      * et declenche tout seul les ruptures.
      *
      * Ruptures (I-spec) :
      *   L3 = PAYS    -> nouvelle page, total pays
      *   L2 = GENRE   -> titre du genre, total genre
      *   L1 = IDFILM  -> fiche du film, total cachets du film
      *   LR           -> total general
      * Indicateurs :
      *   01  enregistrement FILMCASR lu
      *   20  ACTEUR a blanc  (film sans casting)
      *   21  REALIS a blanc  (realisateur inconnu)
      *   OF  debordement de page
      *=================================================================
     HDECEDIT('0,') DATEDIT(*DMY/) OPTION(*SRCSTMT)
     FFILMCAST  IPE  E           K DISK
     FQSYSPRT   O    F  132        PRINTER OFLIND(*INOF)
      *
      * Definition des ruptures et des indicateurs de zone
     IFILMCASR      01
     I                                          PAYS          L3
     I                                          GENRE         L2
     I                                          IDFILM        L1
     I                                          REALIS                  21
     I                                          ACTEUR                  20
      *
      * ================ CALCULS DE DETAIL (a chaque enregistrement) =====
      * Nouveau pays : la numerotation des pages repart a 1
     C   L3              Z-ADD     0             PAGE
      * ... et le debordement est annule : l'en-tete L3 fait deja le saut
     C   L3              SETOFF                                       OF
      * Une ligne de casting = un acteur de plus pour le film
     C  N20              ADD       1             NBA1              3 0
     C  N20              ADD       CACHET        CAF1             11 2
      * Premier enregistrement d'un film (L1 allume) : on compte le film
     C   L1              ADD       1             NBF2              5 0
     C   L1              ADD       BUDGET        BUD2             11 2
     C   L1              ADD       RECET         REC2             13 2
      *
      * ================ CALCULS DE TOTAL (a la rupture) =================
      * Rupture film  : cumuls du film remontes dans le genre
     CL1                 ADD       NBA1          NBA2              5 0
     CL1                 ADD       CAF1          CAF2             11 2
      * Rupture genre : cumuls du genre remontes dans le pays
     CL2                 ADD       NBF2          NBF3              5 0
     CL2                 ADD       NBA2          NBA3              5 0
     CL2                 ADD       BUD2          BUD3             11 2
     CL2                 ADD       REC2          REC3             13 2
     CL2                 ADD       CAF2          CAF3             11 2
      * Rupture pays  : cumuls du pays remontes dans le total general
     CL3                 ADD       NBF3          NBFR              5 0
     CL3                 ADD       NBA3          NBAR              5 0
     CL3                 ADD       BUD3          BUDR             11 2
     CL3                 ADD       REC3          RECR             13 2
     CL3                 ADD       CAF3          CAFR             11 2
     O*
     O* ---- En-tete de page : nouveau pays (L3) ou debordement (OF)
     O*      OF seul (NL3) : sinon, au temps "debordement" (avant le
     O*      transfert du nouvel enregistrement), le cycle imprimerait
     O*      une page vide au nom de l'ANCIEN pays
     OQSYSPRT   H    L3                     1 01
     O         OR    OFNL3
     O                                            8 'FILMCYC'
     O                                           69 'CATALOGUE DES FILMS'
     O                                           91 'PAR PAYS ET PAR GENRE'
     O                       UDATE         Y    112
     O                                          122 'Page'
     O                       PAGE          Z    127
     OQSYSPRT   H    L3                     2
     O         OR    OFNL3
     O                                            6 'Pays :'
     O                       PAYS                27
     OQSYSPRT   H    L3                     1
     O         OR    OFNL3
     O                                           12 'Ord'
     O                                           31 'Acteur'
     O                                           67 'Personnage'
     O                                          103 'Role'
     O                                          129 'Cachet kEUR'
     OQSYSPRT   H    L3                     1
     O         OR    OFNL3
     O                                           26 '--------------------------'
     O                                           52 '--------------------------'
     O                                           78 '--------------------------'
     O                                          104 '--------------------------'
     O                                          129 '-------------------------'
     O* ---- Detail : titre du genre (premier film du genre)
     OQSYSPRT   D    L2                  1  1
     O                                           12 '== Genre :'
     O                       GENRE               34
     O* ---- Detail : fiche du film (premier enregistrement du film)
     OQSYSPRT   D    L1                  1  1
     O                       IDFILM        Z      7
     O                       TITRE               49
     O                       ANNEE               55
     O                       DUREE         Z     60
     O                                           64 'min'
     O                                           79 'Realisateur :'
     O              N21      REALIS             121
     O               21                          90 '(inconnu)'
     OQSYSPRT   D    L1                     1
     O                                           17 'Budget :'
     O                       BUDGET        1     28
     O                                           33 'MEUR'
     O                                           46 'Recettes :'
     O                       RECET         1     59
     O                                           64 'MEUR'
     O                                           73 'Note :'
     O                       NOTE          3     77
     O                                           90 'Classif. :'
     O                       CLASSI             103
     O* ---- Detail : une ligne par acteur
     O*      (01 obligatoire : sinon la ligne sort a vide au 1er cycle 1P)
     OQSYSPRT   D    01N20                  1
     O                       ORDRE         Z     12
     O                       ACTEUR              55
     O                       PERSO               97
     O                       ROLE               111
     O                       CACHET        1    126
     O* ---- Detail : film sans casting
     OQSYSPRT   D    01 20                  1
     O                                           37 'Aucun acteur au casting'
     O* ---- Total film (L1) : seulement si le film a un casting
     OQSYSPRT   T    L1N20                  1
     O                                           98 'Acteurs :'
     O                       NBA1          3B   102
     O                       CAF1          1B   126
     O* ---- Total genre (L2)
     OQSYSPRT   T    L2                  1  1
     O                                           18 '* Total genre'
     O                       GENRE               39
     O                                           49 'Films :'
     O                       NBF2          3B    55
     O                                           67 'Acteurs :'
     O                       NBA2          3B    73
     OQSYSPRT   T    L2                     2
     O                                           26 'Budget :'
     O                       BUD2          1B    41
     O                                           46 'MEUR'
     O                                           59 'Recettes :'
     O                       REC2          1B    77
     O                                           82 'MEUR'
     O                                           94 'Cachets :'
     O                       CAF2          1B   109
     O                                          114 'kEUR'
     O* ---- Total pays (L3)
     OQSYSPRT   T    L3                  1  1
     O                                           18 '** Total pays'
     O                       PAYS                39
     O                                           49 'Films :'
     O                       NBF3          3B    55
     O                                           67 'Acteurs :'
     O                       NBA3          3B    73
     OQSYSPRT   T    L3                     2
     O                                           26 'Budget :'
     O                       BUD3          1B    41
     O                                           46 'MEUR'
     O                                           59 'Recettes :'
     O                       REC3          1B    77
     O                                           82 'MEUR'
     O                                           94 'Cachets :'
     O                       CAF3          1B   109
     O                                          114 'kEUR'
     O* ---- Total general (LR)
     OQSYSPRT   T    LR                  2  1
     O                                           22 '*** TOTAL GENERAL'
     O                                           49 'Films :'
     O                       NBFR          3     55
     O                                           67 'Acteurs :'
     O                       NBAR          3     73
     OQSYSPRT   T    LR                     1
     O                                           26 'Budget :'
     O                       BUDR          1     41
     O                                           46 'MEUR'
     O                                           59 'Recettes :'
     O                       RECR          1     77
     O                                           82 'MEUR'
     O                                           94 'Cachets :'
     O                       CAFR          1    109
     O                                          114 'kEUR'
```
