---
bibliotheque: BIB05
fichier_source: QWEBSRC
membre: DB1W2FM
type: Autres/Web
longueur_enregistrement: 114
lignes: 209
modifie: 2026-11-16
---

# BIB05/QWEBSRC/DB1W2FM

```text
<?xml version="1.0" encoding="ISO-8859-1"?>

<file version="1.1">

<fnkey fnkey="3"/>

<record recordtype="sflctl" width="800" height="500" sflpage="10" name="FC1" sflctl="SF1" overlay="no" top="0" lef
t="0" style="background:#f4f6fb;font-family:'Segoe UI',Roboto,Arial,sans-serif;">
<sfldsp/>

<sfldspctl/>

<sfltitle height="24" style="font-family:'Segoe UI',Roboto,Arial,sans-serif;background:#1e3a8a;color:#ffffff;font-
weight:600;">
<column text="Nom" width="150" sort="yes"/>

<column text="Prénom" width="120" sort="yes"/>

<column text="Naissance" width="90" sort="yes"/>

<column text="CP" width="60" sort="yes"/>

<column text="Ville" width="150" sort="yes"/>

<column text="Mail" width="190"/>

<column text="Actions" width="60"/>

</sfltitle>

<sflpaginationbar sflsearch="yes">

<image top="0" left="0" proportion="yes" image="/phl/images/excel.gif">

<event hyperlink="yes" type="onclick">

<function name="sndsflcoltoexcel" record="SF1"/>

</event>

</image>

</sflpaginationbar>

<field usage="H" name="NOMW" datatype="A" size="30" top="5" left="5"/>

<contextmenu name="MENUSAL">

<menutitle text="Salarié"/>

<menutext text="Modifier la fiche">

<function name="callpgm400" pgm="DB1W1">

<function name="parampgm400" value="&amp;vscreen(SACOD)"/>

</function>

</menutext>

<menuseparator/>

<menutext text="Exporter vers Excel" image="/phl/images/excel.gif">

<function name="sndtoexcel" fields="*ALL" sflselected="all" head="Nom;Prénom;Naissance;CP;Ville" record="SF1"/>

</menutext>

<menuseparator/>

<menutext text="Afficher la fiche">

<function name="callpgm400" pgm="DB1W1">

<function name="parampgm400" value="&amp;vscreen(SACOD)"/>

</function>

</menutext>

</contextmenu>

<const type="btnimg" noupdate="yes" nomove="yes" icone="yes" image="/phl/images/excel.gif" text="Excel" position="
R" shortkey="065010" top="433" left="130" width="62" style="font-family:'Segoe UI',Ro-
boto,Arial,sans-serif;border-radius:8px;border:1px solid #cbd5e1;background:#f1f5f9;color:#334155;font-weight:600;
">
<event hyperlink="yes" type="onclick">

<function name="sndsflcoltoexcel" record="SF1"/>

</event>

</const>

<image name="CORBEILLE" width="32" height="32" image="/phl/images/trash.gif" top="433" left="400">

<event type="ondrop">

<function name="msgconfirm" text="&quot;Supprimer ce salarié ?&quot;"/>

<function name="msgalert" text="&quot;Salarié supprimé (simulation)&quot;"/>

</event>

</image>

<const type="btnimg" noupdate="yes" nomove="yes" icone="yes" image="/phl/images/cancel4.gif" text="Sortir" positio
n="R" shortkey="065010" top="433" left="44" width="62" style="font-family:'Segoe UI',-
Roboto,Arial,sans-serif;border-radius:8px;border:1px solid #cbd5e1;background:#f1f5f9;color:#334155;font-weight:60
0;">
<event type="onclick">

<function name="setfnkey" fnkey="3"/>

</event>

</const>

<const type="btnimg" noupdate="yes" nomove="yes" icone="yes" image="/phl/images/ok.gif" text="Valider" position="R
" shortkey="065010" top="437" left="659" style="font-family:'Segoe UI',Roboto,Arial,s-
ans-serif;border-radius:8px;border:none;background:#2563eb;color:#ffffff;font-weight:600;box-shadow:0 2px 6px rgba
(37,99,235,.35);">
<event type="onclick">

<function name="setfnkey" fnkey="enter"/>

</event>

</const>

</record>

<record recordtype="sfl" width="800" top="24" height="24" name="SF1">

<field usage="H" name="SACOD" datatype="A" size="3"/>

<field usage="H" name="OPT" datatype="A" size="1"/>

<event hyperlink="yes" type="oncontextmenu">

<function name="dspcontextmenu" popuprecord="FC1" popupname="MENUSAL"/>

</event>

<sflcolumn>

<field usage="O" name="SANOM" datatype="A" size="30" style="font-family:'Segoe UI',Roboto,Arial,sans-serif;color:#
334155;">
<event type="ondrag">

<function name="setvalue" value="NOMW" setfield="NOMW" setrecord="FC1" setvalue="&amp;vscreen(SANOM)"/>

</event>

</field>

</sflcolumn>

<sflcolumn>

<field usage="O" name="SAPRN" datatype="A" size="30" style="font-family:'Segoe UI',Roboto,Arial,sans-serif;color:#
334155;"/>
</sflcolumn>

<sflcolumn>

<field usage="O" name="SADAT" datatype="D" datefmt="*JOB" datesep="." style="font-family:'Segoe UI',Roboto,Arial,s
ans-serif;color:#334155;"/>
</sflcolumn>

<sflcolumn>

<field usage="O" name="SAPOS" datatype="A" size="5" style="font-family:'Segoe UI',Roboto,Arial,sans-serif;color:#3
34155;"/>
</sflcolumn>

<sflcolumn>

<field usage="O" name="SAVIL" datatype="A" size="30" style="font-family:'Segoe UI',Roboto,Arial,sans-serif;color:#
334155;"/>
</sflcolumn>

<sflcolumn>

<field usage="O" name="SAMAIL" datatype="A" size="50" style="color:#2563eb;text-decoration:underline;cursor:pointe
r;">
<event hyperlink="yes" type="onclick">

<function name="callurl" url="mailto:&amp;SAMAIL"/>

</event>

</field>

</sflcolumn>

<sflcolumn>

<imgupd top="4" left="6">

<function name="msgalert" text="Modification du salarié &amp;SACOD"/>

</imgupd>

</sflcolumn>

</record>

</file>
```
