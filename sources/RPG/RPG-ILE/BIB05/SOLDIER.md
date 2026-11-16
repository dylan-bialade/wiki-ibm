---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: SOLDIER
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 171
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/SOLDIER

```rpg
**FREE
ctl-opt dftactgrp(*no) actgrp(*caller);

// ============================================================================
// Programme : PSOLDAT_SQL
// Description : Gestion des soldats - Version RPG ILE Full Free avec SQL
// ============================================================================

dcl-f ESOLDAT workstn;

// Variables pour les données du soldat
dcl-s wIdSld   packed(5:0);
dcl-s wNmSld   char(30);
dcl-s wPrSld   char(30);
dcl-s wArSld1  char(30);
dcl-s wClaSld  char(20);

// Messages
dcl-s MSG char(52) dim(4);

// Indicateur de soldat trouvé
dcl-s soldatTrouve ind;

// Initialisation des messages
MSG(1) = 'Le Soldat a été supprimé';
MSG(2) = 'Le Soldat a été modifié';
MSG(3) = 'Numéro de Soldat inexistant';
MSG(4) = 'Le Soldat a été créé';

// Boucle principale
dow not *INKC;
    exfmt FMT1;
    MES = *blanks;

    // Si pas F3 (sortie) et pas F6 (création)
    if not *INKC and not *INKF;
        afficherSoldat();
    endif;

    // Mode création (F6)
    if *INKF;
        dow *on;
            if *INKC or *INKL;
                leave;
            endif;

            autoIncrement();
            exfmt FMT3;

            if IDSLD <> *zero
               and NMSLD <> *blanks
               and PRSLD <> *blanks
               and ARSLD1 <> *blanks
               and CLASLD <> *blanks;
                creerSoldat();
                leave;
            endif;
        enddo;
    endif;
enddo;

*inlr = *on;
return;

// ============================================================================
// Procédure : afficherSoldat
// Description : Affiche et gère un soldat existant
// ============================================================================
dcl-proc afficherSoldat;

    exec sql
        SELECT IDSLD, NMSLD, PRSLD, ARSLD1, CLASLD
        INTO :wIdSld, :wNmSld, :wPrSld, :wArSld1, :wClaSld
        FROM SOLDAT
        WHERE IDSLD = :IDSLD
        FETCH FIRST 1 ROW ONLY;

    if sqlcode = 0;
        // Charger les valeurs dans les champs écran
        NMSLD = wNmSld;
        PRSLD = wPrSld;
        ARSLD1 = wArSld1;
        CLASLD = wClaSld;

        dow not *INKC and not *INKL;
            exfmt FMT2;

            // F13 = Suppression
            if *INKM;
                supprimerSoldat();
                leave;
            endif;

            // F23 = Modification
            if *INKX;
                modifierSoldat();
                leave;
            endif;
        enddo;
    else;
        MES = MSG(3);
    endif;

end-proc;

// ============================================================================
// Procédure : supprimerSoldat
// Description : Supprime le soldat courant
// ============================================================================
dcl-proc supprimerSoldat;

    exec sql
        DELETE FROM SOLDAT
        WHERE IDSLD = :IDSLD;

    MES = MSG(1);

end-proc;

// ============================================================================
// Procédure : modifierSoldat
// Description : Met à jour le soldat courant
// ============================================================================
dcl-proc modifierSoldat;

    exec sql
        UPDATE SOLDAT
        SET NMSLD = :NMSLD,
            PRSLD = :PRSLD,
            ARSLD1 = :ARSLD1,
            CLASLD = :CLASLD
        WHERE IDSLD = :IDSLD;

    MES = MSG(2);

end-proc;

// ============================================================================
// Procédure : creerSoldat
// Description : Crée un nouveau soldat
// ============================================================================
dcl-proc creerSoldat;

    exec sql
        INSERT INTO SOLDAT (IDSLD, NMSLD, PRSLD, ARSLD1, CLASLD)
        VALUES (:IDSLD, :NMSLD, :PRSLD, :ARSLD1, :CLASLD);

    MES = MSG(4);

end-proc;

// ============================================================================
// Procédure : autoIncrement
// Description : Génère le prochain ID disponible
// ============================================================================
dcl-proc autoIncrement;

    dcl-s maxId packed(5:0);

    exec sql
        SELECT COALESCE(MAX(IDSLD), 0)
        INTO :maxId
        FROM SOLDAT;

    if sqlcode = 0;
        IDSLD = maxId + 1;
    else;
        IDSLD = 1;
    endif;

end-proc;
```
