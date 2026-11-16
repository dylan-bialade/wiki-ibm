---
bibliotheque: BIB05
fichier_source: QCLPSRC
membre: MENUFM
type: CL/CL-procedural
longueur_enregistrement: 80
lignes: 36
modifie: 2026-11-16
---

# BIB05/QCLPSRC/MENUFM

```cl
     A*%%TS  SD  20260922  133250  DYLAN2      REL-V7R5M0  5770-WDS
     A*%%EC
     A                                      DSPSIZ(24 80 *DS3)
     A          R FMT1
     A*%%TS  SD  20260922  133250  DYLAN2      REL-V7R5M0  5770-WDS
     A                                      CF03(03)
     A                                      CF09(09)
     A                                  1 36'menu dylan'
     A                                  1  2USER
     A                                  2  2SYSNAME
     A                                  1 69DATE
     A                                      EDTCDE(Y)
     A                                  2 68TIME
     A                                  4  5' 1. PDM avec  *curlib/qdssrc'
     A                                  5  5' 2. pdm avec  *curlib/qclpsrc'
     A                                  6  5' 3. start sda '
     A                                  7  5' 4. start pdm '
     A                                  8  5' 5. wrkusrjob '
     A                                 10  3'input'
     A                                 11  4'output'
     A            FLD002         2A  I 10 11
     A            FLD005         4A  O 11 12
     A                                 12  4'both'
     A            FLD006         1A  B 12 10
     A                                 13  4'input num'
     A            FLD007         1S 0I 13 15
     A                                 14  4'output num'
     A            FLD008         1S 0O 14 16
     A                                 15  4'both num'
     A            FLD009         1S 0B 15 16
     A                                  9  6'option:'
     A            OPT           10S 0B  9 16
     A                                 20 16'sort avec f3  '
     A                                 20 35'd all spool f9  '
     A  99                             17 18'spool dtl'
     A                                      COLOR(PNK)
```
