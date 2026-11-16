---
bibliotheque: BIB02
fichier_source: QCHATGPT
membre: ECRGPT
type: DDS
longueur_enregistrement: 100
lignes: 26
modifie: 2026-11-16
---

# BIB02/QCHATGPT/ECRGPT

```text
     A                                      DISPLAY
     A                                      STD 24
     A          R STUDENTR                  SFL
     A                                      SFLNXTCHG
     A            STUDID        10S 0B  3 10EDTCDE(Z)
     A            NAME          50A  O  3 20
     A            FIRSTNAME     50A  O  3 72
     A            BIRTHDATE      8A  O  4 10EDTFMT(*ISO)
     A            SEXE           1A  O  4 50
     A          R STUDENTCTL                SFLCTL(STUDENTR)
     A                                      SFLSIZ(15)
     A                                      SFLPAG(10)
     A                                      OVERLAY
     A                                      SFLDSP
     A                                      SFLDSPCTL
     A                                      SFLINZ
     A                                      SFLCLR
     A        99                            SFLDSP
     A        99                            SFLDSPCTL
     A        98                            SFLCLR
     A        80                            SFLEND(*MORE)
     A          R FOOTER
     A                                      OVERLAY
     A                                      1 73DATE
     A                                      1 80TIME
     A                                      5  2'F3=Exit   F8=Update   F4=Delete'
```
