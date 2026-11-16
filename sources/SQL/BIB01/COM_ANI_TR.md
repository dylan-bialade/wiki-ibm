---
bibliotheque: BIB01
fichier_source: QSQLSRC
membre: COM_ANI_TR
type: SQL
longueur_enregistrement: 100
lignes: 811
modifie: 2026-11-16
---

# BIB01/QSQLSRC/COM_ANI_TR

```sql
/******************************************************************************/




-- Triggers sur fichier COM_ANI




-- Libellé    : Trigger pour envoi à LiteSoft




-------------------------------------------------------------------------------




--  Projet     :




--  Auteur     : NBO




--  Date       : 10/04/2024




/******************************************************************************/




CREATE OR REPLACE TRIGGER MAX.COM_ANI_TR




        AFTER INSERT OR UPDATE ON MAX.COM_ANI




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




'ERREUR : Le TRIGGER MAX.COM_ANI_TR a été désactivé !!!!! '




                    );




               -- Désactivation du Trigger --




                UPDATE MAX.TR_ACTIF




                 SET TRIGGER_ACTIF = '0'




                 WHERE nom_trigger = 'MAX.COM_ANI_TR';




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




            WHERE NOM_TRIGGER = 'MAX.COM_ANI_TR'




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




                            'psAction' VALUE 'majAnim',




                            'psType' VALUE TRIM(PTYPE),




                            'psTable' VALUE 'MAX.COM_ANI',




                            'ANM_COD' VALUE TRIM(CHAR(NEW_N.ANM_COD)),




                            'ANM_MR' VALUE TRIM(NEW_N.ANM_MR),




                            'ANM_NOM' VALUE TRIM(NEW_N.ANM_NOM),




                            'ANM_PRE' VALUE TRIM(NEW_N.ANM_PRE),




                            'ANM_RS' VALUE TRIM(NEW_N.ANM_RS),




                            'ANM_NRU' VALUE TRIM(CHAR(NEW_N.ANM_NRU)),




                            'ANM_RUE' VALUE TRIM(NEW_N.ANM_RUE),




                            'ANM_AD2' VALUE TRIM(NEW_N.ANM_AD2),




                            'ANM_PTT' VALUE TRIM(CHAR(NEW_N.ANM_PTT)),




                            'ANM_VIL' VALUE TRIM(NEW_N.ANM_VIL),




                            'ANM_CPA' VALUE TRIM(CHAR(NEW_N.ANM_CPA)),




                            'ANM_NPA' VALUE TRIM(NEW_N.ANM_NPA),




                            'ANM_TEL' VALUE TRIM(NEW_N.ANM_TEL),




                            'ANM_FAX' VALUE TRIM(NEW_N.ANM_FAX),




                            'ANM_MAIL' VALUE TRIM(NEW_N.ANM_MAIL),




                            'ANM_TYP' VALUE TRIM(NEW_N.ANM_TYP),




                            'ANM_CAL' VALUE TRIM(NEW_N.ANM_CAL),




                            'ANM_FOR' VALUE TRIM(CHAR(NEW_N.ANM_FOR)),




                            'ANM_CDU' VALUE TRIM(CHAR(NEW_N.ANM_CDU)),




                            'ANM_CAU' VALUE TRIM(CHAR(NEW_N.ANM_CAU)),




                            'ANM_ZA' VALUE TRIM(NEW_N.ANM_ZA),




                            'ANM_INA' VALUE TRIM(CHAR(NEW_N.ANM_INA)),




                            'ANM_SEC' VALUE TRIM(CHAR(NEW_N.ANM_SEC)),




                            'ANM_SS' VALUE TRIM(CHAR(NEW_N.ANM_SS)),




                            'ANM_NAT' VALUE TRIM(NEW_N.ANM_NAT),




                            'ANM_NAI' VALUE TRIM(CHAR(NEW_N.ANM_NAI)),




                            'ANM_LIE' VALUE TRIM(NEW_N.ANM_LIE),




                            'ANM_PGI' VALUE TRIM(NEW_N.ANM_PGI),




                            'ANM_SUP' VALUE TRIM(CHAR(NEW_N.ANM_SUP)),




                            'ANM_TG1' VALUE TRIM(NEW_N.ANM_TG1),




                            'ANM_TG2' VALUE TRIM(NEW_N.ANM_TG2),




                            'ANM_TG3' VALUE TRIM(NEW_N.ANM_TG3),




                            'ANM_DT1' VALUE TRIM(CHAR(NEW_N.ANM_DT1)),




                            'ANM_DT2' VALUE TRIM(CHAR(NEW_N.ANM_DT2)),




                            'ANM_DT3' VALUE TRIM(CHAR(NEW_N.ANM_DT3))




                        );









        --    else









        --    SET API_DATA = JSON_OBJECT(




        --                  'psAction' VALUE 'majAnim',




        --                  'psType' VALUE TRIM(PTYPE),




        --                  'psTable' VALUE 'MAX.COM_ANI',




        --                  'ANM_COD' VALUE TRIM(CHAR(OLD_O.ANM_COD)),




        --                  'ANM_MR' VALUE TRIM(OLD_O.ANM_MR),




        --                  'ANM_NOM' VALUE TRIM(OLD_O.ANM_NOM),




        --                  'ANM_PRE' VALUE TRIM(OLD_O.ANM_PRE),




        --                  'ANM_RS' VALUE TRIM(OLD_O.ANM_RS),




        --                  'ANM_NRU' VALUE TRIM(CHAR(OLD_O.ANM_NRU)),




        --                  'ANM_RUE' VALUE TRIM(OLD_O.ANM_RUE),




        --                  'ANM_AD2' VALUE TRIM(OLD_O.ANM_AD2),




        --                  'ANM_PTT' VALUE TRIM(CHAR(OLD_O.ANM_PTT)),




        --                  'ANM_VIL' VALUE TRIM(OLD_O.ANM_VIL),




        --                  'ANM_CPA' VALUE TRIM(CHAR(OLD_O.ANM_CPA)),




        --                  'ANM_NPA' VALUE TRIM(OLD_O.ANM_NPA),




        --                  'ANM_TEL' VALUE TRIM(OLD_O.ANM_TEL),




        --                  'ANM_FAX' VALUE TRIM(OLD_O.ANM_FAX),




        --                  'ANM_MAIL' VALUE TRIM(OLD_O.ANM_MAIL),




        --                  'ANM_TYP' VALUE TRIM(OLD_O.ANM_TYP),




        --                  'ANM_CAL' VALUE TRIM(OLD_O.ANM_CAL),




        --                  'ANM_FOR' VALUE TRIM(CHAR(OLD_O.ANM_FOR)),




        --                  'ANM_CDU' VALUE TRIM(CHAR(OLD_O.ANM_CDU)),




        --                  'ANM_CAU' VALUE TRIM(CHAR(OLD_O.ANM_CAU)),




        --                  'ANM_ZA' VALUE TRIM(OLD_O.ANM_ZA),




        --                  'ANM_INA' VALUE TRIM(CHAR(OLD_O.ANM_INA)),




        --                  'ANM_SEC' VALUE TRIM(CHAR(OLD_O.ANM_SEC)),




        --                  'ANM_SS' VALUE TRIM(CHAR(OLD_O.ANM_SS)),




        --                  'ANM_NAT' VALUE TRIM(OLD_O.ANM_NAT),




        --                  'ANM_NAI' VALUE TRIM(CHAR(OLD_O.ANM_NAI)),




        --                  'ANM_LIE' VALUE TRIM(OLD_O.ANM_LIE),




        --                  'ANM_PGI' VALUE TRIM(OLD_O.ANM_PGI),




        --                  'ANM_SUP' VALUE TRIM(CHAR(OLD_O.ANM_SUP)),




        --                  'ANM_TG1' VALUE TRIM(OLD_O.ANM_TG1),




        --                  'ANM_TG2' VALUE TRIM(OLD_O.ANM_TG2),




        --                  'ANM_TG3' VALUE TRIM(OLD_O.ANM_TG3),




        --                  'ANM_DT1' VALUE TRIM(CHAR(OLD_O.ANM_DT1)),




        --                  'ANM_DT2' VALUE TRIM(CHAR(OLD_O.ANM_DT2)),




        --                  'ANM_DT3' VALUE TRIM(CHAR(OLD_O.ANM_DT3))




        --              );









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
