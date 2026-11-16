---
bibliotheque: BIB02
fichier_source: QVSRC
membre: RPG3EX
type: RPG/RPG-III-400
longueur_enregistrement: 100
lignes: 356
modifie: 2026-11-16
---

# BIB02/QVSRC/RPG3EX

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     H              J
     F*===============================================================
     F*  ACTMUL - SELECTION DES ACTIVITES
     F*===============================================================
     F* 01 - AIDE
     F* 03 - FIN
     F* 05 - REAFFICHAGE
     F* 12 - ECRAN PRECEDENT
     F* 17 - DEBUT LISTE
     F* 18 - FIN LISTE
     F* 21 - COMMANDE
     F* 60 - AFFICHAGE FORMAT DE CONTROLE
     F* 61 - AFFICHAGE ENRGTS DU SOUS FICHIER
     F* 62 - EFFACEMENT SOUS FICHIER
     F* 63 - FIN DE FICHIER
     F* 64 - DEFILEMENT ARRIERE
     F* 65 - DEFILEMENT AVANT
     F* 66 - TRI PAR CODE
     F* 67 - TRI PAR LIBELLE
     F* 68 - TRI PAR
     F* 81 - MESSAGE D'ERREUR
     F* 99 - FIN DE LECTURE ECRAN DE SELECTION
     F*===============================================================
     FRAYONCO IF  E           K        DISK
     FRAYONLI IF  E           K        DISK
     F            RRAYON                            KRENAMEZFMTX
     FCHALPWDPIF  E           K        DISK
     FACTMULFMCF  E                    WORKSTN
     F                                              KINFDS INFDS
     F                                        LIGNE1KSFILE FSEL
     E                    TRAY       30  2
     I*   DS CALCUL POSITION DU CURSEUR
     IINFDS       DS
     I                                    B 370 3710CSRLOC
     I*   LDA
     ILDA        UDS
     I                                        1   8 ZPGM
     I                                        9  36 ZTIT1
     I                                       37  64 ZTIT2
     I                                       65  94 ZENT
     C*   DEFINITION DES CLES
     C           CLECOD    KLIST
     C
     C                     KFLD           RAYCOD
     C           CLELIB    KLIST
     C                     KFLD           RAYLIB
     C                     KFLD           RAYCOD
     C           CLEWRA    KLIST
     C                     KFLD           PDEP    8
     C                     KFLD           RAYCOD
     C*   DEFINITION DES ZONES
     C           *LIKE     DEFN RAYCOD    PCOD
     C           *LIKE     DEFN RAYCOD    PRMCOD
     C           *LIKE     DEFN RAYCOD    DRNCOD
     C           *LIKE     DEFN RAYLIB    PRMLIB
     C           *LIKE     DEFN RAYLIB    DRNLIB
     C*   LECTURE LDA
     C           *NAMVAR   DEFN *LDA      LDA
     C                     IN   LDA
     C                     OUT  LDA
     C*PARAMETRES RECUS
     C           *ENTRY    PLIST
     C                     PARM           TRAY
     C                     PARM           WTOUT   1
     C                     PARM           PDEP    8
     C                     PARM           CATEG   2
     C           CATEG     IFEQ '10'
     C                     MOVE '1'       *IN27
     C                     ENDIF
      *   RECUPERATION DE LA DATE DU JOUR EN FORMAT (AAAAMMJJ) ------
     C                     CALL 'XRTVDTJ'
     C                     PARM           PUDATE  80
     C                     MOVE PUDATE    DATLIV  80
     C           CATEG     IFEQ '10'
     C                     MOVE *BLANKS   DATLIV
     C                     ENDIF
     C*   INITIALISATION DU TRI PAR CODE
     C                     MOVEA'100'     *IN,66
     C                     MOVE *BLANKS   TRAY
     C*--------------------------------------------------------------
     C*                CORPS DU PROGRAMME
     C*--------------------------------------------------------------
     C                     EXSR RAZECR
     C                     EXSR REMECR
     C                     EXSR TRTECR
     C           FIN       TAG
     C                     SETON                     LR
     C*-------------------------------------------------------------------------
     C*  RAZECR  - REMISE A BLANC SOUS-FICHIER ECRAN
     C*-------------------------------------------------------------------------
     C           RAZECR    BEGSR
     C                     SETON                     62
     C                     WRITEFENT
     C                     SETOF                     616263
     C                     Z-ADD0         LIG     20
     C                     Z-ADD0         LIGNE1  40
     C                     Z-ADD0         TLIGN1  40
     C   66      CLECOD    SETLLRAYONCO
     C   67      CLELIB    SETLLRAYONLI
     C                     ENDSR
     C*-------------------------------------------------------------------------
     C*  REMECR - LECTURE FICHIER / REMPLISSAGE SOUS-FICHIER ECRAN
     C*-------------------------------------------------------------------------
     C           REMECR    BEGSR
     C                     SETOF                     40
     C                     SETOF                     63
     C                     MOVEL*BLANK    PRMCOD
     C                     MOVEL*BLANK    PRMLIB
     C                     MOVEL*BLANK    DRNCOD
     C                     MOVEL*BLANK    DRNLIB
     C                     Z-ADDTLIGN1    LIGNE1
     C                     MOVE '0'       *IN81
     C                     MOVE '0'       *IN82
     C   66                READ RAYONCO                  63
     C   67                READ RAYONLI                  63
     C           *IN63     DOWEQ'0'
     C           LIG       ANDLT10
     C* LECT DEPOT
     C                     MOVE '0'       *IN26
     C           CLEWRA    SETLLCHALPWDP
     C           CLEWRA    READECHALPWDP                 25
     C           *IN25     DOWEQ*OFF
     C* DISTRI NEGOCE
d3   C           LIGDLI    IFLE DATLIV
     C           LIGP10    ANDEQ0
     C           LIGDEP    ANDEQPDEP
     C           *IN27     ANDEQ'0'
     C                     MOVE '1'       *IN26
     C                     LEAVE
     C                     ENDIF
     C* E COMMERCE    DATE CDE <= DATE  LIVRAISON
     C           *IN27     IFEQ '1'
d3   C*          LIGDCD    IFLE DATLIV
     C*          LIGDEP    ANDEQPDEP
     C                     MOVE '1'       *IN26
     C                     LEAVE
     C*                    ENDIF
     C                     ENDIF
     C*
     C           CLEWRA    READECHALPWDP                 25
     C                     ENDDO
     C*
     C           *IN26     IFEQ '1'
     C           LIGDEP    ANDEQPDEP
     C           CDERAY    ANDEQRAYCOD
     C                     ADD  1         LIG
     C                     ADD  1         LIGNE1
     C                     Z-ADD1         I
     C           RAYCOD    LOKUPTRAY,I                   10
     C   10                MOVE RAYCOD    TRAY,I
     C   10                MOVE '1'       ZOPT
     C  N10                MOVE ' '       ZOPT
     C*  SAUVEGARDE PREMIER ENREGISTERMENT
     C           LIG       IFEQ 1
     C                     MOVELRAYCOD    PRMCOD
     C                     MOVELRAYLIB    PRMLIB
     C                     END                             LIG = 1
     C                     WRITEFSEL
     C                     ENDIF
     C           LIG       IFNE 10
     C   66                READ RAYONCO                  63
     C   67                READ RAYONLI                  63
     C*  SAUVEGARDE DERNIER ENREGISTERMENT
     C  N63                MOVELRAYCOD    DRNCOD
     C  N63                MOVELRAYLIB    DRNLIB
     C                     END                             LIG <> 10
     C                     END                             *IN63 DOWEQ '0'
     C  N63 66             READ RAYONCO                  63
     C  N63 67             READ RAYONLI                  63
     C  N63                MOVELRAYCOD    DRNCOD
     C  N63                MOVELRAYLIB    DRNLIB
     C                     Z-ADDLIGNE1    TLIGN1
     C                     ENDSR
     C*-------------------------------------------------------------------------
     C*  TRTECR - TRAITEMENT DES OPTIONS CHOISIES
     C*-------------------------------------------------------------------------
     C           TRTECR    BEGSR
     C           TRT1      TAG
     C                     Z-ADD0         X       20
     C                     WRITEFBAS
     C           TLIGN1    IFGT 0
     C                     SETON                     6061
     C                     ELSE
     C                     SETON                     60
     C                     END                             TLIGN1 > 0
     C                     MOVEL*BLANK    ECOD
     C                     MOVEL*BLANK    ELIB
     C           LIG       IFEQ 0
     C                     MOVE '1'       *IN82
     C                     ENDIF
     C                     EXFMTFENT
     C   03
     COR 12                GOTO FTRTF1
     C*REAFFICHAGE
     C   05                DO
     C                     MOVELPRMCOD    RAYCOD
     C                     MOVELPRMLIB    RAYLIB
     C                     EXSR RAZECR
     C                     EXSR REMECR
     C                     GOTO TRT1
     C                     END                             REAFFICHAGE
     C*DEBUT DE FICHIER
     C   17                DO
     C                     MOVEL*BLANK    RAYCOD
     C                     MOVEL*BLANK    RAYLIB
     C                     EXSR RAZECR
     C                     EXSR REMECR
     C                     GOTO TRT1
     C                     END                             DEBUT FICHIER
     C*FIN DE FICHIER
     C   18                DO
     C                     MOVEL*HIVAL    RAYCOD
     C                     MOVEL*HIVAL    RAYLIB
     C                     EXSR ARRECR
     C                     EXSR RAZECR
     C                     EXSR REMECR
     C                     GOTO TRT1
     C                     END                             FIN FICHIER
     C*PAGINATION ARRIERE
     C   64                DO
     C                     MOVELPRMCOD    RAYCOD
     C                     MOVELPRMLIB    RAYLIB
     C                     EXSR ARRECR
     C                     EXSR RAZECR
     C                     EXSR REMECR
     C                     GOTO TRT1
     C                     END                             PAGIN. ARRIERE
     C*PAGINATION AVANT
     C   65                DO
     C           *IN63     IFEQ '0'
     C                     MOVELDRNCOD    RAYCOD
     C                     MOVELDRNLIB    RAYLIB
     C                     EXSR RAZECR
     C                     EXSR REMECR
     C                     END                             *IN63 = '0'
     C                     GOTO TRT1
     C                     END                             PAGIN. AVANT
     C*REAFFICHAGE LISTE A PARTIR D'UN CODE SAISI
     C           ECOD      IFNE *BLANK
     C                     MOVELECOD      RAYCOD
     C                     MOVELELIB      RAYLIB
     C                     MOVEA'100'     *IN,66
     C                     EXSR RAZECR
     C                     EXSR REMECR
     C                     GOTO TRT1
     C                     END                             ECOD <> ' '
     C*REAFFICHAGE LISTE A PARTIR D'UN LIBELLE SAISI
     C           ELIB      IFNE *BLANK
     C                     MOVELECOD      RAYCOD
     C                     MOVELELIB      RAYLIB
     C                     MOVEA'010'     *IN,66
     C                     EXSR RAZECR
     C                     EXSR REMECR
     C                     GOTO TRT1
     C                     END                             ELIB <> ' '
     C*
     C*F7 : VALIDATION GLOBALE
     C*
     C                     MOVE '0'       £ACTIO  1
     C           TRT2      TAG
     C*
     C                     MOVE '0'       *IN07
     C           *IN07     IFEQ '1'
     C                     Z-ADD1         I       20
     C           *LOVAL    SETLLRAYONCO
     C                     READ RAYONCO                  98
     C           *IN98     DOWEQ*OFF
     C           '  '      LOKUPTRAY,I                   10
     C           *IN10     IFEQ '1'
     C                     MOVE RAYCOD    TRAY,I
     C                     ENDIF
     C*
     C                     ADD  1         I
     C           I         IFLE 30
     C                     READ RAYONCO                  98
     C                     ELSE
     C                     LEAVE
     C                     ENDIF
     C                     ENDDO
     C                     MOVE '1'       WTOUT
     C                     GOTO FTRTF1
     C                     ENDIF
     C* SOUS FICHIER VIDE
     C           TLIGN1    CABEQ0         FTRTF1
     C* TRAITEMENT DES MODIFS DU SOUS FICHIER
     C                     READCFSEL                     99
     C  N99                DO
     C*' ' = DESELECTION
     C           ZOPT      IFEQ *BLANK
     C                     Z-ADD1         I       20
     C           RAYCOD    LOKUPTRAY,I                   10
     C   10                MOVE *BLANKS   TRAY,I
     C   10                MOVE '1'       £ACTIO
     C*
     C                     MOVE '0'       *IN40
     C                     UPDATFSEL
     C*
     C                     GOTO TRT2
     C                     END                             ZOPT = ' '
     C*'1' = SELECTION
     C           ZOPT      IFEQ '1'
     C                     Z-ADD1         I       20
     C           '  '      LOKUPTRAY,I                   10
     C           *IN10     IFEQ *ON                                *
     C                     MOVE RAYCOD    TRAY,I
     C                     MOVE '1'       £ACTIO
     C*
     C                     MOVE '1'       *IN40
     C                     UPDATFSEL
     C*
     C                     GOTO TRT2
     C                     ENDIF
     C                     ENDIF
     C                     ENDDO
     C* AU MOINS UNE ACTION SUR LE SOUS FICHIER => REAFFICHAGE
     C           £ACTIO    IFEQ '1'                                *
     C                     GOTO TRT1
     C                     ENDIF
     C*
     C*ENTREE : VALIDATION SELECTION
     C*
     C                     MOVE '1'       *IN81
     C                     Z-ADD0         I
     C           ERR       TAG
     C                     ADD  1         I
     C*
     C           TRAY,I    IFNE '  '
     C                     MOVE '0'       *IN81
     C                     GOTO FTRTF1
     C                     ELSE
     C           I         IFLT 30
     C                     GOTO ERR
     C                     ENDIF
     C                     ENDIF
     C*
     C           *IN81     IFEQ '1'
     C                     GOTO TRT1
     C                     ENDIF
     C*
     C           FTRTF1    ENDSR
     C*-------------------------------------------------------------------------
     C*  ARRECR - PAGINATION ARRIERE
     C*-------------------------------------------------------------------------
     C           ARRECR    BEGSR
     C                     SETOF                     63
     C                     Z-ADD0         LIG
     C* 18                Z-ADD1         LIG
     C   66      CLECOD    SETLLRAYONCO
     C   67      CLELIB    SETLLRAYONLI
     C           *IN63     DOWEQ'0'
     C           LIG       ANDLT10
     C                     ADD  1         LIG
     C   66                READPRAYONCO                  63
     C   67                READPRAYONLI                  63
     C                     END                             *IN63 DOWEQ '0'
     C                     ENDSR
```
