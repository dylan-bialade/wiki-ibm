---
bibliotheque: BIALADE
fichier_source: QRPGSRC
membre: MAJIDCLI
type: RPG\RPG-III-400
longueur_enregistrement: 80
lignes: 14
modifie: 2026-11-16
---

# BIALADE/QRPGSRC/MAJIDCLI

```rpg
     FIDCFL   UF  E           K        DISK                      A
     C                     SETON                     LR
     C*          003       SETLLCLIENTS
     C*                    READ CLIENTS                  90
     C*                    MOVEL'TOTO'    PRECLI
     C*                    UPDATCLIENTS
     C*          004       SETLLCLIENTS
     C*          004       READECLIENTS                  90
     C*                    DELETCLIENTS
     C           *HIVAL    SETLLCLIENTS
     C                     READ CLIENTS                  90
     C                     MOVE 'TATA'    PRECLI
     C                     MOVE '005'     IDCLI
     C                     WRITECLIENTS
```
