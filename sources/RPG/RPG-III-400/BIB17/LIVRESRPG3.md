---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: LIVRESRPG3
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 245
modifie: 2026-11-16
---

# BIB17/QRPGSRC/LIVRESRPG3

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     H* Options A/M/D, F3 quitter, F6 creer, F12 annuler,
     H* F23 confirmer la suppression
     F* DECLARATION DES FICHIERS
     FLIVRESECCF  E                    WORKSTN
     FLIVRESL UF  E           K        DISK                      A
     E* TABLEAU DES MESSAGES ET LIBELLES (DONNEES ** EN FIN)
     E                    MSG     1  16 50
     C*
     C* BOUCLE PRINCIPALE : ECRAN 1
     C*
     C           *IN03     DOWEQ'0'
     C                     EXFMTFMT1
     C                     MOVE *BLANK    E1MSG
     C                     SETOF                     64
     C* F3 = QUITTER
     C           *IN03     IFEQ '1'
     C                     LEAVE
     C                     ENDIF
     C* F6 = CREER
     C           *IN06     IFEQ '1'
     C                     EXSR CREER
     C                     ITER
     C                     ENDIF
     C* CONTROLE DE L OPTION
     C           E1OPT     IFNE 'A'
     C           E1OPT     ANDNE'M'
     C           E1OPT     ANDNE'D'
     C                     Z-ADD5         X
     C                     EXSR ERREUR
     C                     ITER
     C                     ENDIF
     C* VERIFICATION DE L EXISTENCE DU LIVRE
     C           E1ISB     CHAINLIVRESL             N90
     C           *IN90     IFEQ '1'
     C                     Z-ADD1         X
     C                     EXSR ERREUR
     C                     ITER
     C                     ENDIF
     C                     EXSR CHARG
     C* AIGUILLAGE SUR L OPTION
     C           E1OPT     CASEQ'A'       AFFIC
     C           E1OPT     CASEQ'M'       MODIF
     C           E1OPT     CASEQ'D'       SUPPR
     C                     ENDCS
     C                     ENDDO
     C*
     C* SORTIE DU PROGRAMME
     C                     SETON                         LR
     C*================================================================
     C* INITIALISATION
     C           *INZSR    BEGSR
     C                     Z-ADD0         X       20
     C                     MOVE '0'       FINI    1
     C                     MOVE *BLANK    E1MSG
     C                     ENDSR
     C*================================================================
     C* CHARGEMENT DES ZONES ECRAN DEPUIS LE FICHIER
     C           CHARG     BEGSR
     C                     Z-ADDISBN      E2ISB
     C                     MOVELTITRE     E2TIT
     C                     MOVELAUTEUR    E2AUT
     C                     MOVELDISPO     E2DISP
     C                     ENDSR
     C*================================================================
     C* A = AFFICHAGE
     C           AFFIC     BEGSR
     C                     SETON                     61
     C                     SETOF                     6263
     C                     MOVELMSG,13    E2MOD     P
     C                     EXFMTFMT2
     C                     MOVE *BLANK    E1MSG
     C                     SETOF                     64
     C                     ENDSR
     C*================================================================
     C* M = MODIFICATION
     C           MODIF     BEGSR
     C                     SETOF                     616263
     C                     MOVELMSG,14    E2MOD     P
     C                     MOVE '0'       FINI
     C           FINI      DOUEQ'1'
     C                     EXFMTFMT2
     C                     MOVE *BLANK    E1MSG
     C                     SETOF                     64
     C           *IN03     IFEQ '1'
     C           *IN12     OREQ '1'
     C           *IN12     IFEQ '1'
     C                     Z-ADD10        X
     C                     EXSR INFO
     C                     ENDIF
     C                     MOVE '1'       FINI
     C                     ITER
     C                     ENDIF
     C                     EXSR CONTRO
     C           *IN64     IFEQ '1'
     C                     ITER
     C                     ENDIF
     C* RELECTURE AVEC VERROU PUIS MISE A JOUR
     C           E2ISB     CHAINLIVRESL              90
     C           *IN90     IFEQ '1'
     C                     Z-ADD11        X
     C                     EXSR ERREUR
     C                     ELSE
     C                     MOVELE2TIT     TITRE
     C                     MOVELE2AUT     AUTEUR
     C                     MOVELE2DISP    DISPO
     C                     UPDATLIVREF
     C                     Z-ADD2         X
     C                     EXSR INFO
     C                     ENDIF
     C                     MOVE '1'       FINI
     C                     ENDDO
     C                     ENDSR
     C*================================================================
     C* D = SUPPRESSION (CONFIRMATION PAR F23)
     C           SUPPR     BEGSR
     C                     SETON                     6163
     C                     SETOF                     62
     C                     MOVELMSG,15    E2MOD     P
     C                     Z-ADD9         X
     C                     EXSR ERREUR
     C                     MOVE '0'       FINI
     C           FINI      DOUEQ'1'
     C                     EXFMTFMT2
     C                     MOVE *BLANK    E1MSG
     C                     SETOF                     64
     C           *IN03     IFEQ '1'
     C           *IN12     OREQ '1'
     C           *IN12     IFEQ '1'
     C                     Z-ADD10        X
     C                     EXSR INFO
     C                     ENDIF
     C                     MOVE '1'       FINI
     C                     ITER
     C                     ENDIF
     C* ENTREE SANS F23 : ON REDEMANDE LA CONFIRMATION
     C           *IN23     IFEQ '0'
     C                     Z-ADD9         X
     C                     EXSR ERREUR
     C                     ITER
     C                     ENDIF
     C           E2ISB     CHAINLIVRESL              90
     C           *IN90     IFEQ '1'
     C                     Z-ADD11        X
     C                     EXSR ERREUR
     C                     ELSE
     C                     DELETLIVREF
     C                     Z-ADD3         X
     C                     EXSR INFO
     C                     ENDIF
     C                     MOVE '1'       FINI
     C                     ENDDO
     C                     ENDSR
     C*================================================================
     C* F6 = CREATION
     C           CREER     BEGSR
     C                     SETOF                     6163
     C                     SETON                     62
     C                     MOVELMSG,16    E2MOD     P
     C                     Z-ADD0         E2ISB
     C                     MOVE *BLANK    E2TIT
     C                     MOVE *BLANK    E2AUT
     C                     MOVE 'O'       E2DISP
     C                     MOVE '0'       FINI
     C           FINI      DOUEQ'1'
     C                     EXFMTFMT2
     C                     MOVE *BLANK    E1MSG
     C                     SETOF                     64
     C           *IN03     IFEQ '1'
     C           *IN12     OREQ '1'
     C           *IN12     IFEQ '1'
     C                     Z-ADD10        X
     C                     EXSR INFO
     C                     ENDIF
     C                     MOVE '1'       FINI
     C                     ITER
     C                     ENDIF
     C           E2ISB     IFLE 0
     C                     Z-ADD12        X
     C                     EXSR ERREUR
     C                     ITER
     C                     ENDIF
     C* L ISBN NE DOIT PAS DEJA EXISTER
     C           E2ISB     SETLLLIVRESL                  91
     C           *IN91     IFEQ '1'
     C                     Z-ADD6         X
     C                     EXSR ERREUR
     C                     ITER
     C                     ENDIF
     C                     EXSR CONTRO
     C           *IN64     IFEQ '1'
     C                     ITER
     C                     ENDIF
     C                     Z-ADDE2ISB     ISBN
     C                     MOVELE2TIT     TITRE
     C                     MOVELE2AUT     AUTEUR
     C                     MOVELE2DISP    DISPO
     C                     WRITELIVREF
     C                     Z-ADDE2ISB     E1ISB
     C                     Z-ADD4         X
     C                     EXSR INFO
     C                     MOVE '1'       FINI
     C                     ENDDO
     C                     ENDSR
     C*================================================================
     C* CONTROLE DES ZONES SAISIES (TITRE, DISPO)
     C           CONTRO    BEGSR
     C           E2TIT     IFEQ *BLANK
     C                     Z-ADD7         X
     C                     EXSR ERREUR
     C                     ELSE
     C           E2DISP    IFNE 'O'
     C           E2DISP    ANDNE'N'
     C                     Z-ADD8         X
     C                     EXSR ERREUR
     C                     ENDIF
     C                     ENDIF
     C                     ENDSR
     C*================================================================
     C* MESSAGE D ERREUR (ROUGE) / MESSAGE D INFORMATION (VERT)
     C           ERREUR    BEGSR
     C                     SETON                     64
     C                     MOVELMSG,X     E1MSG     P
     C                     ENDSR
     C*
     C           INFO      BEGSR
     C                     SETOF                     64
     C                     MOVELMSG,X     E1MSG     P
     C                     ENDSR
**
Livre inexistant : saisissez un ISBN valide
Mise à jour effectuée
Livre supprimé
Livre créé
Option invalide : saisissez A, M ou D
Ce numéro ISBN existe déjà
Le titre est obligatoire
Disponibilité : saisissez O ou N
Appuyez sur F23 pour confirmer la suppression
Opération annulée
Livre introuvable, opération impossible
Le numéro ISBN doit être supérieur à zéro
Affichage
Modification
Suppression
Création
```
