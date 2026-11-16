---
bibliotheque: BIB09
fichier_source: QSOURCES
membre: CLIENTS
type: DDS
longueur_enregistrement: 120
lignes: 11
modifie: 2026-11-16
---

# BIB09/QSOURCES/CLIENTS

```text
     A                                      UNIQUE
     A          R FCLIENTS
     A            CLINUM         7S 0       COLHDG('Numero' 'Client')
     A            CLINOM        40A         COLHDG('Nom Complet')
     A            CLIPAY        30A         COLHDG('Pays de' 'Residence')
     A            CLIFOR        15S 2       COLHDG('Fortune' 'Millions EUR')
     A            CLICAT         1A         COLHDG('Categorie')
     A                                      VALUES('P' 'D' 'G')
     A            CLIDAT          L         COLHDG('Date' 'Inscription')
     A                                      DATFMT(*ISO)
     A          K CLINUM
```
