---
bibliotheque: BIB27
fichier_source: QCOBOLSRC
membre: SYNTHCOBOL
type: COBOL
longueur_enregistrement: 80
lignes: 99
modifie: 2026-11-25
---

# BIB27/QCOBOLSRC/SYNTHCOBOL

```text
      *================================================================
      * IDENTIFICATION DIVISION - ILE COBOL for IBM i
      * Référence : IBM ILE COBOL Language Reference (SC09-2508)
      * Compilateur : CRTBNDCBL ou CRTSQLCBLI
      *================================================================
       IDENTIFICATION DIVISION.
      *----------------------------------------------------------------
      * PROGRAM-ID (OBLIGATOIRE)
      * Nomme le programme COBOL.
      * Le nom doit correspondre au nom objet *PGM IBM i (max 10 car.)
      * OPTIONS disponibles :
      *   RECURSIVE   le programme peut s'appeler lui-même (récursif)
      *   COMMON      uniquement pour les programmes imbriqués (nested)
      *   INITIAL     réinitialise l'état à chaque CALL
      *Combinaison impossible : RECURSIVE + INITITAL
      *                         RECURSIVE + COMMON
      *----------------------------------------------------------------

       PROGRAM-ID. SYNTHCOBOL IS RECURSIVE PROGRAM.

      *----------------------------------------------------------------
      * AUTHOR (OBSOLETE - documentation uniquement)
      * Non traité par le compilateur IBM ILE COBOL.
      * Accepté sans erreur, ignoré à la compilation.
      *----------------------------------------------------------------
       AUTHOR. NOM02.
      *----------------------------------------------------------------
      * INSTALLATION (OBSOLETE - documentation uniquement)
      * Identifie le site d'installation. Non traité par le compilateur.
      *----------------------------------------------------------------
       INSTALLATION. ENVIRONNEMENT IBM I.

      *----------------------------------------------------------------
      * DATE-WRITTEN (OBSOLETE - documentation uniquement)
      * Date d'écriture du programme. Non traitée par le compilateur.
      *----------------------------------------------------------------
       DATE-WRITTEN. 2024-06-01.

      *----------------------------------------------------------------
      * DATE-COMPILED (OBSOLETE - documentation uniquement)
      *----------------------------------------------------------------
       DATE-COMPILED. 2024-06-01.

      *----------------------------------------------------------------
      * SECURITY (OBSOLETE - documentation uniquement)
      * Niveau de sécurité/confidentialité. Non traité par le compilateur.
      *----------------------------------------------------------------
       SECURITY. CONFIDENTIEL.









      *================================================================
      * ENVIRONMENT DIVISION - ILE COBOL for IBM i
      * Réf : IBM ILE COBOL Language Reference SC09-2539 (IBM i 7.2+)
      * Division OPTIONNELLE - mais fortement utilisée sur IBM i
      * Structure : 2 sections
      *   1. CONFIGURATION SECTION  (optionnelle)
      *   2. INPUT-OUTPUT SECTION   (optionnelle)
      *================================================================
       ENVIRONMENT DIVISION.

      *================================================================
      * SECTION 1 : CONFIGURATION SECTION
      * Décrit l'environnement matériel de compilation et d'exécution.
      * Contient 3 paragraphes possibles :
      *   - SOURCE-COMPUTER
      *   - OBJECT-COMPUTER
      *   - SPECIAL-NAMES
      *================================================================
       CONFIGURATION SECTION.
      *----------------------------------------------------------------
      * SOURCE-COMPUTER (optionnel)
      * Identifie le système sur lequel le source est compilé.
      * Sur IBM i : nom conventionnel IBM-ISERIES ou IBM-AS400.
      * Clause optionnelle : WITH DEBUGGING MODE
      *    Active les lignes de débogage (colonne 7 = 'D')
      *    OBSOLETE depuis COBOL 85 mais toujours supporté ILE COBOL
      *----------------------------------------------------------------
       SOURCE-COMPUTER. IBM-ISERIES WITH DEBUGGING MODE.
      *    Avec debugging mode :
      *    SOURCE-COMPUTER. IBM-ISERIES WITH DEBUGGING MODE.










       PROCEDURE DIVISION.
            STOP RUN.
```
