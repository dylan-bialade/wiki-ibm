---
bibliotheque: BIB03
fichier_source: QRPGLESRC
membre: TP1MAIN
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 41
modifie: 2026-11-16
---

# BIB03/QRPGLESRC/TP1MAIN

```rpg
**free
// TP1MAIN : module d'entrée (PEP) - utilise calcTtc et nbCalculs de TP1MOD

dcl-f ARTICLE usage(*input);
dcl-f ARTPROMO usage(*input) rename(ARTICF:PROMOF) prefix('P_');

/copy Qcpysrc,TP1MODP

dcl-s nbCalculs int(10) import;      // pas de inz sur une donnée importée

dcl-s totHT   packed(11:2);
dcl-s totTTC  packed(11:2);
dcl-s rep     char(1);

// --- ARTICLE ---
read ARTICF;
dow not %eof(ARTICLE);
  totHT  += ARPXHT;
  totTTC += calcTtc(ARPXHT : ARCTVA);
  read ARTICF;
enddo;
dsply ('ARTICLE  Total HT  : ' + %char(totHT));
dsply ('ARTICLE  Total TTC : ' + %char(totTTC));

// --- ARTPROMO ---
totHT  = 0;
totTTC = 0;
read PROMOF;
dow not %eof(ARTPROMO);
  totHT  += P_ARPXHT;
  totTTC += calcTtc(P_ARPXHT : P_ARCTVA);
  read PROMOF;
enddo;
dsply ('ARTPROMO Total HT  : ' + %char(totHT));
dsply ('ARTPROMO Total TTC : ' + %char(totTTC));

dsply ('nbCalculs : ' + %char(nbCalculs));

dsply 'Pile : Maj+Echap, option 3 puis 11' '' rep;

*inlr = *on;
```
