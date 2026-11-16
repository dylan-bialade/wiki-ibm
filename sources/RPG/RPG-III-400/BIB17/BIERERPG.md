---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: BIERERPG
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 208
modifie: 2026-11-16
---

# BIB17/QRPGSRC/BIERERPG

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     H*================================================================
     H* OBJET       : Gestion des bieres - liste en sous-fichier.
     H*               Positionnement sur la reference, alerte si le
     H*               stock est inferieur au stock minimum.
     H*----------------------------------------------------------------
     H* OPTIONS     : 2 = modifier      4 = supprimer
     H*                     6 = imprimer
     H* TOUCHES     : F3 quitter        F5 rafraichir    F6 creer
     H*               F8 WRKSPLF        F9 DLTSPLF
     H*               F24 export CSV
     H*----------------------------------------------------------------
     H* FICHIERS    : BIERL   (IF)  logique des bieres
     H*               BIERED  (CF)  ecran SFL1 / CTL1 / FOOT
     H* APPELS      : AFFBIER   creation / modification (PRIDPR)
     H*                  suppression, affichage, impression
     H*               EXPCSVPF  export CSV (nom du fichier)
     H*               QCMDEXC   execution de commande
     H*----------------------------------------------------------------
     H* INDICATEURS : 03 05 06 08 09 24  touches de fonction
     H*               30 SFLCLR  31 SFLDSPCTL  32 SFLDSP  33 SFLEND
     H*               35 fin READC     40 etat du stock (ligne)
     H*               70 positionnement modifie (CHANGE)
     H*               98 erreur d'appel          99 fin de lecture
     H*================================================================
      *
     FBIERL   IF  E           K        DISK
     FBIERED  CF  E                    WORKSTN
     F                                        RANG  KSFILE SFL1
      *
     E                    CMD     1   2 50
      *
     IBEERF
     I              TXTVAPR                         TXTVA
     ISFL1
     I              TXTVAPR                         TXTVA
     I           SDS
     I                                        1  10 PGM
      *
     * PROGRAMME BOUCLE PRINCIPALE
     C                     EXSR INZSF1
     C                     EXSR LODSF1
      *
     C           *IN03     DOWEQ*OFF
     C                     WRITEFOOT
     C                     EXFMTCTL1
     C                     MOVE '0'       MAJ
      *
     *  TRAITEMENT DES TOUCHES DE FONCTION
     C                     SELEC
     C           *IN03     WHEQ '1'
     C           *IN05     WHEQ '1'
     C                     MOVE '1'       MAJ
     C           *IN06     WHEQ '1'
     C                     EXSR CREATE
      *
     *==== F8 COMMANDE WRKSPLF ================
     C           *IN08     WHEQ '1'
     C                     MOVEL*BLANK    WCMD
     C                     MOVELCMD,1     WCMD
     C                     EXSR EXECMD
      *
     *======F9 COMMANDE DLTSPLF==============================
     C           *IN09     WHEQ '1'
     C                     MOVEL*BLANK    WCMD
     C                     MOVELCMD,2     WCMD
     C                     EXSR EXECMD
      *
    *========F24 EXPORT EN CSV ==============================
     C           *IN24     WHEQ '1'
     C                     MOVEL*BLANK    FICEXP 10
     C                     MOVEL'BIERE'   FICEXP
     C                     CALL 'EXPCSVPF'
     C                     PARM           FICEXP
      *
     * SI AUCUNE DE CES FONCTIONS APPUYÉES
     C                     OTHER
     C                     EXSR SROPT
      *
     C                     ENDSL
      *
     * SI MAJ OU 70(INDICATEUR CHANGE SUR FILTRE) ON REAFFICHE)
     C           *IN70     IFEQ '1'
     C           MAJ       OREQ '1'
     C                     EXSR INZSF1
     C                     EXSR LODSF1
     C                     ENDIF
     C                     ENDDO
      *
     C                     SETON                     LR
      *
     * SOUS ROUTINE INIT PGM
     C           *INZSR    BEGSR
     C                     MOVE PGM       NMPGM
     C                     Z-ADD*ZERO     RANG    40
     C                     MOVE '0'       MAJ     1
     C                     MOVEL*BLANK    WCMD  100
     C                     Z-ADD100       WLEN   155
     C           PLID      PLIST
     C                     PARM           PRIDPR
     C                     ENDSR
      *
     *  SOUS ROUTNE INIT SF1
     C           INZSF1    BEGSR
     C                     SETOF                     313233
     C                     SETON                     30
     C                     WRITECTL1
     C                     SETOF                     30
     C                     Z-ADD*ZERO     RANG
     C                     ENDSR
      *
     * SS ROUTINE CHARGEMENT SF1
     C           LODSF1    BEGSR
     * SI UNE VALEUR EST DANS LE FILTRE ON LIT DESSUS
     C           REFFLT    IFNE *BLANK
     C*                    MOVELFLTDPT    CPRN
     C           REFFLT    SETLLBEERF
     C                     READ BEERF                    99
     * SINON ON DÉMARRE SUR LOVAL
     C                     ELSE
     C           *LOVAL    SETLLBEERF
     C                     READ BEERF                    99
     C                     ENDIF
      *
      *
     C           *IN99     DOWEQ'0'
     C           RANG      ANDLT9999
     C*
     C                     ADD  1         RANG
     C           PRSTPR    IFLT STMIPR
     C                     SETOF                         40
     C                     ELSE
     C                     SETON                         40
     C                     ENDIF
     C                     WRITESFL1
     C                     READ BEERF                    99
     C                     ENDDO
      *
     C           RANG      COMP *ZERO                32
     C                     SETON                     3133
      *
     C                     ENDSR
      *
      *
     * SOUS ROUTINE TRAITEMENT OPTION SF1
     C           SROPT     BEGSR
     C           *IN03     IFEQ '0'
      *
     C                     READCSFL1                     35
     C           *IN35     DOWEQ'0'
     C           *IN03     ANDEQ'0'
     C           SFLOPT    CASEQ2         OPTMOD
     C           SFLOPT    CASEQ4         OPTDLT
     C           SFLOPT    CASEQ5         OPTAFF
     C           SFLOPT    CASEQ6         OPTIMP
     C                     ENDCS
      *
     C                     CLEARSFLOPT
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
     C                     CALL 'AFFBIER' PLID
     C                     MOVE '1'       MAJ
     C                     ENDSR
      *
     * SOUS ROUTINE DELET OPTDLT
     C           OPTDLT    BEGSR
     *TODO
     C                     CALL 'DLTBBN'  PLID
     C                     MOVE '1'       MAJ
     C                     ENDSR
      *
     * SOUS ROUTINE AFFCI OPTAFF
     *TODO
     C           OPTAFF    BEGSR
     C                     CALL 'AFFBBN'  PLID
     C                     ENDSR
      *
     * SOUS ROUTINEIMPRESSION
     *TODO
     C           OPTIMP    BEGSR
     C                     CALL 'CLIDPF'  PLID
     C*                    EXSR SRNOTF
     C                     ENDSR
      *
     * SOUS ROUTINE CREATE
     C           CREATE    BEGSR
     C                     Z-ADD*ZERO     PRIDPR
     C                     CALL 'AFFBIER' PLID
     C                     SETOF                     06
     C                     MOVE '1'       MAJ
     C                     ENDSR
      *
     * SOUS ROUTINE EXECTION DE COMMANDE
     C           EXECMD    BEGSR
     C                     CALL 'QCMDEXC'              98
     C                     PARM           WCMD
     C                     PARM           WLEN
     C                     ENDSR
**
WRKSPLF
DLTSPLF FILE(QPRINT) SPLNBR(*LAST)
```
