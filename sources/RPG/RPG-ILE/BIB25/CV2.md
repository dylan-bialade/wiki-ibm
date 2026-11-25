---
bibliotheque: BIB25
fichier_source: QFALTER
membre: CV2
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 100
modifie: 2026-11-25
---

# BIB25/QFALTER/CV2

```text
      * Programme: CV2 / BIB25
      * Contrôle de validation : RPGLE
      * 22/11/2024
      *-------------------------------------------------------------------*
      *       Déclaration de Fichiers                                     |
      *-------------------------------------------------------------------*
     FPRODUCTS  UF   E           k DISK    RENAME(PRODUCTS:FPRODUCTS)
     F                                     COMMIT
      *
      *-------------------------------------------------------------------*
      *   Déclaration API : QMHRTVM(retrieve message's from message files)|
      *-------------------------------------------------------------------*
     DQMHRTVM          PR                  EXTPGM('QMHRTVM')
     D  pMsgInfo                  32767A   options(*VARSIZE)
     D  pMsgInfoLen                  10I 0 CONST
     D  pReturnFmt                    8A   CONST
     D  pMsgId                        7A   CONST
     D  pMsgFile                     20A   CONST
     D  pMsgData                  32767A   CONST  options(*VARSIZE)
     D  pMsgDataLen                  10I 0 CONST
     D  pReplSubst                   10A   CONST
     D  pRtnCtrl                     10A   CONST
     D  pApiErrorDS               32767A   options(*NOPASS:*VARSIZE)
     D  pRtvOption                   10A   options(*NOPASS)
     D  pCCSID                       10I 0 CONST options(*NOPASS)
     D  pReplCCSID                   10I 0 CONST options(*NOPASS)
      *-------------------------------------------------------------------*
      *       Déclaration de Variables                                    |
      *-------------------------------------------------------------------*
     DDatePart         S             10A
     DTimePart         S              8A
     DMicroseconds     S              6A
     DCurrentTimeC     S             26A
     DCurrentTimeS     S               Z
     DErros            S              1A   INZ('N')
     DErrorCode        S              7A   INZ('*NONE')
     DMsgDSPLY         S             50A
      *
      * Variables pour l'API système QMHRTVM
     D MsgInfo         S           1024A   INZ
     D MsgFile         S             20A   INZ('QCPFMSG   *LIBL')
     D MsgFormat       S              8A   INZ('RTVM0400')
     D MsgID           S              7A   INZ
     D MsgData         S             80A   INZ
     D MsgDataLen      S             10I 0 INZ(80)
     D MsgText         S           1024A   INZ
     D RcvLen          S             10I 0 INZ(%SIZE(MsgInfo))
      *
      * Structure de données pour les erreurs API
     D ApiErrorDS      DS
     D  BytesProv                    10I 0 INZ(%SIZE(ApiErrorDS))
     D  BytesAvail                   10I 0
     D  ExceptionID                   7A
     D  Reserved                      1A
     D  ExceptionData               128A
      *
      *-------------------------------------------------------------------*
      *       Calcul du TIMESTAMP                                         |
      *-------------------------------------------------------------------*
     C                   EVAL      DatePart = %char(%date())
     C                   EVAL      TimePart = %char(%time())
     C                   EVAL      Microseconds = '000000'
     C                   EVAL      CurrentTimeC = DatePart + '-'
     C                                          + TimePart + '.'
     C                                          + Microseconds
     C                   EVAL      CurrentTimeS = %timestamp(CurrentTimeC)
     C
      *-------------------------------------------------------------------*
      *       Corps du programme                                          |
      *-------------------------------------------------------------------*
     C                   READ      FPRODUCTS
     C*
     C                   DOW       not %eof
     C                   IF        PRODU00001  = 'Laptop'
     C                   EVAL      PRICE = 900
     C                   EVAL      UPDATED_AT = CurrentTimeS
     C                   MONITOR
     C                   UPDATE    FPRODUCTS
     C                   ON-ERROR
     C                   EVAL      Erros = 'Y'
     C                   EVAL      ErrorCode = %CHAR(%status(PRODUCTS))
     C                   EVAL      MsgID = 'CPF' + ErrorCode
     C                   CALLP     QMHRTVM( MsgInfo : RcvLen :MsgFormat :
     C                             MsgID : MsgFile : MsgData : MsgDataLen :
     C                                  '*YES' : '*MSG' : ApiErrorDS)
     C                   EVAL      MsgText = %TRIM(MsgInfo)
     C                   EVAL      MsgDSPLY = %SUBST(MsgText:1:50)
     C     MsgDSPLY      DSPLY
     C                   LEAVE
     C                   ENDMON
     C                   ENDIF
     C                   READ      FPRODUCTS
     C                   ENDDO
     C*                  SND-MSG   *ESCAPE 'SOME KIND OF ERROR'
     C                   IF        Erros = 'N'
     C     'validation'  COMMIT
     C                   ELSE
     C                   ROLBK
     C                   ENDIF
     C                   EVAL      *inlr  = *on
```
