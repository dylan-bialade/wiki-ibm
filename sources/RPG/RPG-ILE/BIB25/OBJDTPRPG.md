---
bibliotheque: BIB25
fichier_source: QILETP
membre: OBJDTPRPG
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 94
modifie: 2026-11-25
---

# BIB25/QILETP/OBJDTPRPG

```rpg
**free

CTL-OPT NOMAIN;

// Procédure Détermination informations pour création fichier en sortie
DCL-PROC CurDate EXPORT;
  DCL-PI *n;
    year char(4);
    month char(2);
    seq char(2);
  END-PI;
  dcl-s currentdate date;
  dcl-s sequence char(10);
  // Date du jour
  exec sql
  select current_date into :currentdate from sysibm.sysdummy1;
  // Numéro de sequence aléatoire
  exec sql
  select DIGITS(INT(RAND() * 100)) into :sequence from sysibm.sysdummy1;

  year = %subst(%char(currentdate):1:4);
  month = %subst(%char(currentdate):6:2);
  seq = %subst(sequence:9:2);

  return;
END-PROC;

// Procédure Insertion fichier en sortie
DCL-PROC Trait EXPORT;
  DCL-PI *n;
    file_name char(10);
    file_type char(10);
    file_library char(10);
    src_file_name char(10);
    src_file_library char(10);
    src_mbr_file char(10);
    file_output char(10);
  END-PI;

  DCL-s commande varchar(500);
  dcl-s sql varchar(500);
  DCL-S pgm char(10);
  DCL-S pgm_library char(10);
  DCL-S source_file char(10);
  DCL-S source_file_library char(10);
  DCL-S pgm_member char(10);
  DCL-S pgm_attribut char(10);

  // Si PF et LF
  IF %trim(file_type) = 'PF' or %trim(file_type) = 'LF';

    exec sql
    declare c1 cursor for
    SELECT whpnam , whlib
    FROM dsppgmref
    WHERE WHFNAM = :file_name AND WHLNAM = :file_library;

    exec sql open c1;

    exec sql
    fetch c1 into :pgm , :pgm_library;
    dow sqlcode <> 100;
      commande = 'DSPOBJD OBJ(' + pgm_library + '/' + pgm +
                  ') OBJTYPE(*PGM) OUTFILE(QTEMP/OBJDPGM)';

      exec sql
      call qsys2.qcmdexc(:commande);

      exec sql
      select odsrcf , odsrcl , odsrcm , odobat
      into :source_file, :source_file_library , :pgm_member , :pgm_attribut
      from qtemp.OBJDPGM;

      // Insertion dans le fichier en sortie
      sql = 'INSERT INTO ' + file_output +
          ' (file_name, file_type, file_library, pgm_name, pgm_type,' +
          ' pgm_library, source_file_name, source_library_name) ' +
          'VALUES (''' + file_name + ''', ''' + file_type + ''', ''' +
          file_library + ''', ''' + pgm + ''', ''' + pgm_attribut + ''', ''' +
          pgm_library + ''', ''' + source_file + ''', ''' + pgm_member + ''')';


      exec sql
      execute immediate :sql;


      exec sql
      fetch c1 into :pgm , :pgm_library;
    ENDDO;
    exec sql close c1;
  ENDIF;

  return;
END-PROC;
```
