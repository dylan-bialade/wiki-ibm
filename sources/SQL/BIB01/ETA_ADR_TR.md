---
bibliotheque: BIB01
fichier_source: QSQLSRC
membre: ETA_ADR_TR
type: SQL
longueur_enregistrement: 100
lignes: 986
modifie: 2026-11-16
---

# BIB01/QSQLSRC/ETA_ADR_TR

```sql
/******************************************************************************/




-- Triggers sur fichier ETA_ADR




-- Libellé    : Trigger pour envoi à LiteSoft




-------------------------------------------------------------------------------




--  Projet     :




--  Auteur     : NBO




--  Date       : 10/04/2024




/******************************************************************************/




CREATE OR REPLACE TRIGGER MAX.ETA_ADR_TR




        AFTER INSERT OR UPDATE ON MAX.ETA_ADR




        REFERENCING NEW AS NEW_N




                    OLD AS OLD_O




        FOR EACH ROW




        SET OPTION COMMIT = *NONE,




                  DBGVIEW = *SOURCE,




                ALWCPYDTA = *OPTIMIZE




    BEGIN ATOMIC




        DECLARE PTYPE CHAR(6);




        DECLARE API_DATA CHAR(10000);




        DECLARE TRG_ACTIF CHAR(1);




        DECLARE BIB_DTAQ CHAR(10);




        DECLARE NOM_DTAQ CHAR(10);




       -----------------------------------




        --  Gestion erreur handler       --




        -----------------------------------




        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION




        BEGIN




                 -- Notification Erreur     --




               CALL QSYS2.SEND_MESSAGE(




                MESSAGE_ID => 'SQL7064',




                MESSAGE_LENGTH => 56,




                MESSAGE_TEXT =>




'ERREUR : Le TRIGGER MAX.ETA_ADR_TR a été désactivé !!!!! '




                    );




               -- Désactivation du Trigger --




                UPDATE MAX.TR_ACTIF




                 SET TRIGGER_ACTIF = '0'




                 WHERE nom_trigger = 'MAX.ETA_ADR_TR';




        END;




        -----------------------------------




        --     Controle trigger actif    --




        -----------------------------------




        SELECT TRIGGER_ACTIF,




               BIB_DTAQ,




               NOM_DTAQ




            INTO TRG_ACTIF,




                 BIB_DTAQ,




                 NOM_DTAQ




            FROM MAX.TRIGGERACTIF




            WHERE NOM_TRIGGER = 'MAX.ETA_ADR_TR'




            FETCH FIRST 1 ROWS ONLY;









        IF TRG_ACTIF = '1' THEN




            -----------------------------------




            ---  Definition du mode         ---




            -----------------------------------




            CASE




                WHEN INSERTING THEN SET PTYPE = 'INSERT';




                WHEN UPDATING  THEN SET PTYPE = 'UPDATE';




                WHEN DELETING  THEN SET PTYPE = 'DELETE';




            END CASE;




            -----------------------------------




            --  Creation du JSON             --




            -----------------------------------









            CASE




            WHEN PTYPE = 'INSERT' OR PTYPE = 'UPDATE' then









            SET API_DATA = JSON_OBJECT(




                            'psAction' VALUE 'majEtab',




                            'psType' VALUE TRIM(PTYPE),




                            'psTable' VALUE 'MAX.ETA_ADR',




                            'ETA_NUM' VALUE TRIM(CHAR(NEW_N.ETA_NUM)),




                            'ETA_AD' VALUE TRIM(NEW_N.ETA_AD),




                            'ETA_RUE' VALUE TRIM(CHAR(NEW_N.ETA_RUE)),




                            'ETA_NRU' VALUE TRIM(NEW_N.ETA_NRU),




                            'ETA_A49' VALUE TRIM(NEW_N.ETA_A49),




                            'ETA_PTT' VALUE TRIM(CHAR(NEW_N.ETA_PTT)),




                            'ETA_BUR' VALUE TRIM(NEW_N.ETA_BUR),




                            'ETA_DPT' VALUE TRIM(CHAR(NEW_N.ETA_DPT)),




                            'ETA_PTTE' VALUE TRIM(NEW_N.ETA_PTTE),




                            'ETA_CPI' VALUE TRIM(CHAR(NEW_N.ETA_CPI)),




                            'ETA_NPA' VALUE TRIM(NEW_N.ETA_NPA),




                            'ETA_INS' VALUE TRIM(NEW_N.ETA_INS),




                            'ETA_NDL' VALUE TRIM(NEW_N.ETA_NDL),




                            'ETA_RUE2' VALUE TRIM(CHAR(NEW_N.ETA_RUE2)),




                            'ETA_NRU2' VALUE TRIM(NEW_N.ETA_NRU2),




                            'ETA_LIV' VALUE TRIM(NEW_N.ETA_LIV),




                            'ETA_TLF' VALUE TRIM(NEW_N.ETA_TLF),




                            'ETA_FAX' VALUE TRIM(NEW_N.ETA_FAX),




                            'ETA_MAI' VALUE TRIM(NEW_N.ETA_MAI),




                            'ETA_MAI2' VALUE TRIM(NEW_N.ETA_MAI2),




                            'ETA_TYP' VALUE TRIM(NEW_N.ETA_TYP),




                            'ETA_NBC' VALUE TRIM(CHAR(NEW_N.ETA_NBC)),




                            'ETA_NBE' VALUE TRIM(CHAR(NEW_N.ETA_NBE)),




                            'ETA_MR' VALUE TRIM(NEW_N.ETA_MR),




                            'ETA_PRE' VALUE TRIM(NEW_N.ETA_PRE),




                            'ETA_NOM' VALUE TRIM(NEW_N.ETA_NOM),




                            'ETA_COM' VALUE TRIM(NEW_N.ETA_COM),




                            'ETA_MR2' VALUE TRIM(NEW_N.ETA_MR2),




                            'ETA_PRE2' VALUE TRIM(NEW_N.ETA_PRE2),




                            'ETA_NOM2' VALUE TRIM(NEW_N.ETA_NOM2),




                            'ETA_COM2' VALUE TRIM(NEW_N.ETA_COM2),




                            'ETA_TG1' VALUE TRIM(NEW_N.ETA_TG1),




                            'ETA_TG2' VALUE TRIM(NEW_N.ETA_TG2),




                            'ETA_TG3' VALUE TRIM(NEW_N.ETA_TG3),




                            'ETA_TG4' VALUE TRIM(NEW_N.ETA_TG4),




                            'ETA_TG5' VALUE TRIM(NEW_N.ETA_TG5),




                            'ETA_D01' VALUE TRIM(CHAR(NEW_N.ETA_D01)),




                            'ETA_D02' VALUE TRIM(CHAR(NEW_N.ETA_D02)),




                            'ETA_DT1' VALUE TRIM(CHAR(NEW_N.ETA_DT1)),




                            'ETA_DT2' VALUE TRIM(CHAR(NEW_N.ETA_DT2)),




                            'ETA_DT3' VALUE TRIM(CHAR(NEW_N.ETA_DT3)),




                            'ETA_DT4' VALUE TRIM(CHAR(NEW_N.ETA_DT4)),




                            'ETA_DT5' VALUE TRIM(CHAR(NEW_N.ETA_DT5)),




                            'PAYPAY' VALUE




                            CASE




                                WHEN NEW_N.ETA_CPI = 0 THEN 'FR'




                                ELSE (SELECT PAYPAY




                                            FROM AUT.PAYS




                                            WHERE PAYALP = NEW_N.ETA_CPI




                                            FETCH FIRST 1 ROWS ONLY)




                            END









                    );









         -- else









         -- SET API_DATA = JSON_OBJECT(




         --                   'psAction' VALUE 'majEtab',




         --                   'psType' VALUE TRIM(PTYPE),




         --                   'psTable' VALUE 'MAX.ETA_ADR',




         --                   'ETA_NUM' VALUE TRIM(CHAR(OLD_O.ETA_NUM)),




         --                   'ETA_AD' VALUE TRIM(OLD_O.ETA_AD),




         --                   'ETA_RUE' VALUE TRIM(CHAR(OLD_O.ETA_RUE)),




         --                   'ETA_NRU' VALUE TRIM(OLD_O.ETA_NRU),




         --                   'ETA_A49' VALUE TRIM(OLD_O.ETA_A49),




         --                   'ETA_PTT' VALUE TRIM(CHAR(OLD_O.ETA_PTT)),




         --                   'ETA_BUR' VALUE TRIM(OLD_O.ETA_BUR),




         --                   'ETA_DPT' VALUE TRIM(CHAR(OLD_O.ETA_DPT)),




         --                   'ETA_PTTE' VALUE TRIM(OLD_O.ETA_PTTE),




         --                   'ETA_CPI' VALUE TRIM(CHAR(OLD_O.ETA_CPI)),




         --                   'ETA_NPA' VALUE TRIM(OLD_O.ETA_NPA),




         --                   'ETA_INS' VALUE TRIM(OLD_O.ETA_INS),




         --                   'ETA_NDL' VALUE TRIM(OLD_O.ETA_NDL),




         --                   'ETA_RUE2' VALUE TRIM(CHAR(OLD_O.ETA_RUE2)),




         --                   'ETA_NRU2' VALUE TRIM(OLD_O.ETA_NRU2),




         --                   'ETA_LIV' VALUE TRIM(OLD_O.ETA_LIV),




         --                   'ETA_TLF' VALUE TRIM(OLD_O.ETA_TLF),




         --                   'ETA_FAX' VALUE TRIM(OLD_O.ETA_FAX),




         --                   'ETA_MAI' VALUE TRIM(OLD_O.ETA_MAI),




         --                   'ETA_MAI2' VALUE TRIM(OLD_O.ETA_MAI2),




         --                   'ETA_TYP' VALUE TRIM(OLD_O.ETA_TYP),




         --                   'ETA_NBC' VALUE TRIM(CHAR(OLD_O.ETA_NBC)),




         --                   'ETA_NBE' VALUE TRIM(CHAR(OLD_O.ETA_NBE)),




         --                   'ETA_MR' VALUE TRIM(OLD_O.ETA_MR),




         --                   'ETA_PRE' VALUE TRIM(OLD_O.ETA_PRE),




         --                   'ETA_NOM' VALUE TRIM(OLD_O.ETA_NOM),




         --                   'ETA_COM' VALUE TRIM(OLD_O.ETA_COM),




         --                   'ETA_MR2' VALUE TRIM(OLD_O.ETA_MR2),




         --                   'ETA_PRE2' VALUE TRIM(OLD_O.ETA_PRE2,




         --                   'ETA_NOM2' VALUE TRIM(OLD_O.ETA_NOM2),




         --                   'ETA_COM2' VALUE TRIM(OLD_O.ETA_COM2),




         --                   'ETA_TG1' VALUE TRIM(OLD_O.ETA_TG1),




         --                   'ETA_TG2' VALUE TRIM(OLD_O.ETA_TG2),




         --                   'ETA_TG3' VALUE TRIM(OLD_O.ETA_TG3),




         --                   'ETA_TG4' VALUE TRIM(OLD_O.ETA_TG4),




         --                   'ETA_TG5' VALUE TRIM(OLD_O.ETA_TG5),




         --                   'ETA_D01' VALUE TRIM(CHAR(OLD_O.ETA_D01)),




         --                   'ETA_D02' VALUE TRIM(CHAR(OLD_O.ETA_D02)),




         --                   'ETA_DT1' VALUE TRIM(CHAR(OLD_O.ETA_DT1)),




         --                   'ETA_DT2' VALUE TRIM(CHAR(OLD_O.ETA_DT2)),




         --                   'ETA_DT3' VALUE TRIM(CHAR(OLD_O.ETA_DT3)),




         --                   'ETA_DT4' VALUE TRIM(CHAR(OLD_O.ETA_DT4)),




         --                   'ETA_DT5' VALUE TRIM(CHAR(OLD_O.ETA_DT5)),




         --                   'PAYPAY' VALUE




         --                   CASE




         --                       WHEN NEW_N.ETA_CPI = 0 THEN 'FR'




         --                       ELSE (SELECT PAYPAY




         --                                   FROM AUT.PAYS




         --                                   WHERE PAYALP = NEW_N.ETA_CPI




         --                                   FETCH FIRST 1 ROWS ONLY)




         --                   END,




         --




         --    );









            END CASE;




            -----------------------------------




            -- Ecriture du JSON dans la DTAQ --




            -----------------------------------




            CALL QSYS2.SEND_DATA_QUEUE(




                MESSAGE_DATA       => API_DATA,




                DATA_QUEUE         => NOM_DTAQ,




                DATA_QUEUE_LIBRARY => BIB_DTAQ




            );




            -----------------------------------




        END IF;




    END;
```
