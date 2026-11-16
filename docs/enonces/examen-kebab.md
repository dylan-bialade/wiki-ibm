# examen-kebab : examen de mi-parcours (7 h, 100 points)

Chaîne de restauration rapide fictive ; l'épreuve se déroule dans un environnement personnel sur la machine de formation ; livrables : une **sauvegarde (SAVF) de la bibliothèque** et la **requête SQL**.

| Partie | Contenu | Points |
|---|---|---|
| 1 | **Environnement** : bibliothèque, profil de test copié de `QPGMR` (ne pas compiler avec lui), `JOBD` (avec `JOBQ`, `OUTQ`, `MSGQ` personnelles), sous-système distinct (entrée de file de travaux + poste de routage), bibliothèque d'examen dans la liste initiale de la `JOBD` | 15 |
| 2 | **Fichiers sources** `QDDSSRC`, `QCLPSRC`, `QRPGSRC` | 3 |
| 3 | **DDS** : PF `PRODUIT` (code 7A clé, libellé, catégorie, prix HT/TTC `5P 2`, dispo O/N) et `COMMANDE` (n° `7P 0` clé, date ISO, heure ISO, mangeur, code produit, quantité, montant TTC `7P 2`, sauce, livraison O/N) ; LF `LFPRDCAT` (tri catégorie puis libellé) et `LFCMDVIP` (**sélection** : montant TTC ≥ 12 €, tri mangeur puis date) ; données copiées d'une bibliothèque fournie | 7 |
| 4 | **CL** : lister les `*PGM` d'une bibliothèque dans un `*OUTFILE` en `QTEMP`, les afficher **un par un** sur un écran 5250 (système, rang / total, nom, attribut, description, créateur) ; **F3** quitte, Entrée = suivant, fin après le dernier | 20 |
| 5 | **SQL** : chiffre d'affaires par catégorie sur les **12 derniers mois** : jointure externe pour garder les produits sans commande récente (une ligne « Aucune vente »), `GROUP BY`, nombre de produits distincts, total des quantités, chiffre d'affaires TTC, tri décroissant | 5 |
| 6 | **RPG III** : consulter les commandes VIP via `LFCMDVIP` (mangeur puis date), chercher le produit par clé dans `PRODUIT` (« PRODUIT INCONNU » si absent), afficher les champs dont le **mode de service** (LIVRAISON / SUR PLACE) ; Entrée = suivante ; fin de fichier + Entrée ou F3 = fin | 50 |

- **Compétences** : `CRTLIB`, `CRTUSRPRF`, `CRTJOBD`, `CRTJOBQ`, `CRTOUTQ`, `CRTMSGQ`, `CRTSBSD`, `ADDJOBQE`, `ADDRTGE`, `CRTSRCPF` ; DDS (dates/heures, `S`/`COMP`, clés composées) ; `DSPOBJD OUTPUT(*OUTFILE)`, `DCLF`, `RCVF`, `SNDRCVF` ; `LEFT JOIN`, `COALESCE`, `GROUP BY`, `CURRENT DATE - 12 MONTHS` ; RPG III (`CHAIN`, `READ`, `EXFMT`, indicateurs de touches).
- **Dans le dépôt** : **aucune solution** de cet examen. Briques proches : CL [OBJLSTC](../../sources/CL/CL-procedural/BIB09/OBJLSTC.md) (liste d'objets), [AFFOBJDCL](../../sources/CL/CL-procedural/BIB06/AFFOBJDCL.md) ; RPG III lecture + `CHAIN` : [GESTLIVRE](../../sources/RPG/RPG-III-400/BIB10/GESTLIVRE.md).
