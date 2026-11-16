---
bibliotheque: BIB05
fichier_source: QRPGLESRC2
membre: ASYNTAXTAB
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 320
modifie: 2026-11-16
---

# BIB05/QRPGLESRC2/ASYNTAXTAB

```text
     H* ==============================================================
     H* DEMOTAB - Demonstration des TABLEAUX (mot-cle DIM) en RPG IV
     H*           format fixe (colonne), IBM i 7.1 et superieur
     H*           (une seule ligne, signalee, demande 7.3 TR9).
     H*
     H* Programme autonome : aucun fichier, aucun ecran DDS. Les
     H* resultats sortent par DSPLY : appeler depuis un job
     H* INTERACTIF (ENTREE apres chaque ligne affichee).
     H*
     H* Notions illustrees :
     H*    1. D-spec avec DIM et constante nommee de dimension
     H*    2. Tableaux PARALLELES (meme indice = meme article)
     H*    3. Tableau a donnees de compilation (CTDATA / PERRCD)
     H*    4. Totalisation en une instruction : %XFOOT
     H*    5. Recherche : %LOOKUP et les variantes %LOOKUPxx
     H*    6. Tri : SORTA sur un tableau de cles construites
     H*    7. Tableau de STRUCTURES qualifiees (DS ... DIM)
     H*    8. Tableau a DEUX dimensions (sous-tableau dans une DS)
     H*    9. Sous-ensemble de tableau : %SUBARR
     H*   10. Passage d un tableau en parametre CONST a une
     H*       sous-procedure (P-spec)
     H*
     H* Compilation :
     H*   CRTBNDRPG PGM(MABIB/DEMOTAB) SRCFILE(MABIB/QRPGLESRC)
     H*             SRCMBR(DEMOTAB) DFTACTGRP(*NO) ACTGRP(*NEW)
     H*             DBGVIEW(*SOURCE)
     H* Execution :
     H*   CALL PGM(MABIB/DEMOTAB)
     H* ==============================================================
     H DFTACTGRP(*NO) ACTGRP(*NEW) OPTION(*SRCSTMT : *NODEBUGIO)
     H TEXT('Demonstration des tableaux DIM en RPG IV')
     D*
     D* ==============================================================
     D* 1. Constantes de dimension : la taille des tableaux n est
     D*    ecrite qu une seule fois, ici. Tous les DIM y font
     D*    reference : la changer ne touche qu une ligne.
     D* ==============================================================
     D NB_ART          C                   CONST(5)
     D NB_MOIS         C                   CONST(12)
     D*
     D* ==============================================================
     D* 2. Tableaux PARALLELES : plusieurs tableaux distincts dont
     D*    le meme indice designe le meme article. Forme historique,
     D*    simple mais fragile (rien ne garantit la coherence).
     D* ==============================================================
     D CodeArt         S              6A   DIM(NB_ART)   INZ(*BLANKS)
     D LibArt          S             20A   DIM(NB_ART)   INZ(*BLANKS)
     D FamArt          S              3A   DIM(NB_ART)   INZ(*BLANKS)
     D QteVdu          S              5P 0 DIM(NB_ART)   INZ(0)
     D PrxUni          S              7P 2 DIM(NB_ART)   INZ(0)
     D MntLig          S              9P 2 DIM(NB_ART)   INZ(0)
     D*
     D* ==============================================================
     D* 3. Tableau a DONNEES DE COMPILATION : les 12 libelles sont
     D*    ecrits en fin de source, apres la ligne **CTDATA NomMois.
     D*    PERRCD(1) = une valeur par ligne de donnees.
     D* ==============================================================
     D NomMois         S              9A   DIM(NB_MOIS)  CTDATA PERRCD(1)
     D*
     D* ==============================================================
     D* 7. Tableau de STRUCTURES qualifiees : une entree du tableau
     D*    porte TOUTES les zones d un article. Forme a preferer
     D*    aujourd hui aux tableaux paralleles.
     D*    Acces : Vente(I).Code, Vente(I).Montant
     D* ==============================================================
     D Vente           DS                  QUALIFIED DIM(NB_ART)
     D   Code                         6A
     D   Libelle                     20A
     D   Famille                      3A
     D   Montant                      9P 2
     D*
     D* ==============================================================
     D* 8. Tableau a DEUX dimensions : RPG ne connait pas le tableau
     D*    a deux indices ; on imbrique un tableau DANS une DS elle-
     D*    meme tableau. Acces : Budget(article).Mois(mois)
     D* ==============================================================
     D Budget          DS                  QUALIFIED DIM(NB_ART)
     D   Mois                         9P 2 DIM(NB_MOIS)
     D*
     D* ==============================================================
     D* 6. Tableau de cles pour le tri : famille + montant edite +
     D*    code. SORTA ne trie qu un tableau a la fois ; la cle
     D*    concatenee permet donc un tri multi-critere.
     D* ==============================================================
     D CleTri          S             30A   DIM(NB_ART)   INZ(*BLANKS)
     D*
     D*  Variables de travail
     D I               S             10I 0 INZ(0)
     D J               S             10I 0 INZ(0)
     D Pos             S             10I 0 INZ(0)
     D TotGen          S             11P 2 INZ(0)
     D TotPart         S             11P 2 INZ(0)
     D Msg             S             52A   INZ(*BLANKS)
     D*
     D* ==============================================================
     D* 10. Prototype de la sous-procedure : elle recoit un TABLEAU
     D*     complet en parametre. CONST evite la recopie et interdit
     D*     la modification cote procedure.
     D* ==============================================================
     D SommeTab        PR            11P 2
     D   pTable                       9P 2 DIM(NB_ART) CONST
     D   pNbElem                     10I 0 CONST
     C*
     C* ==============================================================
     C* Corps du programme : enchainement des demonstrations
     C* ==============================================================
     C                   EXSR      INITTAB
     C                   EXSR      CALCUL
     C                   EXSR      RECHERC
     C                   EXSR      TRIART
     C                   EXSR      REPART
     C                   EXSR      SOUSENS
     C                   EVAL      *INLR = *ON
     C                   RETURN
     C*
     C* ==============================================================
     C* INITTAB - Alimentation des tableaux paralleles. Un tableau
     C*           se remplit indice par indice ; la notation
     C*           Tableau(n) designe le n-ieme element.
     C* ==============================================================
     C     INITTAB       BEGSR
     C                   EVAL      CodeArt(1) = 'ART001'
     C                   EVAL      LibArt(1)  = 'Clavier AZERTY'
     C                   EVAL      FamArt(1)  = 'INF'
     C                   EVAL      QteVdu(1)  = 12
     C                   EVAL      PrxUni(1)  = 45.90
     C*
     C                   EVAL      CodeArt(2) = 'ART002'
     C                   EVAL      LibArt(2)  = 'Ecran 24 pouces'
     C                   EVAL      FamArt(2)  = 'INF'
     C                   EVAL      QteVdu(2)  = 4
     C                   EVAL      PrxUni(2)  = 179.00
     C*
     C                   EVAL      CodeArt(3) = 'ART003'
     C                   EVAL      LibArt(3)  = 'Chaise de bureau'
     C                   EVAL      FamArt(3)  = 'MOB'
     C                   EVAL      QteVdu(3)  = 7
     C                   EVAL      PrxUni(3)  = 129.50
     C*
     C                   EVAL      CodeArt(4) = 'ART004'
     C                   EVAL      LibArt(4)  = 'Bureau 160x80'
     C                   EVAL      FamArt(4)  = 'MOB'
     C                   EVAL      QteVdu(4)  = 2
     C                   EVAL      PrxUni(4)  = 349.00
     C*
     C                   EVAL      CodeArt(5) = 'ART005'
     C                   EVAL      LibArt(5)  = 'Cartouche encre'
     C                   EVAL      FamArt(5)  = 'CON'
     C                   EVAL      QteVdu(5)  = 25
     C                   EVAL      PrxUni(5)  = 18.75
     C                   ENDSR
     C*
     C* ==============================================================
     C* CALCUL - Boucle sur les indices, recopie dans le tableau de
     C*          structures, construction de la cle de tri, puis
     C*          totalisation par %XFOOT.
     C* ==============================================================
     C     CALCUL        BEGSR
     C                   FOR       I = 1 TO NB_ART
     C*  Montant de la ligne = quantite vendue * prix unitaire
     C                   EVAL(H)   MntLig(I) = QteVdu(I) * PrxUni(I)
     C*
     C*  7. Meme information, rangee dans le tableau de structures
     C                   EVAL      Vente(I).Code    = CodeArt(I)
     C                   EVAL      Vente(I).Libelle = LibArt(I)
     C                   EVAL      Vente(I).Famille = FamArt(I)
     C                   EVAL      Vente(I).Montant = MntLig(I)
     C*
     C*  6. Cle de tri = famille (3) + montant edite (9) + code (6).
     C*     %EDITC code X conserve les zeros de tete, ce qui rend le
     C*     montant triable en alphanumerique.
     C                   EVAL      CleTri(I) = FamArt(I) +
     C                                         %EDITC(MntLig(I) : 'X') +
     C                                         CodeArt(I)
     C                   ENDFOR
     C*
     C*  4. %XFOOT additionne TOUS les elements du tableau en une
     C*     seule instruction (forme moderne de l opcode XFOOT).
     C                   EVAL      TotGen = %XFOOT(MntLig)
     C                   EVAL      Msg = 'Total general des ventes : ' +
     C                                   %CHAR(TotGen)
     C     Msg           DSPLY
     C                   ENDSR
     C*
     C* ==============================================================
     C* RECHERC - %LOOKUP rend l INDICE de la valeur cherchee, ou
     C*           ZERO si elle est absente. Sur un tableau non trie,
     C*           la recherche est sequentielle.
     C*           Variantes : %LOOKUPLT, %LOOKUPLE, %LOOKUPGE et
     C*           %LOOKUPGT (tableau declare ASCEND ou DESCEND :
     C*           recherche binaire, donc beaucoup plus rapide).
     C* ==============================================================
     C     RECHERC       BEGSR
     C                   EVAL      Pos = %LOOKUP('ART003' : CodeArt)
     C                   IF        Pos > 0
     C                   EVAL      Msg = 'ART003 en position ' +
     C                                   %CHAR(Pos) + ' : ' +
     C                                   %TRIMR(LibArt(Pos))
     C                   ELSE
     C                   EVAL      Msg = 'ART003 est absent du tableau'
     C                   ENDIF
     C     Msg           DSPLY
     C*
     C*  Recherche dans le tableau de structures : la notation (*)
     C*  cible une zone precise de toutes les entrees. Seule ligne
     C*  du programme a exiger IBM i 7.3 TR9 / 7.4 TR3 : avant, il
     C*  faut une boucle FOR avec test sur Vente(I).Famille.
     C                   EVAL      Pos = %LOOKUP('MOB' : Vente(*).Famille)
     C                   IF        Pos > 0
     C                   EVAL      Msg = 'Premier article famille MOB : ' +
     C                                   %TRIMR(Vente(Pos).Libelle)
     C     Msg           DSPLY
     C                   ENDIF
     C                   ENDSR
     C*
     C* ==============================================================
     C* TRIART - SORTA trie le tableau SUR PLACE, par ordre
     C*          croissant ; SORTA(D) trie en decroissant (7.1+).
     C*          On trie le tableau de cles, puis on retrouve chaque
     C*          article par le code extrait de la cle.
     C* ==============================================================
     C     TRIART        BEGSR
     C                   SORTA     CleTri
     C*
     C                   EVAL      Msg = 'Ventes triees par famille/montant :'
     C     Msg           DSPLY
     C                   FOR       I = 1 TO NB_ART
     C*  Le code occupe les positions 13 a 18 de la cle
     C                   EVAL      Pos = %LOOKUP(%SUBST(CleTri(I) : 13 : 6) :
     C                                                  CodeArt)
     C                   EVAL      Msg = FamArt(Pos) + ' ' +
     C                                   %TRIMR(LibArt(Pos)) + ' ' +
     C                                   %CHAR(MntLig(Pos))
     C     Msg           DSPLY
     C                   ENDFOR
     C                   ENDSR
     C*
     C* ==============================================================
     C* REPART - Tableau a deux dimensions : le montant annuel de
     C*          chaque article est reparti sur les 12 mois, puis
     C*          totalise par ligne (%XFOOT sur le sous-tableau) et
     C*          par colonne (boucle a indice de mois fixe).
     C* ==============================================================
     C     REPART        BEGSR
     C                   FOR       I = 1 TO NB_ART
     C                   FOR       J = 1 TO NB_MOIS
     C                   EVAL(H)   Budget(I).Mois(J) = MntLig(I) / NB_MOIS
     C                   ENDFOR
     C                   ENDFOR
     C*
     C*  Total annuel du premier article : %XFOOT sur le sous-tableau
     C                   EVAL      TotPart = %XFOOT(Budget(1).Mois)
     C                   EVAL      Msg = 'Budget annuel de ' +
     C                                   %TRIMR(LibArt(1)) + ' : ' +
     C                                   %CHAR(TotPart)
     C     Msg           DSPLY
     C*
     C*  Total d un mois donne, tous articles confondus : on
     C*  parcourt la premiere dimension a indice de mois fixe.
     C                   EVAL      TotPart = 0
     C                   FOR       I = 1 TO NB_ART
     C                   EVAL      TotPart = TotPart + Budget(I).Mois(NB_MOIS)
     C                   ENDFOR
     C                   EVAL      Msg = 'Total ' + %TRIMR(NomMois(NB_MOIS)) +
     C                                   ' : ' + %CHAR(TotPart)
     C     Msg           DSPLY
     C                   ENDSR
     C*
     C* ==============================================================
     C* SOUSENS - %SUBARR isole une TRANCHE du tableau (depart et
     C*           nombre d elements) ; SommeTab montre le passage du
     C*           tableau entier a une sous-procedure.
     C* ==============================================================
     C     SOUSENS       BEGSR
     C*  9. Somme des trois premieres lignes seulement
     C                   EVAL      TotPart = %XFOOT(%SUBARR(MntLig : 1 : 3))
     C                   EVAL      Msg = 'Somme des 3 premieres lignes : ' +
     C                                   %CHAR(TotPart)
     C     Msg           DSPLY
     C*
     C*  10. Le tableau complet est passe a la sous-procedure
     C                   EVAL      TotPart = SommeTab(MntLig : NB_ART)
     C                   EVAL      Msg = 'Somme calculee par SommeTab : ' +
     C                                   %CHAR(TotPart)
     C     Msg           DSPLY
     C                   ENDSR
     P*
     P* ==============================================================
     P* SommeTab - Additionne les pNbElem premiers elements du
     P*            tableau recu. Le parametre est declare
     P*            DIM(NB_ART) CONST : passage par reference, sans
     P*            recopie et sans risque de modification.
     P*            %XFOOT(pTable) ferait la meme chose en une ligne ;
     P*            la boucle montre l acces indice par indice.
     P* ==============================================================
     P SommeTab        B
     D SommeTab        PI            11P 2
     D   pTable                       9P 2 DIM(NB_ART) CONST
     D   pNbElem                     10I 0 CONST
     D*  Variables locales a la procedure
     D wTotal          S             11P 2 INZ(0)
     D wIdx            S             10I 0 INZ(0)
     C                   FOR       wIdx = 1 TO pNbElem
     C                   EVAL      wTotal = wTotal + pTable(wIdx)
     C                   ENDFOR
     C                   RETURN    wTotal
     P SommeTab        E
**CTDATA NomMois
Janvier
Fevrier
Mars
Avril
Mai
Juin
Juillet
Aout
Septembre
Octobre
Novembre
Decembre
```
