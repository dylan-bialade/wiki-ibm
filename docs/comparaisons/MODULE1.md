# MODULE1 : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB02 | QMOD | RPG/RPG-ILE | 32 | 100 % | procedures (dcl-proc), prototypes (dcl-pr) | [MODULE1.md](../../sources/RPG/RPG-ILE/BIB02/MODULE1.md) |
| BIB20 | QILESRC | RPG/RPG-ILE | 53 | 7 % | full free, SQL embarque, procedures (dcl-proc), prototypes (dcl-pr) | [MODULE1.md](../../sources/RPG/RPG-ILE/BIB20/MODULE1.md) |

## Differences

- Techniques communes : procedures (dcl-proc), prototypes (dcl-pr)
- **BIB20** en propre : full free, SQL embarque

## Codes

### BIB02 (RPG/RPG-ILE, 32 lignes)

```text
       CTL-OPT nomain;
       DCL-PR SubProcedure1 packed(4:0);
         *n packed(4:0) value;
         *n packed(4:0) value;
       END-PR;

       DCL-PR SubProcedure2 packed(4:0);
         *n packed(4:0) value;
         *n packed(4:0) value;
          *n packed(4:0) value;
       END-PR;

       DCL-PROC SubProcedure1 export;
         DCL-PI SubProcedure1 packed(4:0);
          num1 packed(4:0) value;
          num2 packed(4:0) value;
         END-PI;

       DCL-S Modulo packed(4:0);

       Modulo = %rem(num1:num2);
       return Modulo;

       END-PROC;

        DCL-PROC SubProcedure2 export;
          DCL-PI SubProcedure2 packed(4:0);
            num1 packed(4:0) value;
            num2 packed(4:0) value;
          END-PI;

        END-PROC;
```

### BIB20 (RPG/RPG-ILE, 53 lignes)

```text
**free

                                ctl-opt nomain;

                                                                dcl-proc checkMail EXPORT; // PROC qui sert a vé
rifier le mail via un regex sql                                                     dcl-pi *n ind; // *ON ou *OF
F                                                                                                       mail cha
r(100) const; // Mail entrant
    end-pi;

                                    dcl-s reponse ind; // Contient le booléan

                                                                    exec sql SELECT
                                                                                                CASE WHEN :mail
like '%@%.%'
THEN true
                ELSE false END as mail
                            into :reponse
                                            from sysibm.sysdummy1;

                                                                    return reponse;

                                                                                                end-proc;


                dcl-proc checkSecu EXPORT; // Vérifie le numéro de sécu
                                    dcl-pi *n ind; // *ON ou *OFF
                                                        secu char(100) const;
                                                                    end-pi;

                                                                                                    dcl-s repons
e ind;

                    if %len(%trim(secu)) = 13;
                                        reponse = *on;
                                                    else;
                                                                        reponse = *off;
                                                                                    endif;


    return reponse;

                                end-proc;

                                                                dcl-proc calculTVA EXPORT; // calcul la tva lors
que on envoi un nombre (10%)                                                        dcl-pi *n zoned(5:0); // la
tva calculé                                                                                             nb zoned
(5:0) const;
    end-pi;

                                    return nb * 0.10;

                                                                end-proc;
```
