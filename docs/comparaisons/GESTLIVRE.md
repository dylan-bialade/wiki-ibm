# GESTLIVRE : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB10 | QRPGSRC | RPG/RPG-III-400 | 154 | 100 % | ecran (WORKSTN), boucle DOW/DOU/FOR, procedures (dcl-proc), indicateurs *INxx | [GESTLIVRE.md](../../sources/RPG/RPG-III-400/BIB10/GESTLIVRE.md) |
| BIB05 | QRPGSRC | RPG/RPG-III-400 | 64 | 12 % | ecran (WORKSTN), SETLL / READ, boucle DOW/DOU/FOR, indicateurs *INxx | [GESTLIVRE.md](../../sources/RPG/RPG-III-400/BIB05/GESTLIVRE.md) |

## Differences

- Techniques communes : ecran (WORKSTN), boucle DOW/DOU/FOR, indicateurs *INxx
- **BIB10** en propre : procedures (dcl-proc)
- **BIB05** en propre : SETLL / READ

## Codes

### BIB10 (RPG/RPG-III-400, 154 lignes)

_Long : voir [GESTLIVRE.md](../../sources/RPG/RPG-III-400/BIB10/GESTLIVRE.md)._

### BIB05 (RPG/RPG-III-400, 64 lignes)

```text
      *NOMPGM:GESTIONAIRE LIVRE
      *NOMPROP:BIB05
      *FILLEDEPEND:LIVRES(DTA) LIVRESL(LF) LIVRESDS(ECRAN)
     * SI TU VOIS SA TU A COPIER BIB05
      *============================================================
     FLIVRESDSCF  E                    WORKSTN
     FLIVRESL UF  E           K        DISK                      A
     C           DEBUT     TAG
     C                     SETOF                     12    OFF RETOUR
     C                     EXFMTFMT1
     C           ISBN      SETLLLIVREF
     C                     READ LIVREF                   90
      * BOUCLE EXIT
     C           *IN03     DOWEQ*OFF                       EXIT
      *SI 12 RETOUR ECRAN AVANT
     C           *IN12     IFEQ *ON                        RETURN
     C                     GOTO DEBUT
     C                     ENDIF
     C           *IN90     IFEQ *OFF
     C           OPT       COMP 'M'                      91INDI DE MODIF
     C           OPT       COMP 'D'                      92INDI DE DELETE
      *DEBUT MODIF
     C           *IN91     IFEQ *ON
     C                     MOVE 'MODIF'   MSG
     C           ISBN      CHAINLIVREF               90
     C                     MOVELTITRE     TITRE
     C                     MOVELAUTEUR    AUTEUR
     C                     MOVELDISPO     DISPO
     C                     EXFMTFMT2
     C                     UPDATLIVREF
     C                     ENDIF
      *DEBUT SUPP
     C           *IN92     IFEQ *ON
     C                     MOVE 'DELETE'  MSG
     C                     EXFMTFMT2
     C           *IN23     IFEQ *ON
     C           ISBN      CHAINLIVREF               90
     C                     EXFMTFMT2
     C                     DELETLIVREF
     C                     ENDIF
     C                     ENDIF
      *DEBUT CRÉATION
     C           *IN06     IFEQ *ON
     C                     MOVE 'CREATE'  MSG
     C           *HIVAL    CHAINLIVREF               90
     C                     ADD  1         ISBN
     C                     MOVEL*BLANK    TITRE
     C                     MOVEL*BLANK    AUTEUR
     C                     MOVEL*BLANK    DISPO
     C                     MOVELTITRE     TITRE
     C                     MOVELAUTEUR    AUTEUR
     C                     MOVELDISPO     DISPO
     C                     EXFMTFMT2
     C                     WRITELIVREF
     C                     ENDIF
      *DEBUT SI ERR
     C                     ELSE
     C                     MOVEL'PAS LA'  TITRE
     C                     EXFMTFMT2
     C                     GOTO DEBUT
     C                     ENDIF
     C                     EXFMTFMT2
     C                     ENDDO
     C                     SETON                     LR
```
