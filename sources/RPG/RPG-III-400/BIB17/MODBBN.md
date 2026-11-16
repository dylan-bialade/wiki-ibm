---
bibliotheque: BIB17
fichier_source: QRPGSRC
membre: MODBBN
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 106
modifie: 2026-11-16
---

# BIB17/QRPGSRC/MODBBN

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FBBNLF2  UF  E           K        DISK                      A
     FBBNDSP  CF  E                    WORKSTN
      *
     E                    STRIN   1   3 15
      *
     IFBONBON
     I              COULEUR                         COLOR
     ISFL1
     I              COULEUR                         COLOR
     IMODBBN
     I              COULEUR                         COLOR
      *
     C           *ENTRY    PLIST
     C                     PARM           NUMBER
      *
     C                     SETOF                     5049
     C                     Z-ADD0         TEMPID  60
      *
     C*  ---- PREPARATION SELON LE MODE ----
     C           NUMBER    IFEQ *ZERO
     C*  creation : nouvel ID d'abord, PUIS zones a blancc
     C                     MOVE 'C'       MODE    1
     C                     MOVELSTRIN,3   MODMOD
     C                     EXSR INCRID
     C                     MOVE *BLANK    NOM
     C                     MOVE *BLANK    MARQUE
     C                     MOVE *BLANK    COLOR
     C                     Z-ADD0         PRIX
     C                     SETOF                     90
     C                     ELSE
     C*  modification : lecture avec verrou
     C                     MOVE 'M'       MODE
     C                     MOVELSTRIN,1   MODMOD
     C           NUMBER    CHAINFBONBON              90
     C                     ENDIF
      *
     C*  ---- BOUCLE COMMUNE ----
     C           *IN90     DOWEQ'0'
     C           *IN03     ANDEQ'0'
     C           *IN12     ANDEQ'0'
     C                     EXFMTMODBBN
      *
     C                     SELEC
     C           *IN03     WHEQ '1'
     C           *IN12     OREQ '1'
     C           *IN20     OREQ '1'
     C                     OTHER
     C                     SETOF                     49
     C                     EXSR VALNOM
     C                     EXSR VALMAR
     C                     EXSR VALCOU
     C                     EXSR VALPRI
     C           MODE      IFEQ 'C'
     C  N49                WRITEFBONBON
     C                     ELSE
     C  N49                UPDATFBONBON
     C                     ENDIF
     C  N49                LEAVE
     C                     ENDSL
     C                     ENDDO
      *
     C                     SETON                     LR
      *
      *CONTROLE VALIDITE NOM
     C           VALNOM    BEGSR
     C                     SETOF                     40
     C           NOM       IFEQ *BLANK
     C                     SETON                     4049
     C                     ENDIF
     C                     ENDSR
      * CONTROLE VALIDITE MARQUE
     C           VALMAR    BEGSR
     C                     SETOF                     41
     C           MARQUE    IFEQ *BLANK
     C                     SETON                     4149
     C                     ENDIF
     C                     ENDSR
      * CONTROLE VALIDITE COULEUR
     C           VALCOU    BEGSR
     C                     SETOF                     42
     C           COLOR     IFEQ *BLANK
     C                     SETON                     4249
     C                     ENDIF
     C                     ENDSR
      * CONTROLE VALIDITE PRIX
     C           VALPRI    BEGSR
     C                     SETOF                     43
     C           PRIX      IFEQ *ZERO
     C                     SETON                     4349
     C                     ENDIF
     C                     ENDSR
      *
      * SOUS ROUTINE INCREMENT ID (lecture sans verrou : N col. 53)
     C           INCRID    BEGSR
     C                     Z-ADD1         TEMPID
     C           *HIVAL    SETLLFBONBON
     C                     READPFBONBON             N    99
     C           *IN99     IFEQ '0'
     C           NUMBER    ADD  1         TEMPID
     C                     ENDIF
     C                     Z-ADDTEMPID    NUMBER
     C                     ENDSR
**
Modification
Affichage
Creation
```
