# 01 - Comprendre IBM i

> Source : [job-i.fr](https://job-i.fr/) (synthèse personnelle, pages liées en fin de section). Les blocs `AUTO` sont régénérés ; **écrivez uniquement dans « Mes exemples »**.

<!-- AUTO:START -->
## AS/400 et IBM i  ([source](https://job-i.fr/as400-vs-ibm-i), [découverte](https://job-i.fr/ibm-i))
- Même système depuis 1988 : AS/400 → iSeries (2000) → i5/OS (2004) → IBM i (2008) → 7.5 (2022) → 7.6 (2025, Power11).
- Constantes : TIMI (couche machine), stockage à un niveau, objets, base de données intégrée (Db2 for i).
- Vocabulaire : **OPM** (ancien modèle) / **ILE**, **LPAR** (partition), **PASE** (runtime AIX : Python, git), **TR/PTF** (Technology Refresh / correctifs).
- RPG entièrement libre depuis 7.2 TR3 (2015).

## Objets  ([source](https://job-i.fr/objets-ibm-i))
- Objet = nom (10 car.) + type + bibliothèque ; résolution par `*LIBL`.

| Type | Rôle |
|---|---|
| `*FILE` PF / LF / DSPF / PRTF / SAVF | table / vue-index / écran / impression / sauvegarde |
| `*PGM`, `*MODULE`, `*SRVPGM`, `*BNDDIR` | programme, module, programme de service, répertoire de liage |
| `*CMD`, `*DTAARA`, `*DTAQ` | commande, zone de données, file de données |
| `*JRN`/`*JRNRCV`, `*JOBQ`, `*OUTQ`, `*SBSD` | journal, file de travaux, file de sortie, sous-système |
| `*LIB`, `*USRPRF`, `*AUTL` | bibliothèque, profil, liste d'autorisation |

- Commandes : `WRKOBJ`, `DSPOBJD`, `CRTDUPOBJ`, `MOVOBJ`, `RNMOBJ`, `DLTOBJ`, `DSPOBJAUT`, `GRTOBJAUT`, `SAVOBJ`/`RSTOBJ`, `DSPLIBL`, `ADDLIBLE`.
- Erreurs : `CPF4101` fichier introuvable dans *LIBL, `CPF1023` doublon.

## ILE  ([source](https://job-i.fr/ile-ibm-i))
- Compilateur ILE → `*MODULE` → liage → `*PGM` ou `*SRVPGM` ; `*BNDDIR` = où le lieur cherche.
- `CRTRPGMOD`/`CRTCLMOD`/`CRTCMOD`, `CRTPGM`, `CRTSRVPGM` (source de liage EXPORT), `CRTBNDRPG` (compile + lie en une étape).
- Liage par copie (`UPDPGM`) ou par référence (`UPDSRVPGM`). `DFTACTGRP(*NO)` requis pour `ACTGRP`/`BNDDIR`.
- Ajouter les nouvelles procédures **en fin** de liste d'export (compatibilité).

## Travaux et sous-systèmes  ([source](https://job-i.fr/travaux-ibm-i))
- Job = `numéro/utilisateur/nom`. INT (QINTER, prio 20, `DSPW` au repos) ; BCH (`SBMJOB` → JOBQ → QBATCH, prio 50, `MSGW` si erreur).
- États : `RUN`, `DSPW`, `MSGW` (à traiter), `DEQW`, `DLYW`, `LCKW`.
- Commandes : `WRKACTJOB`, `WRKJOB`, `WRKSBMJOB`, `WRKUSRJOB`, `SBMJOB`, `DSPJOBLOG`, `CHGJOB`, `HLDJOB`, `RLSJOB`, `ENDJOB`.
- SQL : `QSYS2.ACTIVE_JOB_INFO`, `JOB_INFO`, `JOBLOG_INFO`.

## Profils et droits  ([source](https://job-i.fr/profils-utilisateurs-ibm-i))
- `*USRPRF` : classe (`USRCLS`), `CURLIB`, `INLMNU`, `LMTCPB`, `JOBD`, groupes (`GRPPRF`/`SUPGRPPRF`), `AUT` public (`*EXCLUDE`).
- Désactiver (`STATUS(*DISABLED)`) plutôt que supprimer ; créer demande `*SECADM`.
- `SBMJOB JOBD(*USRPRF)` : ajouter `INLLIBL(*JOBD) CURLIB(*USRPRF)`.
- Commandes : `CRTUSRPRF`, `CHGUSRPRF`, `DSPUSRPRF`, `DLTUSRPRF OWNOBJOPT(...)`, `ANZDFTPWD`, `GRTOBJAUT`. SQL : `QSYS2.USER_INFO`.

## Sécurité  ([source](https://job-i.fr/securite-ibm-i))
- `QSECURITY` : 40 recommandé (50 = très strict) ; effet au prochain IPL.
- Mots de passe : `QPWDLVL` 4, 15 car. min, 90 jours ; connexion : `QMAXSIGN` 3, `QLMTSECOFR` 1, `QINACTITV` 15 ; audit : `QAUDCTL`/`QAUDLVL`.
- Outils : `PRTSYSSECA`, `CHGSECAUD`, `ANZPRFACT`. 7.6 : MFA via `CHGSECA ADLSGNFAC`.

## PTF  ([source](https://job-i.fr/installer-ptf-ibm-i))
- Installer par groupes ; microcode côté B ; jamais `INSTYP(*DLYALL)`.
- Séquence : `CRTIMGCLG` → `VFYIMGCLG` → `INSPTF ... INSTYP(*IMMDLY)` → `PWRDWNSYS OPTION(*CNTRLD) DELAY(600) RESTART(*YES) IPLSRC(B)` → `APYPTF ... APY(*PERM)` après quelques semaines. SQL : `QSYS2.GROUP_PTF_INFO`.

## Performances  ([source](https://job-i.fr/performances-ibm-i))
- Mesurer avant de régler : Collection Services, `ACTIVE_JOB_INFO`, `MEMORY_POOL_INFO`, `WRKSYSACT`.
- Leviers : `OVRDBF ... SEQONLY(*YES 2000)`, éviter `ACTGRP(*NEW)` sur appels fréquents, `*INLR` seulement en fin, `SAVLIB DTACPR(*MEDIUM)`.
- Valeurs : `QDYNPTYSCD`=1, `QDYNPTYADJ`=1, `QPFRADJ`=2.
<!-- AUTO:END -->

## Mes exemples
_Exemples tirés de mon travail (compléter via `docs/apports/`)._

- **Sauvegarde d'une bibliothèque en SAVF** : [SAVECL](../../sources/CL/CL-procedural/BIB05/SAVECL.md) — `CRTSAVF` + `MONMSG CPF7302` + `SAVOBJ DEV(*SAVF)`.
- **Environnement automatisé** (JOBQ, OUTQ, JOBD, SBS, CLS) : [ENVAUTO](../../sources/CL/CL-procedural/BIB05/ENVAUTO.md).
- **Export de sources vers l'IFS** : [EXPSRCIFS](../../sources/CL/CL-procedural/BIB05/EXPSRCIFS.md).
