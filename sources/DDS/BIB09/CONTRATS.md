---
bibliotheque: BIB09
fichier_source: QSOURCES
membre: CONTRATS
type: DDS
longueur_enregistrement: 120
lignes: 11
modifie: 2026-11-16
---

# BIB09/QSOURCES/CONTRATS

```text
     A          R FCONTRATS
     A            CTRCOD        10A         COLHDG('Code' 'Contrat')
     A            CTRCLI         7S 0       COLHDG('Numero' 'Client')
     A            CTRTYP         3A         COLHDG('Type' 'Contrat')
     A                                      VALUES('YAC' 'JET' 'ART' 'IMM')
     A            CTRDSC        50A         COLHDG('Description' 'Bien Assure')
     A            CTRVAL        15S 2       COLHDG('Valeur' 'Millions EUR')
     A            CTRSTT         1A         COLHDG('Statut')
     A                                      VALUES('A' 'S' 'R')
     A            CTRDAT          L         COLHDG('Date' 'Souscription')
     A                                      DATFMT(*ISO)
```
