---
bibliotheque: BIB01
fichier_source: QRPGSRC
membre: BONBONSF1
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 19
modifie: 2026-11-16
---

# BIB01/QRPGSRC/BONBONSF1

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     FBONBON  IF  E                    DISK
     FSLISTE  CF  E                    WORKSTN
     F                                        LIGNE KSFILE SFL01
     *--------------------------------------------------------------*
     IFBONBON
     I              COULEUR                         COLOR
     ISFL01
     I              COULEUR                         COLOR
     *--------------------------------------------------------------*
     C                     Z-ADD*ZERO     LIGNE   40
     C                     READ BONBON                   90
     C           *IN90     DOWNE'1'                        <---+
     C                     ADD  1         LIGNE                |
     C                     WRITESFL01                          |
     C                     READ BONBON                   90    |
     C                     ENDDO                           <---+
     C                     SETON                         4142
     C                     EXFMTCTL01
     C                     SETON                         LR
```
