---
bibliotheque: BIB02
fichier_source: QRPGLESRC
membre: BOUCLE1
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 14
modifie: 2026-11-16
---

# BIB02/QRPGLESRC/BOUCLE1

```text
     HOPTION(*SRCSTMT *NODEBUGIO)
     FPRODUITP IF  F     160  2AI     1 DISK
     C                     Z-ADD1         L       10
     C           CLE7      CHAINCLI01L               91
     C      91             EXSR ERREUR
     C      91             GOTO FINTR1
     C                     READ PRODUITP
     C                     TAG01     TAG
     C                     IF        %EOF(PRODUITPF)
     C                     GOTO      FIN
     C                     ENDIF
     C                     READ      PRODUITPF
     C                     GOTO      TAG01
     C                     FIN       TAG
```
