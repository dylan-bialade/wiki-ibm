---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: RPGF
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 711
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/RPGF

```rpg
**free
// Carte H
//***************************************************************************
// SPÉCIFICATIONS DE CONTRÔLE (Carte H en RPG Full Free)
//***************************************************************************
// En RPG Full Free, les spécifications de contrôle utilisent CTL-OPT
// au lieu des anciennes cartes H de position fixes.
//
// Syntaxe générale: CTL-OPT option1(valeur) option2(valeur) ... ;
//
// OPTIONS PRINCIPALES:
//
// GESTION DES GROUPES D'ACTIVATION:
// - DFTACTGRP(*NO)     : Ne pas utiliser le groupe d'activation par défaut
//                        Requis pour utiliser les procédures et la liaison
// - ACTGRP(*NEW)       : Créer un nouveau groupe d'activation à chaque appel
// - ACTGRP(*CALLER)    : Utiliser le groupe d'activation de l'appelant
// - ACTGRP('NOMGRP')   : Utiliser un groupe d'activation nommé spécifique
//
// FORMATS DE DATE ET HEURE:
// - DATFMT(*ISO)       : Format date YYYY-MM-DD (recommandé, standard ISO)
// - DATFMT(*MDY)       : Format date MM/DD/YYYY
// - DATFMT(*DMY)       : Format date DD/MM/YYYY
// - DATFMT(*YMD)       : Format date YY/MM/DD
// - DATFMT(*JUL)       : Format date julien YY/DDD
// - TIMFMT(*ISO)       : Format heure HH:MM:SS (recommandé, standard ISO)
// - TIMFMT(*HMS)       : Format heure HH:MM:SS
// - TIMFMT(*USA)       : Format heure HH:MM AM/PM
//
// OPTIONS D'IMPRESSION ET DEBUG:
// - DEBUG(*YES)        : Activer les informations de débogage
// - DECEDIT('0,')      : Définir le séparateur décimal (virgule ou point)
// - OPTION(*NODEBUGIO) : Désactiver le débogage des E/S
// - OPTION(*SRCSTMT)   : Inclure les numéros de ligne source
//
// AUTRES OPTIONS UTILES:
// - BNDDIR('NOMDIR')   : Spécifier le répertoire de liaison (binding directory)
// - EXTBININT(*YES)    : Utiliser les entiers binaires externes
// - CCSID(*CHAR:1208)  : Définir le CCSID (ex: 1208 pour UTF-8)
// - ALWBLK(*YES)       : Autoriser le blocage d'enregistrements
// - EXPROPTS(*MAXDIGITS) : Maximiser la précision des calculs décimaux
//
// Note: Toutes les options sont séparées par des espaces et la ligne
// se termine par un point-virgule (;)
//***************************************************************************
ctl-opt dftactgrp(*no) actgrp(*caller) datfmt(*iso) timfmt(*iso) ;


// Carte F
//***************************************************************************
// DÉCLARATIONS DES FICHIERS (Carte F en RPG Full Free)
//***************************************************************************
// En RPG Full Free, les déclarations de fichiers utilisent DCL-F au lieu
// des anciennes cartes F de position fixes.
//
// Syntaxe générale: DCL-F nom_fichier TYPE OPTIONS;
//
// TYPES DE FICHIERS:
// - WORKSTN  : Fichier d'affichage écran (DSPF)
// - DISK     : Fichier de base de données (PF/LF) - peut être omis
// - PRINTER  : Fichier d'impression (PRTF)
//
// OPTIONS PRINCIPALES:
// - USAGE(*INPUT)  : Lecture seule
// - USAGE(*OUTPUT) : Écriture seule
// - USAGE(*UPDATE) : Modification
// - USAGE(*DELETE) : Suppression
// - KEYED          : Accès par clé (fichier avec index)
// - OFLIND(ind)    : Indicateur de débordement pour PRINTER
// - PREFIX(txt_)   : Ajoute un préfixe aux noms de champs du fichier
//
// Les usages multiples se combinent avec ":" comme séparateur
// Exemple: USAGE(*INPUT:*UPDATE:*DELETE:*OUTPUT)
//
// L'ordre des usages n'a pas d'importance en Full Free, contrairement
// aux anciennes spécifications F en position fixe.
//***************************************************************************
dcl-f ECRAN1   WORKSTN; // fichier Ecran

dcl-f CLIENT USAGE(*INPUT)  keyed;  // ficher physique PF avec clé

dcl-f FICHIERPF USAGE(*INPUT:*DELETE:*UPDATE:*OUTPUT) keyed;  // ficher physique PF avec clé

dcl-f FICHIERPF2 USAGE(*INPUT:*DELETE:*UPDATE:*OUTPUT);  // ficher physique PF sans clé

dcl-f FICHIERLF USAGE(*INPUT:*DELETE:*UPDATE:*OUTPUT) keyed;  // ficher physique LF avec clé

dcl-f FICHIERPF3 disk USAGE(*UPDATE : *DELETE : *OUTPUT : *INPUT) keyed
prefix(FICPF_);   // Prefix pour ajouter un préfixe aux champs du fichier


dcl-f PRTF1 printer;   // Fichier PRTF
dcl-f PRTF1 printer oflind(INDPage);   // fichier PRTF  débordement personnalisé


//==============================================================================
// DOCUMENTATION DÉTAILLÉE - DÉCLARATIONS DE VARIABLES RPG IV (FREE FORMAT)
//==============================================================================
// Programme : RPGF.RPGLE
// Localisation : /QF_RPG/QRPGLESRC/RPGF.RPGLE
// Description : Carte D - Démonstration des différents types de données
//               disponibles en RPG IV format libre (Free Format)
//==============================================================================

//------------------------------------------------------------------------------
// SECTION 1 : VARIABLES NUMÉRIQUES
//------------------------------------------------------------------------------
// Cette section présente les différents formats de stockage des nombres
// en RPG IV, chacun ayant ses propres caractéristiques de performance
// et d'utilisation de mémoire.
//------------------------------------------------------------------------------

// ZONED DECIMAL (Format ZONED) :
// - Chaque chiffre occupe UN OCTET complet (8 bits)
// - Le signe est stocké dans la zone du dernier octet
// - Format historique, compatible avec les anciennes applications
// - Exemple : 1234 occupe 4 octets
// - Utilisation : compatibilité avec fichiers externes, affichages

// PACKED DECIMAL (Format PACKED) :
// - Format le plus efficace pour les calculs arithmétiques
// - Deux chiffres sont compactés dans UN SEUL OCTET
// - Le signe occupe le dernier demi-octet
// - Exemple : 12345 occupe 3 octets (5 chiffres + signe)
// - Performance optimale pour les opérations mathématiques
// - Utilisation recommandée : calculs, totalisations, montants

// INITIALISATION (INZ) :
// - Le mot-clé INZ permet d'assigner une valeur par défaut
// - Sans INZ, la variable contient des valeurs indéterminées (garbage)
// - Bonne pratique : toujours initialiser les compteurs et accumulateurs

// PRÉCISION DÉCIMALE (positions:décimales) :
// - Premier nombre : positions totales (entier + décimales)
// - Deuxième nombre : nombre de décimales après la virgule
// - Exemple : Packed(10:2) = 8 chiffres avant + 2 après = 12345678.99
// - Important pour les calculs financiers et monétaires

// INTEGER (INT) :
// - Entier signé sur 4 octets (32 bits)
// - Plage : -2,147,483,648 à +2,147,483,647
// - Pas de décimales possibles
// - Performance optimale pour les compteurs et indices
// - Utilisation : boucles FOR, compteurs, identifiants

// BINARY DECIMAL (BINDEC) :
// - Stockage binaire, mais traité comme décimal
// - BINDEC(9) = 4 octets, capacité jusqu'à 9 chiffres
// - Plus rapide que ZONED, mais moins que PACKED pour les calculs
// - Utilisation : interfaçage avec systèmes externes, APIs

//------------------------------------------------------------------------------
// SECTION 2 : VARIABLES ALPHANUMÉRIQUES (CARACTÈRES)
//------------------------------------------------------------------------------
// Cette section couvre les types de données textuelles et leurs usages
//------------------------------------------------------------------------------

// CHAR (Caractère fixe) :
// - Longueur FIXE et CONSTANTE
// - Complété automatiquement par des espaces (padding)
// - Exemple : CHAR(8) occupe TOUJOURS 8 octets
// - Si valeur = 'BON', le système ajoute 5 espaces : 'BON     '
// - Utilisation : codes fixes, clés, indicateurs

// VARCHAR (Variable Character) :
// - Longueur VARIABLE selon le contenu réel
// - Occupe 2 octets supplémentaires pour stocker la longueur
// - Exemple : VARCHAR(255) peut contenir de 0 à 255 caractères
// - Si valeur = 'BON', occupe seulement 5 octets (2 longueur + 3 données)
// - Avantage : économie de mémoire pour données variables
// - Utilisation : descriptions, messages, données web

// CONSTANTES SPÉCIALES :
// - *BLANKS : représente un ou plusieurs espaces
// - Permet d'initialiser proprement les variables
// - Important pour éviter les caractères parasites

// INITIALISATION DE CHAÎNES :
// - Utiliser INZ('valeur') pour définir un contenu par défaut
// - Les apostrophes (') délimitent les chaînes de caractères
// - Attention : la valeur ne doit pas dépasser la longueur déclarée

//------------------------------------------------------------------------------
// SECTION 3 : TABLEAUX (ARRAYS)
//------------------------------------------------------------------------------
// Les tableaux permettent de stocker plusieurs valeurs du même type
//------------------------------------------------------------------------------

// DÉCLARATION DE TABLEAU :
// - DIM(n) : définit le nombre d'éléments (dimension)
// - Chaque élément a le même type et la même taille
// - Les indices commencent à 1 (pas 0 comme en C/Java)
// - Exemple : tabldd a 10 cases, accessibles de tabldd(1) à tabldd(10)
// - Utilisation : listes, collections, données répétitives

//------------------------------------------------------------------------------
// SECTION 4 : DATES
//------------------------------------------------------------------------------
// RPG IV offre un support natif des dates avec format et validation
//------------------------------------------------------------------------------

// DATE (Format ISO par défaut) :
// - Format DATE simple = ISO (YYYY-MM-DD)
// - Le système valide automatiquement la date
// - Impossible de stocker le 32 janvier ou le 29 février année non-bissextile
// - Opérations arithmétiques possibles : DATE + 30 jours

// DATE AVEC FORMAT SPÉCIFIQUE :
// - *MDY : Month-Day-Year (format américain : MM/DD/YYYY)
// - *DMY : Day-Month-Year (format européen : DD/MM/YYYY)
// - *YMD : Year-Month-Day (format asiatique : YYYY/MM/DD)
// - *ISO : Year-Month-Day (YYYY-MM-DD) - Standard international
// - *USA : Month/Day/Year (MM/DD/YYYY)
// - *EUR : Day.Month.Year (DD.MM.YYYY)
// - *JIS : Year-Month-Day (YYYY-MM-DD) - Standard japonais

// AVANTAGES DU TYPE DATE :
// - Validation automatique des dates
// - Calculs de durées simplifiés
// - Formatage automatique selon le format défini
// - Pas de risque d'erreur de conversion manuelle

//==============================================================================
// BONNES PRATIQUES ET RECOMMANDATIONS
//==============================================================================
// 1. Toujours initialiser les variables (INZ) pour éviter les valeurs parasites
// 2. Utiliser PACKED pour les calculs financiers et montants
// 3. Utiliser INT pour les compteurs et indices de boucles
// 4. Préférer VARCHAR pour les données textuelles de longueur variable
// 5. Utiliser le type DATE natif plutôt que des champs numériques
// 6. Choisir la précision décimale adaptée (éviter sur-dimensionnement)
// 7. Documenter les unités (montants en centimes, dates, etc.)
// 8. Respecter les conventions de nommage (minuscules, noms explicites)
//==============================================================================
//Carte D

// Variable scalaire
// Numérique
Dcl-S zoned        Zoned(4:0); // format ZONED  Chaque chiffre est stocké dans un octet
Dcl-S packed       Packed(5);  // format Packed Deux chiffres décimaux sont stockés par octet
Dcl-S packed2      Packed(5) INZ(100);  // ici on itialise la variable packed2 à 100
Dcl-s resultat     Packed(10:2);  // ici on a deux décimal apres la virgule : exemple 12.10
Dcl-S zoned        Zoned(10:2); // ici on a deux décimal apres la virgule : exemple 12.10

Dcl-S Integer      Int(10); // Représente un entier signé sur 4 octets avec une plage de -214
Dcl-S Bin          Bindec(9); // un nombre entier signé stocké sur 4 octets (32 bits).



// char
// Déclaration d'une variable de type caractère fixe sur 8 positions
Dcl-S phrase       Char(8);

// Déclaration d'une variable de type chaîne variable jusqu'à 255 caractères
Dcl-S phrase2      Varchar(255);

// Déclaration d'une variable contenant un espace (initialisée avec *BLANKS)
Dcl-S SpaceVal     Char(1) inz(*BLANKS);

// Déclaration d'une variable contenant un espace (initialisée avec Sylvain)
Dcl-S nom          Char(7) inz('Sylvain');

// Déclaration d'un tableau nommé `tabldd` composé de 10 éléments
// Chaque élément est une chaîne de 1 caractère (CHAR(1))
// Le mot-clé DIM(10) indique qu'il y a 10 cases dans le tableau
dcl-s tabldd char(1) dim(10);

// date
Dcl-S DATE0        Date;
Dcl-S date_mdy     Date(*MDY);

//*******************************************************************************
// constante
Dcl-C CON_1 CONST(1);
Dcl-C CON_2 CONST('test');

//*******************************************************************************
// DATA STRUCTURE (DS) - EXPLICATION DÉTAILLÉE POUR LES EXPERTS
//*******************************************************************************
//
// Une Data Structure (DS) en RPG IV est une structure de données permettant
// de regrouper et d'organiser plusieurs variables en une seule entité logique.
// Elle offre plusieurs avantages fondamentaux :
//
// 1. ORGANISATION MÉMOIRE :
//    - Définit un espace mémoire contigu où plusieurs champs coexistent
//    - Permet le partage de zones mémoire via l'overlapping (Pos())
//    - Optimise l'utilisation de la mémoire en définissant des vues multiples
//
// 2. TYPES DE DATA STRUCTURES :
//    a) DS Standard : Groupement simple de variables
//    b) DS Qualifiée (QUALIFIED) : Nécessite préfixe pour accéder aux champs
//    c) DS Externe (EXTNAME) : Hérite structure d'un fichier/table
//    d) DS Data Area (DTAARA) : Liée à une zone de données système
//    e) DS Program Status (PSDS) : Informations système et programme
//    f) DS File Information (INFDS) : Informations sur fichiers
//
// 3. OVERLAPPING (Recouvrement) :
//    - Pos(n) : Définit position de début du champ dans la DS
//    - Permet à plusieurs champs de partager la même zone mémoire
//    - Utile pour diviser un champ en sous-parties logiques
//    - Exemple : UserSpace(20) contient SpaceName(10) + SpaceLib(10)
//
// 4. AVANTAGES TECHNIQUES :
//    - Passage de paramètres groupés entre programmes/procédures
//    - Manipulation de données structurées complexes
//    - Interface avec API système IBM i
//    - Conversion et reformatage de données
//    - Gestion d'échange de données (EDI, XML, JSON via DATA-INTO)
//
// 5. CAS D'USAGE DANS CE CODE :
//    - InputDs : Découpe logique d'espaces utilisateurs et fichiers
//    - data_struct : Liaison avec Data Area système (*DTAARA)
//
// SYNTAXE MODERNE (Free-Format RPG IV) :
//    Dcl-DS nom_ds [QUALIFIED] [DTAARA] [EXTNAME('fichier')];
//      champ1 type [Pos(n)];
//      champ2 type [Pos(n)];
//    End-DS;
//



// DS
// Structure de données pour gérer les informations d'espace utilisateur et de fichier
Dcl-DS InputDs;
  // Zone principale de 20 caractères pour l'espace utilisateur complet
  UserSpace      Char(20)   Pos(1);

  // Nom de l'espace utilisateur (10 premiers caractères de UserSpace)
  SpaceName      Char(10)   Pos(1);

  // Bibliothèque de l'espace utilisateur (caractères 11 à 20 de UserSpace)
  SpaceLib       Char(10)   Pos(11);

  // Zone de 20 caractères pour le fichier d'entrée complet avec bibliothèque
  InpFileLib     Char(20)   Pos(29);

  // Nom du fichier d'entrée (10 premiers caractères de InpFileLib)
  InpFFilNam     Char(10)   Pos(29);

  // Bibliothèque du fichier d'entrée (caractères 11 à 20 de InpFileLib)
  InpFFilLib     Char(10)   Pos(39);

  // Format d'enregistrement du fichier d'entrée
  InpRcdFmt      Char(10)   Pos(49);
End-DS;

// dtaara
DCL-DS data_struct;
  mydtaara CHAR(100) DTAARA;
END-DS;

// Prototype
//  ==========================================================================================
// DÉCLARATION DE PROCÉDURE (PROTOTYPE) EN RPG IV FORMAT LIBRE
//  ==========================================================================================
// Un prototype de procédure en RPG IV format libre (Free Format) est une
// déclaration qui spécifie le nom, les paramètres et le type de retour
// d'une procédure externe ou interne avant son utilisation dans le code.
// Syntaxe générale:
// DCL-PR nom_procedure [EXTPGM];
//   param1 type [options];
//   param2 type [options];
//   ...
//   [RETURN type];
// END-PR;
// Points importants:
// - EXTPGM : Indique que la procédure est externe (dans un autre programme)
// - Paramètres : Chaque paramètre est défini avec son type et ses options
// - RETURN : Spécifie le type de retour si la procédure renvoie une valeur
// - Les prototypes permettent au compilateur de vérifier les appels de
//   procédure pour la cohérence des types et du nombre de paramètres
//  ==========================================================================================
DCL-PR myPgm EXTPGM;
  name CHAR(10) CONST;
END-PR;

// Prototype de procédure interne
DCL-PR Addition Packed(10:2);
  num1 Packed(10:2) VALUE;
  num2 Packed(10:2) VALUE;
END-PR;
// Prototype de procédure sans valeur de retour
DCL-PI *N;
  name CHAR(10) CONST;
END-PI;



// Remplissage
SpaceName = 'ESPCLIENT';
SpaceLib = 'LIB1';
InpFFilNam = 'ARTICLE';
InpFFillib = 'LIBDATA';
InpRcdFmt = 'FMT01';

// Affichage du tout
dsply UserSpace;      // ESPCLIENTLIB1
dsply InpFileLib;     // ARTICLELIBDATA
dsply InpRcdFmt;      // FMT01



// Assignation de la valeur 'toto' à la variable phrase
phrase = 'toto';

// Calcul : addition de 8 + 47 et stockage du résultat (55) dans la variable zoned
zoned = 8 + 47 ;


// Positionne le curseur de lecture au début du fichier FICHIERPF (*loval = plus petite valeur)
Setll *loval FICHIERPF;

// Lecture dans FICHIERPF
Read FICHIERPF;

// Écriture dans FICHIERFM
Write FICHIERFM;

// Mise à jour de l'enregistrement courant dans FICHIERFM
Update FICHIERFM;

// Chaînage avec une seule clé
Chain key FICHIERPF;

// il n' a plus de klist kfld
// Chaînage avec deux clés
Chain (key:key2) FICHIERPF;

// Chaînage avec trois clés

Chain (key:key2:key3) FICHIERPF;

// Affichage de l'écran ECRAN1
Exfmt ecranfm1;

// =========================================================================
// Structure conditionnelle IF en RPG Full Free
// =========================================================================
// En RPG Full Free, la structure conditionnelle IF suit cette syntaxe:
// if <condition>;
//   <instructions>;
// endif;
//
// Points importants:
// - Chaque clause (if, endif) se termine par un point-virgule
// - Les opérateurs de comparaison: = (égal), <> (différent), > <
// - Les opérateurs logiques: AND, OR, NOT
// - Le ENDIF est obligatoire pour fermer la structure

If packed2 = 8;
  phrase = 'test';
endif;


// =========================================================================
// Structure conditionnelle IF/ELSEIF/ELSE en RPG Full Free
// =========================================================================
// En RPG Full Free, les structures conditionnelles suivent cette syntaxe:
//
// if <condition>;
//   <instructions>;
// elseif <autre_condition>;
//   <instructions>;
// else;
//   <instructions>;
// endif;
//
// Points importants:
// - Chaque clause (if, elseif, else, endif) se termine par un point-virgule
// - Les opérateurs de comparaison: = (égal), <> (différent), > < >= <=
// - Les opérateurs logiques: AND, OR, NOT
// - Plusieurs conditions peuvent être combinées avec OR/AND
// - Le bloc ELSE est optionnel (exécuté si aucune condition n'est vraie)
// - Le ENDIF est obligatoire pour fermer la structure
// =========================================================================
// SI avec des si et sinon...
if packed2 = 7 or packed = 9;
  phrase = 'test2';
elseif packed = 10;
  phrase = 'bob';
else;
  phrase = 'roger';
endif;


// =============================================================================
// Documentation des structures de boucles en RPG Full Free
// =============================================================================
//
// 1. Boucle DOW (Do While) avec condition de fin de fichier:
//    - Syntaxe: DOW (condition);
//    - Continue tant que la condition est vraie
//    - %EOF indique si la fin du fichier est atteinte
//    - Utilisée pour lire des enregistrements jusqu'à la fin du fichier
//    - Exemple: DOW NOT %EOF(); READ fichier; ... ENDDO;
//    - Permet de traiter chaque enregistrement séquentiellement
//
// 2. Boucle DOW avec condition toujours vraie (boucle infinie):
//    - DOW 1=1; crée une boucle sans fin
//    - Nécessite une instruction LEAVE ou RETURN pour sortir
//    - Utilisée pour des traitements continus ou serveurs
//    - Attention aux boucles infinies non contrôlées
//    - Exemple: DOW 1=1; ... IF condition THEN LEAVE; ENDDO;
//    - Permet de gérer des interruptions ou événements internes
//    - Utile pour les programmes de service
//    - Meilleur performance dans certains cas que DOU ou DOW avec condition variable
//
// 3. Boucle DOU (Do Until):
//    - Syntaxe: DOU (condition);
//    - Continue jusqu'à ce que la condition devienne vraie
//    - S'exécute au moins une fois avant de tester la condition
//
// Note: Toutes les boucles se terminent par ENDDO;
//
// Avertissement: Le message indique qu'une chaîne littérale ('toto') est
// utilisée plusieurs fois. Il est recommandé de définir une constante:
// DCL-C MA_CONSTANTE 'toto';
// =============================================================================
// Tant que pas
Dow (Not %eof);
  packed2 = 1;
enddo;

// Tant que 1=1...
dow 1=1;
  phrase = 'toto';
enddo;

Dou zoned = 8;
  zoned += 1;
enddo;

exsr main;

// do until
dou *in03=*on;
  leave;
enddo;

// ============================================================================
// TRAITEMENT DES OPTIONS DU MENU
// ============================================================================
// Cette structure Select évalue la variable S_OPT et exécute la sous-routine
// appropriée selon l'option choisie par l'utilisateur.
//
// OPTIONS DISPONIBLES:
//   '1' - Exécute la sous-routine OPTION1
//   '2' - Exécute la sous-routine OPTION2
//   '4' - Exécute la sous-routine OPTION4
//   '5' - Exécute la sous-routine OPTION5
//   Autre - Retourne au menu principal (sous-routine main)
//
// AMÉLIORATION SUGGÉRÉE EN RPG FULL FREE:
// Pour éviter la répétition des chaînes littérales, définir des constantes:
//
//   dcl-c OPT_OPTION1 '1';
//   dcl-c OPT_OPTION2 '2';
//   dcl-c OPT_OPTION4 '4';
//   dcl-c OPT_OPTION5 '5';
//
// Puis utiliser dans le Select:
//   Select;
//     When S_OPT = OPT_OPTION1;
//       exsr OPTION1;
//     When S_OPT = OPT_OPTION2;
//       exsr OPTION2;
//     // etc.
//   Endsl;
//
// Cette approche améliore la maintenabilité et évite les erreurs de frappe.
// ============================================================================
// Selon
Select;
When S_OPT = '1';
  exsr OPTION1;
When S_OPT = '2';
  exsr OPTION2;
When S_OPT = '4';
  exsr OPTION4;
When S_OPT = '5';
  exsr OPTION5;
Other;
  exsr main;
Endsl;

resultat = Addition(25.50 : 14.25);  // Appel de la procédure

dsply ('Le résultat est : ' + %char(resultat));  // resultat = 39.75

initialisation_sous_fichier();

*inlr = *on;  // Fin du programme


// ============================================================================
// CONVERSION DE BEGSR/ENDSR VERS RPG FULL FREE
// ============================================================================
// IMPORTANT: En RPG Full Free, les sous-routines BEGSR/ENDSR sont OBSOLÈTES.
// Elles doivent être remplacées par des PROCÉDURES (DCL-PROC/END-PROC).
//
// DIFFÉRENCES CLÉS:
// - BEGSR/ENDSR: Ancien style, appelé par EXSR, pas de paramètres
// - DCL-PROC/END-PROC: Style moderne, appelé par nom(), permet paramètres
//
// AVANTAGES DES PROCÉDURES:
// - Passage de paramètres typés
// - Valeur de retour possible
// - Meilleure encapsulation et réutilisabilité
// - Portée des variables locale (pas de pollution globale)
//
// CONVERSION:
// AVANT (ancien style):
//   BEGSR MAIN;
//     // code
//   ENDSR;
//   // Appelé par: exsr MAIN;
//
// APRÈS (Full Free moderne):
//   dcl-proc MAIN;
//     // code
//   end-proc;
//   // Appelé par: MAIN();
//
// DANS VOTRE CAS: Cette sous-routine traite les enregistrements d'un
// sous-fichier jusqu'à EOF et dispatche selon l'option choisie.
// ============================================================================

// ANCIEN CODE (à remplacer) - Sous-routine legacy
BEGSR MAIN;
  READC EXPD_SFL;
  DOW NOT %EOF();
    select;
    When S_OPT = '1';
      exsr OPTION1;
    When S_OPT = '2';
      exsr OPTION2;
    When S_OPT = '4';
      exsr OPTION4;
    When S_OPT = '5';
      exsr OPTION5;
    Other;
      exsr VALIDATE;
    Endsl;
    READC EXPD_SFL;
  ENDDO;
  MODE='1';
ENDSR;

// ============================================================================
// VERSION MODERNISÉE (recommandée pour RPG Full Free)
// ============================================================================
// Remplacez le code ci-dessus par cette procédure moderne:
//
// dcl-proc MAIN;
//   READC EXPD_SFL;
//   DOW NOT %EOF();
//     select;
//     When S_OPT = '1';
//       OPTION1();  // Appel de procédure au lieu de exsr
//     When S_OPT = '2';
//       OPTION2();
//     When S_OPT = '4';
//       OPTION4();
//     When S_OPT = '5';
//       OPTION5();
//     Other;
//       VALIDATE();
//     Endsl;
//     READC EXPD_SFL;
//   ENDDO;
//   MODE='1';
// end-proc;
//
// Appel: MAIN(); au lieu de exsr MAIN;


// ============================================================================
// Sous procédure Addition
// Cette procédure prend deux nombres en entrée et retourne leur somme
//  en tant que valeur de retour.
// Paramètres:
//  - num1: Premier nombre (packed(10:2))
//  - num2: Deuxième nombre (packed(10:2))
//  Retour:
//  - Somme des deux nombres (packed(10:2))
// Exemple d'appel:
//  resultat = Addition(25.50 : 14.25);  // resultat =  39.75
//  dsply ('Le résultat est : ' + %char(resultat));
//  Résultat affiché: "Le résultat est : 39.75"
//  ===========================================================================
dcl-proc Addition;
  dcl-pi *n packed(10:2);  // Signature de la procédure (type de retour)
    num1 packed(10:2) value;  // Premier paramètre en entrée
    num2 packed(10:2) value;  // Deuxième paramètre en entrée
  end-pi;

  return num1 + num2;  // Calcul de la somme et retour du résultat
end-proc;


dcl-proc initialisation_sous_fichier;
  rang = *zero;      // initialisat° du compteur d'enregistrement.
  last_rang = *zero; // initialisat° du dernier rrn d'enregistrement.
  *in31 = *on;       // Activat° de l'indic de vidage de SFL  (Associé au mot clé SFLCR)
  write SF1CTL;      // Vidage du sous-fichier
  *in31 = *off;      // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLCLR)
  *in32 = *off;      // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLDSP)
  *in90 = *off;      // Désactivat° de l'indic de vidage de SFL (Associé au mot clé SFLend)
end-proc ;
```
