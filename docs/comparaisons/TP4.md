# TP4 : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB25 | QDDSSRC | DDS | 94 | 100 % | DDS (R/K/PFILE) | [TP4.md](../../sources/DDS/BIB25/TP4.md) |
| BIB25 | QRPGLESRC | RPG/RPG-ILE | 50 | 0 % | ecran (WORKSTN), CHAIN, boucle DOW/DOU/FOR, procedures (dcl-proc), indicateurs *INxx | [TP4.md](../../sources/RPG/RPG-ILE/BIB25/TP4.md) |
| BIB27 | QRPGSRC | RPG/RPG-III-400 | 94 | 100 % | DDS (R/K/PFILE) | [TP4.md](../../sources/RPG/RPG-III-400/BIB27/TP4.md) |

## Differences

- **BIB25** en propre : DDS (R/K/PFILE)
- **BIB25** en propre : ecran (WORKSTN), CHAIN, boucle DOW/DOU/FOR, procedures (dcl-proc), indicateurs *INxx
- **BIB27** en propre : DDS (R/K/PFILE)
- Langages / types differents : DDS, RPG/RPG-III-400, RPG/RPG-ILE

## Codes

### BIB25 (DDS, 94 lignes)

```text
     A*%%TS  SD  20231123  140912  LEO2        REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A          R FMT1
     A*%%TS  SD  20231123  113310  LEO2        REL-V7R4M0  5770-WDS
     A                                      CHANGE(50)
     A                                  1  3SYSNAME
     A                                  2  3USER
     A                                  1 39'tp 4'
     A                                      COLOR(BLU)
     A                                  1 61TIME
     A                                  2 61DATE
     A                                      EDTCDE(Y)
     A                                  9 17'pokedex number :'
     A            POKENUM        9S 0B  9 38
     A  99                                  ERRMSG('pokemon non trouvé')
     A                                 20 35'f3 = quitter'
     A                                      COLOR(BLU)
     A          R FMT2
     A*%%TS  SD  20231122  165337  LEO2        REL-V7R4M0  5770-WDS
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 39'tp 4'
     A                                      COLOR(BLU)
     A                                  1 63TIME
     A                                  2 63DATE
     A                                      EDTCDE(Y)
     A                                  8 17'pokedex number :'
     A                                 10 17'nom pokemon :'
     A                                 12 17'attack :'
     A                                 14 17'defense :'
     A            POKENUM2       3S 0B  8 38
     A            NAME2         15A  B 10 38
     A            ATTACK2        3S 0B 12 38
     A            DEFENSE2       3S 0B 14 38
     A                                 20 35'f3 = quitter'
     A                                      COLOR(BLU)
     A          R FMT3
     A*%%TS  SD  20231123  140912  LEO2        REL-V7R4M0  5770-WDS
     A                                      CF23(23)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 39'tp 4'
     A                                      COLOR(BLU)
     A                                  4 32'ajouter un pokemon'
     A                                      COLOR(BLU)
     A                                  1 65DATE
     A                                      EDTCDE(Y)
     A                                  2 65TIME
     A                                  8  3'pokedex number :'
     A                                 11  3'pokemon ATTACK :'
     A                                 12  3'pokemon DEFENSE  '
     A                                 13  3'special ATTACK :'
     A                                 14  3'special DEFENSE :'
     A                                 15  3'pokemon SPEED :'
     A                                 16  3'pokemon TYPE1'
     A                                 16 17':'
     A                                 17  3'pokemon TYPE2 :'
     A            POKENUM3  R        B  8 24REFFLD(POKEMON/POKED00001 BIB27/P-
     A                                      OKEMON1G)
     A            ATTACK3   R        B 11 24REFFLD(POKEMON/ATTACK BIB27/POKEM-
     A                                      ON1G)
     A            DEFENSE3  R        B 12 24REFFLD(POKEMON/DEFENSE BIB27/POKE-
     A                                      MON1G)
     A            SPECIA3   R        B 13 24REFFLD(POKEMON/SPECI00001 BIB27/P-
     A                                      OKEMON1G)
     A            SPECID3   R        B 14 24REFFLD(POKEMON/SPECI00002 BIB27/P-
     A                                      OKEMON1G)
     A            SPEED3    R        B 15 24REFFLD(POKEMON/SPEED BIB27/POKEMO-
     A                                      N1G)
     A            TYPE13    R        B 16 24REFFLD(POKEMON/TYPE1 BIB27/POKEMO-
     A                                      N1G)
     A            TYPE23    R        B 17 24REFFLD(POKEMON/TYPE2 BIB27/POKEMO-
     A                                      N1G)
     A                                 10  2' pokemon'
     A                                 10 11'HP'
     A                                 10 14':'
     A                                 10 19' '
     A                                 11 20' '
     A                                 13 20' '
     A                                 14 21' '
     A                                 17  1' '
     A                                 17 19' '
     A                                 17 22' '
     A                                 17 75' '
     A                                  6  3'pokemon name :'
     A            NAME3     R        B  6 24REFFLD(POKEMON/NAME BIB27/POKEMON-
     A                                      1G)
     A                                 22 36'f3 = exit '
     A                                      COLOR(BLU)
     A            HP3       R        B 10 24REFFLD(POKEMON/HP BIB27/POKEMON1G)
     A                                 22  9'f23 = ajouter'
     A                                      COLOR(RED)
```

### BIB25 (RPG/RPG-ILE, 50 lignes)

```text
     *******  HEADER *************

     Halwnull(*usrctl)

     *********    DECLARATIVES     **************

     FPOKEMONL1 IF a E           K DISK    prefix(lf_)
     Ftp4       cf   e             workstn

     *********     TRAITEMENT      **************

     C                   SETON                                            LR

     C                   DOW       *in03 = '0'

     c                   clear                   pokenum
     C                   EXFMT     FMT1

     C                   SELECT
     C                   WHEN      *IN50 = '1'
     C     pokenum       CHAIN     POKEMON
     C                   IF        %found
     c                   move      lf_poked00001 pokenum2
     c                   movel     lf_name       name2
     c                   move      lf_attack     attack2
     c                   move      lf_defense    defense2
     c                   EXFMT     FMT2
     c                   else
     c                   exsr      trt_creation
     c                   endif

     c                   ENDSL
     c                   enddo
     c     trt_creation  begsr
     c                   move      pokenum       pokenum3
     c                   exfmt     fmt3
     c                   if        *in23 = '1'
     c                   eval      lf_name = name3
     c                   move      pokenum3      lf_poked00001
     c                   move      hp3           lf_hp
     c                   move      attack3       lf_attack
     c                   move      defense3      lf_defense
     c                   move      specia3       lf_speci00001
     c                   move      specid3       lf_speci00002
     c                   move      speed3        lf_speed
     c                   eval      lf_type1 = type13
     c                   eval      lf_type2 = type23
     c                   write     pokemon
     c                   endif
     c                   endsr
```

### BIB27 (RPG/RPG-III-400, 94 lignes)

```text
     A*%%TS  SD  20231123  140912  LEO2        REL-V7R4M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A                                      CF03(03)
     A          R FMT1
     A*%%TS  SD  20231123  113310  LEO2        REL-V7R4M0  5770-WDS
     A                                      CHANGE(50)
     A                                  1  3SYSNAME
     A                                  2  3USER
     A                                  1 39'tp 4'
     A                                      COLOR(BLU)
     A                                  1 61TIME
     A                                  2 61DATE
     A                                      EDTCDE(Y)
     A                                  9 17'pokedex number :'
     A            POKENUM        9S 0B  9 38
     A  99                                  ERRMSG('pokemon non trouvé')
     A                                 20 35'f3 = quitter'
     A                                      COLOR(BLU)
     A          R FMT2
     A*%%TS  SD  20231122  165337  LEO2        REL-V7R4M0  5770-WDS
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 39'tp 4'
     A                                      COLOR(BLU)
     A                                  1 63TIME
     A                                  2 63DATE
     A                                      EDTCDE(Y)
     A                                  8 17'pokedex number :'
     A                                 10 17'nom pokemon :'
     A                                 12 17'attack :'
     A                                 14 17'defense :'
     A            POKENUM2       3S 0B  8 38
     A            NAME2         15A  B 10 38
     A            ATTACK2        3S 0B 12 38
     A            DEFENSE2       3S 0B 14 38
     A                                 20 35'f3 = quitter'
     A                                      COLOR(BLU)
     A          R FMT3
     A*%%TS  SD  20231123  140912  LEO2        REL-V7R4M0  5770-WDS
     A                                      CF23(23)
     A                                  1  2SYSNAME
     A                                  2  2USER
     A                                  1 39'tp 4'
     A                                      COLOR(BLU)
     A                                  4 32'ajouter un pokemon'
     A                                      COLOR(BLU)
     A                                  1 65DATE
     A                                      EDTCDE(Y)
     A                                  2 65TIME
     A                                  8  3'pokedex number :'
     A                                 11  3'pokemon ATTACK :'
     A                                 12  3'pokemon DEFENSE  '
     A                                 13  3'special ATTACK :'
     A                                 14  3'special DEFENSE :'
     A                                 15  3'pokemon SPEED :'
     A                                 16  3'pokemon TYPE1'
     A                                 16 17':'
     A                                 17  3'pokemon TYPE2 :'
     A            POKENUM3  R        B  8 24REFFLD(POKEMON/POKED00001 BIB27/P-
     A                                      OKEMON1G)
     A            ATTACK3   R        B 11 24REFFLD(POKEMON/ATTACK BIB27/POKEM-
     A                                      ON1G)
     A            DEFENSE3  R        B 12 24REFFLD(POKEMON/DEFENSE BIB27/POKE-
     A                                      MON1G)
     A            SPECIA3   R        B 13 24REFFLD(POKEMON/SPECI00001 BIB27/P-
     A                                      OKEMON1G)
     A            SPECID3   R        B 14 24REFFLD(POKEMON/SPECI00002 BIB27/P-
     A                                      OKEMON1G)
     A            SPEED3    R        B 15 24REFFLD(POKEMON/SPEED BIB27/POKEMO-
     A                                      N1G)
     A            TYPE13    R        B 16 24REFFLD(POKEMON/TYPE1 BIB27/POKEMO-
     A                                      N1G)
     A            TYPE23    R        B 17 24REFFLD(POKEMON/TYPE2 BIB27/POKEMO-
     A                                      N1G)
     A                                 10  2' pokemon'
     A                                 10 11'HP'
     A                                 10 14':'
     A                                 10 19' '
     A                                 11 20' '
     A                                 13 20' '
     A                                 14 21' '
     A                                 17  1' '
     A                                 17 19' '
     A                                 17 22' '
     A                                 17 75' '
     A                                  6  3'pokemon name :'
     A            NAME3     R        B  6 24REFFLD(POKEMON/NAME BIB27/POKEMON-
     A                                      1G)
     A                                 22 36'f3 = exit '
     A                                      COLOR(BLU)
     A            HP3       R        B 10 24REFFLD(POKEMON/HP BIB27/POKEMON1G)
     A                                 22  9'f23 = ajouter'
     A                                      COLOR(RED)
```
