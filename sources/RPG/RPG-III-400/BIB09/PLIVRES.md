---
bibliotheque: BIB09
fichier_source: QSOURCES
membre: PLIVRES
type: RPG/RPG-III-400
longueur_enregistrement: 120
lignes: 126
modifie: 2026-11-16
---

# BIB09/QSOURCES/PLIVRES

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     H*
     H* PLIVRES - Gestion d'une base de livres
     H* Exercice ORGFORM - RPG 400
     H*
     F* ============================================
     F* DECLARATION DES FICHIERS
     F* ============================================
     FLIVREF  UF  E           K        DISK                      A
     FELIVRES CF  E                    WORKSTN
     C*
     C* ============================================
     C* BOUCLE PRINCIPALE - Ecran FMT1
     C* ============================================
     C           *IN03     DOWEQ'0'
     C*
     C* Initialiser le message
     C                     MOVEL*BLANKS   MSG1
     C                     EXFMTFMT1
     C*
     C* F3 = Quitter
     C           *IN03     IFEQ '1'
     C                     LEAVE
     C                     ENDIF
     C*
     C* F6 = Ajouter un nouveau livre
     C           *IN06     IFEQ '1'
     C                     EXSR AJOUT
     C                     ELSE
     C*
     C* Recherche du livre par ISBN
     C           ISBN      CHAINLIVREF               90
     C           *IN90     IFEQ '0'
     C* Livre trouve -> afficher detail
     C                     EXSR DETAIL
     C                     ELSE
     C* Livre non trouve -> message erreur
     C                     MOVEL'ISBN in' MSG1
     C                     MOVE 'connu'   MSG1
     C                     ENDIF
     C                     ENDIF
     C*
     C                     ENDDO
     C*
     C* Fin du programme
     C                     SETON                     LR
     C*
     C* ============================================
     C* SOUS-PROGRAMME : DETAIL (FMT2)
     C* Affiche les infos et gere modification/supp
     C* ============================================
     C           DETAIL    BEGSR
     C*
     C* Initialiser le message
     C                     MOVEL*BLANKS   MSG2
     C                     EXFMTFMT2
     C*
     C* F3 = Quitter l application
     C           *IN03     IFEQ '1'
     C                     SETON                     LR
     C                     RETRN
     C                     ENDIF
     C*
     C* F13 = Supprimer le livre
     C           *IN13     IFEQ '1'
     C* Relire avec verrouillage pour DELET
     C           ISBN      CHAINLIVREF               91
     C           *IN91     IFEQ '0'
     C                     DELETLIVRESF
     C                     ENDIF
     C                     ELSE
     C*
     C* F12 = Retour (ne rien faire)
     C           *IN12     IFEQ '1'
     C* Relire N pour deverrouiller
     C           ISBN      CHAINLIVREF              N92
     C                     ELSE
     C*
     C* Entree = Modifier le livre
     C* Relire avec verrouillage pour UPDAT
     C           ISBN      CHAINLIVREF               92
     C           *IN92     IFEQ '0'
     C                     UPDATLIVRESF
     C                     ENDIF
     C*
     C                     ENDIF
     C                     ENDIF
     C*
     C                     ENDSR
     C*
     C* ============================================
     C* SOUS-PROGRAMME : AJOUT (F6 depuis FMT1)
     C* Cree un nouveau livre via FMT2
     C* ============================================
     C           AJOUT     BEGSR
     C*
     C* Nettoyer les champs pour saisie
     C                     Z-ADD0         ISBN
     C                     MOVEL*BLANKS   TITRE
     C                     MOVEL*BLANKS   AUTEUR
     C                     MOVEL*BLANKS   MSG2
     C*
     C* Afficher FMT2 en mode creation
     C                     EXFMTFMT2
     C*
     C* F3 = Quitter
     C           *IN03     IFEQ '1'
     C                     SETON                     LR
     C                     RETRN
     C                     ENDIF
     C*
     C* F12 = Retour sans creer
     C           *IN12     IFEQ '0'
     C*
     C* Verifier que ISBN n existe pas deja
     C           ISBN      CHAINLIVREF              N93
     C           *IN93     IFEQ '1'
     C* ISBN libre -> Ecriture du nouveau livre
     C                     WRITELIVRESF
     C                     ELSE
     C* ISBN deja existant
     C                     MOVEL'ISBN de' MSG1
     C                     MOVE 'existe'  MSG1
     C                     ENDIF
     C                     ENDIF
     C*
     C                     ENDSR
```
