---
bibliotheque: BIB02
fichier_source: QSRC
membre: SESSIONSP
type: DDS
longueur_enregistrement: 100
lignes: 19
modifie: 2026-11-16
---

# BIB02/QSRC/SESSIONSP

```text
     A                                      UNIQUE
                R SESSIONF
     A            CODSES         5S 0
     A            CODFOR         5          COLHDG('CODE FORMATION')
     A            CODPAR         5S 0
     A            CODFMTEUR      5S 0
     A            DTDBT           L         COLHDG('DEBUT FORMATION')
     A            DTFIN           L         COLHDG('FIN FORMATION')
     A            NM            15A         COLHDG('NOM PARTICIPANT')
     A            PRN           15A         COLHDG('PRENOM PARTICIPANT')
     A            SCTE          15A         COLHDG('SOCIETE')
     A            ETAT           1A         COLHDG('ETAT PAIEMENT')
                                            VALUES('F' 'N')
     A            TPE            1A         COLHDG('TYPE FORMATION')
                                            VALUES('D' 'P')
     A            PRNFMTEUR     15A         COLHDG('FORMATEUR')

                K CODSES
                K CODPAR
```
