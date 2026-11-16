---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: FFSFR2
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 177
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/FFSFR2

```rpg
**FREE
ctl-opt copyright('(C) ARMONIE 2023.') dftactgrp(*no) optimize(*full)
actgrp(*caller) datfmt(*iso) timfmt(*iso) alloc(*stgmdl)
stgmdl(*inherit) thread(*serialize);

dcl-f SFDSPSQL WORKSTN SFILE(SFL1:rang);

dcl-s last_rang zoned(4:0) inz(*zero);
dcl-c AFFICHER  const('5');

dcl-c SUPPRIMER const('4');
dcl-s i         zoned(4:0) inz(*zero);

dcl-c SFLPAG    const(12);

dcl-c MODIFIER  const('2');
dcl-s datejour  date(*iso) inz(*job);

exec sql
set option commit = *none , alwcpydta = *optimize, closqlcsr = *endmod;

initialisation_sous_fichier();
fabrication_sous_fichier();
scodpro = *blank;

dou *in03;
  write Fkey1;
  exfmt SF1CTL;
  select;
    when *in39;
      fabrication_sous_fichier();
    when scodpro <> *blank;
      exec sql close c1;
      initialisation_sous_fichier();
      fabrication_sous_fichier();
      clear Scodpro;
    when *in05;
      exec sql close c1;
      initialisation_sous_fichier();
      fabrication_sous_fichier();
    when *in06;
      creation();
      exec sql close c1;
      initialisation_sous_fichier();
      fabrication_sous_fichier();
    other;
      exec sql
        SELECT codpro INTO :e1codpro FROM entrepot;
      if sqlcode <> 100;
        trt_readc();
      endif;
      exec sql close c1;
      initialisation_sous_fichier();
      fabrication_sous_fichier();
  endsl;
enddo;

exec sql close c1;
*inlr = *on;

dcl-proc initialisation_sous_fichier;
  rang = *zero;
  last_rang = *zero;
  *in31 = *on;
  write SF1CTL;
  *in31 = *off;
  *in32 = *off;
  *in90 = *off;
  exec sql
    DECLARE c1 CURSOR FOR
    (select codpro, nmpro, qtpro, dtdinv
    from entrepot
    order by codpro)
    FOR READ ONLY OPTIMIZE FOR ALL ROWS;
  exec sql
    open c1;
end-proc;
dcl-proc fabrication_sous_fichier;
  rang = last_rang;
  for i=1 to SFLPAG;
    exec sql FETCH c1 INTO :e1codpro, :e1nmpro, :e1qtpro, :e1dtdinv;
    if sqlcode = 100;
      *in90=*on;
      leave;
    endif;
    if e1codpro >= scodpro;
      rang += 1;
      write SFL1;
    endif;
  endfor;
  if rang = *zero;
    *in32 = *on;
  endif;
  last_rang = rang;
end-proc;
dcl-proc trt_readc;
  Readc SFL1;
  dow not %eof;
    select;
      when opt = AFFICHER;
        affiche();
      when opt = SUPPRIMER;
        suppression();
      when opt = MODIFIER;
        modification();
    endsl;
    Readc SFL1;
  enddo;
end-proc;
dcl-proc creation;
  dou *in03;
    e6dtdinv = datejour;
    exfmt FMT6;
    select;
      when *in03;
        iter;
      when *in12;
        leave;
      when *in23;
        exec sql
            INSERT INTO entrepot (codpro, nmpro, qtpro, dtdinv)
            VALUES (:e6codpro, :e6nmpro, :e6qtpro, :datejour);
        leave;
    endsl;
  enddo;
  clear opt;
end-proc;

dcl-proc affiche;
  exec sql
    SELECT codpro, nmpro, qtpro, dtdinv
    INTO :e5codpro, :e5nmpro, :e5qtpro, :e5dtdinv
    FROM entrepot
    WHERE codpro = :e1codpro;
  exfmt FMT5;
  clear opt;
end-proc;

dcl-proc modification;
  exec sql
    select codpro, nmpro, qtpro, dtdinv
    INTO :e2codpro, :e2nmpro, :e2qtpro, :e2dtdinv
    FROM entrepot
    WHERE codpro = :e1codpro;
  dou *in03;
    exfmt FMT2;
    select;
      when *in03;
        iter;
      when *in12;
        leave;
      when *in23;
        exec sql
            UPDATE entrepot
            SET codpro = :e2codpro, nmpro = :e2nmpro,
            qtpro = :e2qtpro, dtdinv = :E2DTDinV
            WHERE codpro = :e2codpro;
        leave;
    endsl;
  enddo;
  clear opt;
  update SFL1;
end-proc;
dcl-proc suppression;
  exec sql
    SELECT codpro, nmpro, qtpro, dtdinv
    INTO :e4codpro, :e4nmpro, :e4qtpro, :e4dtdinv
    FROM entrepot
    WHERE codpro = :e1codpro;
  exfmt FMT4 ;
  clear opt;
  if *in23;
    exec sql
        delete from entrepot where codpro = :e4codpro;
  endif;
  update SFL1;
end-proc;
```
