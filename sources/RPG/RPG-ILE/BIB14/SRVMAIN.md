---
bibliotheque: BIB14
fichier_source: QRPGLESRC
membre: SRVMAIN
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 225
modifie: 2026-11-16
---

# BIB14/QRPGLESRC/SRVMAIN

```rpg
**free
ctl-opt dftactgrp(*no) actgrp(*new) bnddir('SRVDIR');

dcl-f srvdsp workstn sfile(modsfl:sm_rrn)sfile(USESFL:su_rrn)sfile(EXPSFL:se_rrn);

/copy QCPYSRC,SRVPGMMODP

dcl-s PtrInd pointer inz(%addr(*in));
dcl-ds DS_Global based(PtrInd);
    // FN
  F3     ind pos(3);
  F12    ind pos(12);
    // sfl
  SM_CLR ind pos(30);
  SM_END ind pos(31);
  CM_DSP ind pos(32);
  SM_DSP ind pos(33);
end-ds;

*inlr = *on;
M_LIB = '*LIBL';
dou F3;

  exfmt MNU;

  if f3;
    leave;
  endif;

  if not check();
    iter;
  endif;
  // affichage de la window de selection
  window();

  select;
    when (W_CHX = '1');
      ecranuse();
    when (W_CHX = '2');
      ecranMod();
    when (W_CHX = '3');
      ecranexp();

    other;
      // handle other conditions
  endsl;
enddo;



dcl-proc check;
  dcl-pi *n ind;
  end-pi;
  dcl-s res ind;
  checksrv(M_LIB: M_PGM: res);
  W_LIB = M_LIB;
  return res;
end-proc;

dcl-proc window;
  W_LIB = M_LIB;
  W_PGM = M_PGM;

  dou F3 or F12;
    exfmt win;
    if F3 or F12;
      return;
    endif;
    if W_CHX<>'0';
      return;
    endif;
  enddo;
end-proc;

// option 2 affichage modules

dcl-proc initMod;

  SM_CLR =*on;
  SM_DSP = *off;
  CM_DSP = *off;
  write CTLMOD;
  SM_CLR = *off;
  SM_RRN = 0;
end-proc;

dcl-proc chargeMod;

  dcl-ds modules likeds(modules_t) dim(*auto:300);
  dcl-ds module likeds(modules_t);

  modules = getmod(W_LIB:W_PGM);
  CM_NB = modules(1).lendta;
  if CM_NB<> 0;
    for-each module in %subarr(modules:1:CM_NB);
      SM_MOD = module.nom;
      SM_LIB = module.lib;
      SM_ATT = module.attribut;
      SM_SRC = module.source;
      SM_DATE = %char(%date(module.dateCreation));
      SM_RRN+=1;
      write MODSFL;
    endfor;
  endif;
  if SM_RRN>0;
    SM_DSP = *on;
  else;
    SM_DSP = *off;
  endif;
  CM_DSP = *on;
  SM_END = *on;
  write modpied;

end-proc;

dcl-proc ecranMod;

  CM_LIB = W_LIB;
  CM_PGM = W_PGM;

  initMod();
  chargeMod();

  dou F3 or F12;
    exfmt CTLMOD;
  enddo;
end-proc;

// option 3 liste exports

dcl-proc initExp;

  SM_CLR =*on;
  SM_DSP = *off;
  CM_DSP = *off;
  write EXPCTL;
  SM_CLR = *off;
  SE_RRN = 0;
end-proc;

dcl-proc chargeexp;

  dcl-ds modules likeds(procExport_t) dim(*auto:300);
  dcl-ds module likeds(procExport_t);

  modules = getprocexp(W_LIB:W_PGM);
  CE_NB = modules(1).lendta;
  if CE_NB<> 0;
    for-each module in %subarr(modules:1:CE_NB);
      SENOM = module.nom;
      SE_RRN+=1;
      write EXPSFL;
    endfor;
  endif;
  if SE_RRN>0;
    SM_DSP = *on;
  else;
    SM_DSP = *off;
  endif;
  CM_DSP = *on;
  SM_END = *on;
  write modpied;

end-proc;

dcl-proc ecranexp;

  initExp();
  chargeexp();

  dou F3 or F12;
    exfmt EXPCTL;
  enddo;
end-proc;


// option 1 liste pgm users

dcl-proc initUse;

  SM_CLR =*on;
  SM_DSP = *off;
  CM_DSP = *off;
  write USECTL;
  SM_CLR = *off;
  Su_RRN = 0;
end-proc;

dcl-proc chargeUse;

  dcl-ds modules likeds(linkedPgm_t) dim(*auto:300);
  dcl-ds module likeds(linkedPgm_t);

  modules = getlinkedpgm(W_LIB:W_PGM);
  CU_NB = modules(1).lendta;
  if CU_NB<> 0;
    for-each module in %subarr(modules:1:CU_NB);
      SU_LIB = module.lib;
      SU_PGM = module.nom;
      SU_TYPE = module.type;
      SU_SIG = module.signature;
      SU_RRN+=1;
      write USESFL;
    endfor;
  endif;
  if SU_RRN>0;
    SM_DSP = *on;
  else;
    SM_DSP = *off;
  endif;
  CM_DSP = *on;
  SM_END = *on;
  write modpied;

end-proc;

dcl-proc ecranuse;

  initUse();
  chargeUse();

  dou F3 or F12;
    exfmt USECTL;
  enddo;
end-proc;
```
