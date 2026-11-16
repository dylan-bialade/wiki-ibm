---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: FICCLIRPG
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 173
modifie: 2026-11-16
---

# BIB17/QRPGSRC/FICCLIRPG

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FFCLIL   IF  E           K        DISK
     FCLIDSP  CF  E                    WORKSTN
     F                                        RANG  KSFILE SFL1
      *
     E                    NTFLIS  1   1 60
      *
     I           SDS
     I                                        1  10 PGM
      *
     * PROGRAMME BOUCLE PRINCIPALE
     C                     EXSR INZSF1
     C                     EXSR LODSF1
      *
     C           *IN12     DOWEQ*OFF
     C           *IN03     ANDEQ*OFF
     C                     WRITEFOOT
     C                     EXFMTCTL1
     C                     SELEC
     C           *IN12     WHEQ '1'
     C           *IN03     OREQ '1'
     C           *IN05     WHEQ '1'
     C                     MOVE '1'       MAJ
     C           *IN06     WHEQ '1'
     C                     EXSR CREATE
     *======== F6= IMPRESSION DE LA LISTE
     C           *IN15     WHEQ '1'
     C                     CALL 'CLIMPF'
     C                     EXSR SRNOTF
      *
     C                     OTHER
     C                     EXSR SFLOPT
     C           *IN70     IFEQ '1'
     C           MAJ       OREQ '1'
     C                     EXSR INZSF1
     C                     EXSR LODSF1
     C                     ENDIF
      *
     C                     ENDSL
     C                     ENDDO
      *
     C                     SETON                     LR
      *
     * SOUS ROUTINE INIT PGM
     C           *INZSR    BEGSR
     C                     MOVE PGM       NMPGM
     C                     Z-ADD*ZERO     RANG    40
     C                     MOVE '0'       MAJ     1
     C           PLCLI     PLIST
     C                     PARM           CLIDCL
     C                     MOVE *BLANK    NOTIF1
     C                     MOVE *BLANK    NOTIF2
     C                     ENDSR
      *
     *  SOUS ROUTNE INIT SF1
     C           INZSF1    BEGSR
     C                     SETOF                     313233
     C                     SETON                     30
     C                     WRITECTL1
     C                     SETOF                     30
     C                     Z-ADD*ZERO     RANG
     C*                     MOVEL*BLANK    CPRN    5
     C                     ENDSR
      *
     * SS ROUTINE CHARGEMENT SF1
     C           LODSF1    BEGSR
     C*          FLTDPT    IFNE *ZERO
     C*                    MOVELFLTDPT    CPRN
     C*          CPRN      SETLLCLIENTSF
     C*                    READ CLIENTSF                 99
     C*                    ELSE
     C**         *LOVAL    SETLLCLIENTSF
     C**                   READ CLIENTSF                 99
*    C*                    ENDIF
     C           *LOVAL    SETLLCLIENTSF
     C                     READ CLIENTSF                 99
      *
     C           *IN99     DOWEQ'0'
     C           RANG      ANDLT9999
     C                     EXSR CONVER
     C*
     C           FLTDPT    IFEQ *BLANK
     C           FLTDPT    OREQ DPT
     C                     ADD  1         RANG
     C                     WRITESFL1
     C                     ENDIF
     C                     READ CLIENTSF                 99
     C                     ENDDO
      *
     C           RANG      COMP *ZERO                32
     C                     SETON                     3133
      *
     C                     ENDSR
      *
      *
     * SOUS ROUTINE TRAITEMENT OPTION SF1
     C           SFLOPT    BEGSR
     C           *IN03     IFEQ '0'
     C                     MOVE '0'       MAJ
      *
     C                     READCSFL1                     35
     C           *IN35     DOWEQ'0'
     C           *IN03     ANDEQ'0'
     C           SF1OPT    CASEQ2         OPTMOD
     C           SF1OPT    CASEQ4         OPTDLT
     C           SF1OPT    CASEQ5         OPTAFF
     C           SF1OPT    CASEQ6         OPTIMP
     C                     ENDCS
      *
     C                     CLEARSF1OPT
     C                     UPDATSFL1
     C                     READCSFL1                     35
     C                     ENDDO
      *
      *
     C                     ENDIF
     C                     ENDSR
      *
     * SOUS ROUTINE MODIF OPTMOD
     C           OPTMOD    BEGSR
     C                     CALL 'MODBBN'  PLCLI
     C                     MOVE '1'       MAJ
     C                     ENDSR
      *
     * SOUS ROUTINE DELET OPTDLT
     C           OPTDLT    BEGSR
     C                     CALL 'DLTBBN'  PLCLI
     C                     MOVE '1'       MAJ
     C                     ENDSR
      *
     * SOUS ROUTINE AFFCI OPTAFF
     C           OPTAFF    BEGSR
     C                     CALL 'AFFBBN'  PLCLI
     C                     ENDSR
      *
     * SOUS ROUTINEIMPRESSION
     C           OPTIMP    BEGSR
     C                     CALL 'CLIDPF'  PLCLI
     C                     EXSR SRNOTF
     C                     ENDSR
      *
     * SOUS ROUTINE CREATE
     C           CREATE    BEGSR
     C           'CREATE'  DSPLY
     C                     MOVEL*BLANK    CLCPCL
     C                     CALL 'MODBBN'  PLCLI
     C                     SETOF                     06
     C                     MOVE '1'       MAJ
     C                     ENDSR
      *
     * SS ROUTINE TRANSFORMATION DE CHAMPS
     C           CONVER    BEGSR
     C                     SETOF                     25
     C                     TESTN          CLTECL     25
     C           *IN25     IFEQ *ON
     C                     MOVE CLTECL    TEL
     C                     ELSE
     C                     Z-ADD0         TEL
     C                     ENDIF
      *
     C                     MOVELCLCPCL    DPT
     C                     ENDSR
      *
     * =======SOUS ROUTINE AFFICHAGE NOTIFICATION
     C           SRNOTF    BEGSR
     C                     MOVEL*BLANK    NOTIF1
     C                     MOVEL*BLANK    NOTIF1
     C                     MOVELNTFLIS,1  NOTIF1
     C                     EXFMTNOTIF
     C                     ENDSR
      *
      *
**
IMPRESSION REUSSIE
```
