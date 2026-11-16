---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: TP1RPG2
type: DDS
longueur_enregistrement: 100
lignes: 12
modifie: 2026-11-16
---

# BIB02/QDDSRC/TP1RPG2

```text
     Dlong             S             15  5 Inz(70)
     Dmessage          S             70    dim(2) ctdata
     D
     C                   CALL      'QCMDEXC'
     C                   PARM                    message(1)
     C                   PARM                    long

     C                   return

**ctdata message
sndbrkmsg msg('Hello') tomsgq(*allws)
sndbrkmsg msg('World') tomsgq(*allws)
```
