---
bibliotheque: BIB25
fichier_source: QFACTURE
membre: RPGFACT
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 91
modifie: 2026-11-25
---

# BIB25/QFACTURE/RPGFACT

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      *
      *  Programme RPGFACT : TP RPG CLASSE 01
      *  Version : Classique | lecture du PF + Contrôles dans le Prog
      *  12/09/2024
      *  Léo BIB27
      *--------------------------------------------------------------------*
      *          Déclarations de Fichiers                                  |
      *--------------------------------------------------------------------*
      *
     FFACTURES  UF   E           k Disk
     FWFACT     O    E           k Disk    RENAME(FACTF:WFACTF)
     F                                     PREFIX(W_)
      *
      *--------------------------------------------------------------------*
      *          Déclarations de Variables                                 |
      *--------------------------------------------------------------------*
      *
      * DATA STRUCTURE pour le compte Général
     D£RGENDS          DS
     D £RGEN1                  1      1  0
     D £RGEN                   1      6  0
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
      *  Initialisation de la DATA STRUCTURE
     C                   MOVE      RGEN          £RGEN
      *
      *  Sous routine Règles métiers
     C                   EXSR      TRT_METIER
      *
      *  Sous routine récupération des données
     C  N50              EXSR      TRT_DATA
      *
      *  Sous routine Marquage des données
     C  N50              EXSR      TRT_FLAG
      *
     C                   ENDDO
      *
      *--------------------------------------------------------------------*
      *          Sous-routines                                             |
      *--------------------------------------------------------------------*
     C     TRT_METIER    BEGSR
     C                   SETOFF                                           50
     C     DMARQ         IFEQ      '*'
     C                   SETON                                            50
     C                   ENDIF
     C     REX           IFNE      '20240'
     C                   SETON                                            50
     C                   ENDIF
     C     RTYPE         IFNE      'A'
     C                   SETON                                            50
     C                   ENDIF
     C     £RGEN1        IFNE      6
     C                   SETON                                            50
     C                   ENDIF
     C     DJAL          IFNE      'ANV'
     C                   SETON                                            50
     C                   ENDIF
     C                   ENDSR
      *
     C     TRT_DATA      BEGSR
     C                   MOVE      RTYPE         W_RTYPE
     C                   MOVE      RSTE          W_RSTE
     C                   MOVE      RGEN          W_RGEN
     C                   MOVE      DJAL          W_DJAL
     C                   MOVE      REX           W_REX
     C                   MOVE      ANFACT        W_ANFACT
     C                   MOVE      MOISFACT      W_MOISFACT
     C                   MOVE      JOURFACT      W_JOURFACT
     C                   MOVE      DMONT         W_DMONT
     C                   WRITE     WFACTF
     C                   ENDSR
      *
     C     TRT_FLAG      BEGSR
     C                   MOVE      '*'           DMARQ
     C                   UPDATE    FACTF
     C                   ENDSR
```
