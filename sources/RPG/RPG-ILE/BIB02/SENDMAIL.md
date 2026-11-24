---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: SENDMAIL
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 24
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/SENDMAIL

```rpg
**free
ctl-opt dftactgrp(*no) optimize(*full);

// Déclare une procédure externe appelée QP2Shell qui exécute un programme PASE
// Le paramètre 'cmd' est obligatoire, tandis que 'parm1' et 'parm2' sont optionnels
dcl-pr QP2Shell extpgm('QP2SHELL2');
  cmd   char(1024) const options(*varsize);          // Commande
  parm1 char(1024) const options(*varsize:*nopass);  // Paramètre optionnel 1
  parm2 char(1024) const options(*varsize:*nopass);  // Paramètre optionnel 2
end-pr;

// Déclare une constante NULL de 1 caractère initialisée à x'00'
dcl-s NULL char(1) inz(x'00');

// Appelle la procédure QP2Shell pour exécuter un script PHP avec des paramètres
// Le premier paramètre est le chemin vers l'exécutable PHP
// Le second paramètre est le chemin du script PHP à exécuter
// Le troisième paramètre est l'adresse e-mail à laquelle le mail doit être envoyé
QP2Shell('/usr/local/zendphp7/bin/php-cli' + NULL :      // Chemin vers l'exécutable PHP
         '/www/zendphp7/htdocs/sylvain_php/mail/sendmail.php' + NULL : // Script PHP à exécuter
         'adresse@exemple.invalid' + NULL);  // Adresse e-mail pour l'envoi


*inlr = *on;
```
