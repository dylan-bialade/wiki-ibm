---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: SSFICHIER
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 163
modifie: 2026-11-16
---

# BIB17/QRPGSRC/SSFICHIER

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FLIVNML  IF  E           K        DISK
     FLIVRESL UF  E           K        DISK
     F            LIVREF                            KRENAMELIISBNF
     FTPSF    CF  E                    WORKSTN
     F                                        RANG  KSFILE SFL1
     F                                        RANG2 KSFILE SFL2
      *
     E                    STRIN   1   5 25
      *
     C                     EXSR INZSF1
     C                     EXSR LODSF1
     C           *IN03     DOWEQ'0'
     C           ECRAN     CASEQ'1'       DSPSF1
     C                     CAS            DSPSF1
     C                     ENDCS
      *
     C                     ENDDO
     C                     SETON                     LR
      *
     * ============= SOUS ROUT INIT PGM
     C           *INZSR    BEGSR
     C                     MOVE '1'       ECRAN   1
     C                     MOVE '0'       MAJ     1
     C                     Z-ADD*ZERO     RANG    40
     C                     Z-ADD*ZERO     RANG2   40
     C                     ENDSR
      *
     *============== SOUS ROUTINE INZSF1(init sous fichier 1) =========
     C           INZSF1    BEGSR
     C                     SETOF                     303133
     C                     SETON                     32
     C                     WRITECTL1
     C                     SETOF                     32
     C                     Z-ADD*ZERO     RANG
     C                     ENDSR
      *
     * =========    SOUS ROUTINE LECTURE ======================
     C           LODSF1    BEGSR
     C           *LOVAL    SETLLLIVREF
     C                     READ LIVREF                   90
     C           *IN90     DOWEQ'0'
     C                     ADD  1         RANG
     C                     WRITESFL1
     C                     READ LIVREF                   90
     C                     ENDDO
      *
     *   ETAT DU SOUS FICHIER APRES CHARGEMENT
     C           RANG      IFGT 0
     C                     SETON                     30
     C                     ENDIF
     C                     SETON                     3331
     C                     ENDSR
      *
     * ================= SOUS ROUTINE ECRAN PRINCIPAL===============
     C           DSPSF1    BEGSR
     C                     WRITEREC1
     C                     EXFMTCTL1
      *
     C           *IN03     IFEQ '0'
     C                     MOVE '0'       MAJ
     C                     EXSR INZSF2
     C                     READCSFL1                     80
     C           *IN80     DOWEQ'0'
     C           *IN03     ANDEQ'0'
     C           E1OPT     CASEQ2         OPTMOD
     C           E1OPT     CASEQ5         OPTAFF
     C           E1OPT     CASEQ4         OPTSUP
     C                     ENDCS
      *
     * EFFACE OPTION TRAITÉE ET REECRIT LA LIGNE
     C                     CLEARE1OPT
     C                     UPDATSFL1
     C                     READCSFL1                     80
     C                     ENDDO
      *
     C           RANG2     IFGT 0
     C                     EXSR CNFSUP
     C                     ENDIF
     *  RECHARGEMENT SI CHANGEMENT DE DONNÉES
     C           MAJ       IFEQ '1'
     C                     EXSR INZSF1
     C                     EXSR LODSF1
     C                     ENDIF
      *
     C                     ENDIF
     C                     ENDSR
      *
     *=============== SOUS ROUTINE EDITER=========================
     C           OPTMOD    BEGSR
     C           ISBN      CHAINLIISBNF              91
     C           *IN91     IFEQ '0'
     C                     MOVELSTRIN,2   DAFMOD
     C                     SETOF                     50
     C                     EXFMTDSPAF
     *SI F3 OU F12 ABANDON ON FAIT RIEN SINON (F21 OU ENTREE)
     *ON UPDATE
     C                     SELEC
     C           *IN03     WHEQ '1'
     C           *IN12     OREQ '1'
     C                     OTHER
     C                     UPDATLIISBNF
     C                     MOVE '1'       MAJ
     C                     ENDSL
      *
     C                     ENDIF
     * TODO GÉRER LIVRE NON TROUV
     C                     ENDSR
      *
     *=============== SOUS ROUTINE AFFICHER ======================
     C           OPTAFF    BEGSR
     C                     SETON                     50
     C           ISBN      CHAINLIISBNF             N91
     C           *IN91     IFEQ '0'
     C                     MOVELSTRIN,1   DAFMOD
     C                     EXFMTDSPAF
     C                     ENDIF
     * TODO GÉRER LIVRE NON TROUV
     C                     ENDSR
      *
     *=============== SOUS ROUTINE ECRAN DELETE CONFIRM ==========
     C           CNFSUP    BEGSR
     C           RANG2     IFGT 0
     C                     SETON                     40
     C                     ENDIF
     C                     SETON                     4143
      *
     C                     WRITEREC1
     C                     EXFMTCTL2
      *
     C           *IN03     IFEQ '0'
     C           *IN12     ANDEQ'0'
      *
      * copie de rang dans nbsup pour fixer sa longueyr
     C                     Z-ADDRANG2     NBSUP   40
     C           1         DO   NBSUP     IDX     40
     C           IDX       CHAINSFL2                 45
     C           *IN45     IFEQ '0'
     C           ISBN      CHAINLIISBNF              46
     C  N46                DELETLIISBNF
     C  N46                MOVE '1'       MAJ
     C                     ENDIF
     C                     ENDDO
     C                     ENDIF
     C                     ENDSR
      *
     *============== SOUS ROUTINE INIT SF2 ==================
     C           INZSF2    BEGSR
     C                     SETOF                     404143
     C                     SETON                     42
     C                     WRITECTL2
     C                     SETOF                     42
     C                     Z-ADD*ZERO     RANG2
     C                     ENDSR
      *
     *=============== SOUS ROUTINE DELETE=========================
     C           OPTSUP    BEGSR
     C                     ADD  1         RANG2
     C                     WRITESFL2
     C                     ENDSR
      *
**
DETAILS
MODIFICATIONS
```
