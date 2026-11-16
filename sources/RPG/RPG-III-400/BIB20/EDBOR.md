---
bibliotheque: BIB20
fichier_source: QRPGSRC
membre: EDBOR
type: RPG/RPG-III-400
longueur_enregistrement: 160
lignes: 2630
modifie: 2026-11-16
---

# BIB20/QRPGSRC/EDBOR

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
     *=============SUIVI DES MODIFICATIONS EFFECTUEES==========================     *   Date   |Mném.| Commentaires
     *----------|-----|--------------------------------------------------------     * 13 04 17 | lde | création des bordereaux de chargement chauffeur en PDF
     * 25 08 17 | lde | si le chauffeur n'a, en vrac, que la partie "à contrôle     * le message "pas de vrac"
     * 24 09 18 | lde | TAFARTP1 remplace TAFARTPX                                  * 14 12 18 | lde | suppression de quelques tests pour que les articles soi
     * s'ils se trouvent dans le mauvais paragraphe                                 * 20 11 18 | lde | modif pour récup date si affectation à 72h
     * 28 02 19 | lde | ajout test pour alcool préparé à part                       * 06 03 19 | lde | mise en commentaire test "EcritOK <> *Blanks" au lancem
     * 30 04 19 | lde | changement position sur KLIST "KL11LUL" pour que les al     * part soient bien triées par client
     * 03 03 20 | lde | ajout test sur code géo des alcools car le produit 0899     * doit sortir avec les alcools
     * 24 03 20 | lde | Le Code Article passe de 4 à 5 caractères - D5PUHT remp     * D5VLAV remplacé par CODLOT
     * 27 04 20 | lde | la variable anciennement Zone73 est remplacée par ZONE4     * 07 01 22 | lde | modif pour ne pas prendre dans la gamme sirops, les CAT
     * 14 02 22 | lde | la zone D5NUAV remplacée par CODPRE                         * 19 05 22 | lde | ajout CC 18 ristourne
     * 27 07 22 | lde | à partir du 1 août 2022, les 13,50 passent à 22 euros       * 27 09 22 | lde | à partir du 1 octobre 2022, les 33 passent à 39 euros
     * 16 04 24 | lde | ajout zone couleur JO                                       * 16 07 24 | lde | dans la liste des clients, on affiche aussi ceux qui so
     * 23 07 24 | lde | dans le détail des clients, on affiche aussi ceux qui s     * avec les commentaires
     * 18 11 25 | lde | ajout de 2 nouvelles boucles pour spiritueux sans alcoo     *=========================================================================
     *  *** Indicateurs                                                             *  30 read COLL03L3
     *  31 chain COLL03L4, COLL11LB, COLL11LN, COLL11LT et COLL11LU                 *  32 chain COLL11L11 et COLL11L12
     *  33 chain COLL10L0                                                           *  34 chain COLL11LA
     *  35 chain TAFCLIP1                                                           *  51 chain TAFARTP1
     *  52 chain FICLIVP1                                                           *  70 à 76 pour afficher la ligne (Vrac, Lot...) dans l'entête
     *  77 pour afficher les zones LETTRE et LIBEDI                                 *  80 lookup sur tableau TCLP et TCLI
     *  82 pour afficher la zone CONT2                                              *  83 pour afficher la zone CONT3
     *  84 pour afficher la zone CONT4                                              *  85 pour afficher la zone numéro de commande dans l'entête client pour l
     *  87 pour ne pas afficher les zones numéro de commande (format ENTCLIC)       *  ***
     H DECEDIT('0,') DATEDIT(*DMY.) OPTION(*NODEBUGIO:*SRCSTMT)                      FColl03L3  IF   E           K DISK
     FColl03L4  IF   E           K DISK    Rename(Facd03F1:Coll03F4) Prefix(z)       FColl03LZ  IF   E           K DISK    Rename(Facd03F1:Coll03FZ) Prefix(z)
     FColl11LB  IF   E           K DISK                              Prefix(z)       FColl11LT  IF   E           K DISK    Rename(Facd11F1:Coll11FT)Prefix(z)
     FColl11L11 IF   E           K DISK    Rename(Facd11F1:Coll11F11)                FColl11L12 IF   E           K DISK    Rename(Facd11F1:Coll11F12)
     FColl11L13 IF   E           K DISK    Rename(Facd11F1:Coll11F13) Prefix(z)      FColl11L14 IF   E           K DISK    Rename(Facd11F1:Coll11F14) Prefix(z)
     FColl11LO  IF   E           K DISK    Rename(Facd11F1:Coll11FLL)                FColl11LN  IF   E           K DISK    Rename(Facd11F1:Coll11FLH)
     FColl11LU  IF   E           K DISK    Rename(Facd11F1:Coll11FLU)                FColl11LA  UF   E           K DISK    Rename(Facd11F1:Coll11FLA) Prefix(z)
     FColl11L2  IF   E           K DISK    Rename(Facd11F1:Coll11FL2)                FColl11LZ  IF   E           K DISK    Rename(Facd11F1:Coll11FLZ) Prefix(z)
     FColl10L0  IF   E           K DISK
     FTafcliP1  IF   E           K DISK                                              FTafartP1  IF   E           K DISK
     FFiclivP1  IF   E           K DISK                                              FParam     IF   E           K DISK
     FPrepaP1   IF   E           K DISK
     FIMedborc  O    E             PRINTER Usropn
     * tableau chiffre pair ------------------------------------------              D Tchp            S              2  0 DIM(25)
     * tableau chiffre impair ----------------------------------------              D Tchi            S              2  0 DIM(25)
     * tableau consigne type 1 ---------------------------------------              D TB1             S              6  2 DIM(99) DESCEND
     * tableau consigne type 1 (suite) -------------------------------              D TB1B            S              6  2 DIM(99) DESCEND
     * tableau consigne type 2 ---------------------------------------              D TB2             S              6  2 DIM(99) DESCEND
     * tableau consigne type 3 ---------------------------------------              D TB3             S              6  2 DIM(99) DESCEND
     * tableau consigne type 4 ---------------------------------------              D TB4             S              6  2 DIM(99) DESCEND
     * tableau consigne type 5 ---------------------------------------              D TB5             S              6  2 DIM(99) DESCEND
     * tableau clients sur palettes  ---------------------------------              D Tclp            S              7  0 DIM(9900) DESCEND
     * tableau clients -----------------------------------------------              D Tcli            S              7  0 DIM(9900) DESCEND
     * tableau numéro de lots ----------------------------------------              D Tlot            S              1    DIM(50)
                                                                                     D                 DS
     D  DStaux                 1      5  2                                           D  DSunit                 1      3  0
     D  DSdec                  4      5  0                                           D                 DS
     D  DSident                1      6  0                                           D  DStab                  1      1  0
     D  DSunit1                1      3  0                                           D  DSdec1                 4      5  0
     D  DSparam        DS                                                            D  Pident                 1     17
     D  DStyp                  1      1                                              D  DScon                  2     17
                                                                                     D                 DS
     D  Datliv                 1      8  0                                           D  Livjour                1      2  0
     D  Livmois                3      4  0                                           D  Livan                  5      8  0
     D                 DS                                                            D  Dattrav                1      8  0
     D  TRVan                  1      4  0                                           D  TRVmois                5      6  0
     D  TRVjour                7      8  0
     D                 DS                                                            D  DTdem                  1     23
     D  Datdem                16     23  0 inz(0)                                    D                 DS
     D  DTapdem                1     23                                              D  APDATE                16     23  0 inz(0)
     D                 DS                                                            D  DTapapd                1     23
     D  APAPDT                16     23  0 inz(0)
     D Cod_liv         S              3  0 Inz(*Zeros)                               D Cod_cli         S              7  0 Inz(*Zeros)
     D Code_cli        S              7  0 Inz(*Zeros)                               D Code_clis       S              7  0 Inz(*Zeros)
     D £numcde         S              4  0 Inz(*Zeros)                               D Codeclis        S              7  0 Inz(*Zeros)
     D EcritOK         S              1    Inz(*Blanks)                              D EcritVOK        S              1    Inz(*Blanks)
     D EcritEnt        S              1    Inz(*Blanks)                              D EcritEnt2       S              1    Inz(*Blanks)
     D EcritEnt3       S              1    Inz(*Blanks)                              D EcritEnt4       S              1    Inz(*Blanks)
     D Unefois         S              1    Inz(*Blanks)                              D Unefois2        S              1    Inz(*Blanks)
     D Unefois3        S              1    Inz(*Blanks)                              D Format          S              2    Inz(*Blanks)
     D PubOK           S              1    Inz(*Blanks)                              D Num_cde         S              4  0 Inz(*Zeros)
     D Cod_art         S              5  0 Inz(*Zeros)                               D Cum_cais        S              4  0 Inz(*Zeros)
     D Cum_poid        S              5  0 Inz(*Zeros)                               D Adr_art         S              4    Inz(*Blanks)
     D GeoOK           S              1    Inz(*Blanks)                              D CodeART         S              5  0 Inz(*Zeros)
     D CODEARTIC       S              5  0 Inz(*Zeros)                               D EcritTot        S              1    Inz(*Blanks)
     D EnteteArt       S              1    Inz(*Blanks)                              D VracOK          S              2    Inz(*Blanks)
     D Complig         S              1  0 Inz(*Zeros)                               D Prepare         S              1    Inz(*Blanks)
     D FutOK           S              1    Inz(*Blanks)                              D PiedOK          S              1    Inz(*Blanks)
     D Cod_lot         S              1    Inz(*Blanks)                              D Numpage         S              2  0 Inz(*Zeros)
     D Ecritlib        S              1    Inz(*Blanks)                              D Ind             S              4  0 Inz(*Zeros)
     D Ind2            S              4  0 Inz(*Zeros)                               D Ind3            S              4  0 Inz(*Zeros)
     D SIvrac          S              1    Inz(*Blanks)                              D Apart           S              2  0 Inz(*Zeros)
     D Ilot            S              4  0 Inz(*Zeros)                               D £Lot            S              1    Inz(*Blanks)
     D £Codlot         S              1    Inz(*Blanks)                              D ZoneLot         S              1    Inz(*Blanks)
     D Compt           S              2  0 Inz(*Zeros)                               D NomEX           S              1  0 Inz(*Zeros)
     D A               S              4  0 Inz(*Zeros)                               D A2              S              4  0 Inz(*Zeros)
     D B               S              4  0 Inz(*Zeros)                               D C               S              4  0 Inz(*Zeros)
     D D               S              4  0 Inz(*Zeros)                               D E               S              4  0 Inz(*Zeros)
     D CodePre         S              3  0 Inz(*Zeros)                               D Paletisat1      S              4    Inz(*Blanks)
     D Paletisat2      S              4  0 Inz(*Zeros)                               D Zone4A          S              4    Inz(*Blanks)

     *==**==** lecture entête commandes (tri sur livreur et client)                 C     *Loval        Setll     Coll03L3
     C                   Read      Coll03L3                               30         C                   Clear                   Cod_liv
     C                   Dow       *In30 = *Off                                      *== on ne fait qu'une fois le même livreur
     C                   If        D9livr = Cod_liv                                  C                   Goto      Suiv
     C                   Endif                                                       C                   Z-add     D9livr        Cod_liv
     C                   Clear                   Cod_Cli                             C                   Exsr      Efface
     C                   Clear                   TOTgdiv                             C                   Clear                   TOTgcai
     C                   Clear                   TOTgsir                             C                   Clear                   TOTgalc
     C                   Clear                   TOTgcol                             C                   Clear                   TgPOIart
     C                   Clear                   TOTgfut                             C                   Clear                   TOTpub
     C                   Clear                   NBRcli
     *==**==**     liste des clients : clients préparés        *==**==**            C     D9livr        Chain     Coll03L4                           31
     C                   Dow       *In31 = *Off                                      *== on passe si clients non préparés
     C                   If        zD9aff2 <> 11                                     C                   Goto      Suiv00
     C                   Endif                                                       *== Pas les comptes mat
     C     zD9cli        Chain     TafcliP1                                          C                   If        IPmatl = 'M'
     C                   Goto      Suiv00                                            C                   Endif
     *== on ne fait qu'une fois le même client stat                                 C                   If        zD9clst = Cod_cli
     C                   Goto      Suiv00                                            C                   Endif
     C                   Z-add     zD9clst       Cod_cli                             *== écriture des formats
     C                   Eval      Format = 'CL'                                     C                   Exsr      Entet
     C                   Eval      Unefois = '*'                                     C                   If        EcritEnt = *blanks
     C                   Add       3             Ligne                               C                   Write     ENTETC
     C                   Eval      EcritEnt = '*'                                    C                   Endif
                                                                                     C                   Clear                   SIpal
     C                   If        zD9aff2 = 11                                      C                   Eval      SIpal = '(P)'
     C                   Endif
     C                   Z-add     zD9cli        Codcli                              C                   Add       1             Ind
     C                   Movea     zD9clst       Tclp(Ind)                           C                   Move      Ensliv        ENSEIG
     C                   Move      NNomli        NOMCLI                              C                   Move      Rueliv        RUECLI
     C                   Z-add     CPliv         CPcli                               C                   Move      Villiv        Vilcli
     C                   Move      IPntel        Telcli                              C                   Eval      Prepare = '*'
     *==* récup couleur JO                                                          C                   Exsr      Couleur
     *=================== cumul des colis, sirops, alcools .... ===============     C                   Exsr      CumulCol
     *=========================== cumul de la consigne ========================     C                   Exsr      CumulCons
     *=========================== calcul nombre de commandes ==================     C                   Exsr      CumNBRcde
                                                                                     C                   Exsr      Entet
                                                                                     *= écriture du détail
     C                   If        TOTcai <> *Zeros  Or TOTsir <> *Zeros Or          C                             TOTalc <> *Zeros  Or TOTcol <> *Zeros Or
     C                             POIart <> *Zeros  Or TOTfut <> *Zeros Or          C                             SIpub  <> *Blanks Or TOTver <> *Zeros Or
     C                             TOTeur <> *Zeros  Or TOpfut <> *Zeros Or          C                             TOTdiv <> *Zeros
     C                   Add       4             Ligne                               C                   Clear                   Reprise
     C                   Write     Clients                                           C                   Eval      Unefois = '*'
     C                   Eval      EcritOK = '*'                                     C                   Exsr      Efface
     C                   Clear                   COUL
     C                   Else                                                        *= ********        si reprise de vide
     C                   Add       4             Ligne                               C                   Eval      Reprise = '*'
     C                   Write     Clients                                           C                   Eval      Unefois = '*'
     C                   Eval      EcritOK = '*'                                     C                   Exsr      Efface
     C                   Clear                   COUL
     C                   Endif                                                       C     Suiv00        Tag
     C     D9livr        Reade     Coll03L4                               31         C                   Enddo
     *==**==** fin liste des clients : clients préparés        *==**==**
     C                   Clear                   Cod_Cli                             C                   Clear                   Reprise
     C                   Exsr      Efface
     *==**==**     liste des clients : clients non préparés    *==**==**            C     D9livr        Chain     Coll03L4                           31
     C                   Dow       *In31 = *Off                                      *== on passe si clients trouvés dans le tableau des clients préparés
     C                   Z-add     1             Ind                                 C     zD9clst       LOOKUP    Tclp(Ind)                              80
     C                   If        *In80 = *On                                       C                   Goto      Suiv02
     C                   Endif                                                       *== on passe si clients préparés
     C                   If        zD9aff2 = 11                                      C                   Goto      Suiv02
     C                   Endif                                                       *== Pas les comptes mat
     C     zD9cli        Chain     TafcliP1                                          C                   If        IPmatl = 'M'
     C                   Goto      Suiv02                                            C                   Endif
     *== on ne fait qu'une fois le même client stat                                 C                   If        zD9clst = Cod_cli
     C                   Goto      Suiv02                                            C                   Endif
     C                   Z-add     zD9clst       Cod_cli                             *== écriture des formats
     C                   Eval      Format = 'CL'                                     C                   Exsr      Entet
     C                   Eval      Unefois = '*'                                     C                   If        EcritEnt = *blanks
     C                   Add       3             Ligne                               C                   Write     ENTETC
     C                   Eval      EcritEnt = '*'                                    C                   Endif
                                                                                     C                   Clear                   SIpal
     C                   Z-add     zD9cli        codcli                              C                   Move      Ensliv        ENSEIG
     C                   Move      NNomli        NOMCLI                              C                   Move      Rueliv        RUECLI
     C                   Z-add     CPliv         CPcli                               C                   Move      Villiv        Vilcli
     C                   Move      IPntel        Telcli                              C                   Clear                   Prepare
     *==* récup couleur JO                                                          C                   Exsr      Couleur
     *=================== cumul des colis, sirops, alcools .... ===============     C                   Exsr      CumulCol
     *=========================== cumul de la consigne ========================     C                   Exsr      CumulCons
     *=========================== calcul nombre de commandes ==================     C                   Exsr      CumNBRcde
                                                                                     C                   Exsr      Entet
                                                                                     C                   If        TOTcai <> *Zeros  Or TOTsir <> *Zeros Or
     C                             TOTalc <> *Zeros  Or TOTcol <> *Zeros Or          C                             POIart <> *Zeros  Or TOTfut <> *Zeros Or
     C                             SIpub  <> *Blanks Or TOTver <> *Zeros Or          C                             TOTeur <> *Zeros  Or TOpfut <> *Zeros Or
     C                             TOTdiv <> *Zeros                                  C                   Add       4             Ligne
     C                   Clear                   Reprise                             C                   Write     Clients
     C                   Eval      Unefois = '*'                                     C                   Eval      EcritOK = '*'
     C                   Exsr      Efface                                            C                   Clear                   COUL
                                                                                     C                   Else
     *= ********        si reprise de vide                                          C                   Add       4             Ligne
     C                   Eval      Reprise = '*'                                     C                   Write     Clients
     C                   Eval      Unefois = '*'                                     C                   Eval      EcritOK = '*'
     C                   Exsr      Efface                                            C                   Clear                   COUL
                                                                                     C                   Endif
     C     Suiv02        Tag                                                         C     D9livr        Reade     Coll03L4                               31
     C                   Enddo                                                       C                   Clear                   Reprise
     C                   Clear                   COUL                                *==**==** fin liste des clients : clients non préparés    *==**==**
     *== écriture, si consigne, du compte consignation chauffeur)                   C     M4cons        Chain     TafcliP1                           35
     C                   If        *In35 = *Off                                      C                   Exsr      Entet
     C                   Z-add     Nocli         CODCLI                              C                   Clear                   ENSEIG
     C                   Clear                   NOMCLI                              C                   Clear                   RUECLI
     C                   Clear                   CPCLI                               C                   Clear                   VILCLI
     C                   Clear                   SIpal                               C                   Clear                   TELCLI
     C                   Clear                   NBRCDE                              C                   Add       4             Ligne
     C                   Write     Clients                                           C                   Endif
     C                   Exsr      Efface                                            *=========================== compteur du nombre de clients ===============
     C                   Clear                   CodecliB          7 0               C     D9livr        Chain     Coll03LZ                           31
     C                   Dow       *In31 = *Off                                      C     zD9clst       Chain     TafcliP1
     C                   If        IPmatl = 'M'                                      C                   Goto      SuivC00
     C                   Endif                                                       C                   If        zD9clst <> CodecliB
     C                   Add       1             NBRcli                              C                   Z-add     zD9clst       CodecliB
     C                   Endif                                                       C     SuivC00       Tag
     C     D9livr        Reade     Coll03LZ                               31         C                   Enddo
                                                                                     C                   Exsr      Entet
     C                   Add       3             Ligne                               C                   Write     TotalGC
     C                   Clear                   Ligne                               C                   Clear                   Cod_Cli
     C                   Clear                   Num_cde                             C                   Clear                   TOTGCCAI
     C                   Clear                   TOTGCPOI                            C                   Clear                   £Numcde
                                                                                     *==**==**     liste des clients : clients préparés        *==**==**
     *==**==**     avec leur détail de la commande             *==**==**            C     D9livr        Chain     Coll03LZ                           31
     C                   Clear                   Code_clis                           C                   Dow       *In31 = *Off
     *== on ne fait qu'une fois le même client et numéro de commande                C                   If        zD9clst = Cod_cli And zD9nucd = Num_cde
     C                   Goto      Suiv01                                            C                   Endif
     C                   Z-add     zD9clst       Cod_cli                             C                   Z-add     zD9nucd       Num_cde
     *== on passe si clients non trouvés dans le tableau des clients préparés       C                   Z-add     1             Ind
     C     zD9cli        LOOKUP    Tclp(Ind)                              80         C                   If        *In80 = *Off
     C                   Goto      Suiv01                                            C                   Endif
     C                   Z-add     1             Ind2                                C     zD9clst       LOOKUP    Tcli(Ind2)                             80
     C                   If        *In80 = *On                                       C                   Goto      Suiv01
     C                   Else                                                        C                   Add       1             Ind3
     C                   Movea     zD9clst       Tcli(Ind3)                          C                   Endif
     C     zD9cli        Chain     TafcliP1                                          *== on passe si compte mat
     C                   If        IPMATL = 'M'                                      C                   Goto      Suiv01
     C                   Endif                                                       *== écriture des formats
     C                   Eval      Format = 'CD'                                     C                   Exsr      Entet
                                                                                     C                   Clear                   SIpal
     C                   Eval      SIpal = '(P)'                                     C                   Z-add     zD9cli        codcli
     C                   Move      Ensliv        ENSEIG                              C                   Move      NNomli        NOMCLI
     C                   Move      Rueliv        RUECLI                              C                   Z-add     CPliv         CPcli
     C                   Move      Villiv        Vilcli                              C                   Move      IPntel        Telcli
                                                                                     C                   Clear                   CAICLI
     C                   Clear                   POICLI                              *=================== écriture du détail ==================================
     C     K11L          Chain     Coll11L11                          32
     C                   Clear                   Reprise                             *==**** si aucun détail trouvé, c'est une reprise de vide
     C                   If        *In32 = *On                                       C                   Clear                   COMM
     C                   Eval      COMM = '                   **  Reprise  **'       C                   Exsr      Entet
     C                   Add       3             Ligne                               C                   Write     ENTCLI
     C                   Exsr      Entet                                             C                   Eval      Reprise = '*'
     C                   Add       1             Ligne                               C                   Write     COMMENT
     C                   Clear                   Reprise                             C                   Clear                   COMM
     C                   Exsr      Entet                                              *********** écriture des commentaires
     C     K10b          Chain     Coll10L0                           33             C                   Dow       *In33 = *Off
     C                   If        D8seq <> 'Y'                                      C                   Exsr      Entet
     C                   MoveL     D8lib         COMM                                C                   Add       1             Ligne
     C                   Write     COMMENT                                           C                   Endif
     C     K10b          Reade     Coll10L0                               33         C                   Enddo
      *********** ligne blanche                                                      C                   Clear                   Reprise
     C                   Clear                   COMM                                C                   Add       1             Ligne
     C                   Write     COMMENT                                           C                   Endif
     C                   Clear                   Reprise
     C                   Dow       *In32 = *Off                                      C                   If        D5cc <> 11 And D5cc <> 13
     C                   Goto      Suiv012                                           C                   Endif
                                                                                     C                   If        Numpage = *Zeros
     C                   Eval      Format = 'C2'                                     C                   Else
     C                   Eval      Format = 'CD'                                     C                   Endif
                                                                                     *==**** entête du client : si 1ière fois, client avec adresse et numéro de
     *==****                  : si 2ième fois, client sans adresse et avec numé     C                   If        Unefois2 = *Blanks
     C                   Z-add     D5nucd        Numcde
     C                   If        D5clst = Code_clis And Code_clis <> *Zeros        C                   If        Ligne >= 62
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       2             Ligne
     C                   Write     ENTCLIC
     C                   Else                                                        *==****            écriture du total client
     C                   If        TOTCcai <> *Zeros Or TOTCPOI <> *Zeros            C                   If        Ligne >= 64
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     TOTCLI                                            C                   Endif
     C                   Clear                   TOTCCAI                             C                   Clear                   TOTCPOI
                                                                                     C                   If        EnteteArt = *Blanks
     C                   Exsr      Entet                                             C                   Add       3             Ligne
     C                   Write     ENTCLIB                                           C                   Eval      EnteteArt = '*'
     C                   Endif                                                       C     CODCLI        Chain     TafcliP1
     *==* récup couleur JO                                                          C                   Exsr      Couleur
                                                                                     C                   If        Ligne >= 57
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       3             Ligne
     C                   Write     ENTCLI                                            C                   Endif
     C                   Z-add     D5clst        Code_clis                           C                   Z-add     D5nucd        £Numcde
                                                                                     C                   Eval      Unefois2 = '*'
     ** récup des commentaires livraison                                            C                   Exsr      RecupCom
     C                   Endif
     C                   Z-add     D5code        Artcli                              C                   MoveL     D5lib         Lartcli
     ** recherche bonne paletisation pour article (ex : 0644)                       C     D5code        Chain     TafartP1
     C                   Clear                   Paletisat1        4                 C                   Clear                   Paletisat2        4 0
     C                   Clear                   Ptable                              C                   Clear                   Pident
     C                   Move      'APL'         Ptable                              C                   MoveL     D5code        Pident
     C     Kpar          Chain     Param                              32             C                   If        *In32 = *Off
     C                   Eval      Paletisat1 = %Subst(Ptout:1:4)                    C                   Move      Paletisat1    Paletisat2
     C                   If        Cpalet <> Paletisat2                              C                   Eval      Caicli = D5cais * Paletisat2
     C                   Else                                                        C                   Z-add     D5cais        Caicli
     C                   Endif                                                       C                   Else
     C                   Z-add     D5cais        Caicli                              C                   Endif
                                                                                     C                   Z-add(h)  D5poid        Poicli
     C                   Add       Caicli        TOTCCAI                             C                   Add(h)    D5poid        TOTCPOI
     C                   Add       Caicli        TOTGCCAI                            C                   Add(h)    D5poid        TOTGCPOI
     *== mise à jour des contenances                                                C                   Z-add     D5code        Cart
     C                   Exsr      MiseAjour
     C                   If        Numpage = *Zeros                                  C                   Eval      Format = 'C2'
     C                   Else                                                        C                   Eval      Format = 'DD'
     C                   Endif
     C                   If        Ligne >= 58                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
                                                                                     C                   Add       1             Ligne
     C                   Write     CLIENTSB
     C                   If        Numpage = *Zeros                                  C                   Eval      Format = 'C2'
     C                   Else                                                        C                   Eval      Format = 'CD'
     C                   Endif                                                       C                   Eval      EcritOK = '*'
                                                                                     C     Suiv012       Tag
     C     K11L          Reade     Coll11L11                              32
     C                   If        D5clst = Code_clis And                            C                             D5nucd <> £Numcde
     C                   Clear                   Unefois2                            C                   Endif
                                                                                     C                   Enddo
                                                                                     C                   Clear                   Unefois2
     C     Suiv01        Tag                                                         C     D9livr        Reade     Coll03LZ                               31
     C                   Enddo                                                       *====== écriture total dernier client
     C                   If        TOTCcai <> *Zeros Or TOTCPOI <> *Zeros            C                   If        Ligne >= 64
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     Totcli                                            C                   Clear                   TOTCCAI
     C                   Clear                   TOTCPOI                             C                   Endif
                                                                                     C                   Clear                   Cod_Cli
     C                   Clear                   Num_cde                             C                   Clear                   £Numcde
                                                                                     *==**==**     liste des clients : clients non préparés    *==**==**
     *==**==**     avec leur détail de la commande             *==**==**            C     D9livr        Chain     Coll03L4                           31
     C                   Clear                   Code_clis                           C                   Dow       *In31 = *Off
     *== on ne fait qu'une fois le même client                                      C                   If        zD9cli = Cod_cli And zD9nucd = Num_cde
     C                   Goto      Suiv03                                            C                   Endif
     C                   Z-add     zD9cli        Cod_cli                             C                   Z-add     zD9nucd       Num_cde
     *== on passe si clients trouvés dans le tableau des clients préparés           C                   Z-add     1             Ind
     C     zD9clst       LOOKUP    Tclp(Ind)                              80         C                   If        *In80 = *On
     C                   Goto      Suiv03                                            C                   Endif
     C     zD9cli        Chain     TafcliP1                                          *== on passe si compte mat
     C                   If        IPMATL = 'M'                                      C                   Goto      Suiv03
     C                   Endif                                                       *== écriture des formats
     C                   Eval      Format = 'CD'                                     C                   Exsr      Entet
                                                                                     C                   Clear                   SIpal
     C                   Z-add     zD9cli        codcli                              C                   Move      Ensliv        ENSEIG
     C                   Move      NNomli        NOMCLI                              C                   Move      Rueliv        RUECLI
     C                   Z-add     CPliv         CPcli                               C                   Move      Villiv        Vilcli
     C                   Move      IPntel        Telcli
     C                   Clear                   CAICLI                              C                   Clear                   POICLI
     *=================== écriture du détail ==================================     C     K12           Chain     Coll11L12                          32
                                                                                     C                   Clear                   Reprise
     *==**** si aucun détail trouvé, c'est une reprise de vide                      C                   If        *In32 = *On
     C                   Clear                   COMM                                C                   Eval      COMM = '                   **  Reprise  **'
     C                   Exsr      Entet                                             C                   Add       3             Ligne
     C                   Write     ENTCLI                                            C                   Exsr      Entet
     C                   Eval      Reprise = '*'                                     C                   Add       1             Ligne
     C                   Write     COMMENT                                           C                   Clear                   Reprise
     C                   Clear                   COMM                                C                   Exsr      Entet
      *********** écriture des commentaires                                          C     K10b          Chain     Coll10L0                           33
     C                   Dow       *In33 = *Off                                      C                   If        D8seq <> 'Y'
     C                   Exsr      Entet                                             C                   MoveL     D8lib         COMM
     C                   Add       1             Ligne                               C                   Write     COMMENT
     C                   Endif                                                       C     K10b          Reade     Coll10L0                               33
     C                   Enddo                                                        *********** ligne blanche
     C                   Clear                   Reprise                             C                   Clear                   COMM
     C                   Add       1             Ligne                               C                   Write     COMMENT
     C                   Endif                                                       C                   Clear                   Reprise
                                                                                     C                   Dow       *In32 = *Off
     C                   If        D5cc <> 11 And D5cc <> 13                         C                   Goto      Suiv003
     C                   Endif
     C                   If        Numpage = *Zeros                                  C                   Eval      Format = 'C2'
     C                   Else                                                        C                   Eval      Format = 'CD'
     C                   Endif
     *==**** entête du client : si 1ière fois, client avec adresse et numéro de     *==****                  : si 2ième fois, client sans adresse et avec numé
     C                   If        Unefois2 = *Blanks                                C                   Z-add     D5nucd        Numcde
                                                                                     C                   If        D5clst = Code_clis And Code_clis <> *Zeros
     C                   If        Ligne >= 62                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       2             Ligne                               C                   Write     ENTCLIC
                                                                                     C                   Else
     *==****            écriture du total client                                    C                   If        TOTCcai <> *Zeros Or TOTCPOI <> *Zeros
     C                   If        Ligne >= 64                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     TOTCLI
     C                   Endif                                                       C                   Clear                   TOTCCAI
     C                   Clear                   TOTCPOI
     C                   If        Ligne >= 57                                       C                   Clear                   Ligne
     C                   Endif                                                       C     CODCLI        Chain     TafcliP1
     *==* récup couleur JO                                                          C                   Exsr      Couleur
                                                                                     C                   Exsr      Entet
     C                   Add       3             Ligne                               C                   Write     ENTCLI
     C                   Endif                                                       C                   Z-add     D5clst        Code_clis
     C                   Z-add     D5nucd        £Numcde
     C                   Eval      Unefois2 = '*'                                    ** récup des commentaires livraison
     C                   Exsr      RecupCom                                          C                   Endif
                                                                                     C                   Z-add     D5code        Artcli
     C                   MoveL     D5lib         Lartcli                             ** recherche bonne paletisation pour article (ex : 0644)
     C     D5code        Chain     TafartP1                                          C                   Clear                   Paletisat1        4
     C                   Clear                   Paletisat2        4 0               C                   Clear                   Ptable
     C                   Clear                   Pident                              C                   Move      'APL'         Ptable
     C                   MoveL     D5code        Pident                              C     Kpar          Chain     Param                              32
     C                   If        *In32 = *Off                                      C                   Eval      Paletisat1 = %Subst(Ptout:1:4)
     C                   Move      Paletisat1    Paletisat2                          C                   If        Cpalet <> Paletisat2
     C                   Eval      Caicli = D5cais * Paletisat2                      C                   Else
     C                   Z-add     D5cais        Caicli                              C                   Endif
     C                   Else                                                        C                   Z-add     D5cais        Caicli
     C                   Endif
     C                   Z-add(h)  D5poid        Poicli                              C                   Add       Caicli        TOTCCAI
     C                   Add(h)    D5poid        TOTCPOI                             C                   Add       Caicli        TOTGCCAI
     C                   Add(h)    D5poid        TOTGCPOI                            *== mise à jour des contenances
     C                   Z-add     D5code        Cart                                C                   Exsr      MiseAjour
                                                                                     C                   If        Numpage = *Zeros
     C                   Eval      Format = 'C2'                                     C                   Else
     C                   Eval      Format = 'DD'                                     C                   Endif
     C                   If        Ligne >= 58                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
                                                                                     C                   Add       1             Ligne
     C                   Write     CLIENTSB
     C                   If        Numpage = *Zeros                                  C                   Eval      Format = 'C2'
     C                   Else                                                        C                   Eval      Format = 'CD'
     C                   Endif                                                       C                   Eval      EcritOK = '*'
                                                                                     C     Suiv003       Tag
     C     K12           Reade     Coll11L12                              32         C                   Enddo
                                                                                     C                   Clear                   Unefois2
     C     Suiv03        Tag                                                         C     D9livr        Reade     Coll03L4                               31
     C                   Enddo                                                       *====== écriture total dernier client
     C                   If        TOTCcai <> *Zeros Or TOTCPOI <> *Zeros            C                   If        Ligne >= 64
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     Totcli                                            C                   Endif
     C                   Clear                   TOTCCAI                             C                   Clear                   TOTCPOI
     *====== écriture total général                                                 C                   If        TOTGCCAI <> *Zeros
     C                   Exsr      Entet                                             C                   Add       3             Ligne
     C                   Write     TOTGCLI                                           C                   Endif
                                                                                     C                   Clear                   Cod_Cli
     C                   Clear                   ARTCLI                              C                   Clear                   CONT2
     C                   Clear                   CONT3                               C                   Clear                   CONT4
     C                   Clear                   LARTCLI                             C                   Clear                   CAICLI
     C                   Clear                   POICLI                              C                   Clear                   TOTCCAI
     C                   Clear                   TOTCPOI                             C                   Clear                   Cod_art
     C                   Clear                   Ecritent2                           C                   Clear                   Ecritent3
                                                                                     C                   Exsr      ClearZon
                                                                                     *==**==**               édition des prix unitaires consigne *=**
     C                   Eval      Unefois = '*'                                     C                   Eval      Format = 'DE'
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     Entdec
                                                                                     C                   Z-add     1             A
     C     A             Do        20                                                C                   If        TB1(A) <> *Zeros
     C                   Movea     TB1(A)        DCONS0                              C                   Movea     TB1B(A)       DCONS1
     C                   Movea     TB2(A)        DCONS2                              C                   Movea     TB3(A)        DCONS3
     C                   Movea     TB4(A)        DCONS4                              C                   Movea     TB5(A)        DCONS5
     C                   If        Ligne >= 58                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     Decons
     C                   Add       1             A                                   C                   Endif
     C                   Enddo                                                       *==**==**           fin édition des prix unitaires consigne *=**
                                                                                     C                   Exsr      ClearZon
                                                                                     *==**==**  ajout de ligne blanche pour que le vrac chauffeur se retrouve s
     *==**==**  recto de la prochaine page                                          C                   Z-add     1             Ind
     *********          ajout 1 à Numpage car il y a un décalage de -1 dans Num     *********          (on est à la 11ième page et Numpage contient 10)
     C                   Add       1             Numpage                             *== lecture tableau chiffres pairs
     C     Numpage       LOOKUP    Tchp(Ind)                              80         C                   If        *In80 = *On
     C                   Goto      SautPag
     C                   Else                                                        *== lecture tableau chiffres impairs
     C     Numpage       LOOKUP    Tchi(Ind)                              80         C                   If        *In80 = *On
     C     Numpage       Add       1             £numpag           2 0               C                   Endif
     C                   Endif
     *== écriture de ligne blanche                                                  C     Retpage       Tag
     C                   If        Numpage < £Numpag                                 C                   If        Numpage > 50
     C                   Leave                                                       C                   Endif
     C                   Eval      VracOK = 'LB'                                     C                   Eval      Format = 'CL'
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     LIGNBLAN                                          C                   Goto      Retpage
     C                   Endif                                                       C     Sautpag       Tag
                                                                                     C                   Clear                   £numpag
     C                   Clear                   Ind
     C                   Clear                   Ligne                               C                   Write     Pied
     C                   Clear                   PiedOK                              *==**==**  si le chauffeur n'a pas de VRAC, on va à l'édition
     *==**==**  sans éditer le vrac chauffeur                                       C                   Move      '*'           PasVrac           1
     C     D9livr        Chain     Coll11L12                          32             C                   Dow       *In32 = *Off
     C     D5code        Chain     TafartP1                                          C                   If        D5aff2 <> 11 And D5sta1 <> 'P' And
     C                             D5stour2 <> 'PH' And D5stour2 <> 'PU'             C                             Or D5stour2 = 'AL'
     C                             Or  Geojup >= '9001' And Geotaf >= '9001'         C                   Clear                   PasVrac
     C                   Endif                                                       C     D9livr        Reade     Coll11L12                              32
     C                   Enddo                                                       C                   If        PasVrac <> *Blanks
     C                   Goto      Suit_edi                                          C                   Endif
*                                                                                    C                   Move      '*'           Ecritlib
     C                   Clear                   SIvrac
     *==**==**               édition du VRAC chauffeur     **==**==**               C     D9livr        Chain     FiclivP1                           52
     C                   If        *In52 = *Off                                      C     Kpre          Chain     PrepaP1
     C                   MoveL     CODEDI        Lettre                              C                   If        Lettre = 'B'
     C                   Goto      Deuxieme                                          C                   Endif
     C                   Endif
     C                   Exsr      ClearZon                                          C                   Eval      Lettre = 'A'
     C                   Eval      Libedi = 'Quai / Sol'                             C                   Clear                   FutOK
                                                                                     C     Relecture     Tag
     *==**==**               lecture détail commandes      **==**==**               C     KL11LLL       Setll     Coll11LO
     C     zD9livr       Reade     Coll11LO                               31         C                   Dow       *In31 = *Off
                                                                                     C                   If        D5code <> CodeART
     C                   Z-add     D5code        CodeART                             C     KL11LB        Chain     Coll11LB                           87
     C                   Dow       *In87 = *Off                                      C     zD5code       Chain     TafartP1
                                                                                     C                   Setoff                                       86
     *================ début des contrôles                                          *==                si même livreur
     C                   If        zD5livr = zD9livr                                 *==*               pas la consigne ni déconsigne, ni consigne
     C                   If        zD5cc = 15 Or zD5cc = 16 Or zD5cc = 18            C                   Goto      Suivra1
     C                   Endif                                                       *==*               pas les clients sur palettes
     C                   If        zD5aff2 = 11                                      C                   Goto      Suivra1
     C                   Endif                                                       *==*               pas les articles non préparés par le chauffeur
     C                   If        zD5sta1 <> 'C'                                    C                   Goto      Suivra1
     C                   Endif                                                       *==*               si lot non préparé à part
     C                   If        zCodlot <> *Blanks                                C                   Goto      Suivra1
     C                   Endif                                                       *==*               si article palettes, fûts...on passe
     *==*               sauf si article fût préparé par le chauffeur, dans ce c     C                   MoveL     zCODPRE       CodePre
     C                   If        zD5stour2 <> *Blanks And zD5stour2 <> 'FU'        C                             And zD5stour2 <> 'AL' And
     C                             zD5stour2 <> 'VI' And zD5stour2 <> 'PU'           C                             Or zD5stour2 = 'FU' And CodePre <> zD5livr
     C                             Or Geojup >= '9001' And Geotaf >= '9001'          C                   Goto      Suivra1
     C                   Endif                                                       *==*               si non publicité
     C                   If        zD5catart = 9 And zD5aaav = *Zeros                C                   Goto      Suivra1
     C                   Endif                                                       *==*               si ligne ristourne
     C                   If        zD5aafa = 99                                      C                   Goto      Suivra1
     C                   Endif                                                       *================ fin des contrôles
     C                   Eval      VracOK = 'CH'
     *================* à chaque changement d'article                               C                   If        zD5code <> Cod_art And cod_art <> *Zeros
     C                   Move      Adr_art       AdreA                               C                   Z-add     Cod_art       Cart
     *==* mise à jour zones contenance                                              C                   Exsr      MiseAjour
     C                   MoveL     Libsup        Lart                                *==* ajoute une étoile si article avec consigne
     C                   Clear                   Consig                              C                   If        C2CONSEUR <> *Zeros
     C                   Eval      Consig = '*'                                      C                   Endif
     *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)     C                   If        Unefois = *Blanks
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Seton                                        7271           C                   Setoff                                       737475
     C                   Setoff                                       70             C                   Add       1             Ligne
     C                   Write     LignNoir                                          C                   Eval      Unefois3 = '*'
                                                                                     C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             * édition pour le libellé du vrac (vrac chauffeur, lot, fût...)
     C                   If        Ecritent3 = *Blanks                               C                   Exsr      EntVrac
     C                   Endif
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     * édition pour le vrac de l'entête produit 'adr., code, cont., désignation     C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
     C                   Eval      Unefois = '*'                                     C                   Endif
                                                                                     C                   Add       Qtebor        Totcoli
     C                   Add       Qtebor        Totgen                              *==* écriture du détail
     C                   Exsr      AdreLet
     C                   If        FutOK = *Blanks                                   C                   If        C2tco = 'FUT' Or C2tco = 'TUB'
     C                   Add       1             Ligne                               C                   Write     LignBlan
     C                   Eval      FutOK = '*'                                       C                   Endif
     C                   Endif
     C                   If        Ligne >= 59                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     Detail
     C                   Clear                   Qtebor                              C                   Endif
     *===============================================*                              C                   Add       zD5cais       Qtebor
     C                   Z-add     zD5code       Cod_art                             C                   Move      zCodpic       Adr_art
     C                   Endif
     C     Suivra1       Tag                                                         C     KL11LB        Reade     Coll11LB                               87
     C                   Enddo                                                       C                   Endif
                                                                                     C     zD9livr       Reade     Coll11LO                               31
     C                   Enddo                                                        *=============== dernier enregistrement  ============================
     C                   If        Qtebor <> *Zeros                                  *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)
     C                   If        Unefois = *Blanks                                 C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Seton                                        7271
     C                   Setoff                                       737475         C                   Setoff                                       70
     C                   Add       1             Ligne                               C                   Write     LignNoir
     C                   Eval      Unefois3 = '*'
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent3 = *Blanks                               C                   Exsr      EntVrac
     C                   Endif
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent2 = *Blanks                               C                   Exsr      EntArt
     C                   Endif                                                       C                   Endif
     *==* écriture du détail                                                        C                   Move      Adr_art       AdreA
     C                   Z-add     Cod_art       Cart                                *==* mise à jour zones contenance
     C                   Exsr      MiseAjour                                         C                   MoveL     Libsup        Lart
     C                   Add       Qtebor        Totcoli                             C                   Add       Qtebor        Totgen
     *==* ajoute une étoile si article avec consigne                                C                   Clear                   Consig
     C                   If        C2CONSEUR <> *Zeros                               C                   Eval      Consig = '*'
     C                   Endif
     C                   Exsr      AdreLet
     C                   If        FutOK = *Blanks                                   C                   If        C2tco = 'FUT' Or C2tco = 'TUB'
     C                   Add       1             Ligne                               C                   Write     LignBlan
     C                   Eval      FutOK = '*'                                       C                   Endif
     C                   Endif                                                       C                   Eval      SIvrac = '*'
                                                                                     C                   If        Ligne >= 58
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     Detail                                            *==* total colis
     C                   If        Ligne >= 58                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     TotalColi
     C                   Endif                                                       *==**==**           fin édition du VRAC chauffeur     **==**==**
                                                                                     C                   Exsr      ClearZon
                                                                                     *==**==**               édition des lots (sauf alcool)**==**==**
     *==**==**               lots non préparés à part      **==**==**               ****** lecture du tableau des numéros de lot
     C                   Z-add     1             Ilot                                C     LectLot       Tag
     C                   Movea     Tlot(Ilot)    £lot                                C                   If        £lot = *Blanks
     C                   Goto      Finlot                                            C                   Endif
                                                                                     ****** accès au produit lot
     C     K11LN         Chain     Coll11LN                           31             C                   Dow       *In31 = *Off
                                                                                     C                   If        D5code <> CodeART
     C                   Z-add     D5code        CodeART                             C     KL11LB        Chain     Coll11LB                           87
     C                   Dow       *In87 = *Off
     C                   Setoff                                       86             *================ début des contrôles
     *==                si même livreur                                             C                   If        zD5livr = zD9livr
     *==*               pas la consigne ni déconsigne, ni consigne                  C                   If        zD5cc = 15 Or zD5cc = 16 Or zD5cc = 18
     C                   Goto      Suivra2                                           C                   Endif
     *==*               pas les clients sur palettes                                C                   If        zD5aff2 = 11
     C                   Goto      Suivra2                                           C                   Endif
     *==*               pas les articles non préparés par le chauffeur              C                   If        zD5sta1 <> 'C'
     C                   Goto      Suivra2                                           C                   Endif
     *==*               si non lot                                                  C                   If        zCodlot   = *Blanks
     C                   Goto      Suivra2                                           C                   Endif
     *==*               si lot alcool                                               C                   If        zCodlot   = 'Z'
     C                   Goto      Suivra2                                           C                   Endif
     *==*               si lot préparé à part                                       C                   If        zD5aaav  <> *Zeros
     C                   Goto      Suivra2                                           C                   Endif
     *==*               si articles divers                                          C                   If        zD5catart = 8
     C**                 Goto      Suivra2                                           C                   Endif
     *==*               si non publicité                                            C                   If        zD5catart = 9
     C**                 Goto      Suivra2                                           C                   Endif
     *==*               si ligne ristourne                                          C                   If        zD5aafa = 99
     C                   Goto      Suivra2                                           C                   Endif
     *================ fin des contrôles                                            C                   Eval      VracOK = 'LO'
     C                   Eval      Format = 'VR'
     *==*               à chaque changement de lot ou d'article                     C                   If        zCodlot <> Cod_lot And zD5code <> Cod_art
     C                             And Cod_art <> *Zeros                             C                             Or zCodlot = Cod_lot And zD5code <> Cod_art
     *==* pour écriture du nom du lot                                               C                   If        zCodlot <> Cod_lot
     C                   Clear                   Ecritent3                           C                   Endif
      ***======== la première fois, on édite le titre du lot                         C                   If        Unefois = *Blanks
     C                   Eval      Unefois = '*'                                     *==* écriture du titre du lot
     C                   Seton                                        7071           C                   Setoff                                       7273
     C                   Setoff                                       7475           C                   Move      Cod_lot       £Codlot
     C                   Exsr      Recup                                             C                   If        Unefois3 = *Blanks
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     LignNoir
     C                   Eval      Unefois3 = '*'                                    C                   Endif
                                                                                     C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent3 = *Blanks
     C                   Exsr      EntVrac                                           C                   Endif
                                                                                     C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
     C                   Endif                                                       C                   Endif
                                                                                     *==*               à chaque changement d'article
     C                   If        zD5code <> Cod_art And cod_art <> *Zeros          C                   Move      Adr_art       AdreA
     C                   Z-add     Cod_art       Cart                                *==* mise à jour zones contenance
     C                   Exsr      MiseAjour                                         C                   MoveL     Libsup        Lart
     C                   Add       Qtebor        Totcoli                             C                   Add       Qtebor        Totgen
     C                   Exsr      AdreLet                                           *==* ajoute une étoile si article avec consigne
     C                   Clear                   Consig                              C                   If        C2CONSEUR <> *Zeros
     C                   Eval      Consig = '*'                                      C                   Endif
     *==* écriture du détail                                                        C                   If        Ligne >= 65
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     Detail                                            *==* total colis
     C                   If        zCodlot <> Cod_lot                                C                   If        Totcoli <> *Zeros
     C                   Eval      EcritTot = '*'                                    C                   If        Ligne >= 65
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     TotalColi                                         C                   Endif
     C                   Clear                   Totcoli                             *==* écriture du titre du lot
     C                   Seton                                        7071           C                   Setoff                                       7273
     C                   Setoff                                       7475           C                   Move      zCodlot       £Codlot
     C                   Exsr      Recup                                             C                   If        Unefois3 = *Blanks
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     LignNoir
     C                   Eval      Unefois3 = '*'                                    C                   Endif
                                                                                     C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent3 = *Blanks
     C                   Exsr      EntVrac                                           C                   Endif
                                                                                     C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
     C                   Endif                                                       C                   Clear                   Qtebor
     C                   Endif
     C                   Add       zD5cais       Qtebor                              C                   Z-add     zD5code       Cod_art
     C                   Move      zCodpic       Adr_art                             C                   Move      zCodlot       Cod_lot
     C                   Endif
     C     Suivra2       Tag                                                         C     KL11LB        Reade     Coll11LB                               87
     C                   Enddo                                                       C                   Endif
                                                                                     C     K11LN         Reade     Coll11LN                               31
     C                   Enddo                                                        *=============== dernier enregistrement  ============================
     C                   If        Qtebor <> *Zeros                                  *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)
     C                   If        £Codlot <> Cod_lot                                C                             or Unefois = *Blanks
     C                   Move      Cod_lot       £Codlot                             C                   If        Codlot <> Cod_lot
     C                   If        Totcoli <> *Zeros And Ecrittot = *Blanks          C                   Clear                   EcritTot
     C                   If        Ligne >= 65                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     TotalColi
     C                   Endif                                                       C                   Clear                   Totcoli
     C                   Endif
     C                   If        Unefois3 = *Blanks                                C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     LignNoir                                          C                   Eval      Unefois3 = '*'
     C                   Endif
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent3 = *Blanks                               C                   Seton                                        7071
     C                   Setoff                                       7273           C                   Setoff                                       7475
     C                   Exsr      Recup                                             C                   Exsr      EntVrac
     C                   Endif                                                       C                   Eval      Unefois = '*'
     C                   Endif                                                       *==* écriture du détail
     C                   Move      Adr_art       AdreA                               C                   Z-add     Cod_art       Cart
     *==* mise à jour zones contenance                                              C                   Exsr      MiseAjour
     C                   MoveL     Libsup        Lart                                C                   Add       Qtebor        Totcoli
     C                   Add       Qtebor        Totgen                              *==* ajoute une étoile si article avec consigne
     C                   Clear                   Consig                              C                   If        C2CONSEUR <> *Zeros
     C                   Eval      Consig = '*'                                      C                   Endif
     C                   Eval      SIvrac = '*'
     C                   Exsr      AdreLet                                           C                   If        Ligne >= 58
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     Detail                                            *==* total colis
     C                   If        Ligne >= 58                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     TotalColi
     C                   Endif                                                       *==**==**           fin édition des lots (sauf alcool)**==**==**
     *==**==**               lots non préparés à part      **==**==**
     C                   Exsr      Clearzon
     *==**==**               édition des lots (sauf alcool)**==**==**               *==**==**               lots préparés à part          **==**==**
     C                   Clear                   £Codcli                             C                   Clear                   Codcli
                                                                                     C     K11LN         Chain     Coll11LU                           31
     C                   Dow       *In31 = *Off
     C                   If        D5code <> CodeART                                 C                   Z-add     D5code        CodeART
     C     KL11LT        Chain     Coll11LT                           87             C                   Dow       *In87 = *Off
                                                                                     C                   Setoff                                       86
     *================ début des contrôles                                          *==                si même livreur
     C                   If        zD5livr = zD9livr                                 *==*               pas la consigne ni déconsigne, ni consigne
     C                   If        zD5cc = 15 Or zD5cc = 16 Or zD5cc = 18            C                   Goto      Suivra22
     C                   Endif                                                       *==*               pas les clients sur palettes
     C                   If        zD5aff2 = 11                                      C                   Goto      Suivra22
     C                   Endif                                                       *==*               pas les articles non préparés par le chauffeur
     C                   If        zD5sta1 <> 'C'                                    C                   Goto      Suivra22
     C                   Endif                                                       *==*               si non lot
     C                   If        zCodlot   = *Blanks                               C                   Goto      Suivra22
     C                   Endif                                                       *==*               si lot alcool
     C                   If        zCodlot   = 'Z'                                   C                   Goto      Suivra22
     C                   Endif                                                       *==*               si lot non préparé à part
     C                   If        zD5aaav  = *Zeros                                 C                   Goto      Suivra22
     C                   Endif                                                       *==*               si articles divers
     C                   If        zD5catart = 8                                     C**                 Goto      Suivra22
     C                   Endif                                                       *==*               si non publicité
     C                   If        zD5catart = 9                                     C**                 Goto      Suivra22
     C                   Endif                                                       *==*               si ligne ristourne
     C                   If        zD5aafa = 99                                      C                   Goto      Suivra22
     C                   Endif                                                       *================ fin des contrôles
     C                   Eval      VracOK = 'LO'                                     C                   Eval      Format = 'VR'
                                                                                     *==*               à chaque changement de lot ou d'article
     *==*               ou de client                                                C                   If        zCodlot <> Cod_lot And zD5code <> Cod_art
     C                             And Cod_art <> *Zeros                             C                             Or zCodlot = Cod_lot And zD5code <> Cod_art
     C                             Or zCodlot = Cod_lot And zD5code = Cod_art        C                             And zD5cli <> £Codcli And £Codcli <> *Zeros
     *==* pour écriture du nom du lot                                               C                   If        zCodlot <> Cod_lot
     C                   Clear                   Ecritent3                           C                   Endif
      ***======== la première fois, on édite le titre du lot                         C                   If        Unefois = *Blanks
     C                   Eval      Unefois = '*'                                     *==* écriture du titre du lot
     C                   Seton                                        7071           C                   Setoff                                       7273
     C                   Setoff                                       7475           C                   Move      Cod_lot       £Codlot
     C                   Exsr      Recup                                             C                   If        Unefois3 = *Blanks
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     LignNoir
     C                   Eval      Unefois3 = '*'                                    C                   Endif
                                                                                     C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent3 = *Blanks
     C                   Exsr      EntVrac                                           C                   Endif
                                                                                     C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
     C                   Endif
     *==* écriture du nom client                                                    C                   If        £Codcli <> Codcli
     C                   Z-add     £Codcli       Codcli                              C                   Exsr      Entet
     C     CODCLI        Chain     TafcliP1                                          *==* récup couleur JO
     C                   Exsr      Couleur
     C                   Clear                   ENSEIG                              C                   MoveL     Ensliv        ENSEIG
     C                   Add       2             Ligne                               C                   Write     EntcliD
     C                   Endif                                                       C                   Endif
                                                                                     *==*               à chaque changement d'article
     *==*               ou de client                                                C                   If        zD5code <> Cod_art And cod_art <> *Zeros
     C                             Or zD5code = Cod_art And zD5cli <> £Codcli        C                             And £Codcli <> *Zeros
     C                   Move      Adr_art       AdreA                               C                   Z-add     Cod_art       Cart
     *==* mise à jour zones contenance                                              C                   Exsr      MiseAjour
     C                   MoveL     Libsup        Lart                                C                   Add       Qtebor        Totcoli
     C                   Add       Qtebor        Totgen                              C                   Exsr      AdreLet
     *==* ajoute une étoile si article avec consigne                                C                   Clear                   Consig
     C                   If        C2CONSEUR <> *Zeros                               C                   Eval      Consig = '*'
     C                   Endif                                                       *==* écriture du détail
     C                   If        Ligne >= 65                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     Detail
     *==* total colis                                                               C                   If        zD5cli  <> £codcli
     C                   If        Totcoli <> *Zeros                                 C                   Eval      EcritTot = '*'
     C                   If        Ligne >= 65                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     TotalColi
     C                   Endif                                                       C                   Clear                   Totcoli
     *==* écriture du titre du lot                                                  C                   Seton                                        7071
     C                   Setoff                                       7273           C                   Setoff                                       7475
     C                   Move      zCodlot       £Codlot                             C                   Exsr      Recup
     C                   If        Unefois3 = *Blanks                                C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     LignNoir                                          C                   Eval      Unefois3 = '*'
     C                   Endif
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent3 = *Blanks                               C                   Exsr      EntVrac
     C                   Endif
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent2 = *Blanks                               C                   Exsr      EntArt
     C                   Endif                                                       C                   Endif
     C                   Clear                   Qtebor                              C                   Endif
                                                                                     C                   Z-add     zD5cli        £Codcli           7 0
     C                   Add       zD5cais       Qtebor                              C                   Z-add     zD5code       Cod_art
     C                   Move      zCodpic       Adr_art                             C                   Move      zCodlot       Cod_lot
     C                   Endif
     C     Suivra22      Tag                                                         C     KL11LT        Reade     Coll11LT                               87
     C                   Enddo                                                       C                   Endif
                                                                                     C     K11LN         Reade     Coll11LU                               31
     C                   Enddo                                                        *=============== dernier enregistrement  ============================
     C                   If        Qtebor <> *Zeros                                  *==* écriture de la ligne de séparation
     C                   If        £Codlot <> Cod_lot                                C                             or Unefois = *Blanks
     C                   Move      Cod_lot       £Codlot                             C                   If        zD5cli  <> £codcli
     C                   If        Totcoli <> *Zeros And Ecrittot = *Blanks          C                   Clear                   EcritTot
     C                   If        Ligne >= 65                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     TotalColi
     C                   Endif                                                       C                   Clear                   Totcoli
     C                   Endif
     C                   If        Unefois3 = *Blanks                                C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     LignNoir                                          C                   Eval      Unefois3 = '*'
     C                   Endif
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent3 = *Blanks                               C                   Seton                                        7071
     C                   Setoff                                       7273           C                   Setoff                                       7475
     C                   Exsr      Recup                                             C                   Exsr      EntVrac
     C                   Endif                                                       C                   Eval      Unefois = '*'
     C                   Endif
     *==* écriture du nom client                                                    C                   If        £Codcli <> Codcli
     C                   Z-add     £Codcli       Codcli                              C                   Exsr      Entet
     C     CODCLI        Chain     TafcliP1                                          *==* récup couleur JO
     C                   Exsr      Couleur
     C                   Clear                   ENSEIG                              C                   MoveL     Ensliv        ENSEIG
     C                   Add       2             Ligne                               C                   Write     EntcliD
     C                   Endif
     *==* écriture du détail                                                        C                   Move      Adr_art       AdreA
     C                   Z-add     Cod_art       Cart                                *==* mise à jour zones contenance
     C                   Exsr      MiseAjour                                         C                   MoveL     Libsup        Lart
     C                   Add       Qtebor        Totcoli                             C                   Add       Qtebor        Totgen
     *==* ajoute une étoile si article avec consigne                                C                   Clear                   Consig
     C                   If        C2CONSEUR <> *Zeros                               C                   Eval      Consig = '*'
     C                   Endif                                                       C                   Eval      SIvrac = '*'
                                                                                     C                   Exsr      AdreLet
     C                   If        Ligne >= 58                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     Detail
     *==* total colis                                                               C                   If        Ligne >= 58
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     TotalColi                                         C                   Endif
     *==**==**           fin édition des lots (sauf alcool)**==**==**               *==**==**               lots préparés à part          **==**==**
                                                                                     *== incrémentation tableau des lots
     C                   Add       1             Ilot                                C                   Exsr      Clearzon
     C                   Goto      LectLot                                           C     Finlot        Tag
                                                                                     C                   Exsr      ClearZon
                                                                                     *==**==**               CLIENTS PREPARES              **==**==**
                                                                                     ************* on édite maintenant la pub en global, demande de J.Martin
     ************* ni le nombre de bouteilles d'alcools pour les clients prépar     ************* ni les fûts des client préparés, ni les palettes
    C                   Clear                   ONpasse           1                C                   If        ONpasse <> *Blanks
     *==**==**               édition de la publicité       **==**==**               C     zD9livr       Chain     Coll11L11                          31
     C                   Clear                   Cod_art                             C                   Clear                   Adr_art
     C                   Clear                   Code_clis                           C                   Clear                   Codeclis
     C                   Dow       *In31 = *Off
     C                   If        D5clst <> Codeclis                                C                   Z-add     D5clst        Codeclis
     C     K11Lb         Chain     Coll11L14                          87             C                   Dow       *In87 = *Off
                                                                                     C                   Setoff                                       86
     *================ début des contrôles                                          *==                si même livreur
     C                   If        zD5livr = zD9livr                                 *==*               on passe si clients non sur palettes
     C                   If        zD5aff2 <> 11                                     C                   Goto      Suivra5
     C                   Endif                                                       *==*               si lot
     C                   If        zCodlot   <> *Blanks                              C                   Goto      Suivra5
     C                   Endif                                                       *==*               si non publicité
     C                   If        zD5catart <> 9                                    C                   Goto      Suivra5
     C                   Endif                                                       *================ fin des contrôles
     C                   Eval      VracOK = 'PU'
     *==*               que les articles publicité                                  C                   If        zD5stour2 = 'PU'
     *================* à chaque changement d'article ou de client                  C                   If        zD5code <> Cod_art And cod_art <> *Zeros
     C                             Or                                                C                             zD5clst <> Code_clis And code_clis <> *Zeros
     C                   If        zD5clst <> Code_clis                              C                   Clear                   Code_clis
     C                   Endif                                                       C                   Move      Adr_art       AdreA
     C                   Z-add     Cod_art       Cart                                *==* mise à jour zones contenance
     C                   Exsr      MiseAjour                                         C                   MoveL     Libsup        Lart
                                                                                     *==* écriture de la ligne de séparation (déjà préparé - à charger)
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        EcritVOK = *Blanks                                C                   Exsr      LigneVrac
     C                   Endif                                                       *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)
     C                   If        Unefois = *Blanks                                 C                   If        Ligne >= 56
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent3 = *Blanks
     C                   Seton                                        7571           C                   Setoff                                       727473
     C                   Setoff                                       70             C                   Exsr      EntVrac
     C                   Endif
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent2 = *Blanks                               C                   Exsr      EntArt
     C                   Endif
     C                   If        Ecritent4 = *Blanks                               C                   Exsr      Alimcli
     C                   Eval      Ecritent4 = '*'                                   C                   Endif
     C                   Eval      Unefois = '*'                                     C                   Endif
                                                                                     C                   Z-add     zD5cli        Code_cli
     C                   Add       Qtebor        Totcoli                             C                   Add       Qtebor        Totgen
     *==* écriture du détail                                                        C                   Exsr      AdreLet
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     Detail2
     C                   Clear                   Qtebor
     *==* ===** à chaque changement de client                                       C                   If        zD5clst <> Code_clis
     C                   Clear                   Unefois                             C                   Clear                   Ecritent4
     *==* total colis                                                               C                   If        Ligne >= 56
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     TotalC3                                           C                   Clear                   TOTCOLI
                                                                                     C                   Z-add     zD5clst       Code_clis
     C                   Endif                                                       C                   Endif
     *===============================================*                              C                   Z-add     zD5cli        Code_cli
     C                   Add       zD5cais       Qtebor                              C                   Z-add     zD5code       Cod_art
     C                   Move      zCodpic       Adr_art                             C                   Endif
     C                   Endif
     C     Suivra5       Tag                                                         C     K11Lb         Reade     Coll11L14                              87
                                                                                     C                   If        D5clst = Code_clis And
     C                             D5nucd <> £Numcde                                 C                   Clear                   Unefois2
     C                   Endif
     C                   Enddo                                                       C                   Endif
                                                                                     C     zD9livr       Reade     Coll11L11                              31
     C                   Enddo                                                        *=============== dernier enregistrement  ============================
     C                   If        Qtebor <> *Zeros                                  *==* écriture de la ligne de séparation (déjà préparé - à charger)
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        EcritVOK = *Blanks                                C                   Exsr      LigneVrac
     C                   Endif                                                       *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)
     C                   If        Unefois = *Blanks                                 C                   If        Ligne >= 56
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent3 = *Blanks
     C                   Seton                                        7571           C                   Setoff                                       727374
     C                   Setoff                                       70             C                   Exsr      EntVrac
     C                   Endif
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent2 = *Blanks                               C                   Exsr      EntArt
     C                   Endif                                                       C                   If        Ecritent4 = *Blanks
     C                   Exsr      Alimcli                                           C                   Endif
     C                   Endif                                                       *==* écriture du détail
     C                   Move      Adr_art       AdreA                               C                   Z-add     Cod_art       Cart
     *==* mise à jour zones contenance                                              C                   Exsr      MiseAjour
     C                   MoveL     Libsup        Lart                                C                   Add       Qtebor        Totcoli
     C                   Add       Qtebor        Totgen
     C                   Exsr      AdreLet                                           C                   If        Ligne >= 56
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     Detail2                                           *==* total colis
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     TotalC3
     C                   Endif                                                       *==**==**           fin édition de la publicité       **==**==**
     C                   Clear                   Totgen
     C                   Exsr      ClearZon
     *==**==**           nombre de bouteilles alcools      **==**==**               C     zD9livr       Chain     Coll11L11                          31
     C                   Clear                   CPALC                               C                   Dow       *In31 = *Off
     C                   If        D5aff2 = 11 And D5stour2 = 'AL'                   C                   Add       D5cais        CPALC
     C                   Endif                                                       C     zD9livr       Reade     Coll11L11                              31
     C                   Enddo                                                       C                   If        CPALC <> *Zeros
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       3             Ligne                               C                   Write     ALCOOL
     C                   Endif                                                       *==**==**       fin nombre de bouteilles alcools      **==**==**
     C                   Clear                   Totgen
     C                   Exsr      ClearZon                                          C                   Clear                   EcritVOK
                                                                                     *==**==**               édition des fûts              **==**==**
     C     zD9livr       Chain     Coll11L11                          31             C                   Clear                   Cod_art
     C                   Clear                   Adr_art                             C                   Clear                   Code_clis
     C                   Clear                   Codeclis                            C                   Dow       *In31 = *Off
                                                                                     C                   If        D5clst <> Codeclis
     C                   Z-add     D5clst        Codeclis                            C     K11Lb         Chain     Coll11L14                          87
     C                   Dow       *In87 = *Off
     C                   Setoff                                       86             *================ début des contrôles
     *==                si même livreur                                             C                   If        zD5livr = zD9livr
     *==*               on passe si ligne non facturation                           C                   If        zD5cc <> 11
     C                   Goto      Suivra3                                           C                   Endif
     *==*               pas les articles préparés par le chauffeur                  C                   MoveL     zCodpre       CodePre
     C                   If        zD5sta1 = 'C' And CodePre = zD5livr               C                   Goto      Suivra3
     C                   Endif                                                       *==*               si lot
     C                   If        zCodlot   <> *Blanks                              C                   Goto      Suivra3
     C                   Endif                                                       *==*               si articles divers
     C                   If        zD5catart = 8 And zD5stour2 <> 'FU'               C                   Goto      Suivra3
     C                   Endif                                                       *================ fin des contrôles
     C                   Eval      VracOK = 'FU'                                     C                   Clear                   Format
     C                   Seton                                        85
     *==*               que les articles fûts                                       C                   If        zD5stour2 = 'FU'
     *================* à chaque changement d'article ou de client                  C                   If        zD5code <> Cod_art And cod_art <> *Zeros
     C                             Or                                                C                             zD5clst <> Code_clis And code_clis <> *Zeros
     C                   If        zD5clst <> Code_clis                              C                   Clear                   Code_clis
     C                   Endif                                                       C                   Move      Adr_art       AdreA
     C                   Z-add     Cod_art       Cart                                *==* mise à jour zones contenance
     C                   Exsr      MiseAjour                                         C                   MoveL     Libsup        Lart
                                                                                     *==* écriture de la ligne de séparation (déjà préparé - à charger)
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        EcritVOK = *Blanks                                C                   Exsr      LigneVrac2
     C                   Endif                                                       *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
                                                                                     C                   If        Unefois = *Blanks
     * édition libellé 'Déjà préparé - A charger'                                   C                   Seton                                        7471
     C                   Setoff                                       727375         C                   Setoff                                       70
     C                   If        Ecritent3 = *Blanks                               C                   Exsr      EntVrac
     C                   Endif
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     * édition pour le vrac de l'entête produit 'adr., code, cont., désignation     C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
                                                                                     C                   If        Ecritent4 = *Blanks
     C                   Exsr      Alimcli                                           C                   Eval      Ecritent4 = '*'
     C                   Endif                                                       C                   Eval      Unefois = '*'
     C                   Endif
     C                   Z-add     zD5cli        Code_cli                            C                   Add       Qtebor        Totcoli
     C                   Add       Qtebor        Totgen                              *==* écriture du détail
     C                   Exsr      AdreLet                                           C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     Detail22                                          C                   Clear                   Qtebor
                                                                                     *==* ===** à chaque changement de client
     C                   If        zD5clst <> Code_clis                              C                   Clear                   Unefois
     C                   Clear                   Ecritent4                           *==* total colis
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     TotalC3
     C                   Clear                   TOTCOLI
     C                   Z-add     zD5clst       Code_clis                           C                   Endif
     C                   Endif                                                       *===============================================*
     C                   Z-add     zD5cli        Code_cli                            C                   Add       zD5cais       Qtebor
     C                   Z-add     zD5code       Cod_art                             C                   Move      zCodpic       Adr_art
     C                   Endif                                                       C                   Endif
                                                                                     C     Suivra3       Tag
     C     K11Lb         Reade     Coll11L14                              87         C                   Enddo
     C                   Endif
     C     zD9livr       Reade     Coll11L11                              31         C                   Enddo
      *=============== dernier enregistrement  ============================          C                   If        Qtebor <> *Zeros
     *==* écriture de la ligne de séparation (déjà préparé - à charger)             C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        EcritVOK = *Blanks
     C                   Exsr      LigneVrac2                                        C                   Endif
     *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)     C                   If        Unefois = *Blanks
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent3 = *Blanks                               C                   Seton                                        7471
     C                   Setoff                                       727375         C                   Setoff                                       70
     C                   Exsr      EntVrac                                           C                   Endif
                                                                                     C                   If        Ligne >= 56
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
                                                                                     C                   If        Ecritent4 = *Blanks
     C                   Exsr      Alimcli                                           C                   Endif
     C                   Eval      Unefois = '*'                                     C                   Endif
     *==* écriture du détail                                                        C                   Move      Adr_art       AdreA
     C                   Z-add     Cod_art       Cart                                *==* mise à jour zones contenance
     C                   Exsr      MiseAjour                                         C                   MoveL     Libsup        Lart
     C                   Add       Qtebor        Totcoli                             C                   Add       Qtebor        Totgen
                                                                                     C                   Exsr      AdreLet
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     Detail22
     *==* total colis                                                               C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     TotalC3                                           C                   Endif
     *==**==**           fin édition des fûts              **==**==**               C                   Clear                   Totgen
                                                                                     C                   Exsr      ClearZon
                                                                                     *==**==**               édition des palettes          **==**==**
     C     zD9livr       Chain     Coll11L11                          31             C                   Clear                   Cod_art
     C                   Clear                   Adr_art                             C                   Clear                   Code_clis
     C                   Clear                   Codeclis                            C                   Dow       *In31 = *Off
                                                                                     C                   If        D5clst <> Codeclis
     C                   Z-add     D5clst        Codeclis                            C     K11Lb         Chain     Coll11L14                          87
     C                   Dow       *In87 = *Off
     C                   Seton                                        86             *================ début des contrôles
     *==                si même livreur                                             C                   If        zD5livr = zD9livr
     *==*               on passe si clients non sur palettes                        C                   If        zD5aff2 <> 11
     C                   Goto      Suivra4                                           C                   Endif
     *==*               si lot                                                      C                   If        zCodlot <> *Blanks
     C                   Goto      Suivra4                                           C                   Endif
     *================ fin des contrôles                                            C                   Eval      VracOK = 'PA'
     C                   Eval      Format = 'VR'
     *==*               que les articles sur les palettes                           C                   If        zD5stour2 = 'PH'
     *================* à chaque changement d'article ou de client ============     *==== écritures des entêtes (la 1ière fois) puis de l'enregistrement =====
     C                   If        zD5code <> Cod_art And cod_art <> *Zeros          C                             Or
     C                             zD5clst <> Code_clis And code_clis <> *Zeros
     C                   If        zD5clst <> Code_clis                              C                   Clear                   Code_clis
     C                   Endif
     *==* écriture de la ligne de séparation (déjà préparé - à charger)             C                   If        Ligne >= 56
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        EcritVOK = *Blanks
     C                   Exsr      LigneVrac2                                        C                   Endif
     *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)     C                   If        Unefois = *Blanks
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent3 = *Blanks                               C                   Seton                                        7371
     C                   Setoff                                       727475         C                   Setoff                                       70
     C                   Exsr      EntVrac                                           C                   Endif
     * édition pour le vrac de l'entête produit 'adr., code, cont., désignation     C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
     * alimentation entête client                                                   C                   If        Ecritent4 = *Blanks
     C                   Exsr      Alimcli                                           C                   Eval      Ecritent4 = '*'
     C                   Endif
     C                   Eval      Unefois = '*'                                     C                   Endif
     C                   Z-add     zD5cli        Code_cli                            C                   Add       NBpal         Totcoli
     C                   Add       NBpal         Totgen                              *==* écriture du détail
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
                                                                                     C                   Move      Adr_art       AdreA
     C                   Z-add     Cod_art       Cart                                C                   Exsr      MiseAjour
     C                   MoveL     Libsup        Lart
     C                   Add       1             Ligne                              C                   Write     DetailPNB
     C                   Clear                   Qtebor                              C                   Clear                   NBpal
                                                                                     *==* ===** à chaque changement de client, écriture du total client
     C                   If        zD5clst <> Code_clis                              C                   Clear                   Unefois
     C                   Clear                   Ecritent4                           *==* total colis
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     TotalC3
     C                   Clear                   TOTCOLI
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Endif
     C                   Z-add     zD5clst       Code_clis                           C                   Endif
     *=========================================================================     C                   Clear                   Paletisat1
     C                   Clear                   Paletisat2                          C     zD5code       Chain     TafartP1
     C                   Add       zD5cais       Qtebor                              C                   Z-add     Qtebor        NBpal
     ** recherche bonne paletisation pour article (ex : 0644)                       C                   Clear                   Ptable
     C                   Clear                   Pident                              C                   Move      'APL'         Ptable
     C                   MoveL     zD5code       Pident                              C     Kpar          Chain     Param                              32
     C                   If        *In32 = *Off                                      C                   Eval      Paletisat1 = %Subst(Ptout:1:4)
     C                   Move      Paletisat1    Paletisat2                          C                   If        Cpalet <> Paletisat2
     C                   Z-add     Qtebor        NBpal                               C                   Else
     C                   Eval      NBpal = Qtebor / Paletisat2                       C                   Endif
     C                   Z-add     Paletisat2    Qtebor                              C                   Else
     C                   Eval      NBpal = Qtebor / Cpalet                           C                   Z-add     Cpalet        Qtebor
     C                   Endif
     C                   Z-add     zD5clst       Code_clis                           C                   Z-add     zD5cli        Code_cli
     C                   Z-add     zD5code       Cod_art                             C                   Move      zCodpic       Adr_art
     C                   Endif                                                       C                   Endif
                                                                                     C     Suivra4       Tag
     C     K11Lb         Reade     Coll11L14                              87         C                   Enddo
     C                   Endif
     C     zD9livr       Reade     COLL11L11                              31         C                   Enddo
      *=============== dernier enregistrement  ============================          C                   If        Qtebor <> *Zeros
    C                   Clear                   Ludo              1                C                   If        ludo <> ' '
     C                   Clear                   Paletisat1                          C                   Clear                   Paletisat2
     ** recherche bonne paletisation pour article (ex : 0644)                       C                   Clear                   Ptable
     C                   Clear                   Pident                              C                   Move      'APL'         Ptable
     C                   MoveL     Cod_art       Pident                              C     Kpar          Chain     Param                              32
     C                   If        *In32 = *Off                                      C                   Eval      Paletisat1 = %Subst(Ptout:1:4)
     C                   Move      Paletisat1    Paletisat2                          C                   If        Paletisat2 = 1
     C                   Z-add     Qtebor        NBpal                               C                   Else
     C                   Eval      NBpal = Qtebor / Paletisat2                       C                   Endif
     C                   Eval      Qtebor = Paletisat2                               C                   Else
     C                   Eval      NBpal = Qtebor / Cpalet                           C                   Z-add     Cpalet        Qtebor
     C                   Endif                                                      C                   endif
                                                                                     *==* écriture de la ligne de séparation (déjà préparé - à charger)
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        EcritVOK = *Blanks                                C                   Exsr      LigneVrac2
     C                   Endif                                                       *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)
     C                   If        Unefois = *Blanks                                 C                   If        Ligne >= 56
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent3 = *Blanks
     C                   Seton                                        7371           C                   Setoff                                       727475
     C                   Setoff                                       70             C                   Exsr      EntVrac
     C                   Endif
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent2 = *Blanks                               C                   Exsr      EntArt
     C                   Endif                                                       C                   If        Ecritent4 = *Blanks
     C                   Exsr      Alimcli                                           C                   Endif
     C                   Endif                                                       *==* écriture du détail
     C                   Move      Adr_art       AdreA                               C                   Z-add     Cod_art       Cart
     *==* mise à jour zones contenance                                              C                   Exsr      MiseAjour
     C                   MoveL     Libsup        Lart                                C                   Add       NBpal         Totcoli
     C                   Add       NBpal         Totgen
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     DetailPNB
     C                   Eval      Unefois = '*'                                     *==* total colis
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     TotalC3
     C                   Endif                                                       C                   Clear                   Totgen
     *==**==**           fin édition des palettes          **==**==**              C                   Endif
     *==**==**           FIN CLIENTS PREPARES              **==**==**
     C                   Exsr      ClearZon                                          C                   Clear                   EcritVOK
                                                                                     C                   Eval      Format = 'V2'
                                                                                     *== si pas de vrac chauffeur mais des fûts non préparés par le livreur, de
     *== de la pub, écrit le msg 'pas de vrac'                                      C                   If        SIvrac = *Blanks
     C                   Clear                   Ligne                               C                   Eval      VracOK = 'CH'
     C                   Exsr      Entet                                             C                   Write     Sansvrac
     C                   Endif
     C                   Exsr      ClearZon

     *==**==**               édition des fûts              **==**==**               *==**==** des clients préparés ou préparé par un préparateur =**
     C     KL11LLL       Setll     Coll11LO                                          C     zD9livr       Reade     Coll11LO                               31
     C                   Dow       *In31 = *Off
     C                   If        D5code <> CodeART                                 C                   Z-add     D5code        CodeART
     C     KL11LB        Chain     Coll11LB                           87             C                   Dow       *In87 = *Off
                                                                                     C                   Setoff                                       86
     *================ début des contrôles                                          *==                si même livreur
     C                   If        zD5livr = zD9livr                                 *==*               que les clients sur palettes
     C***                If        zD5aff2 = 11                                      C***                Goto      SuivrF
     C***                Endif                                                       *==*               pas les articles préparés par le chauffeur
     C                   MoveL     zCodpre       CodePre                             C                   If        zD5sta1 = 'C' And CodePre = zD5livr
     C                   Goto      SuivrF                                            C                   Endif
     *==*               si lot                                                      C                   If        zCodlot   <> *Blanks
     C                   Goto      SuivrF                                            C                   Endif
     *==*               si articles divers                                          C                   If        zD5catart = 8 And zD5stour2 <> 'FU'
     C                   Goto      SuivrF                                            C                   Endif
     *==*               si non publicité                                            C                   If        zD5catart = 9
     C                   Goto      SuivrF                                            C                   Endif
     *==*               si ligne ristourne                                          C                   If        zD5aafa = 99
     C                   Goto      SuivrF                                            C                   Endif
     *================ fin des contrôles                                            C                   Eval      VracOK = 'FU'
                                                                                     *==*               que les articles fûts
     C                   If        zD5stour2 = 'FU'                                  *==*               à chaque changement d'article
     C                   If        zD5code <> Cod_art And cod_art <> *Zeros          C                   Move      Adr_art       AdreA
     C                   Z-add     Cod_art       Cart                                *==* mise à jour zones contenance
     C                   Exsr      MiseAjour                                         C                   MoveL     Libsup        Lart
                                                                                     *==* écriture de la ligne de séparation (déjà préparé - à charger)
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        EcritVOK = *Blanks                                C                   Exsr      LigneVrac
     C                   Endif                                                       *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)
     C                   If        Unefois = *Blanks                                 C                   If        Ligne >= 56
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent3 = *Blanks
     C                   Seton                                        7471           C                   Setoff                                       727375
     C                   Setoff                                       70             C                   Exsr      EntVrac
     C                   Endif
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent2 = *Blanks                               C                   Exsr      EntArt
     C                   Endif                                                       C                   Eval      Unefois = '*'
     C                   Endif
     C                   Add       Qtebor        Totcoli                             C                   Add       Qtebor        Totgen
     *==* écriture du détail                                                        C                   Exsr      AdreLet
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     Detail2
     C                   Clear                   Qtebor                              C                   Endif
                                                                                     C                   Add       zD5cais       Qtebor
     C                   Z-add     zD5code       Cod_art                             C                   Move      zCodpic       Adr_art
     C                   Endif                                                       C                   Endif
                                                                                     C     SuivrF        Tag
     C     KL11LB        Reade     Coll11LB                               87         C                   Enddo
     C                   Endif
     C     zD9livr       Reade     Coll11LO                               31         C                   Enddo
      *=============== dernier enregistrement  ============================          C                   If        Qtebor <> *Zeros
     *==* écriture de la ligne de séparation (déjà préparé - à charger)             C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        EcritVOK = *Blanks
     C                   Exsr      LigneVrac                                         C                   Endif
     *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)     C                   If        Unefois = *Blanks
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent3 = *Blanks                               C                   Seton                                        7471
     C                   Setoff                                       727375         C                   Setoff                                       70
     C                   Exsr      EntVrac                                           C                   Endif
                                                                                     C                   If        Ligne >= 56
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
     C                   Endif                                                       *==* écriture du détail
     C                   Move      Adr_art       AdreA                               C                   Z-add     Cod_art       Cart
     *==* mise à jour zones contenance                                              C                   Exsr      MiseAjour
     C                   MoveL     Libsup        Lart                                C                   Add       Qtebor        Totcoli
     C                   Add       Qtebor        Totgen
     C                   Exsr      AdreLet                                           C                   If        Ligne >= 56
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     Detail2                                           *==* total colis
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     TotalC3
     C                   Endif                                                       *==**==**           fin édition des fûts              **==**==**
     *==**==** des clients préparés ou préparé par un préparateur =**
     C                   Exsr      ClearZon
     ************* on n'édite plus maintenant les palettes, demande de J.Martin    C                   Clear                   ONpasse           1
    C                   If        ONpasse <> *Blanks                                *==**==**               édition des palettes          **==**==**
     C     KL11L2        Setll     COLL11L2                                          C     zD9livr       Reade     COLL11L2                               31
     C                   Clear                   Cod_art                             C                   Clear                   Adr_art
     C                   Dow       *In31 = *Off
     C                   If        D5code <> CodeART                                 C                   Z-add     D5code        CodeART
     C     KL11LB        Chain     Coll11LB                           87             C                   Dow       *In87 = *Off
                                                                                     C                   Seton                                        86
     *================ début des contrôles                                          *==                si même livreur
     C                   If        zD5livr = zD9livr                                 *==*               que les clients sur palettes
     C                   If        zD5aff2 = 11                                      C                   Goto      SuivrP
     C                   Endif                                                       *==*               si lot
     C                   If        zCodlot <> *Blanks                                C                   Goto      SuivrP
     C                   Endif                                                       *==*               si articles divers
     C                   If        zD5catart = 8                                     C                   Goto      SuivrP
     C                   Endif                                                       *==*               si non publicité
     C                   If        zD5catart = 9                                     C                   Goto      SuivrP
     C                   Endif                                                       *================ fin des contrôles
     C                   Eval      VracOK = 'PA'
     *==*               que les articles sur les palettes                           C                   If        zD5stour2 = 'PH'
     *==*               à chaque changement d'article                               C                   If        zD5code <> Cod_art And cod_art <> *Zeros
     C                   Move      Adr_art       AdreA                               C                   Z-add     Cod_art       Cart
                                                                                     C                   Clear                   Paletisat1        4
     C                   Clear                   Paletisat2        4 0               ** recherche bonne paletisation pour article (ex : 0644)
     C                   Clear                   Ptable                              C                   Clear                   Pident
     C                   Move      'APL'         Ptable                              C                   MoveL     Cod_art       Pident
     C     Kpar          Chain     Param                              32             C                   If        *In32 = *Off
     C                   Eval      Paletisat1 = %Subst(Ptout:1:4)                    C                   Move      Paletisat1    Paletisat2
     C                   Eval      Qtebor = Paletisat2                               C                   Endif
                                                                                     *==* mise à jour zones contenance
     C                   Exsr      MiseAjour                                         C                   MoveL     Libsup        Lart
                                                                                     *==* écriture de la ligne de séparation (déjà préparé - à charger)
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        EcritVOK = *Blanks                                C                   Exsr      LigneVrac2
     C                   Endif                                                       *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)
     C                   If        Unefois = *Blanks                                 C                   If        Ligne >= 56
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent3 = *Blanks
     C                   Seton                                        7371           C                   Setoff                                       727475
     C                   Setoff                                       70             C                   Exsr      EntVrac
     C                   Endif
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent2 = *Blanks                               C                   Exsr      EntArt
     C                   Endif                                                       C                   Eval      Unefois = '*'
     C                   Endif
     C                   Add       NBpal         Totcoli                             C                   Add       NBpal         Totgen
     *==* écriture du détail                                                        C                   If        Ligne >= 56
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     DetailPNB                                         C                   Clear                   Qtebor
     C                   Clear                   NBpal                               C                   Endif
                                                                                     C                   Clear                   Paletisat1
     C                   Clear                   Paletisat2                          C     zD5code       Chain     TafartP1
     C                   Add       zD5cais       Qtebor                              C                   Z-add     Qtebor        NBpal
     ** recherche bonne paletisation pour article (ex : 0644)                       C                   Clear                   Ptable
     C                   Clear                   Pident                              C                   Move      'APL'         Ptable
     C                   MoveL     zD5code       Pident                              C     Kpar          Chain     Param                              32
     C                   If        *In32 = *Off                                      C                   Eval      Paletisat1 = %Subst(Ptout:1:4)
     C                   Move      Paletisat1    Paletisat2                          C******             If        zD5code = 644
     C                   If        Cpalet <> Paletisat2                              C                   Z-add     Qtebor        NBpal
     C                   Else                                                        C                   Eval      NBpal = Qtebor / Paletisat2
     C                   Endif                                                       C                   Eval      Qtebor = Paletisat2
     C                   Else                                                        C                   Eval      NBpal = Qtebor / Cpalet
     C                   Z-add     Cpalet        Qtebor                              C                   Endif
                                                                                     C                   Z-add     zD5code       Cod_art
     C                   Move      zCodpic       Adr_art                             C                   Endif
     C                   Endif
     C     SuivrP        Tag                                                         C     KL11LB        Reade     Coll11LB                               87
     C                   Enddo                                                       C                   Endif
                                                                                     C     zD9livr       Reade     COLL11L2                               31
     C                   Enddo                                                        *=============== dernier enregistrement  ============================
     C                   If        Qtebor <> *Zeros                                  C                   Clear                   Paletisat1
     C                   Clear                   Paletisat2                          ** recherche bonne paletisation pour article (ex : 0644)
     C                   Clear                   Ptable                              C                   Clear                   Pident
     C                   Move      'APL'         Ptable                              C                   MoveL     Cod_art       Pident
     C     Kpar          Chain     Param                              32             C                   If        *In32 = *Off
     C                   Eval      Paletisat1 = %Subst(Ptout:1:4)                    C                   Move      Paletisat1    Paletisat2
     C                   Eval      Qtebor = Paletisat2                               C                   Endif
                                                                                     *==* écriture de la ligne de séparation (déjà préparé - à charger)
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        EcritVOK = *Blanks                                C                   Exsr      LigneVrac2
     C                   Endif                                                       *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)
     C                   If        Unefois = *Blanks                                 C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent3 = *Blanks
     C                   Seton                                        7371           C                   Setoff                                       727475
     C                   Setoff                                       70             C                   Exsr      EntVrac
     C                   Endif
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent2 = *Blanks                               C                   Exsr      EntArt
     C                   Endif                                                       C                   Endif
     *==* écriture du détail                                                        C                   Move      Adr_art       AdreA
     C                   Z-add     Cod_art       Cart                                *==* mise à jour zones contenance
     C                   Exsr      MiseAjour                                         C                   MoveL     Libsup        Lart
     C                   Add       NBpal         Totcoli                             C                   Add       NBpal         Totgen
                                                                                     C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     DetailPNB                                         C                   Eval      Unefois = '*'
     *==* total colis                                                               C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     TotalC3                                           C                   Endif
     *==**==**           fin édition des palettes          **==**==**              C                   Endif

     C                   Exsr      ClearZon
     *==**==**               édition du lot alcool - sans alcools =**               *==**==**               on édite tous les alcools     **==**==**
     *==**==**               sauf si alcool préparé à part **==**==**               C                   MoveL     'X'           ZoneLot
     C     KL11LHL       Setll     Coll11LN                                          C     zD9livr       Reade     Coll11LN                               31
     C                   Move      Codlot        Cod_lot                             C                   Dow       *In31 = *Off
                                                                                     C                   If        D5code <> CodeART
     C                   Z-add     D5code        CodeART                             C     KL11LB        Chain     Coll11LB                           87
     C                   Dow       *In87 = *Off
     C                   Setoff                                       86             *================ début des contrôles
     *==                si même livreur                                             C                   If        zD5livr = zD9livr
     *==*               pas la consigne ni déconsigne, ni consigne                  C                   If        zD5cc = 15 Or zD5cc = 16 Or zD5cc = 18
     C                   Goto      SuivSSA                                           C                   Endif
     *==*               si non lot                                                  C                   If        zCodlot   = *Blanks
     C                   Goto      SuivSSA                                           C                   Endif
     *==*               si lot non alcool                                           C                   If        zCodlot   <> 'X'
     C                   Goto      SuivSSA                                           C                   Endif
     *==*               si lot préparé à part                                       C                   If        zD5aaav  <> *Zeros
     C                   Goto      SuivSSA                                           C                   Endif
     *==*               si ligne ristourne                                          C                   If        zD5aafa = 99
     C                   Goto      SuivSSA                                           C                   Endif
     *================ fin des contrôles                                            C                   Eval      VracOK = 'LA'
     *==*               à chaque changement de lot ou d'article                     C                   If        zD5code <> Cod_art
      ***======== la première fois, on édite le titre du lot                         *==* écriture de la ligne de séparation (déjà préparé - à charger)
     C                   If        Ligne >= 61                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        EcritVOK = *Blanks                                C                   Exsr      LigneVrac
     C                   Endif                                                       C                   If        Unefois = *Blanks
     C                   Eval      Unefois = '*'                                     *==* écriture du titre du lot
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent3 = *Blanks                               C                   Seton                                        7071
     C                   Setoff                                       7273           C                   Setoff                                       7475
     C                   Move      zCodlot       £Codlot                             C                   Exsr      Recup
     C                   Exsr      EntVrac                                           C                   Endif
                                                                                     C                   If        Ligne >= 62
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
     C                   Endif                                                       C                   Endif
                                                                                     *==*               à chaque changement d'article
     C                   If        zD5code <> Cod_art And cod_art <> *Zeros          C                   Move      Adr_art       AdreA
     C                   Z-add     Cod_art       Cart                                *==* mise à jour zones contenance
     C                   Exsr      MiseAjour                                         C                   MoveL     Libsup        Lart
     C                   Add       Qtebor        Totcoli                             C                   Add       Qtebor        Totgen
                                                                                     *==* écriture du détail
     C                   Exsr      AdreLet                                           C                   If        Ligne >= 63
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     Detail2                                           C                   Clear                   Qtebor
     C                   Endif
     C                   Add       zD5cais       Qtebor                              C                   Z-add     zD5code       Cod_art
     C                   Move      zCodpic       Adr_art                             C                   Move      zCodlot       Cod_lot
     C                   Endif                                                       C     SuivSSA       Tag
     C     KL11LB        Reade     Coll11LB                               87         C                   Enddo
     C                   Endif
     C     zD9livr       Reade     Coll11LN                               31         C                   Enddo
      *=============== dernier enregistrement  ============================          C                   If        Qtebor <> *Zeros
     *==* écriture de la ligne de séparation (déjà préparé - à charger)             C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        EcritVOK = *Blanks
     C                   Exsr      LigneVrac                                         C                   Endif
     *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)     C                   If        Unefois = *Blanks
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent3 = *Blanks                               C                   Seton                                        7071
     C                   Setoff                                       7273           C                   Setoff                                       7475
     C                   Move      Cod_lot       £Codlot                             C                   Exsr      Recup
     C                   Exsr      EntVrac                                           C                   Endif
                                                                                     C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
     C                   Endif                                                       *==* écriture du détail
     C                   Move      Adr_art       AdreA                               C                   Z-add     Cod_art       Cart
     *==* mise à jour zones contenance                                              C                   Exsr      MiseAjour
     C                   MoveL     Libsup        Lart                                *==* récupération du nom du lot
     C                   Move      zCodlot       £Codlot                             C                   Exsr      Recup
     C                   Add       Qtebor        Totcoli                             C                   Add       Qtebor        Totgen
                                                                                     C                   Exsr      AdreLet
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     Detail2
     *==* total colis                                                               C                   If        Ligne >= 61
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     TotalC3                                           C                   Endif
     *==**==**           fin édition du lot alcool - sans alcools =**
     C                   Exsr      ClearZon                                          C                   Clear                   Apart
                                                                                     *==**==**               édition du lot alcool - sans alcools =**
     *==**==**               on édite tous les alcools     **==**==**               *==**==**               préparés à part               **==**==**
     C                   MoveL     'X'           ZoneLot                             C     KL11LUL       Setll     Coll11LU
     C     zD9livr       Reade     Coll11LU                               31         C                   Move      Codlot        Cod_lot
     C                   Dow       *In31 = *Off                                       ** test du code "préparé à part"
     C                   If        D5aaav <> Apart                                   C                   Clear                   CodeArt
     C                   Endif                                                       C                   Z-add     D5aaav        Apart
                                                                                     C                   If        D5code <> CodeART
     C                   Z-add     D5code        CodeART                             C     KL11LT        Chain     Coll11LT                           87
     C                   Dow       *In87 = *Off
     C                   Setoff                                       86             *================ début des contrôles
     *==                si même livreur                                             C                   If        zD5livr = zD9livr
     *==*               pas la consigne ni déconsigne, ni consigne                  C                   If        zD5cc = 15 Or zD5cc = 16 Or zD5cc = 18
     C                   Goto      SuivSSA2                                          C                   Endif
     *==*               si non lot                                                  C                   If        zCodlot   = *Blanks
     C                   Goto      SuivSSA2                                          C                   Endif
     *==*               si lot non alcool                                           C                   If        zCodlot   <> 'X'
     C                   Goto      SuivSSA2                                          C                   Endif
     *==*               si lot non préparé à part                                   C                   If        zD5aaav  = *Zeros
     C                   Goto      SuivSSA2                                          C                   Endif
     *==*               si ligne ristourne                                          C                   If        zD5aafa = 99
     C                   Goto      SuivSSA2                                          C                   Endif
     *================ fin des contrôles                                            C                   Eval      VracOK = 'LA'
     *==*               à chaque changement de client, on edite son code et ens     *==*               le première fois seulement
     C                   If        zD5cli <> Cod_cli And Unefois = *Blanks           C                   Eval      Unefois = '*'
     C                   Z-add     zD5cli        Cod_cli
     C                   Exsr      Entet                                             C                   If        EcritVOK = *Blanks
     C                   Exsr      LigneVrac                                         C                   Endif
                                                                                     C                   Exsr      Entet
     C                   Eval      £Codlot = 'X'                                     C                   Clear                   Nomlot           30
     C                   Eval      Ptable = 'LOT'                                    C                   Clear                   Pident
     C     pEntrep       Cat       'X'           Pident                              C     Kpar          Chain     Param                              32
     C                   If        *In32 = *Off                                      C                   Eval      Nomlot = %Subst(Ptout:1:25)
     C                   Endif                                                       C                   Seton                                        7071
     C                   Setoff                                       7273           C                   Setoff                                       7475
     C                   Exsr      EntVrac
     C                   Exsr      Entet                                             C                   Z-add     zD5cli        CODCLI
     C     CODCLI        Chain     TafcliP1                                          *==* récup couleur JO
     C                   Exsr      Couleur
     C                   Clear                   ENSEIG                              C                   MoveL     Ensliv        ENSEIG
     C                   Add       2             Ligne                               C                   Write     EntcliD
      ******************* si au cas s'il faut changer de page *********              C                   If        Ligne >= 62
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
     C                   Endif
     *==*               à chaque changement d'article                               C                   If        zD5code <> Cod_art And cod_art <> *Zeros
     C                   Move      Adr_art       AdreA                               C                   Z-add     Cod_art       Cart
     *==* mise à jour zones contenance                                              C                   Exsr      MiseAjour
     C                   MoveL     Libsup        Lart                                C                   Add       Qtebor        Totcoli
     C                   Add       Qtebor        Totgen
     *==* écriture du détail                                                        C                   Exsr      AdreLet
                                                                                     C                   If        Ligne >= 63
     C                   Clear                   Ligne                               C                   Endif
                                                                                     C                   Exsr      Entet
     *==* si on vient d'écrire un entête, on remet le code client                   C                   If        Ligne = 2
     C                   Z-add     zD5cli        CODCLI                              C     CODCLI        Chain     TafcliP1
     *==* récup couleur JO                                                          C                   Exsr      Couleur
                                                                                     C                   Clear                   ENSEIG
     C                   MoveL     Ensliv        ENSEIG                              C                   Add       2             Ligne
     C                   Write     EntcliD                                           C                   Endif
                                                                                     C                   Add       1             Ligne
     C                   Write     Detail2                                           C                   Clear                   Qtebor
                                                                                     *==*               à chaque changement de client, on edite son code et ens
     C                   If        zD5cli <> Cod_cli                                 *==* total colis
     C                   If        Ligne >= 61                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     TotalC3
     C                   Clear                   Totcoli
     C                   Exsr      Entet                                             C                   Z-add     zD5cli        Cod_cli
                                                                                     C                   Z-add     zD5cli        CODCLI
     C     CODCLI        Chain     TafcliP1                                          *==* récup couleur JO
     C                   Exsr      Couleur
     C                   Clear                   ENSEIG                              C                   MoveL     Ensliv        ENSEIG
     C                   Add       2             Ligne                               C                   Write     EntcliD
      ******************* si au cas s'il faut changer de page *********              C                   If        Ligne >= 62
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
     C                   Endif                                                       C                   Endif
                                                                                     C                   Add       zD5cais       Qtebor
     C                   Z-add     zD5code       Cod_art                             C                   Move      zCodpic       Adr_art
     C                   Move      zCodlot       Cod_lot                             C                   Endif
     C     SuivSSA2      Tag                                                         C     KL11LT        Reade     Coll11LT                               87
     C                   Enddo                                                       C                   Endif
                                                                                     C     zD9livr       Reade     Coll11LU                               31
     C                   Enddo                                                        *=============== dernier enregistrement  ============================
     C                   If        Qtebor <> *Zeros                                  *==* écriture de la ligne de séparation (déjà préparé - à charger)
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        EcritVOK = *Blanks                                C                   Exsr      LigneVrac
     C                   Endif                                                       *==* écriture du détail
     C                   Move      Adr_art       AdreA                               C                   Z-add     Cod_art       Cart
     *==* mise à jour zones contenance                                              C                   Exsr      MiseAjour
     C                   MoveL     Libsup        Lart                                *==* récupération du nom du lot
     C                   Move      zCodlot       £Codlot                             C                   Exsr      Recup
     C                   Add       Qtebor        Totcoli                             C                   Add       Qtebor        Totgen
                                                                                     C                   Exsr      AdreLet
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     Detail2
     *==* total colis                                                               C                   If        Ligne >= 61
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     TotalC3                                           C                   Endif
     *==**==**           fin édition du lot alcool - sans alcools =**
     C                   Exsr      ClearZon
     *==**==**               édition du lot alcool - cave à vins ==**               *==**==**               on édite tous les alcools     **==**==**
     *==**==**               sauf si alcool préparé à part **==**==**               C                   MoveL     'Y'           ZoneLot
     C     KL11LHL       Setll     Coll11LN                                          C     zD9livr       Reade     Coll11LN                               31
     C                   Move      Codlot        Cod_lot                             C                   Dow       *In31 = *Off
                                                                                     C                   If        D5code <> CodeART
     C                   Z-add     D5code        CodeART                             C     KL11LB        Chain     Coll11LB                           87
     C                   Dow       *In87 = *Off
     C                   Setoff                                       86             *================ début des contrôles
     *==                si même livreur                                             C                   If        zD5livr = zD9livr
     *==*               pas la consigne ni déconsigne, ni consigne                  C                   If        zD5cc = 15 Or zD5cc = 16 Or zD5cc = 18
     C                   Goto      SuivCAV                                           C                   Endif
     *==*               si non lot                                                  C                   If        zCodlot   = *Blanks
     C                   Goto      SuivCAV                                           C                   Endif
     *==*               si lot non alcool                                           C                   If        zCodlot   <> 'Y'
     C                   Goto      SuivCAV                                           C                   Endif
     *==*               si lot préparé à part                                       C                   If        zD5aaav  <> *Zeros
     C                   Goto      SuivCAV                                           C                   Endif
     *==*               si ligne ristourne                                          C                   If        zD5aafa = 99
     C                   Goto      SuivCAV                                           C                   Endif
     *================ fin des contrôles                                            C                   Eval      VracOK = 'LA'
     *==*               à chaque changement de lot ou d'article                     C                   If        zD5code <> Cod_art
      ***======== la première fois, on édite le titre du lot                         *==* écriture de la ligne de séparation (déjà préparé - à charger)
     C                   If        Ligne >= 61                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        EcritVOK = *Blanks                                C                   Exsr      LigneVrac
     C                   Endif                                                       C                   If        Unefois = *Blanks
     C                   Eval      Unefois = '*'                                     *==* écriture du titre du lot
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent3 = *Blanks                               C                   Seton                                        7071
     C                   Setoff                                       7273           C                   Setoff                                       7475
     C                   Move      zCodlot       £Codlot                             C                   Exsr      Recup
     C                   Exsr      EntVrac                                           C                   Endif
                                                                                     C                   If        Ligne >= 62
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
     C                   Endif                                                       C                   Endif
                                                                                     *==*               à chaque changement d'article
     C                   If        zD5code <> Cod_art And cod_art <> *Zeros          C                   Move      Adr_art       AdreA
     C                   Z-add     Cod_art       Cart                                *==* mise à jour zones contenance
     C                   Exsr      MiseAjour                                         C                   MoveL     Libsup        Lart
     C                   Add       Qtebor        Totcoli                             C                   Add       Qtebor        Totgen
                                                                                     *==* écriture du détail
     C                   Exsr      AdreLet                                           C                   If        Ligne >= 63
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     Detail2                                           C                   Clear                   Qtebor
     C                   Endif
     C                   Add       zD5cais       Qtebor                              C                   Z-add     zD5code       Cod_art
     C                   Move      zCodpic       Adr_art                             C                   Move      zCodlot       Cod_lot
     C                   Endif                                                       C     SuivCAV       Tag
     C     KL11LB        Reade     Coll11LB                               87         C                   Enddo
     C                   Endif
     C     zD9livr       Reade     Coll11LN                               31         C                   Enddo
      *=============== dernier enregistrement  ============================          C                   If        Qtebor <> *Zeros
     *==* écriture de la ligne de séparation (déjà préparé - à charger)             C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        EcritVOK = *Blanks
     C                   Exsr      LigneVrac                                         C                   Endif
     *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)     C                   If        Unefois = *Blanks
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent3 = *Blanks                               C                   Seton                                        7071
     C                   Setoff                                       7273           C                   Setoff                                       7475
     C                   Move      Cod_lot       £Codlot                             C                   Exsr      Recup
     C                   Exsr      EntVrac                                           C                   Endif
                                                                                     C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
     C                   Endif                                                       *==* écriture du détail
     C                   Move      Adr_art       AdreA                               C                   Z-add     Cod_art       Cart
     *==* mise à jour zones contenance                                              C                   Exsr      MiseAjour
     C                   MoveL     Libsup        Lart                                *==* récupération du nom du lot
     C                   Move      zCodlot       £Codlot                             C                   Exsr      Recup
     C                   Add       Qtebor        Totcoli                             C                   Add       Qtebor        Totgen
                                                                                     C                   Exsr      AdreLet
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     Detail2
     *==* total colis                                                               C                   If        Ligne >= 61
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     TotalC3                                           C                   Endif
     *==**==**           fin édition du lot alcool - cave à vins ==**
     C                   Exsr      ClearZon                                          C                   Clear                   Apart
                                                                                     *==**==**               édition du lot alcool - cave à vins ==**
     *==**==**               on édite tous les alcools     **==**==**               *==**==**               préparés à part               **==**==**
     C                   MoveL     'Y'           ZoneLot                             C     KL11LUL       Setll     Coll11LU
     C     zD9livr       Reade     Coll11LU                               31         C                   Move      Codlot        Cod_lot
     C                   Dow       *In31 = *Off                                       ** test du code "préparé à part"
     C                   If        D5aaav <> Apart                                   C                   Clear                   CodeArt
     C                   Endif                                                       C                   Z-add     D5aaav        Apart
                                                                                     C                   If        D5code <> CodeART
     C                   Z-add     D5code        CodeART                             C     KL11LT        Chain     Coll11LT                           87
     C                   Dow       *In87 = *Off
     C                   Setoff                                       86             *================ début des contrôles
     *==                si même livreur                                             C                   If        zD5livr = zD9livr
     *==*               pas la consigne ni déconsigne, ni consigne                  C                   If        zD5cc = 15 Or zD5cc = 16 Or zD5cc = 18
     C                   Goto      SuivCAV2                                          C                   Endif
     *==*               si non lot                                                  C                   If        zCodlot   = *Blanks
     C                   Goto      SuivCAV2                                          C                   Endif
     *==*               si lot non alcool                                           C                   If        zCodlot   <> 'Y'
     C                   Goto      SuivCAV2                                          C                   Endif
     *==*               si lot non préparé à part                                   C                   If        zD5aaav  = *Zeros
     C                   Goto      SuivCAV2                                          C                   Endif
     *==*               si ligne ristourne                                          C                   If        zD5aafa = 99
     C                   Goto      SuivCAV2                                          C                   Endif
     *================ fin des contrôles                                            C                   Eval      VracOK = 'LA'
     *==*               à chaque changement de client, on edite son code et ens     *==*               le première fois seulement
     C                   If        zD5cli <> Cod_cli And Unefois = *Blanks           C                   Eval      Unefois = '*'
     C                   Z-add     zD5cli        Cod_cli
     C                   Exsr      Entet                                             C                   If        EcritVOK = *Blanks
     C                   Exsr      LigneVrac                                         C                   Endif
                                                                                     C                   Exsr      Entet
     C                   Eval      £Codlot = 'Y'                                     C                   Clear                   Nomlot           30
     C                   Eval      Ptable = 'LOT'                                    C                   Clear                   Pident
     C     pEntrep       Cat       'Y'           Pident                              C     Kpar          Chain     Param                              32
     C                   If        *In32 = *Off                                      C                   Eval      Nomlot = %Subst(Ptout:1:25)
     C                   Endif                                                       C                   Seton                                        7071
     C                   Setoff                                       7273           C                   Setoff                                       7475
     C                   Exsr      EntVrac
     C                   Exsr      Entet                                             C                   Z-add     zD5cli        CODCLI
     C     CODCLI        Chain     TafcliP1                                          *==* récup couleur JO
     C                   Exsr      Couleur
     C                   Clear                   ENSEIG                              C                   MoveL     Ensliv        ENSEIG
     C                   Add       2             Ligne                               C                   Write     EntcliD
      ******************* si au cas s'il faut changer de page *********              C                   If        Ligne >= 62
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
     C                   Endif
     *==*               à chaque changement d'article                               C                   If        zD5code <> Cod_art And cod_art <> *Zeros
     C                   Move      Adr_art       AdreA                               C                   Z-add     Cod_art       Cart
     *==* mise à jour zones contenance                                              C                   Exsr      MiseAjour
     C                   MoveL     Libsup        Lart                                C                   Add       Qtebor        Totcoli
     C                   Add       Qtebor        Totgen
     *==* écriture du détail                                                        C                   Exsr      AdreLet
                                                                                     C                   If        Ligne >= 63
     C                   Clear                   Ligne                               C                   Endif
                                                                                     C                   Exsr      Entet
     *==* si on vient d'écrire un entête, on remet le code client                   C                   If        Ligne = 2
     C                   Z-add     zD5cli        CODCLI                              C     CODCLI        Chain     TafcliP1
     *==* récup couleur JO                                                          C                   Exsr      Couleur
                                                                                     C                   Clear                   ENSEIG
     C                   MoveL     Ensliv        ENSEIG                              C                   Add       2             Ligne
     C                   Write     EntcliD                                           C                   Endif
                                                                                     C                   Add       1             Ligne
     C                   Write     Detail2                                           C                   Clear                   Qtebor
                                                                                     *==*               à chaque changement de client, on edite son code et ens
     C                   If        zD5cli <> Cod_cli                                 *==* total colis
     C                   If        Ligne >= 61                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     TotalC3
     C                   Clear                   Totcoli
     C                   Exsr      Entet                                             C                   Z-add     zD5cli        Cod_cli
                                                                                     C                   Z-add     zD5cli        CODCLI
     C     CODCLI        Chain     TafcliP1                                          *==* récup couleur JO
     C                   Exsr      Couleur
     C                   Clear                   ENSEIG                              C                   MoveL     Ensliv        ENSEIG
     C                   Add       2             Ligne                               C                   Write     EntcliD
      ******************* si au cas s'il faut changer de page *********              C                   If        Ligne >= 62
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
     C                   Endif                                                       C                   Endif
                                                                                     C                   Add       zD5cais       Qtebor
     C                   Z-add     zD5code       Cod_art                             C                   Move      zCodpic       Adr_art
     C                   Move      zCodlot       Cod_lot                             C                   Endif
     C     SuivCAV2      Tag                                                         C     KL11LT        Reade     Coll11LT                               87
     C                   Enddo                                                       C                   Endif
                                                                                     C     zD9livr       Reade     Coll11LU                               31
     C                   Enddo                                                        *=============== dernier enregistrement  ============================
     C                   If        Qtebor <> *Zeros                                  *==* écriture de la ligne de séparation (déjà préparé - à charger)
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        EcritVOK = *Blanks                                C                   Exsr      LigneVrac
     C                   Endif                                                       *==* écriture du détail
     C                   Move      Adr_art       AdreA                               C                   Z-add     Cod_art       Cart
     *==* mise à jour zones contenance                                              C                   Exsr      MiseAjour
     C                   MoveL     Libsup        Lart                                *==* récupération du nom du lot
     C                   Move      zCodlot       £Codlot                             C                   Exsr      Recup
     C                   Add       Qtebor        Totcoli                             C                   Add       Qtebor        Totgen
                                                                                     C                   Exsr      AdreLet
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     Detail2
     *==* total colis                                                               C                   If        Ligne >= 61
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     TotalC3                                           C                   Endif
     *==**==**           fin édition du lot alcool - cave à vins ==**
     C                   Exsr      ClearZon
     *==**==**               édition du lot alcool         **==**==**               *==**==**               on édite tous les alcools     **==**==**
     *==**==**               sauf si alcool préparé à part **==**==**               C                   MoveL     'Z'           ZoneLot
     C     KL11LHL       Setll     Coll11LN                                          C     zD9livr       Reade     Coll11LN                               31
     C                   Move      Codlot        Cod_lot                             C                   Dow       *In31 = *Off
                                                                                     C                   If        D5code <> CodeART
     C                   Z-add     D5code        CodeART                             C     KL11LB        Chain     Coll11LB                           87
     C                   Dow       *In87 = *Off
     C                   Setoff                                       86             *================ début des contrôles
     *==                si même livreur                                             C                   If        zD5livr = zD9livr
     *==*               pas la consigne ni déconsigne, ni consigne                  C                   If        zD5cc = 15 Or zD5cc = 16 Or zD5cc = 18
     C                   Goto      SuivrAL                                           C                   Endif
     *==*               si non lot                                                  C                   If        zCodlot   = *Blanks
     C                   Goto      SuivrAL                                           C                   Endif
     *==*               si lot non alcool                                           C                   If        zCodlot   <> 'Z'
     C                   Goto      SuivrAL                                           C                   Endif
     *==*               si lot préparé à part                                       C                   If        zD5aaav  <> *Zeros
     C                   Goto      SuivrAL                                           C                   Endif
     *==*               si ligne ristourne                                          C                   If        zD5aafa = 99
     C                   Goto      SuivrAL                                           C                   Endif
     *================ fin des contrôles                                            C                   Eval      VracOK = 'LA'
     *==*               que les produits alcools                                    C**                 If        zD5stour2 = 'AL'
                                                                                     *==*               à chaque changement de lot ou d'article
     C                   If        zD5code <> Cod_art                                 ***======== la première fois, on édite le titre du lot
     *==* écriture de la ligne de séparation (déjà préparé - à charger)             C                   If        Ligne >= 61
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        EcritVOK = *Blanks
     C                   Exsr      LigneVrac                                         C                   Endif
     C                   If        Unefois = *Blanks                                 C                   Eval      Unefois = '*'
     *==* écriture du titre du lot                                                  C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent3 = *Blanks
     C                   Seton                                        7071           C                   Setoff                                       7273
     C                   Setoff                                       7475           C                   Move      zCodlot       £Codlot
     C                   Exsr      Recup                                             C                   Exsr      EntVrac
     C                   Endif
     C                   If        Ligne >= 62                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent2 = *Blanks                               C                   Exsr      EntArt
     C                   Endif                                                       C                   Endif
     C                   Endif
     *==*               à chaque changement d'article                               C                   If        zD5code <> Cod_art And cod_art <> *Zeros
     C                   Move      Adr_art       AdreA                               C                   Z-add     Cod_art       Cart
     *==* mise à jour zones contenance                                              C                   Exsr      MiseAjour
     C                   MoveL     Libsup        Lart                                C                   Add       Qtebor        Totcoli
     C                   Add       Qtebor        Totgen
     *==* écriture du détail                                                        C                   Exsr      AdreLet
     C                   If        Ligne >= 63                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     Detail2
     C                   Clear                   Qtebor                              C                   Endif
                                                                                     C                   Add       zD5cais       Qtebor
     C                   Z-add     zD5code       Cod_art                             C                   Move      zCodpic       Adr_art
     C                   Move      zCodlot       Cod_lot                             C                   Endif
     C     SuivrAL       Tag                                                         C     KL11LB        Reade     Coll11LB                               87
     C                   Enddo                                                       C                   Endif
                                                                                     C     zD9livr       Reade     Coll11LN                               31
     C                   Enddo                                                        *=============== dernier enregistrement  ============================
     C                   If        Qtebor <> *Zeros                                  *==* écriture de la ligne de séparation (déjà préparé - à charger)
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        EcritVOK = *Blanks                                C                   Exsr      LigneVrac
     C                   Endif                                                       *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)
     C                   If        Unefois = *Blanks                                 C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent3 = *Blanks
     C                   Seton                                        7071           C                   Setoff                                       7273
     C                   Setoff                                       7475           C                   Move      Cod_lot       £Codlot
     C                   Exsr      Recup                                             C                   Exsr      EntVrac
     C                   Endif
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent2 = *Blanks                               C                   Exsr      EntArt
     C                   Endif                                                       C                   Endif
     *==* écriture du détail                                                        C                   Move      Adr_art       AdreA
     C                   Z-add     Cod_art       Cart                                *==* mise à jour zones contenance
     C                   Exsr      MiseAjour                                         C                   MoveL     Libsup        Lart
     *==* récupération du nom du lot                                                C                   Move      zCodlot       £Codlot
     C                   Exsr      Recup                                             C                   Add       Qtebor        Totcoli
     C                   Add       Qtebor        Totgen
     C                   Exsr      AdreLet                                           C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     Detail2                                           *==* total colis
     C                   If        Ligne >= 61                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     TotalC3
     C                   Endif                                                       *==**==**           fin édition du lot alcool         **==**==**
                                                                                     C                   Exsr      ClearZon
     C                   Clear                   Apart
     *==**==**               édition du lot alcool         **==**==**               *==**==**               on édite tous les alcools     **==**==**
     *==**==**               préparés à part               **==**==**               C                   MoveL     'Z'           ZoneLot
     C     KL11LUL       Setll     Coll11LU                                          C     zD9livr       Reade     Coll11LU                               31
     C                   Move      Codlot        Cod_lot                             C                   Dow       *In31 = *Off
      ** test du code "préparé à part"                                               C                   If        D5aaav <> Apart
     C                   Clear                   CodeArt                             C                   Endif
     C                   Z-add     D5aaav        Apart
     C                   If        D5code <> CodeART                                 C                   Z-add     D5code        CodeART
     C     KL11LT        Chain     Coll11LT                           87             C                   Dow       *In87 = *Off
                                                                                     C                   Setoff                                       86
     *================ début des contrôles                                          *==                si même livreur
     C                   If        zD5livr = zD9livr                                 *==*               pas la consigne ni déconsigne, ni consigne
     C                   If        zD5cc = 15 Or zD5cc = 16 Or zD5cc = 18            C                   Goto      SuivrAL2
     C                   Endif                                                       *==*               si non lot
     C                   If        zCodlot   = *Blanks                               C                   Goto      SuivrAL2
     C                   Endif                                                       *==*               si lot non alcool
     C                   If        zCodlot   <> 'Z'                                  C                   Goto      SuivrAL2
     C                   Endif                                                       *==*               si lot non préparé à part
     C                   If        zD5aaav  = *Zeros                                 C                   Goto      SuivrAL2
     C                   Endif                                                       *==*               si ligne ristourne
     C                   If        zD5aafa = 99                                      C                   Goto      SuivrAL2
     C                   Endif                                                       *================ fin des contrôles
     C                   Eval      VracOK = 'LA'                                     *==*               que les produits alcools
     C**                 If        zD5stour2 = 'AL'
     *==*               à chaque changement de client, on edite son code et ens     *==*               le première fois seulement
     C                   If        zD5cli <> Cod_cli And Unefois = *Blanks           C                   Eval      Unefois = '*'
     C                   Z-add     zD5cli        Cod_cli
     C                   Exsr      Entet                                             C                   If        EcritVOK = *Blanks
     C                   Exsr      LigneVrac                                         C                   Endif
                                                                                     C                   Exsr      Entet
     C                   Eval      £Codlot = 'Z'                                     C                   Clear                   Nomlot           30
     C                   Eval      Ptable = 'LOT'                                    C                   Clear                   Pident
     C     pEntrep       Cat       'Z'           Pident                              C     Kpar          Chain     Param                              32
     C                   If        *In32 = *Off                                      C                   Eval      Nomlot = %Subst(Ptout:1:25)
     C                   Endif                                                       C                   Seton                                        7071
     C                   Setoff                                       7273           C                   Setoff                                       7475
     C                   Exsr      EntVrac
     C                   Exsr      Entet                                             C                   Z-add     zD5cli        CODCLI
     C     CODCLI        Chain     TafcliP1                                          *==* récup couleur JO
     C                   Exsr      Couleur
     C                   Clear                   ENSEIG                              C                   MoveL     Ensliv        ENSEIG
     C                   Add       2             Ligne                               C                   Write     EntcliD
      ******************* si au cas s'il faut changer de page *********              C                   If        Ligne >= 62
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
     C                   Endif
     *==*               à chaque changement d'article                               C                   If        zD5code <> Cod_art And cod_art <> *Zeros
     C                   Move      Adr_art       AdreA                               C                   Z-add     Cod_art       Cart
     *==* mise à jour zones contenance                                              C                   Exsr      MiseAjour
     C                   MoveL     Libsup        Lart                                C                   Add       Qtebor        Totcoli
     C                   Add       Qtebor        Totgen
     *==* écriture du détail                                                        C                   Exsr      AdreLet
                                                                                     C                   If        Ligne >= 63
     C                   Clear                   Ligne                               C                   Endif
                                                                                     C                   Exsr      Entet
     *==* si on vient d'écrire un entête, on remet le code client                   C                   If        Ligne = 2
     C                   Z-add     zD5cli        CODCLI                              C     CODCLI        Chain     TafcliP1
     *==* récup couleur JO                                                          C                   Exsr      Couleur
                                                                                     C                   Clear                   ENSEIG
     C                   MoveL     Ensliv        ENSEIG                              C                   Add       2             Ligne
     C                   Write     EntcliD                                           C                   Endif
                                                                                     C                   Add       1             Ligne
     C                   Write     Detail2                                           C                   Clear                   Qtebor
                                                                                     *==*               à chaque changement de client, on edite son code et ens
     C                   If        zD5cli <> Cod_cli                                 *==* total colis
     C                   If        Ligne >= 61                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     TotalC3
     C                   Clear                   Totcoli
     C                   Exsr      Entet                                             C                   Z-add     zD5cli        Cod_cli
                                                                                     C                   Z-add     zD5cli        CODCLI
     C     CODCLI        Chain     TafcliP1                                          *==* récup couleur JO
     C                   Exsr      Couleur
     C                   Clear                   ENSEIG                              C                   MoveL     Ensliv        ENSEIG
     C                   Add       2             Ligne                               C                   Write     EntcliD
      ******************* si au cas s'il faut changer de page *********              C                   If        Ligne >= 62
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
     C                   Endif                                                       C                   Endif
                                                                                     C                   Add       zD5cais       Qtebor
     C                   Z-add     zD5code       Cod_art                             C                   Move      zCodpic       Adr_art
     C                   Move      zCodlot       Cod_lot                             C                   Endif
     C     SuivrAL2      Tag                                                         C     KL11LT        Reade     Coll11LT                               87
     C                   Enddo                                                       C                   Endif
                                                                                     C     zD9livr       Reade     Coll11LU                               31
     C                   Enddo                                                        *=============== dernier enregistrement  ============================
     C                   If        Qtebor <> *Zeros                                  *==* écriture de la ligne de séparation (déjà préparé - à charger)
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        EcritVOK = *Blanks                                C                   Exsr      LigneVrac
     C                   Endif                                                       *==* écriture du détail
     C                   Move      Adr_art       AdreA                               C                   Z-add     Cod_art       Cart
     *==* mise à jour zones contenance                                              C                   Exsr      MiseAjour
     C                   MoveL     Libsup        Lart                                *==* récupération du nom du lot
     C                   Move      zCodlot       £Codlot                             C                   Exsr      Recup
     C                   Add       Qtebor        Totcoli                             C                   Add       Qtebor        Totgen
                                                                                     C                   Exsr      AdreLet
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     Detail2
     *==* total colis                                                               C                   If        Ligne >= 61
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     TotalC3                                           C                   Endif
     *==**==**           fin édition du lot alcool         **==**==**
     C                   Exsr      ClearZon
    C                   Clear                   ONpasse           1                C                   If        ONpasse <> *Blanks
     *==**==**               édition alcools des client préparés ==**               C     zD9livr       Chain     Coll11L11                          31
     C                   Clear                   Cod_art                             C                   Clear                   Adr_art
     C                   Clear                   Code_clis                           C                   Clear                   Codeclis
     C                   Dow       *In31 = *Off
     C                   If        D5clst <> Codeclis                                C                   Z-add     D5clst        Codeclis
     C     K11Lb         Chain     Coll11L14                          87             C                   Dow       *In87 = *Off
                                                                                     C                   Setoff                                       86
     *================ début des contrôles                                          *==                si même livreur
     C                   If        zD5livr = zD9livr                                 *==*               on passe si clients non préparés
     C                   If        zD5aff2 <> 11                                     C                   Goto      SuivrALC
     C                   Endif                                                       *==*               si articles alcool
     C                   If        zD5catart = 7 And zD5stour2 <> 'AL'               C                   Goto      SuivrALC
     C                   Endif                                                       *================ fin des contrôles
     C                   Eval      VracOK = 'LA'                                     C                   Clear                   Format
     C                   Seton                                        85
     *==*               que les articles alcools                                    C                   If        zD5stour2 = 'AL'
     *================* à chaque changement d'article ou de client                  C                   If        zD5code <> Cod_art And cod_art <> *Zeros
     C                             Or                                                C                             zD5clst <> Code_clis And code_clis <> *Zeros
     C                   If        zD5clst <> Code_clis                              C                   Clear                   Code_clis
     C                   Endif                                                       C                   Move      Adr_art       AdreA
     C                   Z-add     Cod_art       Cart                                *==* mise à jour zones contenance
     C                   Exsr      MiseAjour                                         C                   MoveL     Libsup        Lart
                                                                                     *==* écriture de la ligne de séparation (déjà préparé - à charger)
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        EcritVOK = *Blanks                                C                   Exsr      LigneVrac2
     C                   Endif                                                       *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
                                                                                     C                   If        Unefois = *Blanks
     * édition libellé 'VRAC, LOT, FUTS....'                                        C                   Seton                                        71
     C                   Setoff                                       727375         C                   Setoff                                       7074
     C                   If        Ecritent3 = *Blanks                               C                   Exsr      EntVrac
     C                   Endif
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     * édition pour le vrac de l'entête produit 'adr., code, cont., désignation     C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
                                                                                     C                   If        Ecritent4 = *Blanks
     C                   Exsr      Alimcli                                           C                   Eval      Ecritent4 = '*'
     C                   Endif                                                       C                   Eval      Unefois = '*'
     C                   Endif
     C                   Z-add     zD5cli        Code_cli                            C                   Add       Qtebor        Totcoli
     C                   Add       Qtebor        Totgen                              *==* écriture du détail
     C                   Exsr      AdreLet                                           C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C***                Write     Detail22                                          C                   Write     Detail2
     C                   Clear                   Qtebor
     *==* ===** à chaque changement de client                                       C                   If        zD5clst <> Code_clis
     C                   Clear                   Unefois                             C                   Clear                   Ecritent4
     *==* total colis                                                               C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     TotalC3                                           C                   Clear                   TOTCOLI
                                                                                     C                   Z-add     zD5clst       Code_clis
     C                   Endif                                                       C                   Endif
     *===============================================*                              C                   Z-add     zD5cli        Code_cli
     C                   Add       zD5cais       Qtebor                              C                   Z-add     zD5code       Cod_art
     C                   Move      zCodpic       Adr_art                             C                   Endif
     C                   Endif
     C     SuivrALC      Tag                                                         C     K11Lb         Reade     Coll11L14                              87
     C                   Enddo                                                       C                   Endif
                                                                                     C     zD9livr       Reade     Coll11L11                              31
     C                   Enddo                                                        *=============== dernier enregistrement  ============================
     C                   If        Qtebor <> *Zeros                                  *==* écriture de la ligne de séparation (déjà préparé - à charger)
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        EcritVOK = *Blanks                                C                   Exsr      LigneVrac2
     C                   Endif                                                       *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)
     C                   If        Unefois = *Blanks                                 C                   If        Ligne >= 56
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent3 = *Blanks
     C                   Seton                                        71             C                   Setoff                                       727375
     C                   Setoff                                       7074           C                   Exsr      EntVrac
     C                   Endif
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent2 = *Blanks                               C                   Exsr      EntArt
     C                   Endif
     C                   If        Ecritent4 = *Blanks                               C                   Exsr      Alimcli
     C                   Endif                                                       C                   Eval      Unefois = '*'
     C                   Endif                                                       *==* écriture du détail
     C                   Move      Adr_art       AdreA                               C                   Z-add     Cod_art       Cart
     *==* mise à jour zones contenance                                              C                   Exsr      MiseAjour
     C                   MoveL     Libsup        Lart                                C                   Add       Qtebor        Totcoli
     C                   Add       Qtebor        Totgen
     C                   Exsr      AdreLet                                           C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C**                 Write     Detail22                                          C                   Write     Detail2
     *==* total colis                                                               C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     TotalC3                                           C                   Endif
     *==**==**           fin édition alcools des client préparés ==**              C                   endif
     C                   Clear                   Totgen
     C                   Exsr      ClearZon
     *==**==**               on édite un global de la publicité *==**               *==**==**               édition de la publicité       **==**==**
     C     KL11LLL       Setll     Coll11LO                                          C     zD9livr       Reade     Coll11LO                               31
     C                   Dow       *In31 = *Off
     C                   If        D5code <> CodeART                                 C                   Z-add     D5code        CodeART
     C     KL11LB        Chain     Coll11LB                           87             C                   Dow       *In87 = *Off
                                                                                     C                   Setoff                                       86
     *================ début des contrôles                                          *==                si même livreur
     C                   If        zD5livr = zD9livr                                 *==*               que les clients sur palettes
     C***                If        zD5aff2 = 11                                      C***                Goto      SuivrPU
     C***                Endif                                                       *==*               si lot
     C                   If        zCodlot   <> *Blanks                              C                   Goto      SuivrPU
     C                   Endif                                                       *==*               si non publicité
     C                   If        zD5catart <> 9                                    C                   Goto      SuivrPU
     C                   Endif                                                       *================ fin des contrôles
     C                   Eval      VracOK = 'PU'
     *==*               que les articles publicité                                  C                   If        zD5stour2 = 'PU'
     *==*               à chaque changement d'article                               C                   If        zD5code <> Cod_art And cod_art <> *Zeros
     C                   Move      Adr_art       AdreA                               C                   Z-add     Cod_art       Cart
     *==* mise à jour zones contenance                                              C                   Exsr      MiseAjour
     C                   MoveL     Libsup        Lart
     *==* écriture de la ligne de séparation (déjà préparé - à charger)             C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        EcritVOK = *Blanks
     C                   Exsr      LigneVrac                                         C                   Endif
     *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)     C                   If        Unefois = *Blanks
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent3 = *Blanks                               C                   Seton                                        7571
     C                   Setoff                                       727473         C                   Setoff                                       70
     C                   Exsr      EntVrac                                           C                   Endif
                                                                                     C                   If        Ligne >= 56
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent2 = *Blanks
     C                   Exsr      EntArt                                            C                   Endif
     C                   Eval      Unefois = '*'                                     C                   Endif
                                                                                     C                   Add       Qtebor        Totcoli
     C                   Add       Qtebor        Totgen                              *==* écriture du détail
     C                   Exsr      AdreLet                                           C                   If        Ligne >= 56
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C                   Write     Detail2                                           C                   Clear                   Qtebor
     C                   Endif
     C                   Add       zD5cais       Qtebor                              C                   Z-add     zD5code       Cod_art
     C                   Move      zCodpic       Adr_art                             C                   Endif
     C                   Endif
     C     SuivrPU       Tag                                                         C     KL11LB        Reade     Coll11LB                               87
     C                   Enddo                                                       C                   Endif
                                                                                     C     zD9livr       Reade     Coll11LO                               31
     C                   Enddo                                                        *=============== dernier enregistrement  ============================
     C                   If        Qtebor <> *Zeros                                  *==* écriture de la ligne de séparation (déjà préparé - à charger)
     C                   If        Ligne >= 60                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        EcritVOK = *Blanks                                C                   Exsr      LigneVrac
     C                   Endif                                                       *==* écriture de la ligne de séparation (Vrac chauffeur, lot, palettes...)
     C                   If        Unefois = *Blanks                                 C                   If        Ligne >= 56
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   If        Ecritent3 = *Blanks
     C                   Seton                                        7571           C                   Setoff                                       727374
     C                   Setoff                                       70             C                   Exsr      EntVrac
     C                   Endif
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   If        Ecritent2 = *Blanks                               C                   Exsr      EntArt
     C                   Endif                                                       C                   Endif
     *==* écriture du détail                                                        C                   Move      Adr_art       AdreA
     C                   Z-add     Cod_art       Cart                                *==* mise à jour zones contenance
     C                   Exsr      MiseAjour                                         C                   MoveL     Libsup        Lart
     C                   Add       Qtebor        Totcoli                             C                   Add       Qtebor        Totgen
                                                                                     C                   Exsr      AdreLet
     C                   If        Ligne >= 56                                       C                   Clear                   Ligne
     C                   Endif                                                       C                   Exsr      Entet
     C                   Add       1             Ligne                               C                   Write     Detail2
     *==* total colis                                                               C                   If        Ligne >= 56
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Add       1             Ligne
     C*******            Write     TotalC3                                           C                   Endif
     *==**==**           fin édition de la publicité       **==**==**
     C                   Exsr      ClearZon
     C                   Clear                   Totgen                              * modif COLL11 avec le code géographique de l'article (GEOJUP)
     C                   Select                                                      C                   When           GeoOK = *Blanks
                                                                                     C                   If        CODEDI = 'A'
     C                   Goto      Suit_edi                                          C                   Endif
     C     Deuxieme      Tag
     C                   Z-add     2             NomEX                               C                   Exsr      Geograph2
     C                   Eval      GeoOK = '*'                                       C                   Clear                   Unefois
     C                   Clear                   Unefois2                            C                   Clear                   Unefois3
     C                   Clear                   EcritVOK                            C                   Clear                   Ecritent2
     C                   Clear                   FutOK                               C                   Setoff                                       77
     C                   Exsr      ClearZon                                          C                   Eval      Lettre = 'B'
     C                   Eval      Libedi = 'Sol / Quai'                             C                   Goto      Relecture
                                                                                     C                   When           GeoOK <> *Blanks
     C                   Clear                   GeoOK                               C                   Exsr      ClearZon
     C                   Exsr      Geograph                                          C                   Goto      Suit_edi
     C                   Endsl                                                       *==**==**           fin édition du VRAC chauffeur     **==**==**
                                                                                     C     Suit_edi      Tag
                                                                                     *==* si pas de vrac, on édite quand même une entête avec un commentaire
     C                   If        PasVrac <> *Blanks                                C                   Clear                   Ligne
     C                   Eval      VracOK = 'CH'                                     C                   Exsr      Entet
     C                   Write     Sansvrac                                          C                   Endif
                                                                                     C                   Exsr      ClearZon
                                                                                     *====== lancement de l'édition
     C***                If        EcritOK <> *Blanks                                C                   Add       1             Numpage
     C                   Write     Pied
     C                   Close     IMedborc                                          C                   Move      Cod_liv       £Liv              3
     C                   Clear                   £Cli              7                 C                   Clear                   £Compteur         3
                                                                                     C                   MoveL     'L'           TypeEdi           1
     C                   Clear                   Libpgm           15                 C                   Eval      Libpgm = 'CLEDBOR2'
     C                   Call      Libpgm                                            C                   Parm                    TypeEdi
     C                   Parm                    £Liv                                C                   Parm                    Nomliv
     C                   Parm                    £Cli                                C                   Parm                    £Compteur
                                                                                     C                   Open      IMedborc
     C***                Endif
     C                   Setoff                                       7785           C                   Clear                   Numpage
     C                   Clear                   Unefois                             C                   Clear                   Unefois2
     C                   Clear                   Unefois3                            C                   Clear                   EnteteArt
     C                   Clear                   EcritOK                             C                   Clear                   Ligne
     C                   Clear                   Cod_cli                             C                   Clear                   EcritEnt
     C                   Clear                   Format                              C                   Clear                   TOTgdiv
     C                   Clear                   TOTgcai                             C                   Clear                   TOTgsir
     C                   Clear                   TOTgalc                             C                   Clear                   TOTgcol
     C                   Clear                   TgPOIart                            C                   Clear                   TOTgfut
     C                   Clear                   TOTgver           2 0               C                   Clear                   TOTgeur           2 0
     C                   Clear                   TOTgpfut          2 0               C                   Clear                   CAICLI
     C                   Clear                   POICLI                              C                   Clear                   TOTCCAI
     C                   Clear                   TOTCPOI                             C                   Clear                   TOTGCCAI
     C                   Clear                   TOTGCPOI                            C                   Clear                   NBRcli
     C                   Clear                   Codecli                             C                   Clear                   PiedOK
     C                   Clear                   GeoOK                               C                   Clear                   VracOK
     C                   Clear                   Ecritlib                            C                   Clear                   Tclp
     C                   Clear                   Tcli                                C                   Clear                   Ind3
                                                                                     C     Suiv          Tag
     C                   Read      Coll03L3                               30         C                   Enddo
     * modif COLL11 effacement du code géographique                                 C***                Exsr      EffaceGEO
     *== fin du programme                                                           C                   Seton                                            Lr
     *=========================================================================     * impression de l'entête
     *=========================================================================     C     Entet         Begsr
     C                   If        Ligne = *Zeros Or                                 C                             Ligne >= 70 And Format = 'CL'
     C                             Or Ligne >= 58 And Format = 'CD'
     C                   If        PiedOK <> *Blanks                                 C                   Add       1             Numpage
     C                   Write     Pied                                              C                   Endif
                                                                                     C                   Clear                   EnteteArt
     C                   Eval      PiedOK = '*'                                      C                   Eval      NOMPGM = '(EDBORCHB)'
     C***                Clear                   LIBENTETE                           *** on ecrit ce libellé que pour le vrac chauffeur
      ***--------> non ce libellé est maintenant mis partout et en dur               C**                 If        Ecritlib <> *Blanks
     C***                Eval      LIBENTETE = 'VRAC Chauffeur'                      C**                 Endif
     C                   Move      *DATE         Datjou                              *   pour tafanel
     C                   Eval      Libent = 'C.H.R.'                                 C                   Move      Datdem        Datliv
     *   pour socodis                                                               C                   If        pEntrep = 'S'
     C                   Eval      Libent = 'Collectivités'                          C                   Select
     *                  si Deja064 = 1 --> affectation à 48h                        C                   When      Deja064 = '1'
     C                   Move      ApDate        Datliv                              *                  si Deja064 = 2 --> affectation à 72h
     C                   When      Deja064 = '2'                                     C                   Move      ApapDT        Datliv
     *                  si Deja064 = 3 --> affectation à 24h                        C                   When      Deja064 = '3'
     C                   Move      Datdem        Datliv                              C                   Endsl
     C                   Endif
     C                   Z-add     Cod_liv       Codliv                              C     Codliv        Chain     FiclivP1
     C                   Clear                   Nomliv                              C                   Clear                   Immat
     C                   MoveL     M4nom         Nomliv                              C                   MoveL     M4IMMT        Immat
                                                                                     C                   Write     EnteteP
     C                   Z-add     2             Ligne             5 0               C
     C                   Select                                                      C                   When      Format = 'CL'
     C                   If        VracOK <> 'CH' And VracOK <> 'LB'                 C                   Write     ENTETC
     C                   Eval      EcritEnt = '*'                                    C                   Add       3             Ligne
     C                   Endif                                                       C                   When      Format = 'CD'
     C                             Or Format = 'DD'                                  C                   If        VracOK = *Blanks
     C                   Write     ENTCLIB                                           C                   Add       3             Ligne
     C                   Endif                                                       C                   Eval      EnteteArt = '*'
     C                   When      Format = 'VR'                                     C                   Select
     C                   When      VracOK = 'CH'                                     C                   Seton                                        727177
     C                   Setoff                                       737475         C                   Setoff                                       70
     C                   When      VracOK = 'LO'                                     C                   Seton                                        707177
     C                   Setoff                                       7273           C                   Setoff                                       7475
     C                   Exsr      Recup                                             C                   When      VracOK = 'FU'
     C                   Seton                                        747177         C                   Setoff                                       727375
     C                   Setoff                                       70             C                   If        EcritVOK = *Blanks
     C                   Exsr      LigneVrac2                                        C                   Endif
     C                   When      VracOK = 'PA'                                     C                   Seton                                        737177
     C                   Setoff                                       727475         C                   Setoff                                       70
     C                   If        EcritVOK = *Blanks                                C                   Exsr      LigneVrac2
     C                   Endif                                                       C                   When      VracOK = 'PU'
     C                   Seton                                        757177         C                   Setoff                                       727473
     C                   Setoff                                       70             C                   If        EcritVOK = *Blanks
     C                   Exsr      LigneVrac                                         C                   Endif
     C                   When      VracOK = 'LA'                                     C                   Seton                                        707144
     C                   Setoff                                       7273           C                   Setoff                                       7475
     C                   If        EcritVOK = *Blanks                                C                   Exsr      LigneVrac
     C                   Endif                                                       C                   Endsl
     C**                 If        Ecritent3 = *Blanks                               C**                 Write     ENTETEL
     C**                 Add       1             Ligne                               C**                 Eval      Ecritent3 = '*'
     C**                 Endif                                                       C                   If        Ecritent2 = *Blanks
     C                   Write     ENTETEPC                                          C                   Add       1             Ligne
     C                   Eval      Ecritent2 = '*'                                   C                   Endif
     C                   Setoff                                       77             C                   Endsl
     C                   Endif                                                       C                   Endsr
     *=========================================================================     * mise à blanc zones contenance
     *=========================================================================     C     MiseAOFF      Begsr
     C                   Setoff                                       82             C                   Setoff                                       83
     C                   Setoff                                       84             C                   Endsr
     *=========================================================================     * mise à jour zones contenance
     *=========================================================================     C     MiseAjour     Begsr
     C     Cart          Chain     TafartP1                                          C                   Select
     *==*==**==         si fûts et BIB                                              C                   When      C2tco = 'FUT' Or C2tco = 'BIB'
     C                   Exsr      MiseAOFF                                          C                   Seton                                        82
     *==                si fûts de plus de 09 litres                                C                   Z-add     Capaci        Cont2
     *==                si fûts de moins de 10 litres                               C                   If        Capaci < 10
     C                   Exsr      MiseAOFF                                          C                   Seton                                        83
     C                   Z-add     Capaci        Cont3                               C                   Endif
     *==*==**==         si autres                                                   C                   When      C2tco <> 'FUT' And C2tco <> 'BIB'
     C                   Exsr      MiseAOFF                                          C                   Select
     *==                si cols égal 1 litre                                        C                   When      C2ctlunit = 1
     C                   Seton                                        83             C                   Z-add     C2ctlunit     Cont3
     *==                si cols supérieur à 1 litres et inférieur à 10 litres       C                   When      C2ctlunit > 1 And C2ctlunit < 10
     C                   Seton                                        83             C                   Z-add     C2ctlunit     Cont3
     *==                si cols inférieur à 1 litre                                 C                   When      C2ctlunit < 1
     *==                si cols inférieur à 1 litre                                 C                   Clear                   Zone1             5
     C                   MoveL     C2ctlunit     Zone1                               C                   If        %Subst(Zone1:5:1) <> '0'
     C                   Seton                                        84             C                   Z-add     C2ctlunit     Cont4
     C                   Else                                                        C                   Seton                                        83
     C                   Z-add     C2ctlunit     Cont3                               C                   Endif
     C                   Endsl                                                       C                   Endsl
     C                   Endsr                                                       *=========================================================================
     * effacement de zones                                                          *=========================================================================
     C     Efface        Begsr                                                       C                   Clear                   TOTdiv
     C                   Clear                   TOTcai                              C                   Clear                   TOTsir
     C                   Clear                   TOTalc                              C                   Clear                   TOTcol
     C                   Clear                   POIart                              C                   Clear                   TOTfut
     C                   Clear                   SIpub                               C                   Clear                   TOTver            1 0
     C                   Clear                   TOTeur            1 0               C                   Clear                   TOpfut            1 0
     C                   Clear                   PubOK                               C                   Clear                   NBRCDE
     C                   Endsr                                                       *=========================================================================
     * récup du nom du lot                                                          *=========================================================================
     C     Recup         Begsr                                                       C                   Clear                   Nomlot           30
     C                   Eval      Ptable = 'LOT'                                    C                   Clear                   Pident
     C     pEntrep       Cat       £Codlot       Pident                              C     Kpar          Chain     Param                              32
     C                   If        *In32 = *Off                                      C                   Eval      Nomlot = %Subst(Ptout:1:25)
     C                   Endif                                                       C                   Endsr
     *=========================================================================     * modif COLL11 avec le code géographique
     *=========================================================================     C     Geograph      Begsr
     C     *Loval        Setll     TafartP1                                          C                   Read      TafartP1                               51
     C                   Dow       *In51 = *Off                                      C                   If        Tagart = *Blanks
     C     Arttaf        Chain     Coll11LA                           34             C                   Dow       *In34 = *Off
     C                   Move      Geotaf        zCodpic                             C                   If        Catart = 9 And Geotaf = *Blanks
     C                   Move      1             zCodpic                             C                   Endif
     C                   Update    Coll11FLA                                         C     Arttaf        Reade     Coll11LA                               34
     C                   Enddo                                                       C                   Endif
     C                   Read      TafartP1                               51         C                   Enddo
     C                   Endsr                                                       *=========================================================================
     * modif COLL11 avec le code géographique                                       *=========================================================================
     C     Geograph2     Begsr                                                       C     *Loval        Setll     TafartP1
     C                   Read      TafartP1                               51         C                   Dow       *In51 = *Off
     C                   If        Tagart = *Blanks                                  C     Arttaf        Chain     Coll11LA                           34
     C                   Dow       *In34 = *Off                                      C                   Move      Geojup        zCodpic
     C                   If        Catart = 9 And Geojup = *Blanks                   C                   Move      1             zCodpic
     C                   Endif                                                       C                   Update    Coll11FLA
     C     Arttaf        Reade     Coll11LA                               34         C                   Enddo
     C                   Endif                                                       C                   Read      TafartP1                               51
     C                   Enddo                                                       C                   Endsr
     *=========================================================================     * modif COLL11 effacement du code géographique
     *=========================================================================     C**   EffaceGeo     Begsr
     C**   *Loval        Setll     Coll11LA                                          C**                 Read      Coll11LA                               34
     C**                 Dow       *In34 = *Off                                      C**                 Clear                   zD5PUHT
     C**                 Update    Coll11FLA                                         C**                 Read      Coll11LA                               34
     C**                 Enddo                                                       C**                 Endsr
     *=========================================================================     * Clear zones de travail
     *=========================================================================     C     ClearZon      Begsr
     C                   Clear                   Unefois                             C                   Clear                   Qtebor
     C                   Clear                   Cod_lot                             C                   Clear                   Cod_art
     C                   Clear                   CodeART                             C                   Clear                   Adr_art
     C                   Clear                   Totcoli                             C                   Clear                   Ecritent3
     C                   Clear                   Ecritent4                           C                   Endsr
     *=========================================================================     * alimentation zone "LETTREADR"
     * si adresse quai "LETTREADR" = Q                                              * si adresse sol "LETTREADR" = S
     *=========================================================================     C     AdreLet       Begsr
     C     CART          Chain     TafartP1                           51
     C                   Clear                   Adr01             4                 C                   Clear                   Adr02             4
     C                   Clear                   Adr01N            4 0               C                   Clear                   Adr02N            4 0
     C                   Clear                   Emplac            1
     C     'ADA'         Chain     Param                              32             C                   Dow       *In32  = *Off
     C                   Eval      Adr01  = %Subst(Pident:1:4)                       C                   Eval      Adr02  = %Subst(Pident:8:4)
     C                   Eval      Emplac = %Subst(Ptout:1:1)                        C                   Move      Adr01         Adr01N
     C                   Move      Adr02         Adr02N                              C                   Eval      LETTREADR = '?'
     C                   Select                                                      C                   When      Geotaf >= Adr01 And Geotaf <= Adr02
     C                   If        LETTRE  = 'A'                                     C                   Eval      LettreADR = Emplac
     C                   Leave                                                       C                   Else
     C                   Eval      LettreADR = Emplac                                C                   Leave
     C                   Endif                                                       C                   When      Geojup >= Adr01 And Geojup <= Adr02
     C                   If        LETTRE  = 'B'                                     C                   Eval      LettreADR = Emplac
     C                   Leave                                                       C                   Endif
     C                   Endsl
     C     'ADA'         Reade     Param                                  32         C                   Enddo
     C                   Endsr                                                       *=========================================================================
     * édition libellé 'A contrôler'                                                *=========================================================================
     C     LigneVrac     Begsr                                                       C                   Eval      EcritVOK = '*'
     C                   Add       3             Ligne                               C                   Write     InfoVrac
     C                   Endsr                                                       *=========================================================================
     * édition libellé 'Déjà préparé'                                               *=========================================================================
     C     LigneVrac2    Begsr                                                       C                   Eval      EcritVOK = '*'
     C                   Add       3             Ligne                               C                   Write     InfoVrac2
     C                   Endsr                                                       *=========================================================================
     * édition pour le vrac de l'entête produit 'adr., code, cont., désignation     *=========================================================================
     C     EntArt        Begsr                                                       C                   Add       1             Ligne
     C                   Write     ENTETEPC                                          C                   Eval      Ecritent2 = '*'
     C                   Endsr                                                       *=========================================================================
     * édition pour le libellé du vrac (vrac chauffeur, lot, fût...)                *=========================================================================
     C     EntVrac       Begsr                                                       C                   If        *In77 = *Off And Unefois2 = *Blanks
     C                   Seton                                        77             C                   Eval      Unefois2 = '*'
     C                   Else                                                        C                   Setoff                                       77
     C                   Endif                                                       C                   Add       1             Ligne
     C                   Write     EnteteL                                           C                   Eval      Ecritent3 = '*'
     C                   Endsr                                                       *=========================================================================
     * cumul des colis, sirops, alcools ....                                        *=========================================================================
     C     CumulCol      Begsr                                                       C     K11L          Chain     Coll11L11                          32
     C                   Clear                   CodeCli           7 0               C                   Dow       *In32 = *Off
     C                   If        D5cc = 11 Or D5cc = 13                            *==                pas de cumul si compte matériel
     C     D5cli         Chain     TafcliP1                                          C                   If        IPmatl <> 'M'
     C     D5code        Chain     TafartP1                                          C                   Select
     *== si sirops                                                                  C                   When      C2gam = 'SIR' And Geojup < '9001' And
     C                             Geotaf < '9001' And Catart <> 7                   C                   Add       D5cais        TOTsir
     C                   Add       D5cais        TOTgsir                             C                   Add       D5cais        TOTcol
     C                   Add       D5cais        TOTgcol                             *== si alcools
     C                   When      D5alcool = '*' Or D5alcool = *Blanks              C                             And Geojup >= '9001' And Geotaf >= '9001'
     C                   Add       D5cais        TOTalc                              C                   Add       D5cais        TOTgalc
     C                   Add       D5cais        TOTcol                              C                   Add       D5cais        TOTgcol
     *== si fûts ou tubes                                                           C                   When      D5stour2 = 'FU'
     C                   Add       D5cais        TOTfut                              C                   Add       D5cais        TOTgfut
     *== si divers                                                                  C                   When      D5stour2 <> 'FU' And D5catart = 8
     C                   Add       D5cais        TOTdiv                              C                   Add       D5cais        TOTgdiv
     C                   Add       D5cais        TOTcol                              C                   Add       D5cais        TOTgcol
     *== si publicité                                                               C                   When      D5catart = 9
     C                   Eval      SIpub = 'Oui'                                     C                   If        D5cli <> Codecli
     C                   Add       1             TOTpub                              C                   Z-add     D5cli         Codecli
     C                   Endif                                                       C                   Eval      PubOK = '*'
     C                   Other                                                       *== si le reste (caisses)
     ** recherche bonne paletisation pour article (ex : 0644)                       C                   Clear                   Paletisat1        4
     C                   Clear                   Paletisat2        4 0               C                   Clear                   Ptable
     C                   Clear                   Pident                              C                   Move      'APL'         Ptable
     C                   MoveL     D5code        Pident                              C     Kpar          Chain     Param                              32
     C                   If        *In32 = *Off                                      C                   Eval      Paletisat1 = %Subst(Ptout:1:4)
     C                   Move      Paletisat1    Paletisat2                          C                   If        Cpalet <> Paletisat2
     C                   Eval      TOTcai = TOTcai + (D5cais * Paletisat2)           C                   Z-add     TOTcai        TOTcol
     C                   Eval      TOTgcai = TOTgcai + (D5cais * Paletisat2)         C                   Eval      TOTgcol = TOTgcol + (D5cais * Paletisat2)
     C                   Else                                                        C                   Add       D5cais        TOTcai
     C                   Add       D5cais        TOTcol                              C                   Add       D5cais        TOTgcol
     C                   Add       D5cais        TOTgcai                             C                   Endif
     C                   Else                                                        C                   Add       D5cais        TOTcai
     C                   Add       D5cais        TOTgcai                             C                   Add       D5cais        TOTcol
     C                   Add       D5cais        TOTgcol                             C                   Endif
     C                   Endsl
     C***                If        D5stour2 <> 'FU'                                  C                   Add(h)    D5poid        POIart
     C                   Add(h)    D5poid        TgPOIart                            C***                Endif
     C                   Endif                                                       C                   Endif
                                                                                     C     Suiv11a       Tag
     C     K11L          Reade     Coll11L11                              32         C                   Enddo
     C                   Endsr                                                       *=========================================================================
     * cumul de la consigne palettes                                                *=========================================================================
     C     CumulCons     Begsr                                                       C                   Clear                   Cli_cons          7 0
     C                   Clear                   CDE_cons          6 0               C     K11L          Chain     Coll11L11                          32
     C                   Dow       *In32 = *Off                                      C     D5cli         Chain     TafcliP1
     C                   If        IPmatl = 'M'                                      C                   Goto      Suiv11b
     C                   Endif                                                       C**                 Select
     *== on passe si clients non préparés                                           C**                 When      D5aff2 <> 11 And Prepare <> *Blanks
     C**                 Goto      Suiv11b                                           *== on passe si clients préparés
     C**                 When      D5aff2 = 11 And Prepare =  *Blanks                C**                 Goto      Suiv11b
     C**                 Endsl
     C                   If        D5clst = Cli_cons And D5cdeglob <> CDE_cons       C                             Or D5clst <> Cli_cons
     * clés fichier COLL11LZ                                                        C     K11LZ         Klist
     C                   Kfld                    D5LIVR                              C                   Kfld                    D5CLST
     C                   Kfld                    D5FACAN                             C                   Kfld                    D5FACMOIS
     C                   Kfld                    D5FACJOUR                           C                   Kfld                    D5CDEGLOB
                                                                                     C     K11LZ         Chain     Coll11LZ                           35
     C                   Dow       *In35 = *Off                                      C                   Select
     *==                          palettes vertes                                   C                   When      zD5pucseur = 39
     C                   Add       zD5cais       TOTver                              C                   Add       zD5cais       TOTGVER
     *==                          palettes europe                                   C                   When      zD5pucseur = 22,00
     C                   Add       zD5cais       TOTeur                              C                   Add       zD5cais       TOTGEUR
     *==                          palettes fûts                                     C                   When      zD5pucseur = 20
     C                   Add       zD5cais       TOpfut                              C                   Add       zD5cais       TOTGPFUT
     C                   Endsl                                                       C     K11LZ         Reade     Coll11LZ                               35
     C                   Enddo                                                       C                   Endif
                                                                                     C                   Z-add     D5clst        Cli_cons
     C                   Z-add     D5cdeglob     CDE_cons
     C     Suiv11b       Tag                                                         C     K11L          Reade     Coll11L11                              32
     C                   Enddo                                                       C                   Endsr
     *=========================================================================     * cumul du nombre de commandes
     *=========================================================================     C     CumNBRcde     Begsr
     C                   Clear                   Num_cde                             C                   Clear                   NBRCDE
     C     K11L          Chain     Coll11L13                          32             C                   Dow       *In32 = *Off
     C**                 Select                                                      *== on passe si clients non préparés
     C**                 When      zD5aff2 <> 11 And Prepare <> *Blanks              C**                 Goto      Suiv11c
     *== on passe si clients préparés                                               C**                 When      zD5aff2 = 11 And Prepare =  *Blanks
     C**                 Goto      Suiv11c                                           C**                 Endsl
     C     zD5cli        Chain     TafcliP1                                          C                   If        IPmatl <> 'M'
     C                   If        zD5nucd <> Num_cde                                C                   Add       1             NBRCDE
     C                   Z-add     zD5nucd       Num_cde                             C                   Endif
     C                   Endif                                                       C     Suiv11c       Tag
     C     K11L          Reade     Coll11L13                              32         C                   Enddo
     C                   Endsr                                                       *=========================================================================
     * récup des commentaires livraison                                             *=========================================================================
     C     RecupCom      Begsr                                                       ** écriture des commentaires de la facture
     C     K10           Chain     Coll10L0                           33             C                   Dow       *In33 = *Off
     C                   If        D8seq = 'S' Or D8seq = 'T' Or D8seq = 'Y' Or      C                             D8seq = '1' Or D8seq = '2'
                                                                                     C                   If        D8seq = 'Y'
     ** pour le commentaire règlement, on prend que : règlement obligatoire, à      C     D8clst        Chain     TafcliP1
     C                   If        IPregt <> *Zeros And IPregt <> 4 And              C                             IPregt <> 8 And IPregt <> 14
     C                   Goto      Passe                                             C                   Endif
     C                   Endif
     C                   Exsr      Entet                                             C                   Clear                   Comm
     C                   Eval      Comm = D8lib                                      C                   Add       1             Ligne
     C                   Write     Comment                                           C                   Endif
     C     Passe         Tag                                                         C     K10           Reade     Coll10L0                               33
     C                   Enddo                                                       C                   Endsr
     *=========================================================================     * alim entête client
     *=========================================================================     C     AlimCli       Begsr
     C                   Clear                   Unefois                             C                   If        Ligne >= 60
     C                   Clear                   Ligne                               C                   Endif
     C                   Exsr      Entet                                             C                   Eval      SIpal = '(P)'
                                                                                     C                   If        zD5aff2 <> 11
     C                   Clear                   SIPAL                               C                   Endif
                                                                                     C                   Z-add     Code_cli      Codcli
     C     Code_cli      Chain     TafcliP1                                          C                   Clear                   ENSEIG
     C                   MoveL     Ensliv        ENSEIG                              C                   Seton                                        87
     C                   Add       1             Ligne                               C                   Write     EntcliC
     C                   Z-add     Noucli        Code_clis                           C                   Setoff                                       87
     C                   Endsr                                                       *=========================================================================
     *== récup zone couleur JO                                                      *=========================================================================
     C     Couleur       Begsr                                                       C                   Clear                   Coul
     C                   Clear                   Pident                              C                   Move      'ZJO'         Ptable
     C                   MoveL     IPdevise      Pident                              C     Kpar          Chain(n)  Param                              32
     C                   If        *In32 = *Off                                      C                   MoveL     Ptout         Coul
     C                   Endif                                                       C                   Endsr
     *=========================================================================     * routine d'initialisation
     *=========================================================================     C     *Inzsr        Begsr
     C                   Open      IMedborc                                          C                   TIME                    Heure
     C                   Z-add     1             NomEX                               * paramètres : entrepôt
     C     *Entry        Plist                                                       C                   Parm                    pEntrep           1
     * récup date du lendemain                                                      C                   Clear                   DTdem
     C     *DTaara       Define    Demain        DTdem                               C                   In        *DTaara
     * récup date du sur lendemain                                                  C                   Clear                   DTAPDEM
     C     *DTaara       Define    APDEM         DTAPDEM                             C                   In        *DTaara
     * récup date à 72h                                                             C                   Clear                   DTapapd
     C     *DTaara       Define    APAPDEM       DTapapd                             C                   In        *DTaara
     * si affectation à 48h, 78h ou 24h                                             C     *DTaara       Define    Dej064        Deja064           1
     C                   In        *DTaara                                           * modif COLL11 avec le code géographique de l'article
     C                   Exsr      Geograph                                          * clés fichier PARAM
     C     Kpar          Klist                                                       C                   Kfld                    Ptable
     C                   Kfld                    Pident                              * clés fichier COLL11L11
     C     K11L          Klist                                                       C                   Kfld                    zD9LIVR
     C                   Kfld                    zD9CLST                             * clés fichier COLL11L14
     C     K11Lb         Klist                                                       C                   Kfld                    D5LIVR
     C                   Kfld                    D5CLST                              * clés fichier COLL11L12
     C     K12           Klist                                                       C                   Kfld                    zD9LIVR
     C                   Kfld                    zD9CLI                              C                   Kfld                    zD9NUCD
     * clés fichier COLL10L0                                                        C     K10           Klist
     C                   Kfld                    D5LIVR                              C                   Kfld                    D5CLI
     C                   Kfld                    D5FACAN                             C                   Kfld                    D5FACMOIS
     C                   Kfld                    D5FACJOUR                           C                   Kfld                    D5NUCD
     C     K10b          Klist                                                       C                   Kfld                    zD9LIVR
     C                   Kfld                    zD9CLI                              C                   Kfld                    zD9FACAN
     C                   Kfld                    zD9FACMOIS                          C                   Kfld                    zD9FACJOUR
     C                   Kfld                    zD9NUCD                             * clés fichier PREPAP1
     C     KPre          Klist                                                       C                   Kfld                    pEntrep
     C                   Kfld                    M4code                              * clés fichier COLL11L2
     C     KL11L2        Klist                                                       C                   Kfld                    D9livr
     C                   Kfld                    CodeARTIC                           * clés fichier COLL11LN
     C     KL11LHL       Klist                                                       C                   Kfld                    D9livr
     C                   Kfld                    ZoneLot                             C                   Kfld                    Zone4A
     C                   Kfld                    CodeARTIC                           C     K11LN         Klist
     C                   Kfld                    zD9livr                             C                   Kfld                    £lot
     * clés fichier COLL11LU                                                        C     KL11LUL       Klist
     C                   Kfld                    D9livr                              C                   Kfld                    ZoneLot
     C                   Kfld                    D9cli                               C                   Kfld                    Zone4A
     C                   Kfld                    CodeARTIC                           * clés fichier COLL11LO
     C     KL11LLL       Klist                                                       C                   Kfld                    zD9livr
     C                   Kfld                    Zone4A                              C                   Kfld                    CodeARTIC
     * clés fichier COLL11LB                                                        C     KL11LB        Klist
     C                   Kfld                    D5LIVR                              C                   Kfld                    D5FACAN
     C                   Kfld                    D5FACMOIS                           C                   Kfld                    D5FACJOUR
     C                   Kfld                    D5CODE                              * clés fichier COLL11LT
     C     KL11LT        Klist                                                       C                   Kfld                    D5LIVR
     C                   Kfld                    D5FACAN                             C                   Kfld                    D5FACMOIS
     C                   Kfld                    D5FACJOUR                           C                   Kfld                    D5CLI
     C                   Kfld                    D5CODE
     C                   Clear                   Zone4A                              C                   Z-add     00001         CodeARTIC
     ****** chargement tableaux déconsigne du vide ============================     C     'VID'         Setgt     Param
     C     'VID'         ReadPE    Param                                  32         C                   Clear                   TB1
     C                   Clear                   TB1B                                C                   Clear                   TB2
     C                   Clear                   TB3                                 C                   Clear                   TB4
     C                   Clear                   TB5                                 C                   Clear                   A
     C                   Clear                   A2                                  C                   Clear                   B
     C                   Clear                   C                                   C                   Clear                   D
     C                   Clear                   E
     C                   Dow       *In32 = *Off                                      C                   MoveL     Pident        DSident
     C                   MoveL     Ptout         DStaux
     C                   Select                                                      C                   When      DStyp  = '1' And A <= 9
     C                   Add       1             A                                   C                   Z-add     DStaux        TB1(A)
     C                   When      DStyp  = '1' And A >= 9                           C                   Add       1             A
     C                   Add       1             A2                                  C                   Z-add     DStaux        TB1B(A2)
     C                   When      DStyp  = '2'                                      C                   Add       1             B
     C                   Z-add     DStaux        TB2(B)                              C                   When      DStyp  = '3'
     C                   Add       1             C                                   C                   Z-add     DStaux        TB3(C)
     C                   When      DStyp  = '4'                                      C                   Add       1             D
     C                   Z-add     DStaux        TB4(D)                              C                   When      DStyp  = '5'
     C                   Add       1             E                                   C                   Z-add     DStaux        TB5(E)
     C                   Endsl
     C     'VID'         ReadPE    Param                                  32         C                   Enddo
                                                                                     *== alim tableau chiffres pairs
     C                   Z-add     1             Ind                                 C                   Z-add     2             Compt
     C     CHp           Tag                                                         C                   If        Ind <= 25
     C                   Movea     Compt         Tchp(Ind)                           C                   Add       1             Ind
     C                   Add       2             Compt                               C                   Goto      CHp
     C                   Endif                                                       *== alim tableau chiffres impairs
     C                   Z-add     1             Ind                                 C                   Z-add     1             Compt
     C     CHi           Tag                                                         C                   If        Ind <= 25
     C                   Movea     Compt         Tchi(Ind)                           C                   Add       1             Ind
     C                   Add       2             Compt                               C                   Goto      CHi
     C                   Endif                                                       ****** chargement tableau des numéros de lot
     C                   Z-add     1             Ilot                                C                   Clear                   Tlot
     C                   Clear                   £lot                                C     'LOT'         Chain     Param                              32
     C                   Dow       *In32 = *Off                                      C                   If        %Subst(Pident:1:1) = 'S'
     C                   If        %Subst(Pident:2:1) <> 'Z'                         C                   Eval      £lot = %Subst(Pident:2:1)
     C                   Movea     £lot          Tlot(Ilot)                          C                   Add       1             Ilot
     C                   Endif                                                       C                   Endif
     C     'LOT'         Reade     Param                                  32         C                   Enddo
     C                   Endsr
```
