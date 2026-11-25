---
bibliotheque: BIB27
fichier_source: QCBLLESRC
membre: EVALUATE01
type: COBOL
longueur_enregistrement: 100
lignes: 25
modifie: 2026-11-25
---

# BIB27/QCBLLESRC/EVALUATE01

```text
      *****************************************************************
      * call borg/evaluate01 parm('58' 'M')
      *****************************************************************
        IDENTIFICATION DIVISION.
        PROGRAM-ID. EVALUATE01.
        ENVIRONMENT DIVISION.
        DATA DIVISION.
        LINKAGE SECTION.
        01 AGE                       PIC X(3).
        01 GENDER                    PIC X(1).
        PROCEDURE DIVISION USING AGE GENDER.
            EVALUATE TRUE ALSO TRUE
               WHEN AGE > '60' ALSO GENDER = 'M'
                    DISPLAY 'THE MAN IS RETIRED   '
               WHEN AGE > '60' ALSO GENDER = 'F'
                    DISPLAY 'THE WOMAN IS RETIRED  '
               WHEN AGE <= '60' ALSO GENDER = 'M'
                    DISPLAY 'THE MAN IS NOT RETIRED'
               WHEN AGE <= '60' ALSO GENDER = 'F'
                    DISPLAY 'THE WOMAN IS NOT RETIRED'
               WHEN OTHER
                    DISPLAY 'INVALID INPUT      '
                   DISPLAY 'AGE =' AGE ' and GENDER =' GENDER
               END-EVALUATE.
               STOP RUN.
```
