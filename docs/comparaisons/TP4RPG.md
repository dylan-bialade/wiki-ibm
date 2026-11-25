# TP4RPG : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB02 | QDDSRC | DDS | 54 | 100 % | ecran (WORKSTN), CHAIN, boucle DOW/DOU/FOR, procedures (dcl-proc), indicateurs *INxx | [TP4RPG.md](../../sources/DDS/BIB02/TP4RPG.md) |
| BIB27 | QRPGSRC | RPG/RPG-III-400 | 50 | 13 % | ecran (WORKSTN), CHAIN, boucle DOW/DOU/FOR, procedures (dcl-proc), indicateurs *INxx | [TP4RPG.md](../../sources/RPG/RPG-III-400/BIB27/TP4RPG.md) |

## Differences

- Techniques communes : ecran (WORKSTN), CHAIN, boucle DOW/DOU/FOR, procedures (dcl-proc), indicateurs *INxx
- Langages / types differents : DDS, RPG/RPG-III-400

## Codes

### BIB02 (DDS, 54 lignes)

```text
     Fsaisagn   CF   E             workstn
     Fagencel1  UF A E           K disk
     C     kagence       klist
     C                   kfld                    CODCLI
     C                   kfld                    CODAGN
     C                   DOW       NOT *IN03
     C                   exfmt     fmt1
     C                   SELECT
     C                   WHEN      *IN03
     C                   EVAL      *inlr=*on
     C                   LEAVE
     C                   WHEN      *IN06
     C                   EVAL      *inlr=*on
     C                   EXSR      F6
     C                   WHEN      *IN12
     C                   EXFMT     fmt1
     C                   EVAL      *inlr=*on
     C                   ENDSL
     C                   move      CODCLIS       CODCLI
     C                   move      CODAGNS       CODAGN
     C     kagence       CHAIN     agencel1
     C                   IF        %Found
     c                   move      codcli        codecli
     c                   move      codagn        codeagn
     c                   move      nom           fmt2nom
     c                   move      rue           fmt2rue
     c                   move      cp            fmt2cp
     c                   move      ville         fmt2ville
     c                   move      region        fmt2region
     C                   EXFMT     fmt2
     C                   IF        *IN50
     c                   move      codcli        codecli
     c                   move      codagn        codeagn
     c                   move      fmt2nom       nom
     c                   move      fmt2rue       rue
     c                   move      fmt2cp        cp
     c                   move      fmt2ville     ville
     c                   move      fmt2region    region
     C                   UPDATE    agencef
     C                   ENDIF
     C                   ENDIF
     C                   ENDDO
     C                   SETON                                            LR
     C     F6            BEGSR
     C                   EXFMT     fmt6
     c                   move      codcli        codecli
     c                   move      codagn        codeagn
     c                   move      fmt2nom       nom
     c                   move      fmt2rue       rue
     c                   move      fmt2cp        cp
     c                   move      fmt2ville     ville
     c                   move      fmt2region    region
     C                   WRITE     agencef
     C                   ENDSR
```

### BIB27 (RPG/RPG-III-400, 50 lignes)

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
