---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: SOLDAT_V2
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 192
modifie: 2026-11-16
---

# BIB17/QRPGSRC/SOLDAT_V2

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FSOLDAT  UF  E           K        DISK                      A
     FSOLDSP  CF  E                    WORKSTN
     E                    MSG     1   9 50
     E                    CLS     1   6 20
     I           SDS
     I                                        1  10 PGM
     C*
    C*================ BOUCLE PRINCIPALE ============================
     C           *IN03     DOWEQ'0'
     C           ECRAN     CASEQ'1'       SUBEC1
     C           ECRAN     CASEQ'2'       SUBEC2
     C           ECRAN     CASEQ'3'       SUBEC3
     C                     ENDCS
     C                     ENDDO
     C                     SETON                     LR
     C*
    C*================ INITIALISATION ==============================
    C*  *INZSR s'execute automatiquement une fois au demarrage.
    C*  On y declare toutes les zones de travail : un seul endroit.
     C           *INZSR    BEGSR
     C                     MOVE PGM       NMPGM
     C                     MOVE '1'       ECRAN   1
     C                     MOVE ' '       MODE    1
     C                     Z-ADD0         TEMPID  50
     C                     ENDSR
     C*
    C*================ ECRAN 1 : RECHERCHE =========================
     C           SUBEC1    BEGSR
     C                     EXFMTSOLF1
    C*  le message (70) a ete vu : on l'eteint pour le tour suivant
     C                     SETOF                     70
     C                     SELEC
    C*  --- F3 : rien a faire, la boucle principale s'arrete
     C           *IN03     WHEQ '1'
    C*  --- F6 : preparation de la creation
     C           *IN06     WHEQ '1'
     C                     EXSR INICR
    C*  --- Entree : le soldat existe-t-il ?
     C                     OTHER
     C           D1IDS     CHAINSOLDATR             N90
     C           *IN90     IFEQ '1'
     C                     MOVELMSG,1     D1ERMS
     C                     SETON                     70
     C                     ELSE
     C                     MOVE '2'       ECRAN
     C                     ENDIF
     C                     ENDSL
     C                     ENDSR
     C*
    C*================ ECRAN 2 : AFFICHAGE =========================
    C*  On relit TOUJOURS le fichier avant d'afficher (sans verrou) :
    C*  l'ecran montre la base, jamais une saisie non enregistree.
     C           SUBEC2    BEGSR
     C           D1IDS     CHAINSOLDATR             N90
     C           *IN90     IFEQ '1'
    C*  --- supprime entre-temps par un autre job
     C                     MOVELMSG,1     D1ERMS
     C                     SETON                     70
     C                     MOVE '1'       ECRAN
     C                     ELSE
     C                     EXFMTSOLF2
     C                     SELEC
     C           *IN12     WHEQ '1'
     C                     MOVE '1'       ECRAN
     C           *IN02     WHEQ '1'
     C                     EXSR INIMO
     C           *IN07     WHEQ '1'
     C                     EXSR SUBDL
     C                     ENDSL
     C                     ENDIF
     C                     ENDSR
     C*
    C*================ ECRAN 3 : SAISIE ============================
    C*  Sert a la creation ET a la modification (selon MODE).
    C*  En cas d'erreur, ECRAN reste a '3' : l'ecran se reaffiche
    C*  tout seul au tour suivant, avec la saisie et le message.
     C           SUBEC3    BEGSR
     C                     EXFMTSOLF3
     C                     SETOF                     80
     C                     SELEC
    C*  --- F12 : retour a l'ecran d'ou l'on vient
     C           *IN12     WHEQ '1'
     C           MODE      IFEQ 'C'
     C                     MOVE '1'       ECRAN
     C                     ELSE
     C                     MOVE '2'       ECRAN
     C                     ENDIF
    C*  --- F23 : controle puis ecriture ou mise a jour
     C           *IN23     WHEQ '1'
     C           CLASLD    LOKUPCLS                      50
     C           *IN50     IFEQ '0'
     C                     MOVELMSG,2     D3ERMS
     C                     SETON                     80
     C                     ELSE
     C           MODE      CASEQ'C'       SUBCR
     C           MODE      CASEQ'M'       SUBUP
     C                     ENDCS
     C                     ENDIF
    C*  --- Entree ou F3 : rien, on reaffiche (ou on quitte sur F3)
     C                     ENDSL
     C                     ENDSR
     C*
    C*================ PREPARATION CREATION ========================
    C*  L'ID est calcule AVANT de vider les zones : le READP recharge
    C*  tout le format SOLDATR et ecraserait sinon les zones vides.
     C           INICR     BEGSR
     C                     Z-ADD1         TEMPID
     C           *HIVAL    SETLLSOLDATR
     C                     READPSOLDATR             N    91
     C           *IN91     IFEQ '0'
     C           IDSLD     ADD  1         TEMPID
     C                     ENDIF
     C*
     C                     MOVE 'C'       MODE
     C                     MOVELMSG,5     D3MOD
     C                     MOVELMSG,6     D3INS
     C                     MOVE *BLANK    NMSLD
     C                     MOVE *BLANK    PRSLD
     C                     MOVE *BLANK    ARSLD1
     C                     MOVE *BLANK    CLASLD
     C                     SETOF                     80
     C                     MOVE '3'       ECRAN
     C                     ENDSR
     C*
    C*================ PREPARATION MODIFICATION ====================
    C*  Lecture AVEC verrou : necessaire pour le UPDAT a venir.
    C*  Le verrou dure le temps de l'ecran 3 ; il est libere par la
    C*  prochaine lecture du fichier (retour ecran 2) ou par LR.
     C           INIMO     BEGSR
     C           IDSLD     CHAINSOLDATR              90
     C           *IN90     IFEQ '1'
     C                     MOVELMSG,1     D1ERMS
     C                     SETON                     70
     C                     MOVE '1'       ECRAN
     C                     ELSE
     C                     MOVE 'M'       MODE
     C                     MOVELMSG,3     D3MOD
     C                     MOVELMSG,4     D3INS
     C                     SETOF                     80
     C                     MOVE '3'       ECRAN
     C                     ENDIF
     C                     ENDSR
     C*
    C*================ ECRITURE (CREATION) =========================
     C           SUBCR     BEGSR
     C                     Z-ADDTEMPID    IDSLD
     C                     WRITESOLDATR
     C                     MOVELMSG,8     D1ERMS
     C                     SETON                     70
     C                     MOVE '1'       ECRAN
     C                     ENDSR
     C*
    C*================ MISE A JOUR (MODIFICATION) ==================
    C*  Retour a l'ecran 1 pour que le message soit visible :
    C*  SOLF2 n'a pas de zone message. Pour revenir sur l'ecran 2,
    C*  ajoute une zone message a SOLF2 et mets ECRAN a '2'.
     C           SUBUP     BEGSR
     C                     UPDATSOLDATR
     C                     MOVELMSG,9     D1ERMS
     C                     SETON                     70
     C                     MOVE '1'       ECRAN
     C                     ENDSR
     C*
    C*================ SUPPRESSION =================================
     C           SUBDL     BEGSR
     C           IDSLD     CHAINSOLDATR              90
     C           *IN90     IFEQ '0'
     C                     DELETSOLDATR
     C                     MOVELMSG,7     D1ERMS
     C                     ELSE
     C                     MOVELMSG,1     D1ERMS
     C                     ENDIF
     C                     SETON                     70
     C                     MOVE '1'       ECRAN
     C                     ENDSR
**
Numero de soldat inconnu
Classe invalide
Modification d'un soldat
Modifiez le soldat puis appuyez sur F23
Creation d'un soldat
Saisissez le soldat puis appuyez sur F23
Soldat supprime
Soldat ajoute
Soldat modifie
**
SOLDAT
ADEPTE
PORTE ETENDARD
FRANC TIREUR
SENTINELLE
INGENIEUR
```
