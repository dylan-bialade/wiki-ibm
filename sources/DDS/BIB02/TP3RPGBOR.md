---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: TP3RPGBOR
type: DDS
longueur_enregistrement: 100
lignes: 20
modifie: 2026-11-16
---

# BIB02/QDDSRC/TP3RPGBOR

```text
     D********  Declarations variables *****
     D CPT             S              2S 0

     D ZONE100         DS           100    DTAARA
     D  ZONE                         10    DIM(10)

     C********  Action !********************
     C                   SETON                                        LR
      * On lit la dtaara
     C                   IN        ZONE100
     C* Ici, %elem va être égal au contenu du DIM, donc 10 !
     C                   FOR       CPT = 1 to %elem(ZONE)
     C* Si j'ai le mot FIN, je sort !!
     C                   IF        ZONE(CPT) = 'FIN'
     C                   LEAVE
     C                   ELSE
     C     ZONE(CPT)     DSPLY
     C                   ENDIF

     C                   ENDFOR
```
