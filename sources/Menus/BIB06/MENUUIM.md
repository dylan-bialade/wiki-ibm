---
bibliotheque: BIB06
fichier_source: QMNUSRC
membre: MENUUIM
type: Menus
longueur_enregistrement: 80
lignes: 524
modifie: 2026-11-16
---

# BIB06/QMNUSRC/MENUUIM

```text
.*---------------------------------------------------------------------------*
.* Exemple de Menu UIM                                                       *
.* à compiler avec CRTMNU TYPE(*UIM)                                         *
.*---------------------------------------------------------------------------*
:PNLGRP.

:COPYR.
© Copyright ORGFORM Limited 2023.

:VAR  NAME=ZMENU.

.*---------------------------------------------------------------------------*
.* Definition des touches de fonctions                                       *
.*---------------------------------------------------------------------------*
:KEYL NAME=menukeys
      HELP=key1.

:KEYI KEY=F1
       HELP=helpf1
       ACTION=HELP.
F1=Help

:KEYI KEY=F3
      HELP=helpf3
      ACTION='EXIT SET'.
F3=Exit

:KEYI KEY=F4
      HELP=helpf4
      ACTION=PROMPT.
F4=Prompt

:KEYI KEY=F8
      HELP=helpf8
      ACTION='CMD WRKSPLF'.
F8=Spooled Files

:KEYI KEY=F9
      HELP=helpf9
      ACTION=RETRIEVE.
F9=Retrieve

:KEYI KEY=F10
      HELP=helpf10
      ACTION='CMD WRKSBMJOB'.
F10=Submited jobs

:KEYI KEY=F11
      HELP=helpf11
      ACTION='CMD WRKACTJOB'.
F11=Active jobs

:KEYI KEY=F12
      HELP=helpf12
      ACTION='CANCEL SET'
      VARUPD=NO.
F12=Cancel

:KEYI KEY=F24
      HELP=helpf24
      ACTION=MOREKEYS
      VARUPD=NO.
F24=More Keys

:KEYI KEY=ENTER
      HELP=enter
      ACTION=ENTER.
:KEYI KEY=HELP
      HELP=help
      ACTION=HELP.
:KEYI KEY=PAGEDOWN
      HELP=pagedown
      ACTION=PAGEDOWN.
:KEYI KEY=PAGEUP
      HELP=pageup
      ACTION=PAGEUP.
:KEYI KEY=PRINT
      HELP=print
      ACTION=PRINT.
:EKEYL.

.*---------------------------------------------------------------------------*
.* Define menu panel                                                         *
.* Pour afficher une ligne souligné sur la 2eme ligne "TOPSEP=RULE"          *
.* Pour afficher une ligne vide "TOPSEP=SPACE"                               *
.* Pour afficher le nom du systeme "TOPSEP=SYSNAM"                           *
.*---------------------------------------------------------------------------*
:PANEL
      NAME=xmenup
      HELP='help/ymenu'
      KEYL=menukeys
      ENTER='MSG CPD9817 QCPFMSG'
      PANELID=ZMENU
      TOPSEP=SPACE.
ORGFORM : Menu UIM

.*---------------------------------------------------------------------------*
.* Define menu area                                                          *
.* Pour afficher une ligne souligné sur la 20eme ligne "BOTSEP=RULE"         *
.*---------------------------------------------------------------------------*
:MENU
      DEPTH='*'
      SCROLL=YES
      BOTSEP=RULE.
:TOPINST.
Choisissez l'une des options suivantes :
.* ------------------------------------*
.*       Définition des actions        *
.* --------- Menu Format --------------*
.*   Opt 01 - 10 Commandes systèmes    *
.*   Opt 11 - 14 Les messages          *
.* ------------------------------------*
:MENUGRP.
Commandes systèmes

:MENUI
      OPTION=1
      ACTION='CMD wrksplf'
      HELP='menu/option1'.
Gérer les fichiers spoule             (WRKSPLF)

:MENUI
      OPTION=2
      ACTION='CMD DLTSPLF FILE(*SELECT)'
      HELP='menu/option2'.
Supprimer un fichier spoule           (DLTSPLF)

:MENUI
      OPTION=3
      ACTION='CMD DSPSPLF'
      HELP='menu/option3'.
Afficher un fichier spoule            (DSPSPLF)

:MENUI
      OPTION=4
      ACTION='CMD STRSDA'
      HELP='menu/option4'.
Aide à la conception d'images-écran   (STRSDA)

:MENUI
      OPTION=5
      ACTION='CMD STRPDM'
      HELP='menu/option5'.
Gestionnaire de développement         (STRPDM)

:MENUI
      OPTION=6
      ACTION='CMD ?WRKOBJ'
      HELP='menu/option6'.
Gérer les objets                      (WRKOBJ)

:MENUI
      OPTION=7
      ACTION='CMD STRSQL'
      HELP='menu/option7'.
Démarrer une session SQL              (STRSQL)

:MENUI
      OPTION=8
      ACTION='CMD STRQRY'
      HELP='menu/option8'.
Utilitaires de requêtes               (STRQRY)

:MENUI
      OPTION=9
      ACTION='CMD WRKACTJOB'
      HELP='menu/option9'.
Gestion des travaux actifs            (WRKACTJOB)

:MENUI
      OPTION=10
      ACTION='CMD WRKUSRJOB'
      HELP='menu/option10'.
Gestion des travaux utilisateur       (WRKUSRJOB)

:EMENUGRP.

:MENUGRP.
Les messages

:MENUI
      OPTION=11
      ACTION='CMD WRKMSG'
      HELP='menu/option11'.
Gérer les messages utilisateur        (WRKMSG)

:MENUI
      OPTION=12
      ACTION='CMD WRKMSG *SYSOPR'
      HELP='menu/option12'.
Gérer les messages QSYSOPR            (WRKMSG *SYSOPR)

:MENUI
      OPTION=13
      ACTION='CMD ? SNDMSG'
      HELP='menu/option13'.
Envoyer un message                    (SNDMSG)

:MENUI
      OPTION=14
      ACTION='CMD DSPMSG'
      HELP='menu/option14'.
Afficher les messages                 (DSPMSG)
:EMENUGRP.

:MENUI
      OPTION=90
      ACTION='CMD SIGNOFF'
      HELP='menu/option90'.
Clore une session                     (SIGNOFF)
:EMENU.

.*-----------------------------------------------*
.* Pour afficher la ligne de commande            *
.* SIZE = SHORT ou LONG                          *
.*-----------------------------------------------*
:CMDLINE
      SIZE=SHORT.
Option ou commande

.*---------------------------------------------------------------------------*
.*                            Gestion des aides                              *
.*---------------------------------------------------------------------------*
:EPANEL.
.*
:HELP      NAME='help/ymenu'.
New Business - Help
:P.
This menu provides Processes, Inquires and Reports
:EHELP.
.*
:HELP      NAME=Key1.
Function keys - Help
:XH3. Function keys
:EHELP.
.*
:HELP      NAME=helpf1.
:PARML.
:PT.F1=Help
:PD.
Provides additional information about using the display or a
specific field on the display.
:EPARML.
:EHELP.
.*
:HELP      NAME=helpf3.
:PARML.
:PT.F3=Exit
:PD.
Ends the menu and returns to the point of entry.
:EPARML.
:EHELP.
.*
:HELP      NAME=helpf4.
:PARML.
:PT.F4=Prompt
:PD.
Provide assisatance in entering or selecting a command.
:EPARML.
:EHELP.
.*
:HELP      NAME=helpf8.
:PARML.
:PT.F8=Spooled Files
:PD.
Enables the user to work with spooled files.
:EPARML.
:EHELP.
.*
:HELP      NAME=helpf9.
:PARML.
:PT.F9=Retrieve
:PD.
Dispalys the last command you entered on the command line and any parameters
included.
:EPARML.
:EHELP.
.*
:HELP      NAME=helpf10.
:PARML.
:PT.F10=Work with submited jobs
:PD.
Enables the user to work with submited jobs.
:EPARML.
:EHELP.
.*
:HELP      NAME=helpf11.
:PARML.
:PT.F11=Work with active jobs
:PD.
Enables the user to work with active jobs.
:EPARML.
:EHELP.
.*
:HELP      NAME=helpf12.
:PARML.
:PT.F12=Cancel
:PD.
Returns to the previous menu or display.
:EPARML.
:EHELP.
.*
:HELP      NAME=helpf24.
:PARML.
:PT.F24=More Keys
:PD.
Shows additional function keys.
:EPARML.
:EHELP.
.**
:HELP      NAME='menu/option1'.
Gérer les fichiers spoule              (WRKSPLF)
:P.
1. Help WRKSPLF
Gestion des SPOOLS
:EHELP.
.**
:HELP      NAME='menu/option2'.
Supprimer un fichier spoule            (DLTSPLF)
:P.
2. Help DLTSPLF
:P.
Tout doit disparaitre
:EHELP.
.*
:HELP      NAME='menu/option3'.
Afficher un fichier spoule             (DSPSPLF)
:P.
3. Help
:EHELP.
.*
:HELP      NAME='menu/option4'.
Aide à la conception d'images-écran    (STRSDA)
:P.
4. Help
:EHELP.
.*
:HELP      NAME='menu/option5'.
Gestionnaire de développement          (STRPDM)
:P.
5. Help
:EHELP.
.*
:HELP      NAME='menu/option6'.
Gérer les objets                       (WRKOBJ)
:P.
6. Help
:EHELP.
.*
:HELP      NAME='menu/option7'.
Démarrer une session SQL               (STRSQL)
:P.
7. Help
:EHELP.
.*
:HELP      NAME='menu/option8'.
Utilitaires de requêtes                (STRQRY)
:P.
8. Help
:EHELP.
.*
:HELP      NAME='menu/option9'.
Gestion des travaux actifs             (WRKACTJOB)
:P.
9. Help
:EHELP.
.*
:HELP      NAME='menu/option10'.
Gestion des travaux utilisateur        (WRKUSRJOB)
:P.
10. Help
:EHELP.
.*
:HELP      NAME='menu/option11'.
Gérer les messages utilisateur         (WRKMSG)
:P.
11. Help
:EHELP.
.*
:HELP      NAME='menu/option12'.
Gérer les messages QSYSOPR             (WRKMSG *SYSOPR)
:P.
12. Help
:EHELP.
.*
:HELP      NAME='menu/option13'.
Envoyer un message                     (SNDMSG)
:P.
13. Help
:EHELP.
.*
:HELP      NAME='menu/option14'.
Afficher les messages                  (DSPMSG)
:P.
14. Help
:EHELP.
.*
:HELP      NAME='menu/option15'.
Clore une session                      (SIGNOFF)
:P.
15. Help
:EHELP.
.*
:HELP      NAME='menu/option16'.
Entering your System Process - HELP
:P.
16. Help
:EHELP.
.*
:HELP      NAME='menu/option17'.
Entering your System Process - HELP
:P.
17. Help
:EHELP.
.*
:HELP      NAME='menu/option18'.
Entering your System Process - HELP
:P.
18. Help
:EHELP.
.*
:HELP      NAME='menu/option19'.
Entering your System Process - HELP
:P.
19. Help
:EHELP.
.*
:HELP      NAME='menu/option20'.
Entering your System Process - HELP
:P.
20. Help
:EHELP.
.*
:HELP      NAME='menu/option21'.
Entering your System Process - HELP
:P.
21. Help
:EHELP.
.*
:HELP      NAME='menu/option22'.
Entering your System Process - HELP
:P.
22. Help
:EHELP.
.*
:HELP      NAME='menu/option23'.
Entering your System Process - HELP
:P.
23. Help
:EHELP.
.*
:HELP      NAME='menu/option24'.
Entering your System Process - HELP
:P.
24. Help
:EHELP.
.*
:HELP      NAME='menu/option25'.
Entering your System Process - HELP
:P.
25. Help
:EHELP.
.*
:HELP      NAME='menu/option26'.
Entering your System Process - HELP
:P.
26. Help
:EHELP.
.*
:HELP      NAME='menu/option27'.
Entering your System Process - HELP
:P.
27. Help
:EHELP.
.*
:HELP      NAME='menu/option90'.
:PARML.
:PT.Option 90 - Help
:PD.
90. Selectionne cette option et BYE BYE !!!
:EPARML.
:EHELP.
.*
:HELP      NAME=enter.
:PARML.
:PT.Enter
:PD.
Permet de revenir à l'écran à partir duquel l'aide a été demandée.
:EPARML.
:EHELP.
.*
:HELP      NAME=help.
:PARML.
:PT.Help
:PD.
Permet d'obtenir des informations supplémentaires sur l'écran affiché.
:EPARML.
:EHELP.
.*
:HELP      NAME=pagedown.
:PARML.
:PT.Page Down
:PD.
Permet d'afficher les informations précédentes.
:EPARML.
:EHELP.
.*
:HELP      NAME=pageup.
:PARML.
:PT.Page Up
:PD.
Permet d'afficher les informations suivantes.
:EPARML.
:EHELP.
.*
:HELP      NAME=print.
:PARML.
:PT.Print
:PD.
Permet d'imprimer les informations affichées à l'écran.
:EPARML.
:EHELP.
.* End of menu source
:EPNLGRP.
```
