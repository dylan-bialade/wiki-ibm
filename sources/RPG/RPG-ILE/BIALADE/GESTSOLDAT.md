---
bibliotheque: BIALADE
fichier_source: QRPGLESRC
membre: GESTSOLDAT
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 86
modifie: 2026-11-16
---

# BIALADE/QRPGLESRC/GESTSOLDAT

```rpg
      *NOMPGM:GESTIONAIRE LIVRE
      *NOMPROP:BIALADE
      *FILLEDEPEND:SODLAT(DTA) SOLDATDS(ECRAN)
     * SI TU VOIS SA TU A COPIER BIALADE
      *============================================================
     FSOLDATDS  CF   E             WORKSTN
     FSOLDAT    UF A E           K DISK
     C     DEBUT         TAG
     C                   EXFMT     FMT1
     C                   SETOFF                                       12        OFF RETOUR
     C     IDSLD         SETLL     SOLDATR
      * BOUCLE EXIT
     C     *IN03         DOWEQ     *OFF                                         EXIT
      *SI 12 RETOUR ECRAN AVANT
     C     *IN12         IFEQ      *ON                                          RETURN
     C                   GOTO      DEBUT
     C                   EXFMT     FMT1
     C                   ENDIF
     C     *IN90         IFEQ      *OFF
      *DEBUT MODIF
     C     *IN02         IFEQ      *ON
     C     *IN07         DOWEQ     *OFF
     C                   MOVE      'MODIF'       MSG
     C     IDSLD         CHAIN     SOLDATR                            90
     C                   EXFMT     FMT2
     C                   MOVEL     NOM           NMSLD
     C                   MOVEL     PRENOM        PRSLD
     C                   MOVEL     ARME          ARSLD1
     C                   MOVEL     CLASSE        CLASLD
     C   07              UPDATE    SOLDATR
     C   03              LEAVE
     C   12              LEAVE
     C                   ENDDO
     C                   SETOFF                                       07
     C                   ENDIF
      *DEBUT SUPP
     C     *IN23         IFEQ      *ON
     C     *IN07         DOWEQ     *OFF
     C                   MOVE      'DELETE'      MSG
     C                   EXFMT     FMT2
     C     IDSLD         CHAIN     SOLDATR                            90
     C                   EXFMT     FMT2
     C   07              DELETE    SOLDATR
     C   03              LEAVE
     C   12              LEAVE
     C                   ENDDO
     C                   SETOFF                                       07
     C                   ENDIF
      *DEBUT CRÉATION
     C     *IN06         IFEQ      *ON
     C     *IN07         DOWEQ     *OFF
     C                   MOVE      'CREATE'      MSG
     C     *HIVAL        CHAIN     SOLDATR                            90
     C                   ADD       1             IDSLD
     C                   MOVEL     *BLANK        NOM
     C                   MOVEL     *BLANK        PRENOM
     C                   MOVEL     *BLANK        ARME
     C                   MOVEL     *BLANK        CLASSE
     C                   EXFMT     FMT2
     C                   MOVEL     NOM           NMSLD
     C                   MOVEL     PRENOM        PRSLD
     C                   MOVEL     ARME          ARSLD1
     C                   MOVEL     CLASSE        CLASLD
     C                   EXFMT     FMT2
     C   07              WRITE     SOLDATR
     C   03              LEAVE
     C   12              LEAVE
     C                   ENDDO
     C                   SETOFF                                       07
     C                   ENDIF
      *AFFICHAGE SIMPLE
     C  N23
     CANN06
     CANN02              MOVE      'PRINT'       MSG
     C     IDSLD         CHAIN     SOLDATR                            90
     C                   MOVEL     NMSLD         NOM
     C                   MOVEL     PRSLD         PRENOM
     C                   MOVEL     ARSLD1        ARME
     C                   MOVEL     CLASLD        CLASSE
     C                   EXFMT     FMT2
      *DEBUT SI ERR
     C*                    GOTO DEBUT
     C                   ENDIF
     C                   EXFMT     FMT2
     C                   ENDDO
     C                   SETON                                        LR
```
