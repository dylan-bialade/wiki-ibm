---
bibliotheque: BIB01
fichier_source: QRPGLESRC
membre: MULRPG
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 68
modifie: 2026-11-16
---

# BIB01/QRPGLESRC/MULRPG

```text
      * **************************************************************
      * PROGRAMME : MULRPG
      * LIBELLE   : Consultation de la table de multiplication
      * PROJET    : FORMATION IBM I - EXERCICE CLLE + RPG III + SBMJOB
      * LANGAGE   : RPG III (RPG/400) - CRTRPGPGM
      * **************************************************************
      * Appele par MULCL (F10) avec le nombre a consulter (3A).
      * Lit TABMUL pour ce nombre (cle partielle) et affiche une
      * ligne par ecran : ENTREE = ligne suivante, F3 = fin.
      *
      * Indicateurs :
      *   03 = F3 (CA03 dans MULRPGD)
      *   90 = fin de lecture (READE, colonnes 58-59)
      *
      * Compil : CRTRPGPGM PGM(&LIB/MULRPG) SRCFILE(&LIB/QRPGSRC)
      * **************************************************************
      * Fichiers
     FMULRPGD CF  E                    WORKSTN
     FTABMUL  IF  E           K        DISK
      * Messages (charges a la compilation, voir ** en fin de source)
      * Un litteral en facteur 2 est limite a 8 caracteres utiles.
     E                    MSGT    1   2 50
      * --------------------------------------------------------------
      * Parametre recu : nombre en ALPHA (passe en *CHAR par le CL)
      * --------------------------------------------------------------
     C           *ENTRY    PLIST
     C                     PARM           PNOMB   3
      * Zone de travail de meme definition que TMNOMB (3S 0)
     C           *LIKE     DEFN TMNOMB    WNOMB
      * Cle partielle : seulement le 1er champ cle de TABMUL
     C           KNOMB     KLIST
     C                     KFLD           WNOMB
      * --------------------------------------------------------------
      * Traitement
      * --------------------------------------------------------------
     C                     MOVE PNOMB     WNOMB            Alpha -> num.
     C                     Z-ADD0         LIGNE
     C                     MOVE *BLANK    MSG
     C           KNOMB     SETLLTABMUL
     C           KNOMB     READETABMUL                   90
     C* Aucune ligne : le calcul batch n a pas encore ete fait
     C           *IN90     IFEQ '1'
     C                     MOVELMSGT,1    MSG       P
     C                     EXFMTMULFMT2
     C                     ELSE
     C* Boucle : une ligne par ecran tant que ni F3 ni fin de lecture
     C           *IN90     DOWEQ'0'
     C           *IN03     ANDEQ'0'
     C           LIGNE     ADD  1         LIGNE
     C                     EXFMTMULFMT2
     C           *IN03     IFEQ '0'
     C           KNOMB     READETABMUL                   90
     C                     ENDIF
     C                     ENDDO
     C* Fin de lecture atteinte sans F3 : on le signale
     C           *IN90     IFEQ '1'
     C           *IN03     ANDEQ'0'
     C                     MOVELMSGT,2    MSG       P
     C                     EXFMTMULFMT2
     C                     ENDIF
     C                     ENDIF
      * --------------------------------------------------------------
      * Fin de programme
      * --------------------------------------------------------------
     C                     SETON                     LR
**
Aucun resultat : soumettez d abord le calcul (F6)
Fin des resultats - ENTREE ou F3 pour sortir
```
