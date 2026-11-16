---
bibliotheque: BIB02
fichier_source: QSRC
membre: ECRANPRTFP
type: DDS
longueur_enregistrement: 100
lignes: 32
modifie: 2026-11-16
---

# BIB02/QSRC/ECRANPRTFP

```text
     A          R ENTETE
     A                                      SPACEB(001)
     A                                     1'**ENTETE**'
     A
     A
     A*****************************************************************
     A          R DETAIL
     A                                      SPACEB(1)
     A            TCODPAR   R        O     1REFFLD(PARTICIPAF/CODPAR +
     A                                      BIB02/PARTICIPA)
     A            TNM       R        O    20REFFLD(PARTICIPAF/NM BIB02/PARTICI-
     A                                      PA)
     A            TPRN      R        O    40REFFLD(PARTICIPAF/PRN BIB02/PARTIC-
     A                                      IPA)
     A            TSCTE     R             60REFFLD(PARTICIPAF/SCTE BIB02/PARTI-
     A                                      CIPA)
     A            TADR      R        O    83REFFLD(PARTICIPAF/ADR BIB02/PARTIC-
     A                                      IPA)
     A            TNUM      R        O   116REFFLD(PARTICIPAF/NUMTEL +
     A                                      BIB02/PARTICIPA)
     A*****************************************************************
     A          R TITRE
     A                                      SPACEB(1)
     A                                     1'Code Participant'
     A                                    20'Nom'
     A                                    40'Prénom'
     A                                    60'Société'
     A                                    82'Adresse Mail'
     A                                   116'N° Téléphone'
     A*****************************************************************
     A          R EJECT                     SKIPA(1)
     A                                   117'À SUIVRE ... ->'
```
