# 02 - Référence système (CL, messages, valeurs système)

> Source : [job-i.fr](https://job-i.fr/). Blocs `AUTO` régénérés ; écrivez dans « Mes exemples ».

<!-- AUTO:START -->
## Commandes CL  ([source](https://job-i.fr/commandes-ibm-i)) — 1 830 fiches
Organisation du site : blocs thématiques (fichiers, IFS, sauvegardes, spools, travaux, profils, bibliothèques, messages, zones de données, compilation, débogage, journalisation, droits, sous-systèmes, planification, valeurs système, PTF) + index A→W. Fiche : `https://job-i.fr/commandes-ibm-i/<commande>`.

| Thème | Commandes courantes |
|---|---|
| Fichiers | `CRTPF`, `CRTSRCPF`, `CPYF`, `DSPFD`, `DSPFFD`, `DSPPFM`, `DLTF`, `DCLF` |
| Bibliothèques | `CRTLIB`, `DLTLIB`, `DSPLIBL`, `EDTLIBL`, `ADDLIBLE` |
| Objets | `CRTDUPOBJ`, `DLTOBJ`, `DSPOBJD`, `CHKOBJ` |
| Données | `CRTDTAARA`, `CRTJOBQ` |
| Travaux | `WRKACTJOB`, `DSPJOBLOG`, `ENDJOB` |
| Profils | `CRTUSRPRF`, `DSPUSRPRF`, `CHGPWD` |
| Système | `DSPSYSVAL`, `CHGSYSVAL` |

## Messages  ([source](https://job-i.fr/messages-ibm-i)) — ~13 200 messages CPF / MCH
- **CPF** : système (commandes, objets, travaux, fichiers) ; **MCH** : erreurs machine (pointeurs, décimal, division par zéro).

| Message | Sens |
|---|---|
| CPF9801 / CPF2105 | objet introuvable |
| CPF9810 | bibliothèque introuvable |
| CPF9802 | pas autorisé à l'objet |
| CPF4131 | niveau de format différent (recompiler) |
| CPF5027 / CPF3130 / CPF3202 | enregistrement / membre / fichier utilisé par un autre travail |
| CPF5026 | clé en double |
| CPF0001 | erreur dans la commande |
| CPF9999 | erreur non interceptée |
| MCH3601 | pointeur non initialisé |
| MCH1210 / MCH1211 | zone trop petite / division par zéro |
| MCH1202 | paramètres incohérents (type/longueur) |

- Piège : `MONMSG MSGID(CPFxxxx)` pour intercepter dans un CL.

## Valeurs système  ([source](https://job-i.fr/valeurs-systeme-ibm-i)) — 158 valeurs (7.5)
Catégories : Sécurité (42), Contrôle système (62), Allocation (14), Date/heure (15), Messages/journalisation (10), Stockage (7), Édition (5), Liste de bibliothèques (3).

| Valeur | Rôle |
|---|---|
| QSECURITY, QPWDLVL, QPWDMINLEN, QPWDEXPITV | niveau sécurité, règles de mot de passe |
| QMAXSIGN, QINACTITV, QLMTSECOFR | tentatives, inactivité, accès privilégiés |
| QAUDLVL, QCRTAUT | audit, droits publics par défaut |
| QCCSID, QLANGID, QCNTRYID, QKBDTYPE | jeu de caractères, langue, pays, clavier |
| QDATFMT, QDATSEP, QDECFMT, QCURSYM, QTIMZON | formats date/décimal/monnaie/fuseau |
| QMAXJOB, QUSRLIBL | nb max de travaux, bibliothèques utilisateur |

- SQL : `SELECT * FROM QSYS2.SYSTEM_VALUE_INFO` (filtrer les valeurs changées).
<!-- AUTO:END -->

## Mes exemples
- **Gestion de liste de bibliothèques** : [CFGLIBL](../../sources/CL/CL-procedural/BIB06/CFGLIBL.md), [CHGLIBCURR](../../sources/CL/CL-procedural/BIB05/CHGLIBCURR.md).
- **Commandes vérifiées dans mon code** : voir [VERIFICATION-JOB-I](../VERIFICATION-JOB-I.md).
