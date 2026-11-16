---
bibliotheque: BIB10
fichier_source: QRPGSRC
membre: SSLIVREPG
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 133
modifie: 2026-11-16
---

# BIB10/QRPGSRC/SSLIVREPG

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      *=================================================*
      *              MON PREMIER RPG                  *
      * CONCATENATION DE STRING ET PYSPLAY SUR MESSAGE*
      *=================================================*
      *
     FSSLIVRE CF  E                    WORKSTN
     F                                        RANK  KSFILE SFL1
     FLIVRELN UF  E           K        DISK
     E                    MOD     1   4 50
     E                    ACT     1   2 70
     C                     SETON                         LR
     C* INIT SFL
     C           *IN03     DOWEQ*OFF
     C                     EXSR CHARGE
     C                     WRITEFOOT
     C                     EXFMTCTL1
     C   03                LEAVE
     C   05                MOVEL*BLANKS   E1AFF
     C   05                MOVEL*BLANKS   LIDX
     C   05                ITER
     C                     READCSFL1                     91
     C           *IN91     DOWEQ*OFF
     C           E1OPT     CASEQ'2'       SBRMOD
     C           E1OPT     CASEQ'4'       SBRDLT
     C           E1OPT     CASEQ'5'       SBRDSP
     C                     ENDCS
     C                     READCSFL1                     91
     C                     ENDDO
     C                     SETOF                         91
     C                     MOVE *BLANKS   E1OPT
     C                     ENDDO
     C*
     C*
     C*
     C*
     C           INIT      BEGSR
     C                     SETON                         32
     C                     WRITECTL1
     C                     SETOF                         32
     C                     Z-ADD*ZEROS    RANK    40
     C                     ENDSR
     C*
     C           CHARGE    BEGSR
     C                     EXSR INIT
     C           E1AFF     IFNE *BLANKS
     C                     MOVELE1AFF     LIDX   30
     C           LIDX      SETLLLIVREF
     C                     ELSE
     C           *LOVAL    SETLLLIVREF
     C                     ENDIF
     C                     READ LIVREF                   90
     C           *IN90     DOWEQ*OFF
     C                     ADD  1         RANK
     C                     MOVE ISBN      E1ISBN
     C                     MOVELTITRE     E1TIT
     C                     MOVELAUTEUR    E1AUT
     C                     MOVELDISPO     E1DSP
     C                     WRITESFL1
     C                     READ LIVREF                   90
     C                     ENDDO
     C           RANK      IFNE 0
     C                     SETON                     333031
     C                     ELSE
     C                     SETON                     3331
     C                     ENDIF
     C                     WRITECTL1
     C                     SETOF                     333031
     C                     ENDSR
     C*
     C           SBRDSP    BEGSR
     C                     SETON                         42
     C                     MOVELMOD,1     E2MOD
     C                     MOVELACT,1     E2ACT
     C                     MOVE E1ISBN    E2ISBN
     C                     MOVELE1AUT     E2AUT
     C                     MOVELE1TIT     E2TIT
     C                     MOVELE1DSP     E2DSP
     C                     EXFMTFMT2
     C                     SETOF                         42
     C                     ENDSR
     C           SBRMOD    BEGSR
     C                     SETOF                         42
     C                     MOVELMOD,2     E2MOD
     C                     MOVELACT,2     E2ACT
     C                     MOVELE1AUT     E2AUT
     C                     MOVELE1TIT     E2TIT
     C                     MOVELE1DSP     E2DSP
     C           1         DOWEQ1
     C                     EXFMTFMT2
     C   03                LEAVE
     C   12                LEAVE
     C           *IN23     IFEQ *ON
     C           E1TIT     CHAINLIVREF               93
     C                     MOVE *BLANK    AUTEUR
     C                     MOVE *BLANK    TITRE
     C                     MOVE *BLANK    DISPO
     C                     MOVELE2AUT     AUTEUR
     C                     MOVELE2TIT     TITRE
     C                     MOVELE2DSP     DISPO
     C                     UPDATLIVREF
     C                     LEAVE
     C                     ENDIF
     C                     ENDDO
     C                     SETOF                     122393
     C                     ENDSR
     C           SBRDLT    BEGSR
     C                     SETON                         42
     C                     MOVELMOD,4     E2MOD
     C                     MOVELACT,2     E2ACT
     C                     MOVE E1ISBN    E2ISBN
     C                     MOVELE1AUT     E2AUT
     C                     MOVELE1TIT     E2TIT
     C                     MOVELE1DSP     E2DSP
     C           1         DOWEQ1
     C                     EXFMTFMT2
     C   03                LEAVE
     C   12                LEAVE
     C           *IN23     IFEQ *ON
     C           E1TIT     CHAINLIVREF               93
     C                     DELETLIVREF
     C                     LEAVE
     C                     ENDIF
     C                     ENDDO
     C                     SETOF                     129323
     C                     ENDSR
**
Affichage d'un LIVRE
Modification d'un LIVRE
Création d'un soldat
SUPPRESSION D'UN LIVRE
**
F3=Exit  F12=Retour
F3=Exit  F12=Retour  F23=Validation
```
