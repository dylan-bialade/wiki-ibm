---
bibliotheque: BIALADE
fichier_source: QRPGLESRC
membre: CLIPRI
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 36
modifie: 2026-11-16
---

# BIALADE/QRPGLESRC/CLIPRI

```rpg
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
     * SI TU VOIS SA TU A COPIER BIALADE
      *=============================================================*
     FCLIENF    IF   E           K DISK
     FQPRINT    O    F  132        PRINTER
     C     *ENTRY        PLIST
     C                   PARM                    CLIDCL            6 0
     C                   EXCEPT    ENT
     C     CLIDCL        SETLL     CLIENTSF
     C                   READ      CLIENTSF                               99
     C*          *IN99     DOWEQ'0'
     C                   EXCEPT    DET
     C                   EXCEPT    DET2
     C*                    READ CLIENTSF                 99
     C*                    ENDDO
     C                   SETON                                        LR
     OQPRINT    E            ENT
     O                                            3 'ID'
     O                                           11 'NOM'
     O                                           36 'ADRESSE'
     O                                           52 'CP'
     O                                           61 'VILLE'
     O                                           80 'TEL'
     O                                           93 'SIRET'
     OQPRINT    E            DET
     O                       CLIDCL               7
     O                       CLNOCL              28
     O                       CLADCL              49
     O                       CLCPCL              55
     O                       CLVICL              76
     O                       CLTECL              87
     O                       CLSICL             102
     OQPRINT    E            DET2           2
     O                       CLMACL             101
```
