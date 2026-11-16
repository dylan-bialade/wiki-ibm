---
bibliotheque: BIALADE
fichier_source: QRPGLESRC
membre: BONPRI
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 64
modifie: 2026-11-16
---

# BIALADE/QRPGLESRC/BONPRI

```rpg
     A*%%***********************************************************************
     A*%%TS  RD  20261015  100138  DYLAN2      REL-V7R5M0  5770-WDS
     A*%%FI+10660100000000000000000000000000000000000000000000000000
     A*%%FI       0000000000000000000000000000000000000000000000000
     A*%%***********************************************************************
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
     * SI TU VOIS SA TU A COPIER BIALADE
     A*%%***********************************************************************
     A*%%FL 001                         bonbon        modif le:
     A*%%FL+001  =============================================================
     A*%%FL     =======
     A*%%FL+001  |
     A*%%FL           |
     A*%%FL+001  |
     A*%%FL           |
     A*%%FL+001  |
     A*%%FL           |
     A*%%FL+001  |
     A*%%FL           |
     A*%%FL+001  |
     A*%%FL           |
     A*%%FL+001  |
     A*%%FL           |
     A*%%FL+001  |
     A*%%FL           |
     A*%%FL+001  |
     A*%%FL           |
     A*%%FL+001  =============================================================
     A*%%FL     =======
     A*%%CP+999CRTPRTF
     A*%%CP+    FILE(BIALADE/BONPRI)
     A*%%CP+    DEVTYPE(*SCS)
     A*%%CP     PAGESIZE(*N       132      *N     )
     A*%%***********************************************************************
     F*PRINT  O   F     132            PRINTER
     F*ONBKNU IF  E           K        DISK
     I*BONBON
     I*             COULEUR                         COUL
     C*           *ENTRY    PLIST
     C*                     PARM           CLIDCL  60
     C*                    EXCPTENT
     C*          *LOVAL    SETLLFBONBON
     C*                    READ FBONBON                  99
     C*          *IN99     DOWEQ'0'
     C*                    EXCPTDET
     C*                    EXCPTDET2
     C*                    READ FBONBON                  99
     C*                    ENDDO
     C*                    SETON                     LR
     O*PRINT  E                ENT
     O*                                   3 'ID'
     O*                                  13 'NOM'
     O*                                  36 'marque'
     O*                                  53 'coul'
     O*                                  64 'prix'
     O*PRINT  E                DET
     O*                        NUMBER    20
     O*                        NOM       30
     O*                        MARQUE    50
     O*                        COUL      59
     O*                        PRIX      65
     O*PRINT  E  2             DET2
```
