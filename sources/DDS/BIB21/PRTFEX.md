---
bibliotheque: BIB21
fichier_source: QDDSSRC
membre: PRTFEX
type: DDS
longueur_enregistrement: 160
lignes: 20
modifie: 2026-11-16
---

# BIB21/QDDSSRC/PRTFEX

```text
                R TITRE                                                                                                 1 50'LISTE DES AGENTS'
                                        1  2'AGE001PRTF'                             A                                  1104DATE(*Y)
     A                                  1121TIME                                                R ENTETE
                                            SPACEB(001)                                                                    2'Code'
                                          21'Nom'                                    A                                    73'Prénom'
                                         105'Telephone'                                                                    2'Adresse'
     A                                      SPACEB(1)                                A                                    52'Code postal'
     A                                    77'Ville'                                             R DETAILS
                  AGCODE    R              2REFFLD(AGENT/AGCODE VANDO00001/AGEN-     A                                      T)
     A                                      SPACEB(1)                                A                                      EDTCDE(Z)
     A            AGNOM     R             21REFFLD(AGENT/AGNOM VANDO00001/AGENT)                  AGPRENOM  R             73REFFLD(AGENT/AGPRENOM VANDO00001/AG-
     A                                      ENT)                                     A            AGTEL     R            105REFFLD(AGENT/AGTEL VANDO00001/AGENT)
     A            AGADR     R              2REFFLD(AGENT/AGADR VANDO00001/AGENT)     A                                      SPACEB(1)
     A            AGPOSTAL  R             52REFFLD(AGENT/AGPOSTAL VANDO00001/AG-     A                                      ENT)
     A            AGVILLE   R             77REFFLD(AGENT/AGVILLE  VANDO00001/AG-     A                                      ENT)
                R EJECT                                                                                                     SKIPA(1)
                                          96'A SUIVRE......'                         A                                      SPACEB(1)
     A                                   124PAGNBR                                              R FIN
                                            SKIPA(1)                                                                     117'FIN.'
     A                                      SPACEB(1)                                A                                   124PAGNBR
```
