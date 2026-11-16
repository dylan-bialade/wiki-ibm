---
bibliotheque: BIB05
fichier_source: QWEBSRC
membre: DB1W3FM
type: Autres/Web
longueur_enregistrement: 114
lignes: 129
modifie: 2026-11-16
---

# BIB05/QWEBSRC/DB1W3FM

```text
<?xml version="1.0" encoding="ISO-8859-1"?>

<file version="1.1">

<fnkey fnkey="3"/>

<record recordtype="sflctl" width="800" height="560" sflpage="7" name="FC1" sflctl="SF1" overlay="no" top="0" left
="0" style="background:#f4f6fb;">
<sfldsp/>

<sfldspctl/>

<sfltitle height="24" style="background:#1e3a8a;color:#ffffff;font-weight:600;">

<column text="Image" width="90"/>

<column text="N°" width="50" sort="yes"/>

<column text="Nom" width="130" sort="yes"/>

<column text="Type 1" width="80" sort="yes"/>

<column text="Type 2" width="80" sort="yes"/>

<column text="PV" width="55" sort="yes"/>

<column text="Att." width="55" sort="yes"/>

<column text="Déf." width="55" sort="yes"/>

<column text="Att. Spé." width="55" sort="yes"/>

<column text="Déf. Spé." width="55" sort="yes"/>

<column text="Vit." width="55" sort="yes"/>

</sfltitle>

<sflpaginationbar sflsearch="yes"/>

<const type="label" text="Pokédex" top="0" left="340" width="120" height="22" style="font-size:18px;font-weight:70
0;color:#1e3a8a;"/>
<const type="btnimg" noupdate="yes" nomove="yes" icone="yes" image="/phl/images/cancel4.gif" text="Sortir" positio
n="R" shortkey="065010" top="520" left="44" width="62" style="border-radius:8px;borde-
r:1px solid #cbd5e1;background:#f1f5f9;color:#334155;font-weight:600;">

<event hyperlink="yes" type="onclick">

<function name="setfnkey" fnkey="3"/>

</event>

</const>

</record>

<record recordtype="sfl" width="800" top="24" height="80" name="SF1">

<field usage="H" name="OPT" datatype="A" size="1"/>

<sflcolumn>

<image top="4" left="8" width="72" height="72" image="https://raw.githubusercontent.com/PokeAPI/sprites/master/spr
ites/pokemon/other/official-artwork/&amp;POKED00001.png"/>
</sflcolumn>

<sflcolumn>

<field usage="O" name="POKED00001" datatype="S" dec="0" size="3" top="28"/>

</sflcolumn>

<sflcolumn>

<field usage="O" name="NAME" datatype="A" size="30" top="28" style="font-weight:600;"/>

</sflcolumn>

<sflcolumn>

<field usage="O" name="TYPE1" datatype="A" size="15" top="28"/>

</sflcolumn>

<sflcolumn>

<field usage="O" name="TYPE2" datatype="A" size="15" top="28"/>

</sflcolumn>

<sflcolumn>

<field usage="O" name="HP" datatype="S" dec="0" size="3" top="28"/>

</sflcolumn>

<sflcolumn>

<field usage="O" name="ATTACK" datatype="S" dec="0" size="3" top="28"/>

</sflcolumn>

<sflcolumn>

<field usage="O" name="DEFENSE" datatype="S" dec="0" size="3" top="28"/>

</sflcolumn>

<sflcolumn>

<field usage="O" name="SPECI00001" datatype="S" dec="0" size="3" top="28"/>

</sflcolumn>

<sflcolumn>

<field usage="O" name="SPECI00002" datatype="S" dec="0" size="3" top="28"/>

</sflcolumn>

<sflcolumn>

<field usage="O" name="SPEED" datatype="S" dec="0" size="3" top="28"/>

</sflcolumn>

</record>

</file>
```
