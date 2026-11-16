---
bibliotheque: BIB20
fichier_source: QRPGSRC
membre: CYCDEMO
type: RPG/RPG-III-400
longueur_enregistrement: 80
lignes: 183
modifie: 2026-11-16
---

# BIB20/QRPGSRC/CYCDEMO

Repere de colonnes :

```text
         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```

```text
      * ======================================================================
      * CYCDEMO  - Programme de demonstration du CYCLE RPG III (RPG/400)
      * ======================================================================
      * Etat des pesees du pont-bascule, par secteur puis par tournee.
      * Donnees : TOURNEE, PESEE, SECTEUR dans BIB20 (copie de TPCYCLE).
      *
      * Rubriques du cycle illustrees :
      *  1. Fichier PRIMAIRE (IP) et SECONDAIRE (IS) lus par le cycle
      *  2. Indicateurs d'identification d'enregistrement (01, 02)
      *  3. Niveaux de controle L1 (tournee) et L2 (secteur)
      *  4. Concordance des enregistrements M1 / indicateur MR
      *  5. Indicateur de zone (60 = tare a zero)
      *  6. Calculs de DETAIL et calculs de TOTAL (L1, L2, LR)
      *  7. Indicateur 1P : en-tetes de la premiere page
      *  8. Debordement OF et saut force (fetch overflow F)
      *  9. Sorties H (en-tete), D (detail), T (total)
      * 10. Mise a blanc apres impression (B) des cumuls
      * 11. Fin de fichier : LR mis par le cycle, pas de SETON LR
      *
      * Ordre d'un tour de cycle :
      *   ecriture H/D -> lecture -> rupture ? -> calculs T -> sorties T
      *   -> LR ? fin -> transfert des zones -> calculs D -> sorties D
      * ======================================================================
      *
      * --- Specification H : date JJ/MM/AA (D /), virgule decimale (J)
     H            D/J
      *
      * --- Specifications F
      * TOURNEE : PRIMAIRE (I en 15, P en 16), acces par cle (K en 31)
      * PESEE   : SECONDAIRE (S en 16), lue en concordance M1 avec
      *           TOURNEE (meme cle de tri)
      * SECTEUR : entree a acces procedural (F en 16), lu par CHAIN
      * QSYSPRT : imprimante decrite par programme, 132 colonnes,
      *           indicateur de debordement OF en colonnes 33-34
     FTOURNEE IP  E           K        DISK
     FPESEE   IS  E           K        DISK
     FSECTEUR IF  E           K        DISK
     FQSYSPRT O   F     132     OF     PRINTER
      *
      * --- Specifications I
      * Format TOURNEER -> indicateur d'identification 01 (col 19-20)
      * TRNSEC : zone de controle L2 (col 59-60)
      * TRNCOD : zone de controle L1 + zone de concordance M1 (61-62)
     ITOURNEER    01
     I                                              TRNSECL2
     I                                              TRNCODL1M1
      * Format PESEER -> indicateur 02
      * Memes niveaux et meme concordance : les zones doivent avoir
      * la meme longueur et le meme ordre de tri que dans TOURNEE.
      * PSTAR : indicateur de zone 60 allume si la tare vaut zero
      *         (colonnes 69-70 = zero ou blanc)
     IPESEER      02
     I                                              PSSEC L2
     I                                              PSTRN L1M1
     I                                              PSTAR           60
      *
      * ======================================================================
      * CALCULS DE DETAIL (rien en colonnes 7-8)
      * Executes a chaque enregistrement lu, APRES les calculs de total
      * du groupe precedent. Ici, L1/L2 allumes = premier enregistrement
      * du nouveau groupe.
      * ======================================================================
      * Debut d'un groupe tournee : extinction des indicateurs
      * d'anomalie du groupe precedent
     C   L1                SETOF                     5152
      * Enregistrement TOURNEE (01)
      * 01 sans MR = tournee sans aucune pesee -> 52
     C   01                MOVE TRNCOD    CODT    4
     C   01                MOVE TRNSEC    SECW    2
     C   01NMR             SETON                         52
      * Enregistrement PESEE (02)
      * 02 sans MR = pesee dont la tournee n'existe pas -> 51
     C   02                MOVE PSTRN     CODT
     C   02                MOVE PSSEC     SECW
     C   02NMR             SETON                     51
      * Poids net : seulement si la tare est connue (N60)
     C   02                Z-ADD0         NET     60
     C   02N60   PSBRU     SUB  PSTAR     NET
     C   02      1         ADD  NBP1      NBP1    50
     C   02      NET       ADD  REA1      REA1    90
      * Debut d'un groupe secteur : lecture du libelle par CHAIN
      * 70 = secteur introuvable (colonnes 54-55)
     C   L2      SECW      CHAINSECTEUR              70
      *
      * ======================================================================
      * CALCULS DE TOTAL (L1, L2 ou LR en colonnes 7-8)
      * Executes a la rupture, AVANT le transfert des zones du nouvel
      * enregistrement : les zones contiennent encore l'ancien groupe.
      * Une rupture L2 allume aussi L1 ; LR allume L1 a L9.
      * ======================================================================
      * Total tournee : poids moyen par pesee, cumul vers le secteur
     CL1                   Z-ADD0         MOY1    70
     CL1         NBP1      COMP 0                    55
     CL1 55      REA1      DIV  NBP1      MOY1      H
     CL1         NBP1      ADD  NBP2      NBP2    50
     CL1         REA1      ADD  REA2      REA2    90
      * Total secteur : cumul vers le total general
     CL2         NBP2      ADD  NBPG      NBPG    50
     CL2         REA2      ADD  REAG      REAG    90
      * Total general : rien a calculer, LR imprime les cumuls.
      * Pas de SETON LR : le cycle allume LR seul en fin de fichier.
      *
      * ======================================================================
      * SORTIES
      * H/D : ecrites en debut de tour, apres les calculs de detail
      * T   : ecrites a la rupture, apres les calculs de total
      * Colonnes 17-18 = interligne avant/apres, 19-22 = saut
      * avant/apres a la ligne n, 16 = F (fetch overflow)
      * ======================================================================
      * En-tetes : premiere page (1P) OU debordement (OF)
      * Saut a la ligne 01 avant impression ; UDATE et PAGE sont
      * des zones reservees fournies par le systeme
     OQSYSPRT H  101   1P
     O       OR        OF
     O                                   24 'SITOM DES TROIS RIVIÈRES'
     O                                   66 'PESÉES PAR TOURNÉE'
     O                                  109 'Édité le'
     O                         UDATE Y  118
     O                                  125 'Page'
     O                         PAGE  Z  130
     OQSYSPRT H  2     1P
     O       OR        OF
     O                                    7 'Tournée'
     O                                   16 'Ticket'
     O                                   27 'Date'
     O                                   38 'Camion'
     O                                   44 'Flux'
     O                                   56 'Brut kg'
     O                                   67 'Tare kg'
     O                                   78 'Net kg'
     O                                  100 'Observation'
      * Detail L2 : titre du secteur, au 1er enregistrement du groupe
     OQSYSPRT D 11     L2
     O                                    8 'Secteur'
     O                         SECW      11
     O                N70      SECNOM    32
     O                 70                32 'SECTEUR INCONNU'
     O                N70                48 'Responsable :'
     O                N70      SECRES    69
      * Detail 01 : la tournee (fetch F : saut de page anticipe si OF)
     OQSYSPRT DF 1     01
     O                         TRNCOD     6
     O                                   12 'Flux'
     O                         TRNFLX    16
     O                         TRNJOU    27
     O                         TRNCHF    48
     O                         TRNCAM    58
     O                 52               113 'SANS PESÉE'
      * Detail 02 : une ligne par pesee
      * 60 (indicateur de zone) : tare a zero, net non calcule
     OQSYSPRT DF 1     02
     O                 51      PSTRN      6
     O                         PSTKT Z   16
     O                         PSDAT     27
     O                         PSCAM     38
     O                         PSFLX     43
     O                         PSBRU 3   56
     O                         PSTAR 3   67
     O                N60      NET   3   78
     O                 60               112 'TARE ABSENTE'
     O                 51               116 'TOURNÉE INCONNUE'
      * Total L1 : B (col 39) remet NBP1 et REA1 a zero apres impression
     OQSYSPRT T  1     L1
     O                                   20 'Total tournée'
     O                         CODT      25
     O                         NBP1  3B  33
     O                                   41 'pesées'
     O                                   56 'moyenne'
     O                         MOY1  3   67
     O                         REA1  3B  78
      * Total L2 : interligne 1 avant, 1 apres
     OQSYSPRT T 11     L2
     O                                   20 'TOTAL SECTEUR'
     O                         SECW      23
     O                         NBP2  3B  33
     O                                   41 'pesées'
     O                         REA2  3B  78
      * Total LR : imprime une seule fois, en fin de fichier
     OQSYSPRT T 2      LR
     O                                   20 'TOTAL GÉNÉRAL'
     O                         NBPG  3   33
     O                                   41 'pesées'
     O                         REAG  3   78
```
