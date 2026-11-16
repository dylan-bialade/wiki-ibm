---
bibliotheque: BIB02
fichier_source: QCHATGPT
membre: RPGGPT
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 47
modifie: 2026-11-16
---

# BIB02/QCHATGPT/RPGGPT

```rpg
**FREE
FSTUDENT   IF   E           DISK    Renamed(Etudiant:STUDENTR)
FSTUDENTD  CF   E             WORKSTN sfile(STUDENTR:RRN)

D STUDENTR        DS                  Qualified
D  STUDID                      10S 0
D  NAME                        50A
D  FIRSTNAME                   50A
D  BIRTHDATE                    8A
D  SEXE                         1A

 /free
  exsr initSfl;
  dow not *in03;
    exsr readSfl;
    exsr process;
  enddo;
  *inlr = *on;
 /end-free

P initSfl       B
 /free
  write STUDENTCTL;
  setll *start STUDENT;
  reade STUDENTR STUDENT;
  dow not %eof(STUDENT);
    write STUDENTR;
    reade STUDENTR STUDENT;
  enddo;
 /end-free
P initSfl       E

P readSfl       B
 /free
  readc STUDENTR;
 /end-free
P readSfl       E

P process       B
 /free
  if *in08;
    update STUDENTR;
  elseif *in04;
    delete STUDENTR;
  endif;
 /end-free
P process       E
```
