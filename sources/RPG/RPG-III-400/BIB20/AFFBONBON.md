---
bibliotheque: BIB20
fichier_source: QRPGSRC
membre: AFFBONBON
type: RPG/RPG-III-400
longueur_enregistrement: 160
lignes: 12
modifie: 2026-11-16
---

# BIB20/QRPGSRC/AFFBONBON

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FEBONBON CF  E                    WORKSTN                                       FLFBONBONIF  E           K        DISK
*****************************************************************************************                  CODE           ************
******************************************************************************       C           *ENTRY    PLIST
     C                     PARM           NUMBB   60                                 C           *IN12     DOWEQ'0'
     C           *IN03     ANDEQ'0'                                                  C           NUMBB     SETLLFBONBON
     C                     READ FBONBON                  90                          C           *IN90     IFEQ '1'
     C                     LEAVE                                                     C                     ENDIF
     C                     MOVE PRIX      PRXTTC                                     C           ENVOI     PLIST
     C                     PARM           PRXTTC                                     C                     CALL 'CALCTTC' ENVOI
     C           PRXTTC    IFGT 2.50                                                 C                     SETON                         48
     C                     ENDIF                                                     C                     EXFMTBONBONF
     C                     ENDDO                                                     C                     SETON                         LR
```
