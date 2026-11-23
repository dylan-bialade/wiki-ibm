# Partie 11 : Modernisation d'application et maintenance de code existant

> Plan de formation, partie 11 sur 14. Limites du code historique, conversion vers le full free, décomposition en modules, standards modernes, nouvelle application (écrans, sous-fichiers, CRUD), mises en situation de maintenance.
>
> **Mots-clés** : modernisation, dette technique, full free, modules, programmes de service, RDi, VS Code, Git, JSON_TABLE, REST, DSPF, sous-fichier, CRUD, STRDBG, correctif.
>
> **Statut des liens** : pages job-i dont l'existence a été vérifiée le 2026-11-23 ; pistes IBM listées = **non lues** (version indiquée) sauf mention « lu ». Retour à l'[index de la formation](README.md).

<!-- TOC:START -->
**Sommaire** (retour : [sommaire general](../SOMMAIRE.md))

- [Où trouver quoi dans le wiki](#où-trouver-quoi-dans-le-wiki)
- [Pages job-i de référence (titres de sections, lus le 2026-11-23)](#pages-job-i-de-référence-titres-de-sections-lus-le-2026-11-23)
- [Plan détaillé](#plan-détaillé)
  - [Les principes de la modernisation d'application](#les-principes-de-la-modernisation-dapplication)
  - [Développer une nouvelle application](#développer-une-nouvelle-application)
  - [Les écrans standards](#les-écrans-standards)
  - [Les sous-fichiers](#les-sous-fichiers)
  - [Mises en situation réelles de maintenance de code](#mises-en-situation-réelles-de-maintenance-de-code)
<!-- TOC:END -->

## Où trouver quoi dans le wiki

- [Cycle RPG III et conversion full free](../CYCLE-RPG.md)
- [Impression : réécrire un état à cycle](../IMPRESSION-RPG.md)
- [Exemples comparés (COMPARAISON)](../COMPARAISON-BIBLIOTHEQUES.md)
- [Énoncés de TP](../enonces/README.md)

## Pages job-i de référence (titres de sections, lus le 2026-11-23)

Ces pages couvrent une partie du plan ; seules leurs rubriques sont listées ici (le contenu est sur job-i.fr).

| Page job-i | En bref (synthèse) | Rubriques |
|---|---|---|
| [Sous-fichier RPG (SFL, SFLCTL) : statique, en RPG III, RPG IV et full free](https://job-i.fr/sous-fichier-rpg) | Un sous-fichier est une liste d'enregistrements écrite ligne par ligne puis affichée en une fois ; l'utilisateur la fait défiler et le programme relit seulement les lignes modifiées. | En une phrase ; Le principe ; Trois façons de le charger, une seule à retenir ; L'écran : un gabarit, un seul DSPF pour les trois versions ; En RPG III ; En RPG IV colonné ; En RPG full free ; Le résultat, identique pour les trois ; Le piège : SFLMSG sur une liste vide |
| [Coder en RPG full free (**FREE) : 3 programmes, compilation, débogage STRDBG et tests](https://job-i.fr/coder-rpg-full-free) | Full free : première ligne **FREE, format libre sans spécification en colonnes ; même compilateur et même débogueur que le RPG IV. | En une phrase ; Préparer l'atelier ; Et SEU ? ; Hello world : quatre lignes ; Sortir du stock un article lu par sa clé ; Consulter un article par son code ou par son libellé ; Déboguer avec STRDBG ; Tester |
| [ILE sur IBM i : modules, programmes de service, liage, exemple RPG, C et CL](https://job-i.fr/ile-ibm-i) | ILE : le compilateur produit un module ; on lie des modules de langages différents en programme ou en programme de service partagé. | En une phrase ; L'ILE, c'est quoi ; Pourquoi l'ILE existe ; L'exemple : un programme RPG, un module C, un module CL ; Mettre en place 1 : trois modules, un programme ; Mettre en place 2 : un programme de service ; Par copie ou par référence : la preuve ; Déboguer d'un langage à l'autre ; Mettre l'ILE en place dans une application |

## Plan détaillé

### Les principes de la modernisation d'application

- **Dans le wiki** : [Cycle vers full free](../CYCLE-RPG.md#partie-2--du-cycle-rpg-iii-au-full-free-table-de-correspondance)

#### Les limites du code historique et les enjeux de la modernisation

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### La conversion vers RPG Free

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### La décomposition d'un monolithe en modules et programmes de service

- **job-i** : [CRTSRVPGM](https://job-i.fr/commandes-ibm-i/crtsrvpgm)

#### Les standards modernes, SQL, erreurs centralisées, logs, constantes globales, validations

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Les outils modernes, RDi, VS Code, Git, JSON_TABLE, webservices REST

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### Développer une nouvelle application

- **Dans le wiki** : [Énoncés de TP](../enonces/README.md)

#### L'architecture d'une application IBM i (PF/LF, DSPF, RPG Free, SQL, ILE)

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### La séparation des traitements métier et du visuel

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Le SQL embarqué dans une application moderne

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### Les écrans standards

- **Dans le wiki** : aucune page dédiée (à documenter).

#### Menu, écrans de saisie, de consultation et d'erreur

- **job-i** : [EXFMT](https://job-i.fr/rpg-iii/exfmt)

#### Validation des données et messages de contrôle

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### Les sous-fichiers

- **Dans le wiki** : [Fiche 03](../cheatsheets/03-rpg-par-version.md)

#### Les sous-fichiers statiques et dynamiques

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### L'intégration d'un CRUD complet en RPG et SQL

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

### Mises en situation réelles de maintenance de code

- **Dans le wiki** : [Index des sources](../INDEX-SOURCES.md)

#### Lecture et analyse d'un programme RPG ancienne génération

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Diagnostic de bug (SQL, logique métier, DSPF, data-area, journaux)

- **job-i** : [DSPJOBLOG](https://job-i.fr/commandes-ibm-i/dspjoblog)

#### Débogage, STRDBG et service entry point

- **job-i** : [STRDBG](https://job-i.fr/commandes-ibm-i/strdbg)

#### Modification d'un code existant sans dégrader la production

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).

#### Dette technique et élaboration de correctifs testés et documentés

- **job-i** : pas de page dédiée trouvée (source à chercher sur ibm.com, voir les pistes IBM).
