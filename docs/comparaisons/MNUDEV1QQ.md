# MNUDEV1QQ : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB06 | QMNUSRC | Menus | 8 | 100 % |  | [MNUDEV1QQ.md](../../sources/Menus/BIB06/MNUDEV1QQ.md) |
| BIB10 | QMNUSRC | Menus | 8 | 78 % |  | [MNUDEV1QQ.md](../../sources/Menus/BIB10/MNUDEV1QQ.md) |

## Differences

## Codes

### BIB06 (Menus, 8 lignes)

```text
MNUDEV1QQ,1                                                                     0001 STRPDM
                                                            0002 STRSDA
                                        0003 ?SNDMSG
                    0004 WRKMSG
0006 WRKACTJOB                                                                  0008 WRKSPLF
                                                            0009 DLTSPLF FILE(*SELECT)
                                        0011 ?WRKMBRPDM
                    0090 SIGNOFF
```

### BIB10 (Menus, 8 lignes)

```text
MNUDEV1QQ,1                                                                     0001 STRPDM
                                                            0002 STRSDA
                                        0003 ?SNDMSG
                    0004 WRKMSG
0006 WRKUSRJOB                                                                  0008 WRKSPLF
                                                            0009 DLTSPLF FILE(*SELECT)
                                        0011 ?WRKMBRPDM
                    0090 SIGNOFF
```
