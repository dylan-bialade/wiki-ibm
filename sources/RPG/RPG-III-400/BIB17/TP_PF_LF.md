---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: TP_PF_LF
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 10
modifie: 2026-11-16
---

# BIB17/QRPGSRC/TP_PF_LF

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FCLILF   IF  E           K        DISK
     C                     READ CLIFMT                   90
     C           *IN90     DOWEQ'0'
     C*                    MOVELNOMCLI    DSPVAR 40
     C*                    MOVE PRECLI    DSPVAR
     C           NOMCLI    CAT  PRECLI:1  DSPVAR 50
     C           DSPVAR    DSPLY
     C                     READ CLIFMT                   90
     C                     ENDDO
     C                     SETON                     LR
```
