---
bibliotheque: BIB27
fichier_source: QRPGLESRC
membre: RPGFACTL1
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 57
modifie: 2026-11-25
---

# BIB27/QRPGLESRC/RPGFACTL1

```text
      *
      *  Programme RPGFACT : TP RPG CLASSE 01
      *  Version : Règles métiers isolées dans le logique FACTURESL2
      *  12/09/2024
      *  Léo BIB27
      *--------------------------------------------------------------------*
      *          Déclarations de Fichiers                                  |
      *--------------------------------------------------------------------*
      *
     FFACTURESL1UF   E           k Disk    PREFIX(L_)
     FWFACT     O    E           k Disk    RENAME(FACTF:WFACTF)
     F                                     PREFIX(W_)
      *
      *--------------------------------------------------------------------*
      *          Programmes                                                |
      *--------------------------------------------------------------------*
      *  Indicateurs LR pour sortir du programme
     C                   SETON                                            LR
      *
      *  Boucle Globale
     C                   DOW       1 = 1
      *
      *  Lecture du fichier en entrée
      *  *IN98 comme indicateur de fin de fichier
     C                   READ      FACTF                                  98
      *
      *  Contrôle fin de fichier
     C   98              LEAVE
      *
      *  Sous routine récupération des données
     C                   EXSR      TRT_DATA
      *
      *  Sous routine Marquage des données
     C                   EXSR      TRT_FLAG
      *
     C                   ENDDO
      *
      *--------------------------------------------------------------------*
      *          Sous-routines                                             |
      *--------------------------------------------------------------------*
     C     TRT_DATA      BEGSR
     C                   MOVE      L_RTYPE       W_RTYPE
     C                   MOVE      L_RSTE        W_RSTE
     C                   MOVE      L_RGEN        W_RGEN
     C                   MOVE      L_DJAL        W_DJAL
     C                   MOVE      L_REX         W_REX
     C                   MOVE      L_ANFACT      W_ANFACT
     C                   MOVE      L_MOISFACT    W_MOISFACT
     C                   MOVE      L_JOURFACT    W_JOURFACT
     C                   MOVE      L_DMONT       W_DMONT
     C                   WRITE     WFACTF
     C                   ENDSR
      *
     C     TRT_FLAG      BEGSR
     C                   MOVE      '*'           L_DMARQ
     C                   UPDATE    FACTF
     C                   ENDSR
```
