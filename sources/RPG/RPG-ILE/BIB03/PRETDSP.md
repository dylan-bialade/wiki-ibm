---
bibliotheque: BIB03
fichier_source: QRPGLESRC
membre: PRETDSP
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 43
modifie: 2026-11-16
---

# BIB03/QRPGLESRC/PRETDSP

```text
     A                                      DSPSIZ(24 80 *DS3)
     A                                      INDARA
     A          R SAISIE
     A                                      CA03(03)
     A                                  1 28'Calcul du pret immobilier'
     A                                  5  2'Capital emprunte . . . . . :'
     A            WCAPITAL       9S 2B  5 32
     A                                  7  2'Taux annuel en % . . . . . :'
     A            WTAUX          5S 2B  7 32
     A                                  9  2'Duree en annees (1 a 30) . :'
     A            WDUREE         2S 0B  9 32
     A            ERRMSG        50A  O 21  2COLOR(RED)
     A                                 23  2'F3=Quitter   Entree=Calculer'
     A          R PRETSFL                   SFL
     A            SMOIS          3S 0O  9  2
     A            SRESTANT      12A  O  9 10
     A            SINTERET       9A  O  9 31
     A            SREMB         12A  O  9 46
     A            SMENS         12A  O  9 64
     A          R PRETCTL                   SFLCTL(PRETSFL)
     A                                      SFLSIZ(0360) SFLPAG(0012)
     A                                      CA03(03) CA12(12)
     A                                      OVERLAY
     A  41                                  SFLDSP
     A  42                                  SFLDSPCTL
     A  43                                  SFLCLR
     A  44                                  SFLEND(*MORE)
     A            CURPAGE        4S 0H      SFLRCDNBR
     A                                  1 27'Calcul du pret immobilier'
     A                                  2 28'Tableau d''amortissement'
     A                                  4  2'Mensualite . . . . :'
     A            WMENS         12A  O  4 30
     A                                  5  2'Cout des interets  :'
     A            WCOUTINT      14A  O  5 28
     A                                  6  2'Cout total du pret :'
     A            WCOUTTOT      14A  O  6 28
     A                                  8  2'Mois'
     A                                  8 10'Capital restant du'
     A                                  8 31'Interets'
     A                                  8 46'Capital rembourse'
     A                                  8 64'Mensualite'
     A          R PRETPIED
     A                                 23  2'F3=Quitter   F12=Retour'
```
