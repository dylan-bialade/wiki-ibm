# 08 - Impression sur IBM i : fichiers imprimante, spools, OUTQ

> Source : [job-i.fr](https://job-i.fr/). Blocs `AUTO` régénérés ; écrivez dans « Mes exemples ». **job-i.fr n'a aucune page sur les DDS d'un fichier imprimante, les spécifications `O` ni `OVRPRTF` en profondeur** : ces points viennent de vos sources (« constat dans le code »).

<!-- AUTO:START -->

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Spools et files de sortie (OUTQ)  (source)](#spools-et-files-de-sortie-outq--source)
- [Créer un fichier imprimante : CRTPRTF  (source)](#créer-un-fichier-imprimante--crtprtf--source)
- [Substituer un fichier imprimante : OVRPRTF  (source)](#substituer-un-fichier-imprimante--ovrprtf--source)
- [Copier un spool : CPYSPLF  (source)](#copier-un-spool--cpysplf--source)
- [Mes exemples](#mes-exemples)
  - [Impression full free : `WRITE QSYSPRT` avec une DS par ligne (validé)](#impression-full-free--write-qsysprt-avec-une-ds-par-ligne-validé)
<!-- TOC:END -->

## Spools et files de sortie (OUTQ)  ([source](https://job-i.fr/outq-ibm-i))
- Un programme qui écrit dans un **fichier imprimante** (`PRTF`) avec `SPOOL(*YES)` crée un **spool** sur disque : il n'attend pas l'imprimante. Une **OUTQ** est la file où attendent les spools ; un **éditeur** (travail `WTR`, sous-système `QSPL`) envoie les spools prêts (`RDY`) à l'imprimante.
- **Où va le spool** : attribut `OUTQ` du fichier imprimante (souvent `*JOB` = file du travail). Si la file n'existe pas, le spool part dans `QGPL/QPRINT` (message `CPD4090`). Un spool survit à son travail.
- Attributs : `PRIORITY` (1 à 9, 1 sort en premier), séquence `*FIFO` / `*JOBNBR`, `SCHEDULE` (`*FILEEND`, `*JOBEND`, `*IMMED`), nombre d'exemplaires (`CHGSPLFA`), `DEVTYPE` `*SCS` ou `*AFPDS` pour la conversion PDF.
- Commandes : `WRKOUTQ`, `WRKSPLF`, `DSPSPLF`, `CHGSPLFA`, `HLDSPLF`, `RLSSPLF`, `CPYSPLF`, `DLTSPLF`, `CRTOUTQ`, `CLROUTQ`, éditeurs `STRPRTWTR`, `ENDWTR`, `WRKWTR`.
- Conversion PDF : `CPYSPLF` avec `TOFILE(*TOSTMF)`, `TOSTMF` (IFS) et `WSCST(*PDF)`, via une JOBQ.
- Services SQL : `QSYS2.OUTPUT_QUEUE_ENTRIES_BASIC`, `QSYS2.OUTPUT_QUEUE_INFO`, `QSYS2.SPOOLED_FILE_INFO`, `SYSTOOLS.SPOOLED_FILE_DATA` (contenu), `SYSTOOLS.DELETE_OLD_SPOOLED_FILES` (tester d'abord avec `PREVIEW => 'YES'`).
- Pièges : sans éditeur actif rien ne s'imprime ; **`DLTSPLF FILE(*SELECT)` supprime tous les spools correspondant au filtre, sans retour arrière** (préférer travail + nom + `SPLNBR`) ; une file n'expose pas le contenu de ses spools par défaut (`DSPDTA(*NO)`).

## Créer un fichier imprimante : CRTPRTF  ([source](https://job-i.fr/commandes-ibm-i/crtprtf))
- Crée un fichier imprimante (aucune donnée) à partir des DDS (`SRCFILE` / `SRCMBR`) et des options de mise en file.
- Paramètres (défaut) : `PAGESIZE` 66 132, `LPI` 6, `CPI` 10, `OVRFLW` 60 (ligne qui déclenche le saut de page), `DEVTYPE` `*SCS`, `OUTQ` `*JOB`, `SPOOL` `*YES`, `FORMTYPE` `*STD`, `SAVE` `*NO`, `MAXRCDS` 100000, `REPLACE` `*YES`.
- Pièges : `OVRFLW` ne doit pas dépasser la hauteur de `PAGESIZE` ; `SPOOL(*NO)` ignore les autres paramètres de mise en file ; au-delà de `MAXRCDS` un message d'interrogation est envoyé ; `FOLD` ignoré hors `*SCS`.

## Substituer un fichier imprimante : OVRPRTF  ([source](https://job-i.fr/commandes-ibm-i/ovrprtf))
- Remplace, pour un programme, le fichier imprimante ou certains de ses attributs : `FILE` (ou `*PRTF`), `TOFILE`, `OUTQ`, `COPIES`, `FORMTYPE`, `HOLD`, `SAVE`, `USRDTA` (et non `USRDATA`), `SPLFNAME`, `OVRSCOPE` (`*ACTGRPDFN` par défaut, `*CALLLVL`, `*JOB`).
- Piège : **aucun effet immédiat** : la substitution s'applique à l'**ouverture** du fichier ; un paramètre non indiqué ne change rien aux valeurs définies ailleurs.

## Copier un spool : CPYSPLF  ([source](https://job-i.fr/commandes-ibm-i/cpysplf))
- Copie un spool vers un fichier physique ou un fichier STREAM : `FILE`, `TOFILE` (`*TOSTMF` pour l'IFS), `JOB`, `SPLNBR` (`*LAST`, `*ONLY`), `TOMBR`, `MBROPT` (`*REPLACE` / `*ADD`), `CTLCHAR`.
- Pièges : le fichier de destination doit exister ; les lignes entièrement blanches ne sont pas copiées ; la copie échoue si le spool est encore ouvert (`OPNSPLF(*NO)` par défaut) ; avec `*TOSTMF`, les répertoires du chemin doivent exister.
<!-- AUTO:END -->

## Mes exemples
### Impression full free : `WRITE QSYSPRT` avec une DS par ligne (validé)
Fichier `QSYSPRT PRINTER(132)`, une DS `LEN(132) INZ` par type de ligne, zones placées par `POS`, espacement par lignes blanches : exemple complet et compilé dans [CYCLEQSYS.rpgle](../exemples-cycle/CYCLEQSYS.rpgle), explications et mesures dans [Impression full free](../IMPRESSION-RPG.md#partie-1--réécrire-un-état-à-cycle-en-full-free-retour-dexpérience). `PRTCTL(...:*COMPAT)` : structure de 9 octets (espace avant `CHAR(1)`, espace après `CHAR(1)`, saut avant `CHAR(2)`, saut après `CHAR(2)`, compteur `ZONED(3:0)`), blanc = aucun ; le premier essai avec des `CHAR(3)` a donné un spool faux : voir [PRTCTL](../IMPRESSION-RPG.md#partie-2--prtctl-contrôle-dynamique-dimpression).
- **RPG III, sortie par spécifications `O` sur `QSYSPRT`** : [CYCDEMO](../../sources/RPG/RPG-III-400/BIB20/CYCDEMO.md) (en-tête sous `1P` / `OF`, détails, totaux `L1` / `L2` / `LR`) ; variante PERSO en cartes `O` : [fiche 06](06-cycle-rpg-et-sous-routines.md). Déclaration constatée : `FQSYSPRT O   F     132     OF     PRINTER`.
- **RPG III, fichier imprimante décrit en externe** : [RPGIMPR](../../sources/RPG/RPG-III-400/BIB20/RPGIMPR.md) (`FIMPR O E 60 PRINTER`, puis `WRITE` des formats `TITRE`, `ENTETE`, `DETAILS`, `ETOILE`) avec ses DDS [BONPRT](../../sources/DDS/BIB20/BONPRT.md) (formats `TITRE`, `ENTETE`, `DETAILS`, `ETOILE`, `EJECT` ; mots-clés `SPACEB(n)` interligne avant, `SKIPA(n)` saut après, positions de colonne en dernière zone).
- **RPG IV, saut de page géré à la main** : [PRINT](../../sources/RPG/RPG-ILE/BIB02/PRINT.md) (`FECRANPRTF O E PRINTER`, compteur `Ligne`, `WRITE EJECT` puis `WRITE ENTETE` / `TITRE` quand la ligne atteint 56) ; autre exemple : [PRINTPAR](../../sources/RPG/RPG-ILE/BIB02/PRINTPAR.md).
- **CL, spools** : conversion en PDF dans l'IFS : [SRCPDFCL](../../sources/CL/CL-procedural/BIB01/SRCPDFCL.md) (`CPYSPLF … TOFILE(*TOSTMF) SPLNBR(*LAST)` puis `DLTSPLF … SPLNBR(*LAST)`) ; création d'une OUTQ : [ENVAUTO](../../sources/CL/CL-procedural/BIB05/ENVAUTO.md) ; **à surveiller** : `DLTSPLF FILE(*SELECT)` dans [MENUECL](../../sources/CL/CL-procedural/BIB05/MENUECL.md) (supprime les spools sélectionnés sans retour arrière).
- **Listage de compilation** : sans imprimante `PRT01`, le message `CPD4090` indique que la sortie est remplacée par `QPRINT` de `QGPL` : le spool se retrouve dans `WRKSPLF`.
- **Ce que le dépôt n'a pas** : aucun `CRTPRTF`, `OVRPRTF` ni `CHGSPLFA` dans vos sources CL, aucune explication des mots-clés DDS d'impression ni des spécifications `O` (job-i.fr non plus) : voir [MANQUES](../MANQUES.md).

> Retour d'expérience (état à cycle réécrit en full free, spools mesurés) : [Impression full free](../IMPRESSION-RPG.md#partie-1--réécrire-un-état-à-cycle-en-full-free-retour-dexpérience).

> PRTCTL : ce qui est documenté ou non : [PRTCTL](../IMPRESSION-RPG.md#partie-2--prtctl-contrôle-dynamique-dimpression).
