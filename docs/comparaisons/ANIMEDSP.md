# ANIMEDSP : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB17 | QDDSSRC | DDS | 24 | 100 % | DDS (R/K/PFILE) | [ANIMEDSP.md](../../sources/DDS/BIB17/ANIMEDSP.md) |
| BIB21 | QDDSSRC | DDS | 55 | 0 % | sous-fichier, DDS (R/K/PFILE) | [ANIMEDSP.md](../../sources/DDS/BIB21/ANIMEDSP.md) |

## Differences

- Techniques communes : DDS (R/K/PFILE)
- **BIB21** en propre : sous-fichier

## Codes

### BIB17 (DDS, 24 lignes)

```text
     A*%%TS  SD  20261027  150629  REMI        REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      INDARA
     A          R FMT1
     A*%%TS  SD  20261027  150629  REMI        REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                      CF10(10)
     A                                  1  2USER
     A                                  2  2SYSNAME
     A                                  1 30'Selection de l''univers'
     A                                      COLOR(WHT)
     A                                  1 72DATE
     A                                      EDTCDE(Y)
     A                                  2 72TIME
     A                                 23  4'F3=Quitter   F10=Plus de choix'
     A                                      COLOR(BLU)
     A                                  8  5'Choisissez un anime'
     A                                      COLOR(WHT)
     A            CHOIX          2Y 0B  8 26SNGCHCFLD((*NUMROW 4))
     A                                      CHOICE(1 '>Dragon ball')
     A                                      CHOICE(8 '>Hunter x Hunter')
     A                                      CHOICE(11 '>Bleach')
     A                                      CHOICE(99 '>Tous')
```

### BIB21 (DDS, 55 lignes)

```text
     A*%%TS  SD  20260218  084037  GGEOFFREY   REL-V7R5M0  5770-WDS                  A*%%EC
     A                                      DSPSIZ(24 80 *DS3)                       A                                      CA03(03)
     A          R SELECTION                                                          A*%%TS  SD  20260217  102530  GGEOFFREY   REL-V7R5M0  5770-WDS
     A                                      CA10(10)                                 A                                  1 30'Sélection de l univers'
     A                                      COLOR(WHT)                               A                                  1 71DATE
     A                                      EDTCDE(Y)                                A                                      COLOR(BLU)
     A                                  2 71TIME                                     A                                      COLOR(BLU)
     A                                  1  2USER                                                                            COLOR(BLU)
     A                                  2  2SYSNAME                                                                         COLOR(BLU)
     A                                 10  3'Choisissez un animé'                    A                                      COLOR(WHT)
     A                                 10 23':'                                      A            FLD001         2Y 0B 10 26SNGCHCFLD
     A                                      CHOICE(1 'DRAGON BALL')                                                         CHOICE(3 'NARUTO')
                                            CHOICE(2 'ONE PIECE')                                                           CHOICE(4 'TOUT')
     A                                 23  2'F3 = Quitter'                           A                                      COLOR(BLU)
     A                                 23 20'F10 = Séléctionner un autre animé'      A                                      COLOR(BLU)
        90        MSGERR        50   M                                               A          R SFLF                      SFL
     A*%%TS  SD  20260218  084037  GGEOFFREY   REL-V7R5M0  5770-WDS                  A            NOM           15A  O  7  2
     A            PRENOM        15A  O  7 18                                         A            UNINAME       20A  O  7 34
     A            TEMPS         20A  O  7 55                                         A          R CTLF                      SFLCTL(SFLF)
     A*%%TS  SD  20260217  104627  GGEOFFREY   REL-V7R5M0  5770-WDS                  A                                      CA10(10)
                                            CA12(12)                                                                        OVERLAY
     A N30                                  SFLDSP                                   A N31                                  SFLDSPCTL
     A  32                                  SFLCLR                                   A  33                                  SFLEND(*MORE)
     A                                      SFLSIZ(0011)                             A                                      SFLPAG(0010)
     A            RANG           4S 0H      SFLRCDNBR                                A                                  1  2USER
     A                                      COLOR(BLU)                               A                                  2  2SYSNAME
     A                                      COLOR(BLU)                               A                                  1 28'Affichage des personnages'
     A                                      COLOR(WHT)                               A                                  1 73DATE
     A                                      EDTCDE(Y)                                A                                      COLOR(BLU)
     A                                  2 73TIME                                     A                                      COLOR(BLU)
     A                                  5  2'Nom'                                    A                                      COLOR(WHT)
     A                                  5 18'Prénom'                                 A                                      COLOR(WHT)
     A                                  5 34'Univers'                                A                                      COLOR(WHT)
     A                                  5 55'Temps d''apparition'                    A                                      COLOR(WHT)
     A          R PIED                                                               A*%%TS  SD  20260217  104627  GGEOFFREY   REL-V7R5M0  5770-WDS
                                            OVERLAY                                  A                                 20 18'Nombre de personnages dans la list-
     A                                      e'                                       A                                      COLOR(YLW)
     A                                 23  3'F3 = Quitter'                           A                                      COLOR(BLU)
     A                                 23 59'F12 = Retour'                           A                                      COLOR(BLU)
     A                                 20 54':'                                      A                                      COLOR(YLW)
     A            TTLPERSO       4Y 0O 20 56EDTCDE(Z)                                A                                      COLOR(YLW)
     A                                 23 21'F10 = Séléctionner un autre animé'      A                                      COLOR(BLU)
     A          R SFLUNI                    SFL                                      A            OPT            1   B  5  4
     A            UNINAME   R        O  5  8REFFLD(UNIVERSF/UNINAME ANIME/UNIVE-     A                                      RS)
     A            UNIVER    R        H      REFFLD(UNIVERSF/UNIVER ANIME/UNIVER-     A                                      S)
     A          R CTLUNI                    SFLCTL(SFLUNI)                           A                                      WINDOW(4 12 14 29)
     A                                      WDWBORDER((*COLOR RED) (*DSPATR RI)-     A                                       (*CHAR '        '))
     A                                      WDWTITLE((*TEXT 'LISTE ANIMÉ') +         A                                      (*COLOR WHT) *TOP *CENTER)
                                            CA12(12)                                 A N30                                  SFLDSP
     A N31                                  SFLDSPCTL                                A  32                                  SFLCLR
     A  33                                  SFLEND(*MORE)                            A                                      SFLPAG(0008)
     A                                      SFLSIZ(0009)                             A            RANG2          4S 0H      SFLRCDNBR
     A                                  2  2'Option : 1 = Choisir'                   A                                      COLOR(BLU)
     A                                  4  8'Nom de l''univers'                      A                                      COLOR(WHT)
     A                                  4  3'OPT'                                    A                                      COLOR(WHT)
```
