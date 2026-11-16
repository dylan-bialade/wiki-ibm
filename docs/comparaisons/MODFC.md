# MODFC : 3 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB02 | QRPGLESRC | RPG/RPG-ILE | 24 | 0 % | full free, procedures (dcl-proc), prototypes (dcl-pr) | [MODFC.md](../../sources/RPG/RPG-ILE/BIB02/MODFC.md) |
| BIB02 | QSRVSRC | Autres/Service-programs | 9 | 100 % |  | [MODFC.md](../../sources/Autres/Service-programs/BIB02/MODFC.md) |
| BIB05 | QRPGLESRC2 | RPG/RPG-ILE | 12 | 0 % | full free, procedures (dcl-proc), prototypes (dcl-pr) | [MODFC.md](../../sources/RPG/RPG-ILE/BIB05/MODFC.md) |

## Differences

- **BIB02** en propre : full free, procedures (dcl-proc), prototypes (dcl-pr)
- **BIB05** en propre : full free, procedures (dcl-proc), prototypes (dcl-pr)
- Langages / types differents : Autres/Service-programs, RPG/RPG-ILE

## Codes

### BIB02 (RPG/RPG-ILE, 24 lignes)

```text
**free
ctl-opt nomain ;

// Renvoi le modulo
dcl-proc modulo export;
  dcl-pi *n int(3);
    num1 int(3);
    num2 int(3);
  end-pi;

  return %rem(num1:num2) ;
end-proc;

// Renvoie le prix TTC
dcl-proc calculTVA export;
  dcl-pi *n int(10);
    ht int(10);
    taxe int(3);
  end-pi;
  Dcl-s ttc int(10);

  ttc = ht * ((taxe/100)+1);
  return ttc;
end-proc;
```

### BIB02 (Autres/Service-programs, 9 lignes)

```text
             STRPGMEXP  SIGNATURE('MA_SIGNATURE')
/********************************************************************/
/*   *SRVPGM      MODFC        BIB02       19/10/23  18:08:51      */
/********************************************************************/
  EXPORT SYMBOL("CALCULTVA")
  EXPORT SYMBOL("MODULO")
/* */
/* EXPORT SYMBOL("ici new")   */
ENDPGMEXP
```

### BIB05 (RPG/RPG-ILE, 12 lignes)

```text
**free
ctl-opt nomain ;

// Renvoi le modulo
dcl-proc modulo export;
  dcl-pi *n zoned(5:0);
    num1 zoned(5:0);
    num2 zoned(5:0);
  end-pi;

  return %rem(num1:num2) ;
end-proc;
```
