---
bibliotheque: BIB02
fichier_source: QILE
membre: RACERPROC
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 23
modifie: 2026-11-16
---

# BIB02/QILE/RACERPROC

```text
          CTL-OPT NOMAIN;
          Dcl-proc Looser export;
              Dcl-pi *n ind;
                 EP3RACE packed(4);   // 5                   EdF1 = 5
              END-PI;
              dcl-s pl int(10);
              pl = 10;
              if EP3RACE > 50;
                 return *ON;
              else;
                 return *OFF;
              ENDIF;
          END-PROC;
          Dcl-proc Winner export;
              Dcl-pi *n ind;
                 EP3RACE packed(4);
              END-PI;
            if EP3RACE < 10;
               return *ON;
            else;
               return *OFF;
            ENDIF;
          END-PROC;
```
