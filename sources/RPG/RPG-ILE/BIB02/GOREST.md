---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: GOREST
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 344
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/GOREST

```rpg
**FREE

// ----------------------------------------------------------------------//
// INDICATEURS SOUS FICHIERS :                                           //
// ----------------------------------------------------------------------//
// SFLDSPCTL : N40                                                       //
// SFLDSP : 41                                                           //
// SFLCLR : 42                                                           //
// SFLEND : N40                                                          //
// Gestion d'erreur : 99                                                 //
// ----------------------------------------------------------------------//

ctl-opt dftactgrp(*no) actgrp(*caller);

// Déclaration du sous fichier
dcl-f egorest workstn sfile(sfl01:ligne);

// Déclaration des variables
dcl-s id          int(10);
dcl-s name        char(20);
dcl-s email       char(20);
dcl-s gender      char(10);
dcl-s status      char(10);

// Variables pour l'affichage détaillé
dcl-s fid         int(10);
dcl-s fname       char(30);
dcl-s femail      char(30);


dcl-s ligne zoned(4:0);

// url et options HTTP
dcl-s url         varchar(256) inz('https://gorest.co.in/public/v2/users');

// Options HTTP pour l'authentification
dcl-s httpOptions varchar(512) inz(
  '{"header":"Authorization,Bearer f9567ea4164009b69d6e72384ef1b364b1b9bde7dfa9aff53f0d4c26f7480b8f"
);



// Déclaration d'une constante pour les enregsitrements
dcl-c MaxRec 9999;

// Paramètres SQL
EXEC SQL SET OPTION COMMIT = *NONE;

// Déclaration du curseur
// Curseur principal (tous)
exec sql
    declare c1 cursor for
        select *
        from json_table(
                qsys2.http_get (
                    :url,
                    :httpOptions
                ),
            '$[*]' COLUMNS (
                id int path '$.id',
                name varchar(200) path '$.name',
                email varchar(200) path '$.email',
                gender varchar(10) path '$.gender',
                status varchar(20) path '$.status'
            )
        );

LoadSfl();

dou *inkc;
    write foot;
    exfmt ctl01;
    select;
        when *inke;
            LoadSfl();
        when *inkf;
            //CreateRestaurant();
    endsl;
    ReadSfl();
    LoadSfl();
enddo;
*inlr = *on;



// ------------------------------------------------------
// Sous-procédure de chargement du sous fichier
// ------------------------------------------------------
dcl-proc LoadSfl;
    // Reset des lignes
    ligne = 0;

    // on vide le sous fichier
    *in42 = *on;
    write CTL01;
    *in42 = *off;

    // Ouverture du curseur
    exec sql
        open c1;

    // Boucle d'écriture
    dow 1 = 1;
        exec sql
        fetch c1 into
            :id,
            :name,
            :email,
            :gender,
            :status;
        // Gestion erreur / sqlcode 100 ou Maxrec
        if sqlcode <> 0 or ligne = MaxRec;
            dsply ('sqlcode=' + %char(sqlcode));
            leave;
        endif;

        name = Truncate(name);
        email = Truncate(email);

        ligne += 1;
        if ligne = 7;
            leave;
        endif;
        // dsply ('Ligne=' + %char(ligne));
        // dsply ('ID=' + %char(id));
        // dsply ('Name=' + name);
        write SFL01;
    enddo;

    // si il y a une ligne on active le sf
    if ligne > 0;
        *in41 = *on;
    else;
        *in41 = *off;
    endif;

    // On ferme le curseur
    exec sql
        close c1;
end-proc;


// ------------------------------------------------------
// Sous-procédure de lecture du sous fichier
// ------------------------------------------------------
dcl-proc ReadSfl;
    dow 1 = 1;
        readc SFL01;
        if (%eof);
            leave;
        endif;

        select;
            when OPT = '2';
                UpdateUser(id);
            when OPT = '4';
                //DeleteUser(id);
            when OPT = '5';
                ShowUser(id);
            other;
                fmsg = 'l''option ' + opt + ' est incorrecte';
        endsl;
        OPT = ' ' ;
    enddo;
end-proc;

// ------------------------------------------------------
// Sous-procédure de troncature des zones texte
// ------------------------------------------------------
dcl-proc Truncate;
    dcl-pi *n char(20);
        texte varchar(20) const;
    end-pi;

    if %len(%trimr(texte)) > 17;
        return %subst(texte:1:17) + '...';
    else;
        return %trimr(texte);
    endif;
end-proc;


// ------------------------------------------------------
// Sous-procédure d'Affichage
// ------------------------------------------------------
dcl-proc ShowUser;
    dcl-pi *n;
        id int(10) const;
    end-pi;
    //*in50 = *on;
    *in99 = *off;
    titre = 'Affichage de l''utilisateur';
    fopt = 'F12=Retour';

    if *inkl;
        return;
    endif;

    // Récupération du client complet
    EXEC SQL
        select
            id,
            name,
            email,
            gender,
            status
        into
            :fid,
            :fname,
            :femail,
            :gender,
            :status
        from json_table(
                qsys2.http_get (
                    :url,
                    :httpOptions
                ),
            '$[*]' COLUMNS (
                id int path '$.id',
                name varchar(200) path '$.name',
                email varchar(200) path '$.email',
                gender varchar(10) path '$.gender',
                status varchar(20) path '$.status'
            )
        )
        where id = :id;

    if SQLCODE = 0;
        exfmt FMT1;
    else;
        dsply ('Erreur SQL : ' + %char(sqlcode));
        *inkl = *on; // Annuler l'affichage
    endif;
end-proc;


// ------------------------------------------------------
// Sous-procédure de Suppression
// ------------------------------------------------------


// ------------------------------------------------------
// Sous-procédure de Mise à jour
// ------------------------------------------------------
dcl-proc UpdateUser;
    dcl-pi *n;
        id int(10) const;
    end-pi;

    titre = 'Modification de l''utilisateur';
    fopt = 'F12=Anuuler   F23=Valider';

    // Désactivation des zones protégées
    //*in50 = *off;
    *in99 = *off; // Gestion des erreurs
    //%subarr(*in : 60 : 4) = *off; // Eteins les indicateurs de 60 à 64

    // Récupération du client complet
    EXEC SQL
        select
            id,
            name,
            email,
            gender,
            status
        into
            :fid,
            :fname,
            :femail,
            :gender,
            :status
        from json_table(
                qsys2.http_get (
                    :url,
                    :httpOptions
                ),
            '$[*]' COLUMNS (
                id int path '$.id',
                name varchar(200) path '$.name',
                email varchar(200) path '$.email',
                gender varchar(10) path '$.gender',
                status varchar(20) path '$.status'
            )
        )
        where id = :id;

    if SQLCODE <> 0;
        dsply ('Erreur SQL : ' + %char(sqlcode));
        *inkl = *on; // Annuler la modification
        return;
    endif;

    dow 1 = 1;
        exfmt FMT1;
        // Annuler la modification
        if *inkl = *on;
            leave;
        endif;

        // Validation de la saisie
        //ControleSaisie();

        // Si pas d'erreur, on met à jour
        if *in23 =*on and *in99 = *off;
            dsply ('Mise à jour de l''utilisateur ID=' + %char(id));
            // Mise à jour en base de données
        EXEC SQL
        select
            id,
            name,
            email,
            gender,
            status
        into
            :fid,
            :fname,
            :femail,
            :gender,
            :status
        from json_table(
                qsys2.http_put (
                    :url,
                    :httpOptions
                ),
            '$[*]' COLUMNS (
                id int path '$.id',
                name varchar(200) path '$.name',
                email varchar(200) path '$.email',
                gender varchar(10) path '$.gender',
                status varchar(20) path '$.status'
            )
        )
        where id = :id;

            if SQLCODE = 0;
                fmsg = 'Utilisateur mis à jour avec succès';
                leave;
            else;
                dsply ('Erreur SQL : ' + %char(sqlcode));
                exfmt FMT1;
            endif;
        endif;
    enddo;
end-proc;
```
