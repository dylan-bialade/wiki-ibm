---
bibliotheque: BIB01
fichier_source: QRPGSRC
membre: PCODPOS
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 21
modifie: 2026-11-16
---

# BIB01/QRPGSRC/PCODPOS

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FECODPOS CF  E                    WORKSTN
     F                                        RANG  KSFILE WSFL
     FCODPOSL1IF  E           K        DISK
     C                     SETON                     LR
     C           1         DOWEQ1
     C                     Z-ADD*ZERO     RANG
     C                     SETON                     60
     C                     WRITEWCTL
     C                     SETOF                     60
     C           WFLT      SETLLFCODPO
     C                     READ FCODPO                   99
     C           *IN99     DOWEQ'0'
     C           RANG      ANDLT9999
     C                     ADD  1         RANG    40
     C                     WRITEWSFL
     C                     READ FCODPO                   99
     C                     ENDDO
     C                     SETON                     61
     C                     EXFMTWCTL
     C   KC                LEAVE
     C                     ENDDO
```
