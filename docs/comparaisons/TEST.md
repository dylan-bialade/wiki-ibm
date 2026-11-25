# TEST : 8 versions differentes dans 5 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB01 | QMNUSRC | Menus | 37 | 0 % | DDS (R/K/PFILE) | [TEST.md](../../sources/Menus/BIB01/TEST.md) |
| BIB05 | QRPGLESRC2 | RPG/RPG-ILE | 67 | 0 % | full free, SQL embarque, curseur SQL, boucle DOW/DOU/FOR | [TEST.md](../../sources/RPG/RPG-ILE/BIB05/TEST.md) |
| BIB17 | QCLPSRC | CL/CL-procedural | 15 | 0 % | gestion d erreur | [TEST.md](../../sources/CL/CL-procedural/BIB17/TEST.md) |
| BIB17 | QRPGLESRC | RPG/RPG-ILE | 4 | 0 % | full free | [TEST.md](../../sources/RPG/RPG-ILE/BIB17/TEST.md) |
| BIB25 | QSQLSRC | SQL | 1 | 0 % | CREATE TABLE/VIEW | [TEST.md](../../sources/SQL/BIB25/TEST.md) |
| BIB27 | QBNDSRC | Autres/Service-programs | 28 | 100 % | full free, prototypes (dcl-pr) | [TEST.md](../../sources/Autres/Service-programs/BIB27/TEST.md) |
| BIB27 | QCLSRC | CL/CL-procedural | 26 | 0 % | boucle DOW/DOU/FOR, gestion d erreur, CL : DCLF | [TEST.md](../../sources/CL/CL-procedural/BIB27/TEST.md) |
| BIB27 | QSQL | RPG/RPG-III-400 | 1 | 0 % | CREATE TABLE/VIEW | [TEST.md](../../sources/RPG/RPG-III-400/BIB27/TEST.md) |

## Differences

- **BIB01** en propre : DDS (R/K/PFILE)
- **BIB05** en propre : full free, SQL embarque, curseur SQL, boucle DOW/DOU/FOR
- **BIB17** en propre : gestion d erreur
- **BIB17** en propre : full free
- **BIB25** en propre : CREATE TABLE/VIEW
- **BIB27** en propre : full free, prototypes (dcl-pr)
- **BIB27** en propre : boucle DOW/DOU/FOR, gestion d erreur, CL : DCLF
- **BIB27** en propre : CREATE TABLE/VIEW
- Langages / types differents : Autres/Service-programs, CL/CL-procedural, Menus, RPG/RPG-III-400, RPG/RPG-ILE, SQL

## Codes

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
// Auteur    : Sylvain BIB02  ORGFORM (Groupe ORGFORM)
// Date      : Mars 2026
// Compil    : CRTSQLRPGI OBJ(DEMOGIT/LSTCLIENT)
//             SRCSTMF('/home/NOM01/demo-rpg-ibmi/qrpglesrc/lstclient.sqlrpgle')
//             COMMIT(*NONE) DBGVIEW(*SOURCE)
// ============================================================
CTL-OPT COPYRIGHT('(C) ORGFORM 2026.')
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

### BIB17 (RPG/RPG-ILE, 4 lignes)

```text
**free
dcl-f univV2 usage(*input) keyed
        extdesc('ANIME/UNIVERSV2') extfile(*extdesc);
*inlr = *on;
```

### BIB25 (SQL, 1 lignes)

```text
create table lgpoeim.test ( id int)
```

### BIB27 (Autres/Service-programs, 28 lignes)

```text
**free
ctl-opt bnddir('BIB27/TESTREP');

dcl-pr soustraction packed(4:0);
  nbr1 packed(4:0);
  nbr2 packed(4:0);
end-pr;

dcl-pr multi packed(7:0);
  nbr1 packed(4:0);
  nbr2 packed(4:0);
END-PR;

dcl-s result packed(4:0);
dcl-s result1 packed(7:0);
dcl-s nbr1 packed(4:0) inz(52);
dcl-s nbr2 packed(4:0) inz(15);


result = soustraction(nbr1:nbr2);

dsply result;

result1 = multi(nbr1:nbr2);

dsply result1;

*inlr = *on;
```

### BIB27 (CL/CL-procedural, 26 lignes)

```text
             PGM        PARM(&LIB)

             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&NAME) TYPE(*CHAR) LEN(10)
             DCL        VAR(&REPO) TYPE(*CHAR) LEN(50)

             DCLF       FILE(QSYS/QAFDPHY) OPNID(F)
             DLTOBJ     OBJ(QTEMP/*ALL) OBJTYPE(*FILE)
             MONMSG     MSGID(CPF2125)
             DSPFD      FILE(&LIB/*ALL) TYPE(*ATR) OUTPUT(*OUTFILE) +
                          FILEATR(*PF) OUTFILE(QTEMP/LISTPF)

             OVRDBF     FILE(QAFDPHY) TOFILE(QTEMP/LISTPF)
 BOUCLE:     RCVF       OPNID(F)
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(FIN))
             CHGVAR     VAR(&REPO) +
                          VALUE('/home/leo2/sauvegarde2023/' +
                          *TCAT &F_PHFILE *TCAT '.csv')
             IF         COND(%SST(&F_PHFCDT 1 2) *EQ '23') THEN(DO)
             CPYTOIMPF  FROMFILE(&F_PHLIB/&F_PHFILE) TOSTMF(&REPO) +
                          MBROPT(*REPLACE) STMFCODPAG(1252) +
                          RCDDLM(*CRLF) STRDLM(*NONE) FLDDLM(';')
             MONMSG     MSGID(CPF2817)
             ENDDO
             GOTO       CMDLBL(BOUCLE)
 FIN:        ENDPGM
```

### BIB27 (RPG/RPG-III-400, 1 lignes)

```text
CREATE TABLE BIB27.USER ( ID INT , NOM CHAR(25));
```
