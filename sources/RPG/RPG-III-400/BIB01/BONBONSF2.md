---
bibliotheque: BIB01
fichier_source: QRPGSRC
membre: BONBONSF2
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 54
modifie: 2026-11-16
---

# BIB01/QRPGSRC/BONBONSF2

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FBONBONL1IF  E           K        DISK
     FSFLBB   CF  E                    WORKSTN
     F                                        LIGNE KSFILE SFL01
      *----------------------------------------*
     IFBONBON
     I              COULEUR                         COLOR
     ISFL01
     I              COULEUR                         COLOR
      *---------PROGRAMME----------------------*
     C                     EXSR CHARGE
     C           1         DOWEQ1
     C                     WRITEPIED
     C                     EXFMTCTL01
     C   KC                LEAVE
     C   KE                EXSR CHARGE
     C                     EXSR RELECT
     C                     ENDDO
     C                     SETON                     LR
      *---------SOUS ROUTINE A FAIRE-----------*
     C           MODIF     BEGSR
     C*                    CALL 'BONBMODI'
     C*                    PARM           NUMBER
     C                     ENDSR
     C           SUPPR     BEGSR
     C*                    CALL 'BONBSUPP'
     C*                    PARM           NUMBER
     C                     ENDSR
      *---------SOCS ROUTINE DE RELECTURE------*
     C           RELECT    BEGSR
     C                     READCSFL01                    80
     C           *IN80     DOWEQ'0'
     C           OPT       CASEQ'2'       MODIF
     C           OPT       CASEQ'4'       SUPPR
     C                     ENDCS
     C                     MOVEL*BLANKS   OPT
     C                     UPDATSFL01
     C                     READCSFL01                    80
     C                     ENDDO
     C                     ENDSR
      *---------SOUS ROUTINE DE CHARGEMENT ----*
     C           CHARGE    BEGSR
     C                     SETON                     40
     C                     WRITECTL01
     C                     SETOF                     40
     C                     Z-ADD*ZERO     LIGNE   40
     C           *LOVAL    SETLLBONBONL1
     C                     READ BONBONL1                 90
     C           *IN90     DOWNE'1'                        <---*
     C                     ADD  1         LIGNE                |
     C                     WRITESFL01                          |
     C                     READ BONBONL1                 90    |
     C                     ENDDO                           <---*
     C                     SETON                     434142
     C                     ENDSR
```
