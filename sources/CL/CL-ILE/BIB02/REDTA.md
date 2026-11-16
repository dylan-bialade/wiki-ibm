---
bibliotheque: BIB02
fichier_source: QCLLESRC
membre: REDTA
type: CL/CL-ILE
longueur_enregistrement: 160
lignes: 8
modifie: 2026-11-16
---

# BIB02/QCLLESRC/REDTA

```cl
             PGM                                                                             /* Déclare variable &MYDATA de type caractère longueur de 10. */
                                                                                             /* Crée une DTAARA appelée MYDATAAREA dans la bib *CURLIB */
             /*La DTAARA est de type char avec len de 10 et contient 'Jojo' */
             /* Gère le message (zone de données déjà existante) */
             /* Récupère la valeur actuelle de la zone de données MYDATAAREA */              /* et         la stocke dans la variable &MYDATA. */
                                                                                             SNDPGMMSG  MSG('Valeur de MYDATAAREA : ' *CAT &MYDATA)
             /* Envoie un message indiquant la valeur de la zone de données */               /* MYDATAAREA concaténée avec la variable &MYDATA. */
                                                                                             ENDPGM
```
