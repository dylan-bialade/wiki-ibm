---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: TP_SOLDAT
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 174
modifie: 2026-11-16
---

# BIB17/QRPGSRC/TP_SOLDAT

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FSOLDAT  UF  E           K        DISK                      A
     FSOLDSP  CF  E                    WORKSTN
     E                    MSG     1  16 50
     E                    CLS     1   6 20
     I           SDS
     I                                        1  10 PGM
      *
     * -------  BOUCLE AFFICHAGE ECR 1-----------------
     C           *IN03     DOWEQ'0'
     C                     MOVE PGM       NMPGM
     C*                    SETOF                     70
     C                     EXFMTSOLF1
     C*                    SETOF                     70
     *         SI F6 AFFICHAGE CREATION
     C           *IN06     IFEQ '1'
     C                     EXSR SUBCR
     C                     ELSE
    C*---------------------------------------------------
     C           D1IDS     CHAINSOLDATR             N90
     C           *IN90     IFEQ '0'
    C*          NMSLD     DSPLY
     C                     EXSR SUBAF
      *
     C                     ELSE
     C                     MOVELMSG,1     D1ERMS
     C                     SETON                     70
     C*                    EXFMTSOLF1
     C                     ENDIF
     C                     ENDIF
     C                     ENDDO
     C                     SETON                     LR
      *
     * ============ SOUS ROUTINE CREATION ========================
     C           SUBCR     BEGSR
      *
     * ----------------- RECUP ID ------------------
     C                     Z-ADD1         TEMPID  50
     C           *HIVAL    SETLLSOLDATR
     C                     READPSOLDATR             N    91
     C           *IN91     IFEQ '0'
     C                     MOVE IDSLD     TEMPID
     C                     ADD  1         TEMPID
     C                     ENDIF
     * -----------------FIN RECUP ID----------------
      *
     C                     SETOF                     708091
     C                     MOVELMSG,5     D3MOD
     C                     MOVELMSG,6     D3INS
     C                     MOVEL*BLANK    NMSLD
     C                     MOVEL*BLANK    PRSLD
     C                     MOVEL*BLANK    ARSLD1
     C                     MOVEL*BLANK    CLASLD
     C                     MOVE '0'       FIN3    1
      *
     C           FIN3      DOWEQ'0'
     C                     EXFMTSOLF3
     C                     SETOF                     80
     C*  --- F3 ou F12 : on sort sans rien faire
     C           *IN12     IFEQ '1'
     C           *IN03     OREQ '1'
     C                     MOVE '1'       FIN3
     C                     ELSE
     C*  --- F23 : on vérifie la classe
     C           *IN23     IFEQ '1'
     C                     EXSR SUBVC
     C*  ------ classe OK : écriture et sortie
     C           *IN50     IFEQ '1'
     C                     Z-ADDTEMPID    IDSLD
     C                     WRITESOLDATR
     C                     SETON                     70
     C                     MOVELMSG,8     D1ERMS
     C                     MOVE '1'       FIN3
     C                     ELSE
     C*  ------ classe KO : message, FIN3 reste à '0' -> réaffichage
     C                     SETON                     80
     C                     MOVELMSG,2     D3ERMS
     C                     ENDIF
     C                     ENDIF
     C                     ENDIF
     C                     ENDDO
     C                     ENDSR
      *
     * ============ SOUS ROUTINE AFFICHAGE========================
     C           SUBAF     BEGSR
     C                     SETOF                     12
     C           *IN12     DOWEQ'0'
     C           *IN03     ANDEQ'0'
     C                     SETOF                     70
     C                     EXFMTSOLF2
     C           *IN12     IFEQ '0'
      *
     C           *IN02     IFEQ '1'
     C                     EXSR SUBUP
     C                     SETOF                     12
     C                     ENDIF
      *
     C           *IN07     IFEQ '1'
     C                     EXSR SUBDL
     C                     SETON                     12
     C                     ENDIF
     C*
     C                     ENDIF
     C                     ENDDO
      *
     C                     ENDSR
      *
     * ============ SOUS ROUTINE MODIFICATION ====================
     C           SUBUP     BEGSR
     C                     SETOF                     7080
     C           IDSLD     CHAINSOLDATR              90
     C           *IN90     IFEQ '0'
     C                     MOVE '0'       FIN3
     C*
     C                     MOVELMSG,4     D3INS
     C                     MOVELMSG,3     D3MOD
     C           FIN3      DOWEQ'0'
     C                     EXFMTSOLF3
     C                     SETOF                     80
     C*  --- F3 ou F12 : on sort sans rien faire
     C           *IN12     IFEQ '1'
     C           *IN03     OREQ '1'
     C                     MOVE '1'       FIN3
     C                     ELSE
     C*  --- F23 : on vérifie la classe
     C           *IN23     IFEQ '1'
     C                     EXSR SUBVC
     C*  ------ classe OK : écriture et sortie
     C           *IN50     IFEQ '1'
     C                     UPDATSOLDATR
     C                     SETON                     70
     C                     MOVELMSG,9     D1ERMS
     C                     MOVE '1'       FIN3
     C                     ELSE
     C*  ------ classe KO : message, FIN3 reste à '0' -> réaffichage
     C                     SETON                     80
     C                     MOVELMSG,2     D3ERMS
     C                     ENDIF
     C                     ENDIF
     C                     ENDIF
     C                     ENDDO
     C                     ENDIF
     C                     ENDSR
     * ============ SOUS ROUTINE DELETE       ====================
     C           SUBDL     BEGSR
     C                     SETOF                     70
     C           IDSLD     CHAINSOLDATR              90
     C           *IN90     IFEQ '0'
     C                     DELETSOLDATR
     C                     SETON                     70
     C                     MOVELMSG,7     D1ERMS
     C                     ENDIF
     C                     ENDSR
      *
     * ============ SOUS ROUTINE VERIF CLASS  ====================
     C           SUBVC     BEGSR
     C           CLASLD    LOKUPCLS                      50
     C                     ENDSR
**
Numero de soldat inconnu
Classe invalide
Modification d'un soldat
Modifier les données d'un soldat, puis appuyez sur f23
Création d'un soldat
Ajouter les données d'un soldat, puis appuyez sur f23
Soldat supprimé
Soldat ajouté
Soldat modifié
**
SOLDAT
ADEPTE
PORTE ETENDARD
FRANC TIREUR
SENTINELLE
INGENIEUR
```
