---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: IFSWRITE
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 174
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/IFSWRITE

```rpg
**FREE
//---------------------------------------------------------------------
// Programme : TP2_RAPPORT
// Auteur    : SYLVAIN BIB02
// Date      : 05/11/2025
// Version   : 1.0
//
// Description :
// Ce programme SQLRPGLE lit les données des tables ETUDIANT et NOTE,
// calcule la moyenne de chaque étudiant, et génère un fichier texte
// dans lIFS avec le format suivant :
//
//   Rapport généré le 2025-11-02 à 15:08:42
//   Prenom Nom - Matiere : Note
//   BELLO Aminu - Info : 15.00
//   BELLO Aminu - Phys : 14.00
//   Moyenne : 14.50
//   NOVAK ivan - math :   9.00
//   ...

// Objectifs pédagogiques :
//   - Manipuler les curseurs SQL dans un programme RPG Free.
//   - Utiliser les procédures QSYS2.IFS_* pour écrire dans lIFS.
//   - Formater les chaînes avec les BIFs (%trim, %upper, %editc).
//   - Gérer les changements détudiant pour calculer les moyennes.
//---------------------------------------------------------------------

ctl-opt dftactgrp(*no) actgrp(*caller)
         option(*nodebugio:*srcstmt)
         timfmt(*iso) datfmt(*iso);

//---------------------------------------------------------------------
// Configuration SQL : pas de commit, format ISO pour les dates et heures
//---------------------------------------------------------------------
exec sql
  set option commit = *none, datfmt = *iso, timfmt = *iso, closqlcsr = *endmod;

//---------------------------------------------------------------------
// Déclaration des variables
//---------------------------------------------------------------------
dcl-s ligne       varchar(200);    // Ligne de texte à écrire dans le fichier IFS
dcl-s total       zoned(7:2);      // Total des notes de létudiant en cours
dcl-s nbnotes     int(10);         // Nombre de notes de létudiant en cours
dcl-s moy         zoned(7:2);      // Moyenne calculée pour létudiant
dcl-s prenomMaj   varchar(50);     // Prénom formaté
dcl-s nomMaj      varchar(50);     // Nom formaté en majuscules
dcl-s id_etu      int(10);         // Identifiant étudiant
dcl-s prenom      varchar(50);     // Prénom lu en base
dcl-s nom         varchar(50);     // Nom lu en base
dcl-s datenaiss   date;            // Date de naissance (non utilisée dans laffichage)
dcl-s matiere     varchar(30);     // Matière
dcl-s note        zoned(5:2);      // Note
dcl-s lastId      int(10) inz(0);  // Permet de détecter le changement détudiant
dcl-s chemin      varchar(30) inz('/home/sylvain/resultat.txt'); // Fichier cible IFS

//---------------------------------------------------------------------
// 1. Effacer le fichier sil existe (évite lajout en doublon)
//---------------------------------------------------------------------
exec sql
  call qsys2.ifs_remove_file(:chemin);

//---------------------------------------------------------------------
// 2. Écrire len-tête du rapport : date, heure, structure de colonnes
//---------------------------------------------------------------------
exec sql
  CALL QSYS2.IFS_WRITE_UTF8(
  PATH_NAME => :chemin,
  LINE      => 'Rapport généré le ' CONCAT CHAR(CURRENT_DATE, ISO)
                CONCAT ' à ' CONCAT CHAR(CURRENT_TIME, ISO),
   OVERWRITE => 'REPLACE',
   END_OF_LINE => 'LF');

ligne = 'Prenom Nom - Matiere : Note';
exec sql
  CALL QSYS2.IFS_WRITE_UTF8(
     PATH_NAME => :chemin,
     LINE      => :ligne,
     OVERWRITE => 'APPEND',
     END_OF_LINE => 'LF');

//---------------------------------------------------------------------
// 3. Lecture SQL : jointure ETUDIANT/NOTE triée du plus âgé au plus jeune
//---------------------------------------------------------------------
exec sql
  declare c1 cursor for
    select e.id_etu,
           e.prenom,
           e.nom,
           e.datenaiss,
           n.matiere,
           n.note
      from etudiant e
      join note n on e.id_etu = n.id_etu
      order by e.datenaiss asc, e.nom, e.prenom;

exec sql open c1;

//---------------------------------------------------------------------
// 4. Boucle principale de lecture du curseur
//---------------------------------------------------------------------
dow 1 = 1;
  exec sql fetch c1 into :id_etu, :prenom, :nom, :datenaiss, :matiere, :note;

  // Condition de sortie de boucle (fin de curseur SQL)
  if sqlcode <> 0;
    leave;
  endif;

  //-------------------------------------------------------------------
  // Si on change détudiant : calcul et écriture de la moyenne précédente
  //-------------------------------------------------------------------
  if id_etu <> lastId and lastId <> 0;
    moy = total / nbnotes;
    ligne = 'Moyenne : ' + %editc(moy:'J');  // Formatage numérique 2 décimales
    exec sql
      CALL QSYS2.IFS_WRITE_UTF8(
         PATH_NAME => :chemin,
         LINE      => :ligne,
         OVERWRITE => 'APPEND',
         END_OF_LINE => 'LF');
    total = 0;
    nbnotes = 0;
  endif;

  //-------------------------------------------------------------------
  // Écriture de la ligne Prenom Nom - Matiere : Note
  //-------------------------------------------------------------------
  nomMaj = %upper(%trim(nom));  // Met le nom en majuscules
  prenomMaj = %trim(prenom);    // Prénom inchangé
  ligne = %trim(nomMaj) + ' ' + %trim(prenomMaj) + ' - ' +
          %trim(matiere) + ' : ' + %editc(note:'J');  // Ligne finale formattée

  exec sql
    CALL QSYS2.IFS_WRITE_UTF8(
        PATH_NAME => :chemin,
        LINE      => :ligne ,
        OVERWRITE => 'APPEND',
        END_OF_LINE => 'LF');

  // Cumul pour calcul de moyenne
  total += note;
  nbnotes += 1;
  lastId = id_etu;
enddo;

//---------------------------------------------------------------------
// 5. Traitement du dernier étudiant (moyenne finale)
//---------------------------------------------------------------------
if nbnotes > 0;
  moy = total / nbnotes;
  ligne = 'Moyenne : ' + %editc(moy:'J');
  exec sql
    CALL QSYS2.IFS_WRITE_UTF8(
        PATH_NAME => :chemin,
        LINE      => :ligne ,
        OVERWRITE => 'APPEND',
        END_OF_LINE => 'LF');
endif;

//---------------------------------------------------------------------
// 6. Fermeture du curseur SQL
//---------------------------------------------------------------------
exec sql close c1;

//---------------------------------------------------------------------
// 7. Message de confirmation dans la console IBM i
//---------------------------------------------------------------------
dsply ('Rapport généré : ' + chemin);

//---------------------------------------------------------------------
// Fin du programme
//---------------------------------------------------------------------
*inlr = *on;
return;
```
