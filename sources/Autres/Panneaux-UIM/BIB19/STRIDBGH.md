---
bibliotheque: BIB19
fichier_source: QPNLSRC
membre: STRIDBGH
type: Autres/Panneaux-UIM
longueur_enregistrement: 80
lignes: 115
modifie: 2026-11-16
---

# BIB19/QPNLSRC/STRIDBGH

```text
.* ---------------------------------------------------------------------
.* STRIDBGH - aide des commandes BIB19 et ENDIDBG (F1 sur l'invite)
.* Licence MIT
.* ---------------------------------------------------------------------
:PNLGRP.
.* ===================================================== BIB19 ===
:HELP NAME='BIB19'.Démarrer IDBG - Aide
:P.La commande Démarrer IDBG (BIB19) débogue un programme ILE RPG
(RPGLE ou SQLRPGLE) avec l'écran, les touches et les commandes du
débogueur source interactif ISDB (STRISDB). Le débogage a lieu dans le
travail en cours. F15 affiche l'écran du programme débogué.
:P.Le programme doit avoir été compilé avec des données de débogage
(DBGVIEW(*SOURCE), *LIST ou *ALL). D'autres programmes peuvent être
ajoutés ensuite avec la commande AddisdbPgm ou par F14 (Gestion de la
liste des programmes), jusqu'à 20 programmes.
:P.Dans l'écran SOURCE, F1 affiche le récapitulatif des commandes et
F24 les autres touches. ENDIDBG arrête IDBG.
:P.:HP2.Restrictions&colon.:EHP2.
:UL.
:LI.Seuls les programmes ILE (*PGM) sont acceptés. Pour un programme OPM,
utilisez STRISDB.
:LI.Le programme est débogué dans le travail en cours uniquement.
:EUL.
:EHELP.
.* -------------------------------------------------------------------
:HELP NAME='BIB19/PGM'.Programme (PGM) - Aide
:XH3.Programme (PGM)
:P.Indiquez le programme ILE à déboguer. Ce paramètre est obligatoire.
:P.:HP2.Nom qualifié&colon.:EHP2.
:PARML.
:PT.:PV.nom-programme:EPV.
:PD.Indiquez le nom du programme.
:EPARML.
:P.:HP2.Bibliothèque&colon.:EHP2.
:PARML.
:PT.:PK DEF.*LIBL:EPK.
:PD.Toutes les bibliothèques de la liste du travail sont explorées.
:PT.*CURLIB
:PD.La bibliothèque en cours du travail est explorée.
:PT.:PV.nom-bibliothèque:EPV.
:PD.Indiquez la bibliothèque qui contient le programme.
:EPARML.
:EHELP.
.* -------------------------------------------------------------------
:HELP NAME='BIB19/UPDPROD'.MàJ fichiers de production (UPDPROD) - Aide
:XH3.MàJ fichiers de production (UPDPROD)
:P.Indique si les fichiers des bibliothèques de production peuvent être
mis à jour pendant le débogage.
:PARML.
:PT.:PK DEF.*NO:EPK.
:PD.Les fichiers de production ne peuvent pas être mis à jour. Une
ouverture en mise à jour échoue (CPF4203).
:PT.*YES
:PD.Les fichiers de production peuvent être mis à jour.
:EPARML.
:EHELP.
.* -------------------------------------------------------------------
:HELP NAME='BIB19/INVPGM'.Appeler le programme (INVPGM) - Aide
:XH3.Appeler le programme (INVPGM)
:P.Indique comment le programme est appelé.
:PARML.
:PT.:PK DEF.*YES:EPK.
:PD.IDBG affiche le source du programme. F5 appelle le programme et
s'arrête sur sa première instruction ; F17 l'appelle sans arrêt.
:PT.*NO
:PD.Posez vos points d'arrêt, puis F17 rend la main. Le programme
s'arrêtera quand vous l'appellerez (menu, application). ENDIDBG
termine le débogage.
:PT.*CMD
:PD.F17 ouvre une ligne de commande d'où vous appelez le programme.
:EPARML.
:EHELP.
.* -------------------------------------------------------------------
:HELP NAME='BIB19/PARM'.Paramètres d'appel (PARM) - Aide
:XH3.Paramètres d'appel (PARM)
:P.Indiquez les paramètres passés au programme quand IDBG l'appelle
(INVPGM(*YES)), comme pour la commande CALL. Vous pouvez indiquer 25
valeurs. Un nombre est passé en décimal condensé (15 5), une chaîne
entre apostrophes en caractères.
:EHELP.
.* -------------------------------------------------------------------
:HELP NAME='BIB19/SRCMBR'.Membre source (SRCMBR) - Aide
:XH3.Membre source (SRCMBR)
:P.Paramètre accepté pour la compatibilité avec STRISDB. IDBG affiche
le source enregistré dans les données de débogage du programme.
:PARML.
:PT.:PK DEF.*PGM:EPK.
:PD.Le membre source est celui qui a servi à la compilation.
:EPARML.
:EHELP.
.* -------------------------------------------------------------------
:HELP NAME='BIB19/SRCFILE'.Fichier source (SRCFILE) - Aide
:XH3.Fichier source (SRCFILE)
:P.Paramètre accepté pour la compatibilité avec STRISDB. IDBG affiche
le source enregistré dans les données de débogage du programme.
:EHELP.
.* -------------------------------------------------------------------
:HELP NAME='BIB19/JOB'.Travail à traiter (JOB) - Aide
:XH3.Travail à traiter (JOB)
:P.Indique le travail dans lequel le programme est débogué.
:PARML.
:PT.:PK DEF.*:EPK.
:PD.Le travail en cours. Le débogage d'un autre travail n'est pas
disponible dans cette version.
:EPARML.
:EHELP.
.* ===================================================== ENDIDBG ===
:HELP NAME='ENDIDBG'.Arrêter IDBG - Aide
:P.La commande Arrêter IDBG (ENDIDBG) termine la session IDBG du
travail en cours, par exemple après BIB19 INVPGM(*NO). Les
programmes sortent du mode débogage et leurs points d'arrêt sont
supprimés.
:P.Cette commande n'a pas de paramètre.
:EHELP.
:EPNLGRP.
```
