# 04 - Db2 for i et SQL spécifique IBM i

> Source : [job-i.fr](https://job-i.fr/). Blocs `AUTO` régénérés ; écrivez dans « Mes exemples ».

<!-- AUTO:START -->
## Fichier physique (PF)  ([source](https://job-i.fr/fichier-physique-pf-ibm-i))
- `*FILE` PF = table (format d'enregistrement, membres, clé). DDS (`CRTPF` sur `QDDSSRC`) ou SQL (`CREATE TABLE`, à privilégier).
- DDS : col. 17 `R`/`K`/blanc · 19-28 nom · 30-34 longueur · 35 type (A, P, S, B, L, T, Z) · 36-37 décimales · 45-80 mots-clés (`UNIQUE`, `TEXT`, `COLHDG`, `VALUES`, `EDTCDE`).
```
     A          R CLIENTR                   TEXT('Client')
     A            NUMCLI         5P 0       COLHDG('Numero' 'client')
     A            NOM           30A
     A          K NUMCLI
```
- Commandes : `CRTLIB`, `CRTSRCPF`, `CRTPF`, `UPDDTA`, `STRDFU`, `DSPPFM`, `RGZPFM`, `CPYF`, `STRJRNPF`. Piège : `VALUES` ne contrôle que la saisie écran (données invalides → `MCH1202` à la lecture).

## Fichier logique (LF)  ([source](https://job-i.fr/fichier-logique-lf-ibm-i))
- Aucune donnée : change l'ordre, filtre, choisit des zones, joint. DDS : `PFILE`, `K`, `S ... COMP(EQ ...)`, `JFILE`, `JOIN`/`JFLD`, `JREF`, `JDFTVAL`.
- SQL ↔ DDS : `CREATE INDEX` = clé ; `CREATE VIEW ... WHERE` = sélection ; `LEFT JOIN` = `JDFTVAL`.
- `CRTLF`, `DSPDBR` (relations), `MAINT(*IMMED)`. Un SELECT sur LF n'est pas trié → `ORDER BY`. LF de jointure = lecture seule.

## Services SQL  ([source](https://job-i.fr/services-sql-ibm-i)) — 390 services
Schémas : **QSYS2** (principal), **SYSTOOLS**, **SYSIBMADM**. Catalogue : `SELECT * FROM QSYS2.SERVICES_INFO`.
| Service | Usage |
|---|---|
| `QSYS2.ACTIVE_JOB_INFO` | travaux actifs |
| `QSYS2.USER_INFO` / `USER_STORAGE` | profils / stockage par profil |
| `QSYS2.JOBLOG_INFO`, `HISTORY_LOG_INFO` | historiques |
| `QSYS2.OUTPUT_QUEUE_ENTRIES` | spools |
| `QSYS2.PTF_INFO`, `GROUP_PTF_INFO` | PTF |
| `QSYS2.OBJECT_STATISTICS('LIB','*ALL')` | objets d'une bibliothèque |
| `QSYS2.SYSTEM_STATUS_INFO`, `SYSLIMITS`, `NETSTAT_INFO` | état système / limites / réseau |
| `QSYS2.OBJECT_PRIVILEGES` | droits |
| `CALL QSYS2.QCMDEXC('cmd')` | exécuter du CL |
| `SYSTOOLS.ENDED_JOB_INFO` | travaux terminés |

## Recettes SQL d'exploitation  ([source](https://job-i.fr/recettes-sql-ibm-i)) — 36 recettes en lecture seule
Thèmes : travaux (7), sécurité (6), stockage (6), messages (4), PTF/licences (4), journaux (3), base de données (3), spool (2), sauvegarde (1).
```sql
-- Travaux bloqués
SELECT JOB_NAME, JOB_USER, SUBSYSTEM FROM TABLE(QSYS2.ACTIVE_JOB_INFO()) A WHERE JOB_STATUS = 'MSGW';
-- Top CPU
SELECT JOB_NAME, CPU_TIME FROM TABLE(QSYS2.ACTIVE_JOB_INFO()) A ORDER BY CPU_TIME DESC FETCH FIRST 10 ROWS ONLY;
-- Profils *ALLOBJ
SELECT USER_NAME FROM QSYS2.USER_INFO WHERE SPECIAL_AUTHORITIES LIKE '%ALLOBJ%';
-- Plus gros objets d'une bibliothèque
SELECT OBJNAME, OBJTYPE, OBJSIZE FROM TABLE(QSYS2.OBJECT_STATISTICS('MABIB','*ALL')) X ORDER BY OBJSIZE DESC FETCH FIRST 10 ROWS ONLY;
```
(Requêtes adaptées : vérifier les noms de colonnes sur votre version.)

## Node.js + Db2 for i  ([source](https://job-i.fr/nodejs-ibm-i))
- `yum -y install nodejs24`, `node -p process.platform` → `os400` ; connexion `idb-pconnector` (`*LOCAL`) avec `enableNumericTypeConversion: true` ; toujours des marqueurs `?`.
<!-- AUTO:END -->

## Mes exemples
- **DDS de fichiers logiques / physiques** : voir `sources/DDS/` ([index](../INDEX-SOURCES.md)).
- **SQL examen** : fichiers `Sans titre 1.sql` et `sqlexamen.sql` dans `Documents` (à déposer dans `docs/apports/`).
- **Création de fichier client** : [CLIENTCRT](../../sources/CL/CL-procedural/BIALADE2/CLIENTCRT.md), [CLIENTINS](../../sources/CL/CL-procedural/BIALADE2/CLIENTINS.md).
