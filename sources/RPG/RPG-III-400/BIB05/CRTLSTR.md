---
bibliotheque: BIB05
fichier_source: QRPGSRC2
membre: CRTLSTR
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 46
modifie: 2026-11-16
---

# BIB05/QRPGSRC2/CRTLSTR

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
     * SI TU VOIS SA TU A COPIER BIB05
     FLSTSF   CF  E                    WORKSTN
     F                                        RRN   KSFILE SFL1
     FLSTKF   IF  E           K        DISK
     C*          CRUD      PLIST
     C*                    PARM           OPT     1
     C*                    PARM           NUMBER  60
     C           DEBUT     TAG
     C           *IN03     DOWEQ*OFF
     C                     SETON                     LR
     C                     Z-ADD0         RRN     40
     C                     SETON                     3233
     C                     WRITECTL1
     C                     SETOF                     32
     C           VAL6      IFEQ *BLANK
     C           *LOVAL    SETLLFMTDBX
     C                     ELSE
     C           VAL6      SETLLFMTDBX
     C                     ENDIF
     C                     READ FMTDBX                   90
     C           *IN90     DOWEQ'0'
     C                     SETOF                     32
     C                     ADD  1         RRN
     C                     MOVELDBXLIB    LIB
     C                     MOVELDBXFIL    FIL
     C                     MOVELDBXMBR    MBR
     C                     MOVELDBXTYP    TYP
     C                     MOVELDBXTXT    TXT
     C                     ADD  DBXNBL    NBL
     C                     WRITESFL1
     C                     READ FMTDBX                   90
     C                     ENDDO
     C                     SETON                         31
     C           RRN       IFGT 0
     C                     SETON                         30
     C                     SETON                         31
     C                     WRITECTL1
     C                     ENDIF
     C                     WRITEFOOTER
     C                     EXFMTCTL1
      *======================================================*
     C   05                GOTO DEBUT
     C                     ENDDO
```
