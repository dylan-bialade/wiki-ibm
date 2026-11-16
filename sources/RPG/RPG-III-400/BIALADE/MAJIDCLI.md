---
bibliotheque: BIALADE
fichier_source: QRPGSRC
membre: MAJIDCLI
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 14
modifie: 2026-11-16
---

# BIALADE/QRPGSRC/MAJIDCLI

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

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
