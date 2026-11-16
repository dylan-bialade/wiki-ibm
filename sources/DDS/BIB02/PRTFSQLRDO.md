---
bibliotheque: BIB02
fichier_source: QSFSRC
membre: PRTFSQLRDO
type: DDS
longueur_enregistrement: 100
lignes: 27
modifie: 2026-11-16
---

# BIB02/QSFSRC/PRTFSQLRDO

```text
     A          R ENTETE
     A                                      SPACEB(001)
     A                                     1'**ENTETE**'
     A
     A
     A*****************************************************************
     A          R DETAIL
     A                                      SPACEB(1)
     A            TCODPRO   R        O     2REFFLD(ENTREPOTF/CODPRO BIB02/ENTR-
     A                                      EPOT)
     A            TNMPRO    R        O   +13REFFLD(ENTREPOTF/NMPRO BIB02/ENTRE-
     A                                      POT)
     A            TQTPRO    R        O    55REFFLD(ENTREPOTF/QTPRO BIB02/ENTRE-
     A                                      POT)
     A            TDTDINV   R        O    +8REFFLD(ENTREPOTF/DTDINV BIB02/ENTR-
     A                                      EPOT)
     A*****************************************************************
     A          R TITRE
     A                                     2'Code produit'
     A                                      SPACEB(1)
     A                                    20'Nom produit'
     A                                    55'Qt produit'
     A                                    66'Date'
     A
     A*****************************************************************
     A          R EJECT                     SKIPA(1)
     A                                   117'À SUIVRE ... ->'
```
