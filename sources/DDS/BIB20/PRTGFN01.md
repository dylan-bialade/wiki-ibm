---
bibliotheque: BIB20
fichier_source: QDDSSRC
membre: PRTGFN01
type: DDS
longueur_enregistrement: 80
lignes: 110
modifie: 2026-11-16
---

# BIB20/QDDSSRC/PRTGFN01

```text
     A*=================================================================
     A* PRTGFN01 - Fichier imprimante externe pour STOENT
     A*            Etat mensuel des entrees en stock
     A*
     A* TTET(i) = Char(60) pos 1-60  : decoupe en segments sans overlap
     A* TFIN(i) = Char(72) pos 61-132: decoupe en segments sans overlap
     A*=================================================================
     A*------------------------------------------------------------------
     A* ENTETE1 - En-tete ligne 1 : saut page col 2, espace apres 2
     A*  Variables : MOISANN(52-60)/ANNEE(56-60) A(62-65)
     A*              NOMPGM(93-100) STE(103-110)
     A*  TTET1 : 1-51   TFIN1:61  TFIN2:66-92  TFIN3:101-102  TFIN4:111-132
     A*------------------------------------------------------------------
     A          R ENTETE1
     A                                      SKIPB(2)
     A                                      SPACEA(2)
     A            E1_TTET1      51A        1
     A N07        E1_MOISANN     9A       52
     A  07        E1_ANNEE       5A       56
     A            E1_TFIN1       1A       61
     A            E1_A           4S 0     62
     A            E1_TFIN2      27A       66
     A            E1_NOMPGM      8A       93
     A            E1_TFIN3       2A      101
     A            E1_STE         8A      103
     A            E1_TFIN4      22A      111
     A*------------------------------------------------------------------
     A* ENTETE2 - En-tete ligne 2 : espace avant 1, pas de chevauchement
     A*------------------------------------------------------------------
     A          R ENTETE2
     A                                      SPACEB(1)
     A            E2_TTET       60A        1
     A            E2_TFIN       72A       61
     A*------------------------------------------------------------------
     A* ENTETE3 - En-tete ligne 3 : espace avant 1
     A*------------------------------------------------------------------
     A          R ENTETE3
     A                                      SPACEB(1)
     A            E3_TTET       60A        1
     A            E3_TFIN       72A       61
     A*------------------------------------------------------------------
     A* ENTETE4 - En-tete ligne 4 : espace avant 1
     A*------------------------------------------------------------------
     A          R ENTETE4
     A                                      SPACEB(1)
     A            E4_TTET       60A        1
     A            E4_TFIN       72A       61
     A*------------------------------------------------------------------
     A* DETAIL - Ligne de detail : espace avant 1
     A*  Variables: B7ART(2-6) C2FRQC(8) LIBSUP(11-40) B7QTE(42-48)
     A*             TYPENT(51-56) MVTJOUR(63-64) /(65) MVTMOIS(66-67)
     A*             /(68) B7MVTAN(69-72) B7PROF(76-85)
     A*  Segments TTET(5):
     A*    TTET1=1   TTET2=7   TTET3=9-10  TTET4=41
     A*    TTET5=49-50  TTET6=57-60
     A*  Segments TFIN(5):
     A*    TFIN1=61-62  TFIN2=73-75  TFIN3=86-132
     A*------------------------------------------------------------------
     A          R DETAIL
     A                                      SPACEB(1)
     A            DT_TTET1       1A        1
     A            DT_B7ART       5S 0      2
     A            DT_TTET2       1A        7
     A            DT_C2FRQC      1A        8
     A            DT_TTET3       2A        9
     A            DT_LIBSUP     30A       11
     A            DT_TTET4       1A       41
     A            DT_B7QTE       5S 0     42EDTWRD('  .   -')
     A            DT_TTET5       2A       49
     A            DT_TYPENT      6A       51
     A            DT_TTET6       4A       57
     A            DT_TFIN1       2A       61
     A            DT_MVTJOUR     2S 0     63
     A                                    65'/'
     A            DT_MVTMOIS     2S 0     66
     A                                    68'/'
     A            DT_B7MVTAN     4S 0     69
     A            DT_TFIN2       3A       73
     A            DT_B7PROF     10A       76
     A            DT_TFIN3      47A       86
     A*------------------------------------------------------------------
     A* NEGATIF - Ligne mention negatif : espace avant 1
     A*  LIBNEG(51-58) dans TTET(5) 1-60 -> TTET1=1-50, TTET2=59-60
     A*------------------------------------------------------------------
     A          R NEGATIF
     A                                      SPACEB(1)
     A            NG_TTET1      50A        1
     A            NG_LIBNEG      8A       51
     A            NG_TTET2       2A       59
     A            NG_TFIN       72A       61
     A*------------------------------------------------------------------
     A* STOT1 - Total article : espace avant 1
     A*  TOTAL ARTICLE(27-39) WCUMUL(42-46) dans TTET(5) 1-60
     A*  Segments: TTET1=1-26  TTET2=40-41  TTET3=47-60
     A*------------------------------------------------------------------
     A          R STOT1
     A                                      SPACEB(1)
     A            S1_TTET1      26A        1
     A                                    27'TOTAL ARTICLE'
     A            S1_TTET2       2A       40
     A            S1_WCUMUL      5S 0     42EDTWRD('  .   -')
     A            S1_TTET3      14A       47
     A            S1_TFIN       72A       61
     A*------------------------------------------------------------------
     A* STOT2 - Separateur : espace avant 1, pas de chevauchement
     A*------------------------------------------------------------------
     A          R STOT2
     A                                      SPACEB(1)
     A            S2_TTET       60A        1
     A            S2_TFIN       72A       61
```
