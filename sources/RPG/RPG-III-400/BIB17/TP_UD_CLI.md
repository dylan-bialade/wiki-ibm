---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: TP_UD_CLI
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 27
modifie: 2026-11-16
---

# BIB17/QRPGSRC/TP_UD_CLI

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FCLIDL   UF  E           K        DISK                      A
     C                     SETON                     LR
     C*          00003     SETLLCLIMFT
     C           00003     CHAINCLIFMT               90
     C           *IN90     IFEQ *OFF
     C                     Z-ADD32        AGE
     C                     UPDATCLIFMT
     C                     ENDIF
     C           00004     CHAINCLIFMT               90
     C           *IN90     IFEQ *OFF
     C                     DELETCLIFMT
     C                     ENDIF
    C           *HIVAL    SETLLCLIFMT
     C                     READPCLIDL                    92
     C           *IN92     IFEQ *OFF
     C           IDCLI     ADD  1         TEMPID  50
     C                     ELSE
     C                     Z-ADD1         TEMPID
     C                     ENDIF
     C*                    MOVE IDCLI     TEMPID  50
     C*          1         ADD  TEMPID    TEMPID
     C                     CLEARCLIFMT
     C                     Z-ADDTEMPID    IDCLI
     C                     MOVE 'CIUREC'  NOMCLI
     C                     MOVE 'TEGCVS'  PRECLI
     C                     Z-ADD145       AGE
     C                     WRITECLIFMT
```
