---
bibliotheque: BIB02
fichier_source: QSRC
membre: ECRANPRTF
type: DDS
longueur_enregistrement: 100
lignes: 39
modifie: 2026-11-16
---

# BIB02/QSRC/ECRANPRTF

```text
     A          R ENTETE
     A                                      SPACEB(001)
     A                                     1'**ENTETE**'
     A
     A
     A*****************************************************************
     A          R DETAIL
     A                                      SPACEB(1)
     A            TDTDBT    R        O     2REFFLD(SESSIONF/DTDBT BIB02/SESS-
     A                                      IONSP)
     A            TDTFIN    R        O    +3REFFLD(SESSIONF/DTFIN BIB02/SESS-
     A                                      IONSP)
     A            TNM       R        O    29REFFLD(SESSIONF/NM BIB02/SESSION-
     A                                      SP)
     A            TPRN      R        O    47REFFLD(SESSIONF/PRN BIB02/SESSIO-
     A                                      NSP)
     A            TSCTE     R        O    +2REFFLD(SESSIONF/SCTE BIB02/SESSI-
     A                                      ONSP)
     A            TETAT     R        O    +1REFFLD(SESSIONF/ETAT BIB02/SESSI-
     A                                      ONSP)
     A            TTPE      R        O    87REFFLD(SESSIONF/TPE BIB02/SESSIO-
     A                                      NSP)
     A            TFORM     R        O    96REFFLD(SESSIONF/PRNFMTEUR BIB02/S-
     A                                      ESSIONSP)
     A*****************************************************************
     A          R TITRE
     A                                      SPACEB(1)
     A                                     2'Date debut'
     A                                    15'Date fin'
     A                                    29'Nom'
     A                                    47'Prénom'
     A                                    64'Société'
     A                                    80'Etat P'
     A                                    87'Type F'
     A                                    96'Formateur'
     A
     A*****************************************************************
     A          R EJECT                     SKIPA(1)
     A                                   117'À SUIVRE ... ->'
```
