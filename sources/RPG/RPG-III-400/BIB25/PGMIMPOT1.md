---
bibliotheque: BIB25
fichier_source: QRPGSRC
membre: PGMIMPOT1
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 20
modifie: 2026-11-25
---

# BIB25/QRPGSRC/PGMIMPOT1

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FIMPOECR CF  E                    WORKSTN
     FIMPOT   IF  E           K        DISK
     FPARTS   IF  E           K        DISK
     F*ESTR   IF  E                    DISK
     C                     SETON                     LR
     C           *IN03     DOWEQ'0'
     C                     EXFMTFIMPOE1
     C           NBENF     CHAINPARTSF               40
     C           CHOIX     IFEQ 1
     C                     Z-ADDMARIE     NBPART  32
     C                     ENDIF
     C           CHOIX     IFEQ 2
     C                     Z-ADDCELIB     NBPART
     C                     ENDIF
     C           REVENU    DIV  NBPART    RESU1   92
     C                     Z-ADD10064     RESU1
     C           RESU1     SETGTIMPOTF               41
     C   41                READPIMPOTF                   45
     C           FB        DSPLY
     C                     ENDDO
```
