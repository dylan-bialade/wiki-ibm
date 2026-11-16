---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: AFFBIER
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 161
modifie: 2026-11-16
---

# BIB17/QRPGSRC/AFFBIER

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
    H*================================================================
    H* PROGRAMME   : <AFFBIER>
    H* AUTEUR      : <remy BIB16>
    H* DATE        : 18/10/2026
    H*----------------------------------------------------------------
    H* OBJET       : Creation et modification d'un produit (biere).
    H*               Calcul du prix TTC et alerte si le stock est
    H*               inferieur au stock minimum.
    H*----------------------------------------------------------------
    H* APPELE PAR  : BIERERPG
    H* PARAMETRE   : PRIDPR (6,0) identifiant produit
    H*                 = 0  : creation (ID attribue automatiquement)
    H*                 > 0  : modification du produit
    H*----------------------------------------------------------------
    H* FICHIERS    : BIERE  (UF/A) produits
    H*               BEERD  (CF)   ecran FMT1
    H*----------------------------------------------------------------
    H* INDICATEURS : 03 F3 quitter      12 F12 retour   21 F21 impr.
    H*               40 a 45 erreurs de zone      49 erreur globale
    H*               75 zones input protected
    H*               70 zone de calcul modifiee (CHANGE)
    H*               79 alerte stock          98 READP   99 CHAIN
    H*================================================================
     *
     FBIERE   UF  E           K        DISK                      A
     FBEERD   CF  E                    WORKSTN
      *
     E                    STMOD   1   3 25
      *
     IBEERF
     I              TXTVAPR                         TXTVA
     IFMT1
     I              TXTVAPR                         TXTVA
      *
     C           *ENTRY    PLIST
     C                     PARM           PRIDPR
      *
    C*  ==== PREPARATION SELON LE MODE ====
     C           PRIDPR    IFEQ *ZERO
     C                     EXSR INICRT
     C                     ELSE
     C                     EXSR INIMOD
     C                     ENDIF
     C                     EXSR CALCUL
      *
    C*  ==== BOUCLE COMMUNE ====
     C           *IN99     DOWEQ'0'
     C           *IN03     ANDEQ'0'
     C           *IN12     ANDEQ'0'
     C                     EXFMTFMT1
     C                     SELEC
    C*  F3 / F12 : la condition du DOW fait sortir
     C           *IN03     WHEQ '1'
     C           *IN12     OREQ '1'
    C*  F21 : impression (a faire)
     C           *IN21     WHEQ '1'
    C*  Entree
     C                     OTHER
     C                     EXSR CALCUL
    C*    zone de calcul modifiee (70) : on reaffiche le nouveau TTC
    C*    sinon : controles puis enregistrement
     C           *IN70     IFEQ '0'
     C                     EXSR CONTRL
     C           *IN49     IFEQ '0'
     C                     EXSR ENREG
     C                     LEAVE
     C                     ENDIF
     C                     ENDIF
     C                     ENDSL
     C                     ENDDO
      *
     C                     SETON                     LR
      *
     * ====== PREPARATION CREATION =============
    C*  nouvel ID AVANT de vider les zones : le READP recharge BEERF
     C           INICRT    BEGSR
     C                     MOVE 'C'       MDOPT   1
     C                     MOVELSTMOD,3   MODE
     C                     Z-ADD1         TEMPID  60
     C           *HIVAL    SETLLBEERF
     C                     READPBEERF               N    98
     C           *IN98     IFEQ '0'
     C           PRIDPR    ADD  1         TEMPID
     C                     ENDIF
     C                     Z-ADDTEMPID    PRIDPR
     C                     MOVE *BLANK    PRNOPR
     C                     MOVE *BLANK    PRREPR
     C                     Z-ADD0         TXTVA
     C                     Z-ADD0         PRSTPR
     C                     Z-ADD0         STMIPR
     C                     Z-ADD0         PRUNVE
    C*  pas de CHAIN : on force l'entree dans la boucle
     C                     SETOF                     99
     C                     ENDSR
      *
     * ====== PREPARATION MODIFICATION =========
     C           INIMOD    BEGSR
     C                     MOVE 'M'       MDOPT
     C                     MOVELSTMOD,1   MODE
     C           PRIDPR    CHAINBEERF                99
     C                     ENDSR
      *
     * ====== CALCULS AFFICHES : TTC ET ALERTE STOCK ======
     C           CALCUL    BEGSR
     C           PRUNVE    MULT TXTVA     WTVA   104
     C           WTVA      DIV  100       WTVA
     * OPTION H POUR ARRONDIR
     C           PRUNVE    ADD  WTVA      PUTTC     H
     C           PRSTPR    IFLT STMIPR
     C                     SETON                     79
     C                     ELSE
     C                     SETOF                     79
     C                     ENDIF
     C                     ENDSR
      *
     * ====== CONTROLES DE SAISIE ===============
    C*  un bloc par zone : test, puis indicateur de la zone + 49
     C           CONTRL    BEGSR
     C                     SETOF                     404142
     C                     SETOF                     434445
     C                     SETOF                     49
     *Controle de la reference : 40
     C           PRREPR    IFEQ *BLANK
     C                     SETON                     4049
     C                     ENDIF
     * Controle du nom du produit : 41
     C           PRNOPR    IFEQ *BLANK
     C                     SETON                     4149
     C                     ENDIF
     *Controle du stock:42
     C           PRSTPR    IFLT *ZERO
     C                     SETON                     4249
     C                     ENDIF
     *Controle du stock mini :43
     C           STMIPR    IFLT *ZERO
     C                     SETON                     4349
     C                     ENDIF
     *Controle du prix unitaire :44
     C           PRUNVE    IFLE *ZERO
     C                     SETON                     4449
     C                     ENDIF
     *Controle du taux tva :45
     C           TXTVA     IFLT *ZERO
     C                     SETON                     4549
     C                     ENDIF
      *
     C                     ENDSR
      *
     * ====== ENREGISTREMENT =====================
     C           ENREG     BEGSR
     C           MDOPT     IFEQ 'C'
     C                     WRITEBEERF
     C                     ELSE
     C                     UPDATBEERF
     C                     ENDIF
     C                     ENDSR
      *
**
......MODIFICATION.......
........AFFICHAGE........
.........CREATION........
```
