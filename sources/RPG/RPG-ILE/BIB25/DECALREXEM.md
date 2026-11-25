---
bibliotheque: BIB25
fichier_source: QRPGLESRC
membre: DECALREXEM
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 136
modifie: 2026-11-25
---

# BIB25/QRPGLESRC/DECALREXEM

```text
     F**** DECLARATION FICHIERS ***************************************
     FFOURNSS   CF   E             WORKSTN
     F                                     SFILE(SFL01:LIGNE)
     FFOURNIS   UF   E           K DISK
     **** Déclaration de variable
     DDecimal          S              6S 0 INZ(0)
     DPacked           S              6P 2 INZ(*ZERO)
     DALPHA            S             10A   INZ(*BLANKS)
     DMSG              S             80    DIM(2) CTDATA PERRCD(1)
     **** Date / Heure
     DDateDMY          S               D   DATFMT(*DMY)
     DDateISO          S               D   DATFMT(*ISO)
     DTime             S               T   TIMFMT(*HMS)
     **** Constante
     DPrenom           C                   CONST('BIB01')
     Dage              C                   CONST(24)
     **** Dtaara
     DDSLDA           UDS                  dtaara(*lda)
     D NOM                           10A   overlay(DSLDA)
     D anniv                         10A   overlay(DSLDA:161)
     **** Data Structure
     D DsDate          DS
     D SS                      1      2
     D AA                      3      4
     D MM                      5      6
     D JJ                      7      8
     D DATEjour                1      8    INZ('20250331')
     D ANNEE                   1      4
     **** TRAITEMENT DU PROGRAMME ************************************
     C*                  IN        DSLDA
     C*                  OUT       DSLDA
     C     *INKC         DOWEQ     '0'
     C                   EXSR      CHARGE
     C                   WRITE     PIED01
     C                   EXFMT     CTL01
     * -- GESTION DES TOUCHES DE FONCTIONS ---------------------------
     C   KL              LEAVE
     C     *INKF         CASEQ     '1'           CREAT
     C     *INKH         CASEQ     '1'           QCMD
     C     *INKV         CASEQ     '1'           LCMD
     C   41              CAS                     RELI
     C                   ENDCS
     C                   ENDDO
     C                   SETON                                        LR
     **** FIN TRAITEMENT *********************************************
     *****************************************************************
     *
     **** SOUS ROUTINES **********************************************
     *****************************************************************
     *
     **** SOUS ROUTINE CHARGE ****************************************
     C     CHARGE        BEGSR
     * ------- REMISE À ZERO DES INDICATEUR ET DE LA LIGNE -----------
     C                   MOVEA     '0000'        *IN(40)
     C                   Z-ADD     0             LIGNE             4 0
     * ------- Effacement du sous fichier *IN40 - SFLCLR -------------
     C                   SETON                                        40
     C                   WRITE     CTL01
     C                   SETOFF                                       40
     * ------- Boucle de remplissage du sous fichier -----------------
     C     *LOVAL        SETLL     FOURNIS
     C                   READ      FOURNIS                                90
     C     *IN90         DOWEQ     '0'
     C                   ADD       1             LIGNE
     C                   WRITE     SFL01
     C                   READ      FOURNIS                                90
     C                   ENDDO
     * ------- Activation des indicateurs d'affichage ----------------
     *  *IN40 - SFLCLR
     *  *IN41 - SFLDSP
     *  *IN42 - SFLDSPCTL
     *  *IN43 - SFLEND
     C                   SETON                                        4243
     C     LIGNE         COMP      0                                  41
     C                   ENDSR
     **** SOUS ROUTINE RELI ******************************************
     C     RELI          BEGSR
     C                   MOVE      '0'           *IN23
     C     *IN23         DOWEQ     '0'
     * ------- Lecture changement du sous fichier --------------------
     C                   READC     SFL01                                  23
     C     *IN23         IFEQ      '0'
     C     OPT           CASEQ     '2'           MODIF
     C     OPT           CASEQ     '4'           SUPPR
     C     OPT           CASEQ     '5'           AFFIC
     C     OPT           CASEQ     '6'           IMPRE
     C                   ENDCS
     C                   MOVE      *BLANKS       OPT
     C                   UPDATE    SFL01
     C                   ENDIF
     C                   ENDDO
     C                   ENDSR
     **** SOUS ROUTINE MODIF *** Opt 2 - Modification ****************
     C     MODIF         BEGSR
     C                   CALL      'FOURNF1'
     C                   PARM                    FOIDFO
     C                   PARM      'MODI'        MODE              4
     C                   ENDSR
     **** SOUS ROUTINE CREAT *** F6 - Création ***********************
     C     CREAT         BEGSR
     C                   CALL      'FOURNF1'
     C                   PARM      0             FOIDFO
     C                   PARM      'CREA'        MODE              4
     C                   ENDSR
     **** SOUS ROUTINE SUPPR *** Opt 4 - Suppression *****************
     C     SUPPR         BEGSR
     C                   EXFMT     WSUPP
     C     WOPT          IFEQ      'OUI'
     C     FOIDFO        CHAIN     FOURNIS                            90
     C  N90              DELETE    FOURNIS
     C                   ENDIF
     C                   ENDSR
     **** SOUS ROUTINE AFFIC *** Opt 5 - Afficher ********************
     C     AFFIC         BEGSR
     C                   CALL      'FOURNF1'
     C                   PARM                    FOIDFO
     C                   PARM      'AFFI'        MODE              4
     C                   ENDSR
     **** SOUS ROUTINE AFFIC *** Opt 6 - IMPRESSION ******************
     C     IMPRE         BEGSR
     C                   CALL      'FOURIMP'
     C                   PARM                    FOIDFO
     C                   ENDSR
     **** SOUS ROUTINE LCMD *** F21 - Ligne de commande **************
     C     LCMD          BEGSR
     C                   CALL      'QUSCMDLN'
     C                   ENDSR
     **** SOUS ROUTINE QCMD *** F08 - WRKSPLF ************************
     C     QCMD          BEGSR
     C                   CALL      'QCMDEXC'
     C                   PARM      'WRKSPLF'     COM              80
     C                   PARM      80            LEN              15 5
     C                   ENDSR
** MSG
 Ligne 1 du tableau
 Ligne 2 du tableau
```
