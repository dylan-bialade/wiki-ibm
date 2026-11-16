---
bibliotheque: BIB05
fichier_source: QWEBSRC
membre: DB1W1FM
type: Autres/Web
longueur_enregistrement: 114
lignes: 217
modifie: 2026-11-16
---

# BIB05/QWEBSRC/DB1W1FM

```text
<?xml version="1.0" encoding="ISO-8859-1"?>

<file version="1.1">

<fnkey fnkey="3"/>

<record recordtype="record" width="800" height="500" name="F1" overlay="no" top="2" left="-19" style="background:#
f4f6fb;">
<fnkey datareturn="yes" fnkey="3"/>

<fnkey fnkey="enter" value="CRTLNOM" function="CRTLNOM" record="F1"/>

<event type="onwrite">

<function name="callfunctionweb" function="affiche"/>

<function name="setvisible" record="F1" value="ERROR_NOM" field="ERROR_NOM" visible="no"/>

</event>

<const type="label" noupdate="yes" text="Fiche salarié" top="24.63" left="234" style="color:#1e3a8a;font-weight:70
0;font-size:24px;letter-spacing:.3px;"/>
<panel text="identité" top="96" left="27" width="445" height="133" style="border:1px solid #e2e8f0;border-radius:1
2px;background:#ffffff;box-shadow:0 2px 8px rgba(15,23,42,.08);color:#1e3a8a;font-wei-
ght:600;"/>

<const type="label" noupdate="yes" text="nom" top="110.23" left="40" style="color:#334155;font-weight:600;font-siz
e:13px;"/>
<const type="label" noupdate="yes" text="prenom" top="143" left="35" style="color:#334155;font-weight:600;font-siz
e:13px;"/>
<const type="label" noupdate="yes" text="civilité" top="180.23" left="39" style="color:#334155;font-weight:600;fon
t-size:13px;"/>
<const type="label" noupdate="yes" text="date de naissance " top="118" left="250" style="color:#334155;font-weight
:600;font-size:13px;"/>
<field usage="B" name="SANOM" datatype="A" size="30" top="120.225" left="97" height="13" style="border:1px solid #
cbd5e1;border-radius:6px;padding:3px 8px;background:#ffffff;color:#0f172a;"/>
<field usage="B" name="SAPRN" datatype="A" size="30" top="147" left="94" style="border:1px solid #cbd5e1;border-ra
dius:6px;padding:3px 8px;background:#ffffff;color:#0f172a;"/>
<field usage="R" name="SACIV" datatype="A" size="1" top="170" left="93" width="253" height="50">

<textbox text="Monsieur;Madame;Mademoiselle" value="1;2;3"/>

<event type="onchange">

<function name="callfunctionweb" function="affiche"/>

</event>

<event type="onclick">

<function name="callfunctionweb" function="affiche"/>

</event>

</field>

<field usage="B" datefmt="*JOB" datesep="." name="SADAT" top="121" left="357" datatype="D" width="80" style="borde
r:1px solid #cbd5e1;border-radius:6px;padding:3px 8px;background:#ffffff;color:#0f172-
a;"/>

<groupbox width="440" height="50" name="N_D_JF" top="228" left="28" style="border:1px solid #e2e8f0;border-radius:
12px;background:#ffffff;box-shadow:0 2px 8px rgba(15,23,42,.08);">
<const type="label" noupdate="yes" text="nom de jeune fille" top="12" left="4" style="color:#334155;font-weight:60
0;font-size:13px;"/>
<field usage="B" name="SANJF" top="13" left="117" datatype="A" size="30" width="225" style="border:1px solid #cbd5
e1;border-radius:6px;padding:3px 8px;background:#ffffff;color:#0f172a;"/>
</groupbox>

<functionweb name="affiche" top="5" left="393">

<function name="if" test="&amp;vscreen(SACIV)='2'">

<function name="setvisible" record="F1" value="N_D_JF" field="N_D_JF" visible="yes"/>

<function name="else"/>

<function name="setvisible" record="F1" value="N_D_JF" field="N_D_JF" visible="no"/>

</function>

</functionweb>

<groupbox width="280" height="41" name="ERROR_NOM" top="110" left="485" style="border:1px solid #fecaca;border-rad
ius:12px;background:#fef2f2;">
<image width="32" height="32" image="/phl/images/zh.gif" top="3" left="8"/>

<const type="label" noupdate="yes" text="Erreur : nom obligatoire" top="12" left="50" style="color:#ac0c0c;font-we
ight:600;font-size:13px;"/>
<field usage="O" name="ERR_COUNT" datatype="S" dec="0" size="3" top="11" left="236" width="28"/>

</groupbox>

<functionweb name="CRTLNOM" top="5" left="500">

<function name="if" test="&amp;vscreen(SANOM)=''">

<function name="setfocus" setrecord="F1" value="SANOM" setfield="SANOM"/>

<function name="setstyle" record="F1" value="SANOM" field="SANOM" style="background-color:#ff0000;" clearstyle="ye
s"/>
<function name="setvisible" record="F1" value="ERROR_NOM" field="ERROR_NOM" visible="yes"/>

<function name="if" test="&amp;vscreen(ERR_COUNT)&gt;=3">

<function name="msgalert" text="&quot;Vous insistez... le nom est toujours obligatoire !&quot;"/>

<function name="else"/>

<function name="if" test="&amp;vscreen(ERR_COUNT)=2">

<function name="msgalert" text="&quot;Encore vide : le nom est vraiment obligatoire !&quot;"/>

<function name="else"/>

<function name="if" test="&amp;vscreen(ERR_COUNT)=1">

<function name="msgalert" text="&quot;Saisissez un nom, s'il vous plaît&quot;"/>

<function name="else"/>

<function name="msgalert" text="&quot;Le nom est obligatoire&quot;"/>

</function>

</function>

</function>

<function name="setvalue" value="ERR_COUNT" setfield="ERR_COUNT" setrecord="F1" setvalue="&amp;eval(&amp;vscreen(E
RR_COUNT) + 1)"/>
<function name="return"/>

<function name="else"/>

<function name="setstyle" record="F1" value="SANOM" field="SANOM" style="background-color:#ffffff;" clearstyle="ye
s"/>
<function name="setvisible" record="F1" value="ERROR_NOM" field="ERROR_NOM" visible="no"/>

<function name="setvalue" value="ERR_COUNT" setfield="ERR_COUNT" setrecord="F1" setvalue="0"/>

</function>

</functionweb>

<field usage="H" name="SACOD" datatype="A" size="3" top="5" left="5"/>

<tabpanel name="ONGLET_MENU" top="290" left="28" width="440" height="135">

<tabtext text="Adresse" name="ADRESSE" shortkey="065010" value="ADR_GRPBOX" groupbox="ADR_GRPBOX" record="F1"/>

<tabtext text="Photo" name="PHOTO" shortkey="065010" value="PHOT_GRPBOX" groupbox="PHOT_GRPBOX" record="F1"/>

</tabpanel>

<groupbox width="430" height="105" name="ADR_GRPBOX" top="315" left="33" style="border:1px solid #e2e8f0;border-ra
dius:12px;background:#ffffff;box-shadow:0 2px 8px rgba(15,23,42,.08);">
<const type="label" noupdate="yes" text="adresse" top="5" left="5" style="color:#334155;font-weight:600;font-size:
13px;"/>
<field usage="B" name="SAADR" datatype="A" size="60" top="5" left="80" width="300" style="border:1px solid #cbd5e1
;border-radius:6px;padding:3px 8px;background:#ffffff;color:#0f172a;"/>
<const type="label" noupdate="yes" text="code postal" top="30" left="5" style="color:#334155;font-weight:600;font-
size:13px;"/>
<field usage="B" name="SAPOS" datatype="A" size="5" top="30" left="80" width="60" style="border:1px solid #cbd5e1;
border-radius:6px;padding:3px 8px;background:#ffffff;color:#0f172a;"/>
<const type="label" noupdate="yes" text="ville" top="30" left="160" style="color:#334155;font-weight:600;font-size
:13px;"/>
<field usage="B" name="SAVIL" datatype="A" size="30" top="30" left="200" width="180" style="border:1px solid #cbd5
e1;border-radius:6px;padding:3px 8px;background:#ffffff;color:#0f172a;"/>
<const type="label" noupdate="yes" text="pays" top="55" left="5" style="color:#334155;font-weight:600;font-size:13
px;"/>
<field usage="S" name="SAPAY" datatype="A" size="2" top="55" left="80" width="180" style="border:1px solid #cbd5e1
;border-radius:6px;padding:3px 8px;background:#ffffff;color:#0f172a;">
<sqlbox sql="select PAYCOD, PAYLIB from PAYS order by PAYLIB"/>

</field>

<const type="label" noupdate="yes" text="département" top="80" left="5" style="color:#334155;font-weight:600;font-
size:13px;"/>
<field usage="U" name="SADPT" datatype="A" size="3" top="80" left="80" width="180" style="border:1px solid #cbd5e1
;border-radius:6px;padding:3px 8px;background:#ffffff;color:#0f172a;" sql="select dpd-
pt, dplib from DEPT where dppay = '&amp;vscreen(SAPAY)' order by dplib"/>

</groupbox>

<groupbox width="430" height="105" name="PHOT_GRPBOX" top="315" left="33" style="border:1px solid #e2e8f0;border-r
adius:12px;background:#ffffff;box-shadow:0 2px 8px rgba(15,23,42,.08);">
<image width="80" height="95" image="/phl/appliPHLFORMV6/images/&amp;SACOD.jpg" top="5" left="10"/>

</groupbox>

<const type="btnimg" noupdate="yes" nomove="yes" icone="yes" image="/phl/images/cancel4.gif" text="Sortir" positio
n="R" shortkey="065010" top="433" left="44" width="62" style="border-radius:8px;borde-
r:1px solid #cbd5e1;background:#f1f5f9;color:#334155;font-weight:600;">

<event type="onclick">

<function name="setfnkey" fnkey="3"/>

</event>

</const>

<const type="btnimg" noupdate="yes" nomove="yes" icone="yes" image="/phl/images/ok.gif" text="Valider" position="R
" shortkey="065010" top="437" left="659" style="border-radius:8px;border:none;backgro-
und:#2563eb;color:#ffffff;font-weight:600;box-shadow:0 2px 6px rgba(37,99,235,.35);">

<event type="onclick">

<function name="setfnkey" fnkey="enter"/>

</event>

</const>

</record>

</file>
```
