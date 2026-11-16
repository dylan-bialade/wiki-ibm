---
bibliotheque: BIB17
fichier_source: QRPGLESRC
membre: DSPJEUX2
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 34
modifie: 2026-11-16
---

# BIB17/QRPGLESRC/DSPJEUX2

```text
      * Programme : affiche les titres des jeux dans l'ordre de la clé
     FJEUX      IF   E           K DISK
      * Lecture d'amorce : premier jeu
     C                   READ      JEUX
      * Tant qu'il reste des jeux à lire
     C                   DOW       NOT %EOF(JEUX)
      * Cas particulier : Mass Effect
     C                   IF        TITJEU = 'Mass Effect'
     C     'RIP Bioware' DSPLY
     C                   ELSE
      * Cas général : affichage du titre
     C     TITJEU        DSPLY
     C                   ENDIF
      * Lecture du jeu suivant
     C                   READ      JEUX
     C                   ENDDO
      * Fin du programme
     C                   EVAL      *INLR = *ON

      *==================================================================================
      * Variante : boucle « infinie » avec sortie par LEAVE
     C                   DOW       1 = 1
      * Lecture du jeu suivant
     C                   READ      JEUX
      * Plus de jeu : on sort de la boucle
     C                   IF        %EOF(JEUX)
     C                   LEAVE
     C                   ENDIF
     C                   IF        TITJEU = 'Mass Effect'
     C     'RIP Bioware' DSPLY
     C                   ELSE
     C     TITJEU        DSPLY
     C                   ENDIF
     C                   ENDDO
```
