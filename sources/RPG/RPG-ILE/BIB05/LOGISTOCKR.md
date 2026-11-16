---
bibliotheque: BIB05
fichier_source: QRPGLESRC3
membre: LOGISTOCKR
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 273
modifie: 2026-11-16
---

# BIB05/QRPGLESRC3/LOGISTOCKR

```text
      *NOMPGM:
      *NOMPROP:
      *FILLEDEPEND:
     * SI TU VOIS SA TU A COPIER BIB05
     H*---------------------------------------------------------------
     H* LOGISTOCKR : GESTION DES ARTICLES LOGISTOCK
     H*   F6 creer / 2 modifier (F23) / 4 supprimer (F23) / 5 afficher
     H*   filtre sur le code produit, ordre de la base (cle CHAR)
     H*---------------------------------------------------------------
     F*  Ecran : sous-fichier SFL1, numero de ligne dans RRN
     FLOGISTOCKDCF   E             WORKSTN
     F                                     SFILE(SFL1:RRN)
     F*  LF LOGISTOCKL : cle CODPRO, lecture/maj/ajout/suppr
     FLOGISTOCKLUF A E           K DISK
     D*  Variables de travail
     DRRN              S              4S 0
     DEOFFLG           S              1N
     DQUITTER          S              1N
     DRECHRG           S              1N
     DPREVPOS          S                   LIKE(POSCOD)
     DDERNCODE         S                   LIKE(CODPRO)
     DCLE              S                   LIKE(CODPRO)
     DPREMIER          S                   LIKE(RRN)
     DI                S              5I 0
     C*---------------------------------------------------------------
     C* PROGRAMME PRINCIPAL
     C*---------------------------------------------------------------
     C                   EVAL      POSCOD = *BLANKS
     C                   EVAL      PREVPOS = *BLANKS
     C* Premier chargement du sous-fichier
     C                   EXSR      DEBSFL
     C                   DOW       NOT QUITTER
     C* 31=SFLDSP 32=SFLDSPCTL 34=SFLEND(*MORE) : etat du sous-fichier
     C                   EVAL      *IN31 = (RRN > 0)
     C                   EVAL      *IN32 = *ON
     C                   EVAL      *IN34 = EOFFLG
     C* On ecrit le pied de page (efface l ecran) puis CTL1 en OVERLAY
     C                   WRITE     FOOTER
     C                   EXFMT     CTL1
     C                   EVAL      MSG = *BLANKS
     C                   SELECT
     C* F3 : quitter
     C                   WHEN      *IN03
     C                   EVAL      QUITTER = *ON
     C* F6 : creer un article
     C                   WHEN      *IN06
     C                   EXSR      CREER
     C* Page suivante : charge 11 lignes de plus
     C                   WHEN      *IN25
     C                   EXSR      CHGPLUS
     C* ENTREE : options 2, 4, 5 saisies dans le sous-fichier
     C                   OTHER
     C                   IF        RRN > 0
     C                   EXSR      TRTOPT
     C                   ENDIF
     C                   ENDSL
     C* Recharge si filtre change ou donnees modifiees
     C                   IF        NOT QUITTER
     C                   IF        RECHRG OR POSCOD <> PREVPOS
     C                   EVAL      PREVPOS = POSCOD
     C                   EVAL      RECHRG = *OFF
     C                   EXSR      DEBSFL
     C                   ENDIF
     C                   ENDIF
     C                   ENDDO
     C                   EVAL      *INLR = *ON
     C                   RETURN
     C*---------------------------------------------------------------
     C* DEBSFL : vide le sous-fichier et charge la 1re page
     C*   a partir du code saisi (ordre de la base, cle en caracteres)
     C*---------------------------------------------------------------
     C     DEBSFL        BEGSR
     C* Vider le sous-fichier (SFLCLR)
     C                   EVAL      *IN31 = *OFF
     C                   EVAL      *IN32 = *OFF
     C                   EVAL      *IN33 = *ON
     C                   WRITE     CTL1
     C                   EVAL      *IN33 = *OFF
     C                   EVAL      RRN = 0
     C                   EVAL      EOFFLG = *OFF
     C                   EVAL      SFLPOS = 1
     C* Positionnement : debut du fichier ou a partir de POSCOD
     C                   IF        POSCOD = *BLANKS
     C     *LOVAL        SETLL     LOGISTOCKL
     C                   ELSE
     C     POSCOD        SETLL     LOGISTOCKL
     C                   ENDIF
     C                   EXSR      CHGPAGE
     C                   IF        RRN = 0
     C                   EVAL      MSG = 'Aucun article trouve'
     C                   ENDIF
     C                   ENDSR
     C*---------------------------------------------------------------
     C* CHGPAGE : lit 11 enregistrements dans le sous-fichier
     C*---------------------------------------------------------------
     C     CHGPAGE       BEGSR
     C                   EVAL      PREMIER = RRN + 1
     C                   FOR       I = 1 TO 11
     C                   IF        RRN >= 9999
     C                   LEAVE
     C                   ENDIF
     C                   READ      LOGISTOCKL
     C* Fin de fichier : SFLEND(*MORE) passe a Fin
     C                   IF        %EOF(LOGISTOCKL)
     C                   EVAL      EOFFLG = *ON
     C                   LEAVE
     C                   ENDIF
     C                   EVAL      OPT = *BLANKS
     C                   EVAL      DERNCODE = CODPRO
     C                   EVAL      RRN = RRN + 1
     C                   WRITE     SFL1
     C                   ENDFOR
     C* La nouvelle page s affiche en haut
     C                   IF        RRN >= PREMIER
     C                   EVAL      SFLPOS = PREMIER
     C                   ENDIF
     C                   ENDSR
     C*---------------------------------------------------------------
     C* CHGPLUS : page suivante, reprend apres le dernier code lu
     C*---------------------------------------------------------------
     C     CHGPLUS       BEGSR
     C                   IF        EOFFLG
     C                   LEAVESR
     C                   ENDIF
     C     DERNCODE      SETGT     LOGISTOCKL
     C                   EXSR      CHGPAGE
     C                   ENDSR
     C*---------------------------------------------------------------
     C* TRTOPT : traite les options saisies (2, 4, 5)
     C*---------------------------------------------------------------
     C     TRTOPT        BEGSR
     C                   READC     SFL1
     C                   DOW       NOT %EOF(LOGISTOCKD) AND NOT QUITTER
     C* On garde le code de la ligne choisie
     C                   EVAL      CLE = CODPRO
     C                   SELECT
     C                   WHEN      OPT = ' '
     C                   WHEN      OPT = '2'
     C                   EXSR      MODIF
     C                   WHEN      OPT = '4'
     C                   EXSR      SUPPR
     C                   WHEN      OPT = '5'
     C                   EXSR      AFFICH
     C                   OTHER
     C                   EVAL      MSG = 'Option invalide (2, 4 ou 5)'
     C                   ENDSL
     C* On efface l option dans le sous-fichier (sauf si rechargement)
     C                   IF        NOT RECHRG AND NOT QUITTER
     C                   EVAL      OPT = *BLANKS
     C                   UPDATE    SFL1
     C                   ENDIF
     C                   READC     SFL1
     C                   ENDDO
     C                   ENDSR
     C*---------------------------------------------------------------
     C* AFFICH : option 5, fenetre pop-up (lecture sans verrou)
     C*---------------------------------------------------------------
     C     AFFICH        BEGSR
     C     CLE           CHAIN(N)  LOGISTOCKL
     C                   IF        NOT %FOUND(LOGISTOCKL)
     C                   EVAL      MSG = 'Article introuvable'
     C                   LEAVESR
     C                   ENDIF
     C                   EXFMT     FMTAFF
     C                   IF        *IN03
     C                   EVAL      QUITTER = *ON
     C                   ENDIF
     C                   ENDSR
     C*---------------------------------------------------------------
     C* MODIF : option 2, F23 pour confirmer (ENTREE sans effet)
     C*---------------------------------------------------------------
     C     MODIF         BEGSR
     C     CLE           CHAIN     LOGISTOCKL
     C                   IF        NOT %FOUND(LOGISTOCKL)
     C                   EVAL      MSG = 'Introuvable ou verrouille'
     C                   LEAVESR
     C                   ENDIF
     C                   DOW       *ON
     C                   EXFMT     FMTMOD
     C                   EVAL      MSG = *BLANKS
     C                   SELECT
     C* F3 : quitter le programme
     C                   WHEN      *IN03
     C                   UNLOCK    LOGISTOCKL
     C                   EVAL      QUITTER = *ON
     C                   LEAVE
     C* F12 : annuler, on relit la valeur d origine (sans verrou)
     C                   WHEN      *IN12
     C                   UNLOCK    LOGISTOCKL
     C     CLE           CHAIN(N)  LOGISTOCKL
     C                   LEAVE
     C* F23 : confirmer la modification
     C                   WHEN      *IN23
     C                   IF        NOMPRO = *BLANKS
     C                   EVAL      MSG = 'Nom produit obligatoire'
     C                   ELSE
     C                   UPDATE    ENTREPOTF
     C                   EVAL      MSG = 'Article modifie'
     C                   LEAVE
     C                   ENDIF
     C* ENTREE : rien, on rappelle F23
     C                   OTHER
     C                   EVAL      MSG = 'F23 = confirmer la modif.'
     C                   ENDSL
     C                   ENDDO
     C                   ENDSR
     C*---------------------------------------------------------------
     C* SUPPR : option 4, F23 pour confirmer (ENTREE sans effet)
     C*---------------------------------------------------------------
     C     SUPPR         BEGSR
     C     CLE           CHAIN     LOGISTOCKL
     C                   IF        NOT %FOUND(LOGISTOCKL)
     C                   EVAL      MSG = 'Introuvable ou verrouille'
     C                   LEAVESR
     C                   ENDIF
     C                   DOW       *ON
     C                   EXFMT     FMTSUP
     C                   EVAL      MSG = *BLANKS
     C                   SELECT
     C                   WHEN      *IN03
     C                   UNLOCK    LOGISTOCKL
     C                   EVAL      QUITTER = *ON
     C                   LEAVE
     C                   WHEN      *IN12
     C                   UNLOCK    LOGISTOCKL
     C                   LEAVE
     C* F23 : supprime l enregistrement verrouille, puis recharge
     C                   WHEN      *IN23
     C                   DELETE    LOGISTOCKL
     C                   EVAL      MSG = 'Article supprime'
     C                   EVAL      RECHRG = *ON
     C                   LEAVE
     C                   OTHER
     C                   EVAL      MSG = 'F23 = confirmer la suppr.'
     C                   ENDSL
     C                   ENDDO
     C                   ENDSR
     C*---------------------------------------------------------------
     C* CREER : F6, ENTREE valide la creation
     C*---------------------------------------------------------------
     C     CREER         BEGSR
     C                   CLEAR                   ENTREPOTF
     C                   EVAL      QTPRO = 0
     C                   EVAL      DTDINV = %DATE()
     C                   DOW       *ON
     C                   EXFMT     FMTCRE
     C                   EVAL      MSG = *BLANKS
     C                   IF        *IN03
     C                   EVAL      QUITTER = *ON
     C                   LEAVE
     C                   ENDIF
     C                   IF        *IN12
     C                   LEAVE
     C                   ENDIF
     C* Controles : code et nom obligatoires, code unique
     C                   SELECT
     C                   WHEN      CODPRO = *BLANKS
     C                   EVAL      MSG = 'Code produit obligatoire'
     C                   WHEN      NOMPRO = *BLANKS
     C                   EVAL      MSG = 'Nom produit obligatoire'
     C                   OTHER
     C     CODPRO        SETLL     LOGISTOCKL
     C                   IF        %EQUAL(LOGISTOCKL)
     C                   EVAL      MSG = 'Ce code produit existe deja'
     C                   ELSE
     C                   WRITE     ENTREPOTF
     C                   EVAL      MSG = 'Article cree'
     C                   EVAL      RECHRG = *ON
     C                   LEAVE
     C                   ENDIF
     C                   ENDSL
     C                   ENDDO
     C                   ENDSR
```
