---
bibliotheque: BIB12
fichier_source: QDDSSRC
membre: TST
type: DDS
longueur_enregistrement: 100
lignes: 58
modifie: 2026-11-16
---

# BIB12/QDDSSRC/TST

```text
**free
ctl-opt dftactgrp(*no) actgrp(*new);

// =================================================================
// 1. Déclarations des fichiers (avec TEMPLATE pour éviter les doublons)
// =================================================================
// Version V1
dcl-f mangas usage(*input) keyed usropn block(*yes) template;
dcl-f unilf  usage(*input) keyed usropn block(*yes) template;

// Version V2 (Partagent les mêmes formats MANGASFM et UNIVERSF)
dcl-f mangas2 usage(*input) keyed usropn block(*yes) template;
dcl-f unilf2  usage(*input) keyed usropn block(*yes) template;


// =================================================================
// 2. Exemples d'appels dynamiques selon le traitement en cours
// =================================================================

// Si le traitement demande la V1 :
TraiterMangas(mangas:MANGASFM);

// Si le traitement demande la V2 :
TraiterMangas(mangas2);


*inlr = *on;

// =================================================================
// 3. Procédure Unique et Générique
// =================================================================
dcl-proc TraiterMangas;
  dcl-pi *n;
    // Le paramètre accepte n'importe quel fichier basé sur le modèle "mangas"
    FicParam likefile(mangas) usropn;
    enrge likerec(MANGASFM:*input);
  end-pi;

  // Déclaration de la structure de données basée sur le format commun
  dcl-ds EnregManga likerec(enrge : *input);
  dcl-s CleManga packed(4:0); // À adapter selon le type de votre clé

  // Ouverture dynamique du fichier passé en paramètre
  if not %open(FicParam);
    open FicParam;
  endif;

  // Exemple de lecture chaînée (KEYED) avec le format qualifié
  chain CleManga FicParam.MANGASFM EnregManga;

  if %found(FicParam);
    // Votre logique de traitement ici (ex: EnregManga.Titre...)
  endif;

  // Fermeture du fichier en fin de procédure
  close FicParam;

end-proc;
```
