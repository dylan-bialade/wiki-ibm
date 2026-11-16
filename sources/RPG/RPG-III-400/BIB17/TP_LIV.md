---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: TP_LIV
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 79
modifie: 2026-11-16
---

# BIB17/QRPGSRC/TP_LIV

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FLIVRESL UF  E           K        DISK                      A
     FLIVDSP  CF  E                    WORKSTN
     *=======  BOUCLE AFFICHAGE ===========================
     C           *IN03     DOWEQ'0'
     C                     EXFMTLIVF1
     * ============= SI F6 ON ENTRE EN MODE CREATION
     C           *IN06     IFEQ '1'
     C                     EXSR SUBCR
     C                     ELSE
     *-----------------------------------------
     C           D1ISBN    CHAINLIVREF               90
    C*          TITRE     DSPLY
     C           *IN90     IFEQ '0'
     C           D1OPT     CASEQ'A'       SUBAF
     C           D1OPT     CASEQ'M'       SUBUP
     C           D1OPT     CASEQ'D'       SUBDL
     C                     CAS            SUBER
     C                     ENDCS
     C                     ELSE
     C                     SETON                         98
     C*                    EXFMTLIVF1
     C                     ENDIF
     C                     ENDIF
     C                     ENDDO
     C                     SETON                     LR
     *-------   SOUS PROGRAMME AFFICHAGE --------------------
     C           SUBAF     BEGSR
     C                     SETON                         30
     C                     EXFMTLIVF2
     C           *IN12     IFEQ '0'
     C           *IN03     ANDEQ'0'
     C           *IN23     IFEQ '1'
     C                     EXSR SUBDL
     C                     ELSE
     C                     MOVE 'M'       D1OPT
     C                     EXSR SUBUP
     C                     ENDIF
     C                     ENDIF
     C                     ENDSR
     *  ----------- SOUS PROGRAMME UPDATE -------------------
     C           SUBUP     BEGSR
     C                     SETOF                         30
     C                     EXFMTLIVF2
     C           *IN12     IFEQ '0'
     C           *IN03     ANDEQ'0'
     C           *IN23     IFEQ '1'
     C                     EXSR SUBDL
     C                     ELSE
     C                     UPDATLIVREF
     C                     ENDIF
     C                     ENDIF
     C                     ENDSR
     * ------------- SOUS PROGRAMME DELETE ------------------
     C           SUBDL     BEGSR
     C                     SETON                     30
     C                     SETON                     50
     C                     EXFMTLIVF2
     C                     SETOF                     50
     C           *IN23     IFEQ '1'
     C                     DELETLIVREF
     C                     ENDIF
     C                     ENDSR
     * -------------- SOUS PROGRAMME CREATION ---------------
     C           SUBCR     BEGSR
     C                     SETOF                         30
     C                     EXFMTLIVF2
     C                     Z-ADD*ZERO     ISBN
     C                     MOVEL*BLANK    TITRE
     C                     MOVEL*BLANK    AUTEUR
     C                     MOVEL*BLANK    DISPO
     C           *IN12     IFEQ '0'
     C           *IN03     ANDEQ'0'
     C                     WRITELIVREF
     C                     ENDIF
     C                     ENDSR
     *-------------- SOUS SYSTEME ERREUR OPT -----------------
     C           SUBER     BEGSR
     C                     SETON                         99
     C                     ENDSR
```
