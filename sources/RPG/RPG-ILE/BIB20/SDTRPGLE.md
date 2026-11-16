---
bibliotheque: BIB20
fichier_source: QRPGLESRC
membre: SDTRPGLE
type: RPG/RPG-ILE
longueur_enregistrement: 120
lignes: 112
modifie: 2026-11-16
---

# BIB20/QRPGLESRC/SDTRPGLE

```text
     FSOLDAT    uf a e           k disk
     fECRTPSDT  cf   e             workstn
     c                   DOW       *IN03 = '0'
     c                   exfmt     saisie

     C                   IF        *IN06 = '0'
     C                   DOW       *IN03 = '0' AND
     C                             *IN12 = '0'
     C                   exfmt     creation
     C                   setoff                                       8990

     C                   if        ECNMSD = ' ' OR
     C                             ECPRSD = ' ' OR
     C                             ECARS1 = ' ' OR
     C                             ECARS2 = ' ' OR
     C                             ECCLAS = ' '
     C                   SETON                                        90
     C                   EVAL      MSGERC = 'Un des champs est vide.'
     C                   else
     c     *HIVAL        SETLL     SOLDAT
     C                   READP     SOLDAT
     C                   IF        %FOUND()
     c                   EVAL      IDSDT = IDSDT + 1
     c                   else
     C                   EVAL      IDSDT = 1
     C                   ENDIF
     c
     C                   EVAL      NMSDT = ECNMSD
     C                   EVAL      ARSDT1 = ECARS1
     C                   EVAL      ARSDT2 = ECARS2
     C                   EVAL      CLASID = ECCLAS
     C                   EVAL      PRSDT = ECPRSD
     c                   SETON                                        89
     c                   EVAL      MSGERC = 'Le soldat a bien été crée.'
     C                   ENDIF
     c
     C                   ENDDO
     C
     C                   ELSE
     C     ESID          CHAIN     SOLDAT
     C                   IF        %FOUND()
     C                   EVAL      EAIDSD = IDSDT
     C                   EVAL      EAnmsd = nmSDT
     C                   EVAL      EAprSD = prSDT
     C                   EVAL      EAarS1 = arsdt1
     C                   EVAL      EAarS2 = arsdt2
     C                   EVAL      EAclas = clasid
     C                   EVAL      Emnmsd = nmSDT
     C                   EVAL      EmprSD = prSDT
     C                   EVAL      EmarS1 = arsdt1
     C                   EVAL      EmarS2 = arsdt2
     C                   EVAL      Emclas = clasid
     C                   DOW       *IN03 = '0'
     C
     C                   EXFMT     AFFICHE
     C                   IF        *IN12 = '1'
     C                   LEAVE
     C                   ENDIF
     C
     C                   EVAL      MSGERA = ' '
     C                   if        *IN02 = '1'
     C                   DOW       *IN03 = '0' AND
     C                             *IN12 = '0'
     C                   EXFMT     MODIF
     C                   if        EMNMSD = ' ' OR
     C                             EMPRSD = ' ' OR
     C                             EMARS1 = ' ' OR
     C                             EMARS2 = ' ' OR
     C                             EMCLAS = ' '
     C                   EVAL      MSGERM = 'Des champs sont vides.'
     C                   SETON                                        90
     C                   else
     c
     C                   EVAL      NMSDT = EMNMSD
     C                   EVAL      ARSDT1 = EMARS1
     C                   EVAL      ARSDT2 = EMARS2
     C                   EVAL      CLASID = EMCLAS
     C                   EVAL      PRSDT = EMPRSD
     C                   EVAL      MSGERA = 'Le soldat a bien été modifié.'
     C                   SETON                                        89
     C                   LEAVE
     C                   ENDIF
     C                   SETOFF                                       12
     C                   ENDDO
     C
     C                   if        *IN07 = '1'
     C                   DELETE    SOLDAT
     C                   EVAL      msgers = 'Le soldat a bien été supprimé'
     C                   SETON                                        89
     C                   LEAVE
     C                   ENDIF
     C
     C                   ENDDO
     C
     C                   ELSE
     C                   SETON                                        90
     C                   EVAL      MSGERS = 'Le soldat n a pas été trouvé'
     C                   endif
     C
     C                   endif
     C
     C
     C
     C
     C
     C
     C
     C
     C
     C                   endif
     C                   enddo
     C                   seton                                        lr
```
