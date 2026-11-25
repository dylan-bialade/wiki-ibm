---
bibliotheque: BIB25
fichier_source: QF_PFLF
membre: COMMANDE
type: DDS
longueur_enregistrement: 80
lignes: 16
modifie: 2026-11-25
---

# BIB25/QF_PFLF/COMMANDE

```text
     A                                      UNIQUE
     A                                      REF(CLIENTS)
     A          R FCOMMANDE
     A            ID        R               COLHDG('ID COMMANDE')
     A            ID_CLI    R               COLHDG('ID CLIENTS')
     A                                      REFFLD(ID CLIENTS)
     A            DATE_CMD  R               REFFLD(DATE_A CLIENTS)
     A                                      COLHDG('DATE COMMANDE')
     A            MONTANT        6S 2       COLHDG('MONTANT COMMANDE')
     A            STATUT         8A         COLHDG('STATUT DE LA' +
     A                                      'COMMANDE')
     A                                      VALUES('en cours' 'annulée'  +
     A                                      'livrée' )
     A            CMT           25A         COLHDG('COMMENTAIRE')
     A                                      ALWNULL
     A          K ID
```
