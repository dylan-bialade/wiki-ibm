# tp-calculateur-impot : calcul d'impôt sur le revenu (barème 2020)

- **Objectif** : transformer une explication en algorithme : un formulaire (2 écrans) calcule l'impôt et la somme restante. Hors périmètre : réductions, crédits, contribution hauts revenus, décote. Barème **2020** (pas 2023/2024).
- **Niveaux** : **0** créer les écrans ; **1** célibataire ; **2** case Oui/Non « pacsé/marié » ; **3** nombre d'enfants.
- **Écrans** : saisie (revenu net imposable annuel, pacsé/marié Oui/Non, nombre d'enfants ; F3) puis résultat (« Pour un salaire net imposable de… », impôt, « Il vous restera… » ; F3, F12).
- **Méthode** : quotient familial = revenu net imposable ÷ nombre de parts ; appliquer le barème progressif au quotient ; **multiplier** le résultat par le nombre de parts.
- **Barème 2020 (par part)** : 0 % jusqu'à 10 064 € ; 11 % de 10 064 à 25 659 € ; 30 % de 25 659 à 73 369 € ; 41 % de 73 369 à 157 806 € ; 45 % au-delà.
- **Parts** (seul / en couple) : sans enfant 1 / 2 ; 1 enfant 1,5 / 2,5 ; 2 enfants 2 / 3 ; 3 enfants 3 / 4 ; 4 enfants 4 / 5 ; 5 enfants 5 / 6 ; 6 enfants 6 (seul).
- **Exemples de l'énoncé** (revenu 32 000 €) : célibataire 3 617,34 € ; couple 1 305,70 € ; couple + 2 enfants (3 parts) 198,55 €.
- **Incohérence relevée** : avec le barème donné, un calcul direct donne 3 617,75 € (1 part), 1 305,92 € (2 parts) et 198,88 € (3 parts) ; la maquette d'écran affiche 198,66 € pour le dernier cas, le texte 198,55 €. Les écarts viennent probablement d'arrondis ou d'un simulateur officiel : **ne pas utiliser ces trois valeurs comme jeu d'essai sans confirmer** avec l'enseignant.
- **Compétences** : DSPF (boutons radio `CHECK`/`RANGE`, zones numériques), calcul par tranches (`SELECT`/`WHEN` ou table), `%DEC`/`%DECH` (arrondi), `DIV` avec `(H)`.
- **Dans le dépôt** : RPG [IMPOT](../../sources/RPG/RPG-ILE/BIB05/IMPOT.md), [IMPOTS](../../sources/RPG/RPG-ILE/BIB17/IMPOTS.md), [CALCIMPOT](../../sources/RPG/RPG-ILE/BIB10/CALCIMPOT.md), [IMPOTFRCL](../../sources/RPG/RPG-ILE/BIB10/IMPOTFRCL.md) ; écrans [IMPOTDSP](../../sources/DDS/BIB10/IMPOTDSP.md), [IMPOTDSP (BIB17)](../../sources/DDS/BIB17/IMPOTDSP.md) ; CL [IMPOTCL](../../sources/CL/CL-ILE/BIB10/IMPOTCL.md), [DTARAIMPOT](../../sources/CL/CL-procedural/BIB17/DTARAIMPOT.md) (barème en zone de données).
