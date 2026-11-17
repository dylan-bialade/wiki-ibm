# TEST : 4 versions differentes dans 3 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB17 | QCLPSRC | CL/CL-procedural | 15 | 100 % | gestion d erreur | [TEST.md](../../sources/CL/CL-procedural/BIB17/TEST.md) |
| BIB01 | QMNUSRC | Menus | 37 | 0 % | DDS (R/K/PFILE) | [TEST.md](../../sources/Menus/BIB01/TEST.md) |
| BIB05 | QRPGLESRC2 | RPG/RPG-ILE | 67 | 0 % | full free, SQL embarque, curseur SQL, boucle DOW/DOU/FOR | [TEST.md](../../sources/RPG/RPG-ILE/BIB05/TEST.md) |
| BIB17 | QRPGLESRC | RPG/RPG-ILE | 4 | 0 % | full free | [TEST.md](../../sources/RPG/RPG-ILE/BIB17/TEST.md) |

## Differences

- **BIB17** en propre : gestion d erreur
- **BIB01** en propre : DDS (R/K/PFILE)
- **BIB05** en propre : full free, SQL embarque, curseur SQL, boucle DOW/DOU/FOR
- **BIB17** en propre : full free
- Langages / types differents : CL/CL-procedural, Menus, RPG/RPG-ILE

## Codes

### BIB17 (CL/CL-procedural, 15 lignes)

```text
             PGM
             STRPCO
             MONMSG     MSGID(IWS4010)
             STRPCCMD   PCCMD('START +
                          https://4613189023.digiforma.net/ts/3054308+
                          /attendances') PAUSE(*NO)
             ADDLIBLE   LIB(BIB17)







             ENDPGM
```

### BIB01 (Menus, 37 lignes)

```text
     A* Menu de format libre : TEST
     A*%%TS  SD  20251010  101733  FADRIEN     REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3                  -
     A                                             27 132 *DS4)
     A                                      CHGINPDFT
     A                                      INDARA
     A                                      PRINT(*LIBL/QSYSPRT)
     A          R TEST
     A                                      DSPMOD(*DS3)
     A                                      LOCK
     A                                      SLNO(01)
     A                                      CLRL(*ALL)
     A                                      ALWROL
     A                                      CF03
     A                                      HELP HOME
     A                                      HLPRTN
     A                                 01002'TEST'
     A                                      COLOR(BLU)
     A                                 01034'TEST Menu'
     A                                      DSPATR(HI)
     A                                 03002'Choisir une des options suivantes -
     A                                      :'
     A                                      COLOR(BLU)
     A                                 05007'1.'
     A                                 06007'2.'
     A                                 07007'3.'
     A                                 08007'4.'
     A                                 09007'5.'
     A                                 10007'6.'
     A                                 11007'7.'
     A                                 12007'8.'
     A                                 13007'9.'
     A                                 14006'10.'
     A* CMDPROMPT  Ne pas supprimer cette spécification DDS.
     A                                019002'Option ou commande                -
     A                                          '
```

### BIB05 (RPG/RPG-ILE, 67 lignes)

```text
**FREE
// ============================================================
// Programme : LSTCLIENT
// Objet     : Liste les clients de la table DEMOGIT.CLIENT
// Auteur    : Sylvain BIB02  NOTOS (Groupe Armonie)
// Date      : Mars 2026
// Compil    : CRTSQLRPGI OBJ(DEMOGIT/LSTCLIENT)
//             SRCSTMF('/home/SAKTEPE/demo-rpg-ibmi/qrpglesrc/lstclient.sqlrpgle')
//             COMMIT(*NONE) DBGVIEW(*SOURCE)
// ============================================================
CTL-OPT COPYRIGHT('(C) ARMONIE 2026.')
        OPTION(*SRCSTMT)
        DFTACTGRP(*NO)
        ACTGRP(*CALLER)
        DATFMT(*ISO)
        TIMFMT(*ISO);

// ---------------------------------------------------------------
// Déclaration des variables
// ---------------------------------------------------------------
Dcl-S wNom    Char(25);
Dcl-S wPrenom Char(25);
Dcl-S wMsg    Char(50);
dcl-s attendre  char(1);  // Variable "pause"
dcl-s message char(10) inz('git');

// ---------------------------------------------------------------
// Options SQL
// ---------------------------------------------------------------
EXEC SQL
  SET OPTION COMMIT = *NONE,
             DATFMT = *ISO,
             TIMFMT = *ISO,
             ALWCPYDTA = *OPTIMIZE,
             CLOSQLCSR = *ENDMOD;

// ---------------------------------------------------------------
// Traitement principal
// ---------------------------------------------------------------

// Déclaration du curseur
EXEC SQL
  DECLARE C1 CURSOR FOR
    SELECT NOMCLI, PRECLI
      FROM DEMOGIT.CLIENT
     ORDER BY NUMCLI;

// Ouverture du curseur
EXEC SQL OPEN C1;

// Première lecture
EXEC SQL FETCH C1 INTO :wNom, :wPrenom;

dsply message '' attendre;

// Boucle de lecture
DoW SQLCOD = 0;
  wMsg = %TrimR(wPrenom) + ' ' + %TrimR(wNom);
  Dsply wMsg '' attendre;
  EXEC SQL FETCH C1 INTO :wNom, :wPrenom;
EndDo;

// Fermeture du curseur
EXEC SQL CLOSE C1;

*InLR = *On;
Return;
```

### BIB17 (RPG/RPG-ILE, 4 lignes)

```text
**free
dcl-f univV2 usage(*input) keyed
        extdesc('ANIME/UNIVERSV2') extfile(*extdesc);
*inlr = *on;
```
