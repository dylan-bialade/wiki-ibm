---
bibliotheque: BIB20
fichier_source: QILESRC
membre: MODULE1
type: RPG/RPG-ILE
longueur_enregistrement: 112
lignes: 53
modifie: 2026-11-16
---

# BIB20/QILESRC/MODULE1

```rpg
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
