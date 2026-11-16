---
bibliotheque: BIB13
fichier_source: QRPGLESRC
membre: TP02MOD
type: RPG/RPG-ILE
longueur_enregistrement: 114
lignes: 139
modifie: 2026-11-16
---

# BIB13/QRPGLESRC/TP02MOD

```rpg
**free

ctl-opt nomain option(*srcstmt:*nodebugio);



/include QCPYSRC,TP02MODP



dcl-c STOCK_SECU const(0);

dcl-s nbLecture int(10) inz(0) export;

dcl-s test char(1) inz('1') export;



dcl-s articleStock packed(7:0);

dcl-s articleHt packed(9:2);



dcl-proc lireArticle;

  dcl-pi *n ind;

    code char(6)const;

  end-pi;

  dcl-s req char(500);

  req = ' select ARSTK,ARPXHT from BIB13.ARTICLE WHERE ARCODE = ?';

  exec sql prepare req from :req;

  exec sql declare C1 cursor for req;



  exec sql open c1 using :code;

  dow sqlcode =0;

    exec sql fetch c1 into :articleStock,:articleHt;

    nbLecture+=1;

    if sqlcode = 0;

      return *on;

    else;

      return *off;

    endif;

  enddo;

  return *off;



end-proc;



dcl-proc stockArticle export;

  dcl-pi *n packed(7:0);

    code char(6)const;

  end-pi;

  if lireArticle(code);

    return articleStock;

  else;

    return -1;

  endif;

end-proc;



dcl-proc valeurStock export;

  dcl-pi *n packed(11:2);

    code char(6)const;

  end-pi;

  if lireArticle(code);

    return articleHt*articleStock;

  else;

    return 0;

  endif;

end-proc;



dcl-proc estDisponible export;

  dcl-pi *n ind;

    code char(6) const;

    qte packed(7:0) const;

  end-pi;

  if not lireArticle(code);

    return *off;

  endif;

  if (articleStock-STOCK_SECU) >= qte;

    return *on;

  endif;

  return *off;

end-proc;
```
