---
bibliotheque: BIB02
fichier_source: QVINCI
membre: GBA
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 336
modifie: 2026-11-16
---

# BIB02/QVINCI/GBA

```text
     H*-------------------------------------------------------------------------*
     H* Balance auxiliaire groupe. - Extraction.                                I
     H*-------------------------------------------------------------------------*
     F*
     FFAN870P1  IF   E           K DISK    Prefix(LST_)
     FFAN010P1  IF   E           K DISK    Prefix(STE_)
     FGSTTIAL0  IF   E           K DISK    Prefix(GST_)
     FCTALC3    IF   E           K DISK
     FWGBALAAP  O    E             DISK
     FXGBALAAP  O    E             DISK    Rename(FAN200F1:FAN200O)
     D*
     D*
     D* DS de contrôle du fichier correspondance comptes généraux.
     D GCORRA        E DS                  EXTNAME(GCORRAP)
     D                                     PREFIX(CRA_)
     D*
     D* DS de contrôle du fichier correspondance auxiliaire groupe.
     D GCORRB        E DS                  EXTNAME(GCORRBP)
     D                                     PREFIX(CRB_)
     D*
     D* Définition de zones.
     D DSWRKS        E DS                  EXTNAME(DSWRKSTN)
     C*
     C*
     C*-------------------------------------------------------------------------*
     C* Clef du fichier "FAN870P1".                                             I
     C*-------------------------------------------------------------------------I
     C     $AN870        Klist                                                  I
     C                   Kfld                    LST_RSTE                       I
     C                   Kfld                    LST_RLIST                      I
     C                   Kfld                    LST_RSTEL                      I
     C*                                                                         I
     C     àAN870        Klist                                                  I
     C                   Kfld                    LST_RSTE                       I
     C                   Kfld                    LST_RLIST                      I
     C*-------------------------------------------------------------------------*
     C*
     C*
     C*-------------------------------------------------------------------------*
     C* Clef du fichier "FAN010P1".                                             I
     C*-------------------------------------------------------------------------I
     C     $AN010        Klist                                                  I
     C                   Kfld                    STE_RSTE                       I
     C*-------------------------------------------------------------------------*
     C*
     C*
     C*-------------------------------------------------------------------------*
     C* Clef du fichier "GSTTIAL0".                                             I
     C*-------------------------------------------------------------------------I
     C     £STTIA        Klist                                                  I
     C                   Kfld                    GST_RSTE                       I
     C*-------------------------------------------------------------------------*
     C*
     C*
     C*-------------------------------------------------------------------------*
     C* Clef du fichier "CTALC3  ".                                             I
     C*-------------------------------------------------------------------------I
     C     $TALC3        Klist                                                  I
     C                   Kfld                    RSTE                           I
     C                   Kfld                    DSEQ                           I
     C*-------------------------------------------------------------------------*
     C*
     C*
     C*-------------------------------------------------------------------------*
     C* Définition de zones.                                                    I
     C*-------------------------------------------------------------------------I
     C     *Like         Define    TZOA01        PSELEC                         I
     C     *Like         Define    LST_RLIST     PLISTE                         I
     C     *Like         Define    RSTE          PSTED                          I
     C     *Like         Define    RSTE          PSTEF                          I
     C     *Like         Define    REX           PAAPER                         I
     C     *Like         Define    RPERIO        PMMPER                         I
     C     *Like         Define    TZOA01        SACCES                         I
     C     *Like         Define    TZOA01        SMAJ                           I
     C     *Like         Define    CRA_FRUBRD    TRUBR                          I
     C     *Like         Define    DMONT         TMONT                          I
     C     *Like         Define    TZOA01        TEXCLU                         I
     C*-------------------------------------------------------------------------*
     C*
     C*
     C*-------------------------------------------------------------------------*
     C* Reception des paramètres.                                               I
     C*-------------------------------------------------------------------------I
     C     *Entry        Plist                                                  I
     C                   Parm                    PSELEC                         I
     C                   Parm                    PLISTE                         I
     C                   Parm                    PSTED                          I
     C                   Parm                    PSTEF                          I
     C                   Parm                    PAAPER                         I
     C                   Parm                    PMMPER                         I
     C*-------------------------------------------------------------------------*
     C*
     C*
     C*-------------------------------------------------------------------------*
     C* Traitement.                                                             I
     C*-------------------------------------------------------------------------I
     C* Recherche des paramètres auxiliaire groupe & compte équilibre.          I
     C                   Clear                   GCORRB                         I
     C                   Clear                   £MSGID                         I
     C                   Clear                   £MSGFI                         I
     C*                                                                         I
     C                   Call      '£CORRB'                                     I
     C                   Parm                    GCORRB                         I
     C                   Parm                    £MSGID                         I
     C                   Parm                    £MSGFI                         I
     C*                                                                         I
     C* Sélection de sociétés.                                                  I
     C                   Eval      STE_RSTE   = PSTED                           I
     C     $AN010        Setll     FAN010P1                                     I
     C                   Do        *Hival                                       I<--------*
     C                   Read      FAN010P1                                     I         I
     C                   If        %Eof                                         I<------* I
     C                   Leave                                                  I       I I
     C                   End                                                    I<------* I
     C*                                                                         I         I
     C                   If        STE_RSTE   > PSTEF  and PSTEF  <> 0          I<------* I
     C                   Leave                                                  I       I I
     C                   End                                                    I<------* I
     C*                                                                         I         I
     C                   If        STE_RSTE  <> PSTED  and PSTEF  =  0          I<------* I
     C                   Leave                                                  I       I I
     C                   End                                                    I<------* I
     C*                                                                         I         I
     C                   Exsr      £SRSTE                                       I         I
     C*                                                                         I         I
     C                   End                                                    I<--------*
     C*-------------------------------------------------------------------------*
     C*
     C*
     C                   Eval      *InLR = *On
     C*
     C*
     C*-------------------------------------------------------------------------*
     C* Traitement société.                                                     I
     C*-------------------------------------------------------------------------I
     C     £SRSTE        Begsr                                                  I
     C*                                                                         I
     C* Société exclue du périmètre ICS.                                        I
     C                   Eval      GST_RSTE   = STE_RSTE                        I
     C     £STTIA        Chain     GSTTIAL0                                     I
     C                   If        %Found                                       I<--------*
     C                   Leavesr                                                I         I
     C                   End                                                    I<--------*
     C*                                                                         I
     C* Initialisation.                                                         I
     C                   Clear                   MTIERS                         I
     C                   Clear                   MNOCG                          I
     C                   Clear                   TMONT                          I
     C*                                                                         I
     C* Lecture des mouvements.                                                 I
     C                   Eval      RSTE   = STE_RSTE                            I
     C                   Eval      DSEQ   = CRB_DSEQ                            I
     C     $TALC3        Setll     CTALC3                                       I
     C                   Do        *Hival                                       I<--------*
     C     $TALC3        Reade     CTALC3                                       I         I
     C                   If        %Eof                                         I<------* I
     C                   Exsr      £SROUT                                       I       I I
     C                   Leave                                                  I       I I
     C                   End                                                    I<------* I
     C*                                                                         I         I
     C                   If        RAUX   <> MTIERS or  RGEN   <> MNOCG         I<------* I
     C                   Exsr      £SROUT                                       I       I I
     C                   End                                                    I<------* I
     C*                                                                         I         I
     C                   If        TEXCLU =  *All'1'                            I<------* I
     C                   Iter                                                   I       I I
     C                   End                                                    I<------* I
     C*                                                                         I         I
     C                   If        DSEQ   <> 'GROUPE'                           I<------* I
     C                   Iter                                                   I       I I
     C                   End                                                    I<------* I
     C*                                                                         I         I
     C                   If        RCE    <> *All'6'                            I<------* I
     C                   Iter                                                   I       I I
     C                   End                                                    I<------* I
     C*                                                                         I         I
     C                   If        RGEN   >= 600000                             I<------* I
     C                   If        REX    <  PAAPER                             I<------* I
     C                   Iter                                                   I       I I
     C                   End                                                    I<------* I
     C                   End                                                    I<------* I
     C*                                                                         I         I
     C                   If        RGEN   <  600000                             I<------* I
     C                   If        REX    <  20160                              I<------* I
     C                   Iter                                                   I       I I
     C                   End                                                    I<------* I
     C                   End                                                    I<------* I
     C*                                                                         I         I
     C                   If        REX    >  PAAPER    Or                       I<------* I
     C                             REX    =  PAAPER    And                      I<------* I
     C                             RPERIO >  PMMPER                             I<------* I
     C                   Iter                                                   I       I I
     C                   End                                                    I<------* I
     C*                                                                         I         I
     C                   If        DEX    <> 0                                  I<------* I
     C                   If        DEX               <  PAAPER and              I<----* I I
     C                             %Subst(%editc(RGEN:'4') :1:1) = '6'    or    I<----* I I
     C                             DEX               <  PAAPER and              I<----* I I
     C                             %Subst(%editc(RGEN:'4') :1:1) = '7'          I<----* I I
     C                   Iter                                                   I     I I I
     C                   End                                                    I<----* I I
     C                   End                                                    I<------* I
     C*                                                                         I         I
     C                   If        DEX    =  0                                  I<------* I
     C                   If        REX               <  PAAPER and              I<----* I I
     C                             %Subst(%editc(RGEN:'4') :1:1) = '6'    or    I<----* I I
     C                             REX               <  PAAPER and              I<----* I I
     C                             %Subst(%editc(RGEN:'4') :1:1) = '7'          I<----* I I
     C                   Iter                                                   I     I I I
     C                   End                                                    I<----* I I
     C                   End                                                    I<------* I
     C*                                                                         I         I
     C                   If        DCOEF  >  0                                  I<------* I
     C                   Eval      TMONT  = TMONT  + DMONT                      I       I I
     C                   Else                                                   IElse<--X I
     C                   Eval      TMONT  = TMONT  - DMONT                      I       I I
     C                   End                                                    I<------* I
     C*                                                                         I         I
     C                   Write     FAN200O                                      I         I
     C*                                                                         I         I
     C                   End                                                    I<--------*
     C*                                                                         I
     C                   Endsr                                                  I
     C*-------------------------------------------------------------------------*
     C*
     C*
     C*-------------------------------------------------------------------------*
     C* Sortie d'un enregistrement.                                             I
     C*-------------------------------------------------------------------------I
     C     £SROUT        Begsr                                                  I
     C*                                                                         I
     C                   Do                                                     I
     C*                                                                         I
     C                   If        TMONT  = 0                                   I<--------*
     C                   Leave                                                  I         I
     C                   End                                                    I<--------*
     C*                                                                         I
     C* Recherche des informations correspondance C.G.                          I
     C                   Clear                   GCORRA                         I
     C                   Eval      CRA_RSTE   = RSTE                            I
     C                   Eval      CRA_RGEN   = MNOCG                           I
     C                   Eval      CRA_FSENS  = *All'*'                         I
     C*                                                                         I
     C                   Call      '£CORRA'                                     I
     C                   Parm                    GCORRA                         I
     C                   Parm      *Blanks       £MSGID                         I
     C                   Parm      *Blanks       £MSGFI                         I
     C*                                                                         I
     C                   If        £MSGID <> *Blanks                            I<--------*
     C                   Eval      CRA_FRUBRD =  '?' + %editc(MNOCG:'4') + 'A'  I         I
     C                   Eval      CRA_FRUBRC =  '?' + %editc(MNOCG:'4') + 'P'  I         I
     C                   End                                                    I<--------*
     C*                                                                         I
     C* Rubrique/Nature à considérer.                                           I
     C                   If        TMONT  > 0                                   I<--------*
     C                   Eval      TRUBR  = CRA_FRUBRD                          I         I
     C                   Eval      TNATUR = CRA_FNATUD                          I         I
     C                   End                                                    I<--------*
     C*                                                                         I
     C                   If        TMONT  < 0                                   I<--------*
     C                   Eval      TRUBR  = CRA_FRUBRC                          I         I
     C                   Eval      TNATUR = CRA_FNATUC                          I         I
     C                   End                                                    I<--------*
     C*                                                                         I
     C                   Select                                                 I<--------*
     C                   When      %Scan('R':TRUBR) > 0 and TMONT  > 0          I1        I
     C                   Eval      TZN250 = TMONT *  -1                         I         I
     C                   When      %Scan('R':TRUBR) > 0 and TMONT  < 0          I2        I
     C                   Eval      TZN250 = TMONT *  -1                         I         I
     C                   When      %Scan('A':TRUBR) > 0 and TMONT  > 0          I3        I
     C                   Eval      TZN250 = TMONT                               I         I
     C                   When      %Scan('A':TRUBR) > 0 and TMONT  < 0          I4        I
     C                   Eval      TZN250 = TMONT                               I         I
     C                   When      %Scan('P':TRUBR) > 0 and TMONT  > 0          I5        I
     C                   Eval      TZN250 = TMONT  * -1                         I         I
     C                   When      %Scan('P':TRUBR) > 0 and TMONT  < 0          I6        I
     C                   Eval      TZN250 = TMONT  * -1                         I         I
     C                   Endsl                                                  I<--------*
     C*                                                                         I
     C                   Eval      FSTE   =  RSTE                               I
     C                   Eval      FAAPER =  REX                                I
     C                   Eval      FMMPER =  RPERIO                             I
     C                   Write     WGBALAAF                                     I
     C*                                                                         I
     C                   End                                                    I
     C*                                                                         I
     C                   Clear                   TMONT                          I
     C                   Eval      TEXCLU = *All'0'                             I
     C                   Eval      MTIERS = RAUX                                I
     C                   Eval      MNOCG  = RGEN                                I
     C*                                                                         I
     C                   Monitor                                                IMonitor<-*
     C                   Move      MTIERS        GST_RSTE                       I         I
     C                   On-Error                                               IOn-Error<X
     C                   Clear                   GST_RSTE                       I         I
     C                   EndMon                                                 IEndMonito*
     C     £STTIA        Chain     GSTTIAL0                                     I
     C                   If        %Found                                       I<--------*
     C                   Eval      TEXCLU = *All'1'                             I         I
     C                   Leavesr                                                I         I
     C                   End                                                    I<--------*
     C*                                                                         I
     C* Toutes les sociétés groupe.                                             I
     C                   If        PSELEC = *All'2'                             I<--------*
     C*                                                                         I         I
     C                   Eval      LST_RSTE   =  0                              I         I
     C                   Eval      LST_RLIST  =  PLISTE                         I         I
     C                   Eval      LST_RSTEL  =  GST_RSTE                       I         I
     C     $AN870        Setll     FAN870P1                                     I         I
     C     $AN870        Reade     FAN870P1                                     I         I
     C                   If        %Eof                                         I<------* I
     C                   Eval      TEXCLU = *All'1'                             I       I I
     C                   Leavesr                                                I       I I
     C                   End                                                    I<------* I
     C*                                                                         I         I
     C                   End                                                    I<--------*
     C*                                                                         I
     C* Toutes les sociétés sauf groupe.                                        I
     C                   If        PSELEC = *All'3'                             I<--------*
     C*                                                                         I         I
     C                   Eval      LST_RSTE   =  0                              I         I
     C                   Eval      LST_RLIST  =  PLISTE                         I         I
     C                   Eval      LST_RSTEL  =  GST_RSTE                       I         I
     C     $AN870        Setll     FAN870P1                                     I         I
     C     $AN870        Reade     FAN870P1                                     I         I
     C                   If        Not(%Eof)                                    I<------* I
     C                   Eval      TEXCLU = *All'1'                             I       I I
     C                   Leavesr                                                I       I I
     C                   End                                                    I<------* I
     C*                                                                         I         I
     C                   End                                                    I<--------*
     C*                                                                         I
     C                   Endsr                                                  I
     C*-------------------------------------------------------------------------*
     C*
     C*
```
