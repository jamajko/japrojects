/
--FUNKCIA
--Tato funkcia vrati scitany plat vsetkych zamestnancov (aj z tabulky LEKARI, aj ASISTENTI) pre vybrane oddelenie. Vstupom pre funkciu je ID oddelenia.
--Pred vratenim scitaneho platu vypise aj pocet ludi, ktori nemaju zaznam o plate (pretoze platy su v tejto databaze nepovinny atribut).
CREATE OR REPLACE FUNCTION funkcia_platy(var_odd IN NUMBER) RETURN NUMBER IS
CURSOR kurzor_id IS SELECT LEKARI_lekari_id FROM ODD_LEK WHERE ODDELENIE_oddelenie_id = var_odd;	--Deklaracia kurzora kurzor_id, obsahuje id lekarov, ktori su priradeni k vybranemu oddeleniu podla var_odd(vstup do funkcie) 
var_kurzor NUMBER;		--do tejto premennej sa bude zapisovat ID lekara z kurzora
scit_al NUMBER := 0;	--premenna pre scitane platy zamestnancov
a_plat NUMBER := 0;		--premenna pre platy asistentov
l_plat NUMBER := 0;		--premenna pre platy lekarov
pocet_n NUMBER :=0;		--do tejto premennej sa bude zapisovat pocet zamestnancov, ktori nemaju uvedeny plat
BEGIN
    OPEN kurzor_id;		--otvorenie kurzora kurzor_id
        LOOP			--cyklus
            FETCH kurzor_id INTO var_kurzor;	--Nacitanie zaznamu z kurzora kurzor_id do premennej var_kurzor.
            EXIT WHEN kurzor_id%NOTFOUND;		--Cyklus bezi dovtedy, kym kurzor ukazuje na nejaky zaznam.
            SELECT lekari_plat INTO l_plat FROM LEKARI WHERE lekari_id = var_kurzor;		--do premennej l_plat nacita plat lekara s ID podla premennej var_kurzor
            SELECT SUM(asistenti_plat) INTO a_plat FROM ASISTENTI WHERE LEKARI_lekari_id = var_kurzor;	--do premennej a_plat nacita scitane platy asistentov lekara s ID podla var_kurzor
            
            IF a_plat IS NULL THEN	--Ak asistent nemal uvedeny plat,...
                a_plat := 0;		--... premenna a_plat sa nastavi na 0 (aby pri scitavani nemala hodnotu NULL)...
                pocet_n := pocet_n + 1;		--... a pocet_n sa zvacsi o 1, co iteruje pocet zamestnancov, co nemaju uvedeny plat
            END IF;
            IF l_plat IS NULL THEN	--Ak lekar nemal uvedeny plat,...
                l_plat := 0;		--... premenna l_plat sa nastavi na 0 (aby pri scitavani nemala hodnotu NULL)...
                pocet_n := pocet_n + 1;		--... a pocet_n sa zvacsi o 1, co iteruje pocet zamestnancov, co nemaju uvedeny plat
            END IF;
            
            scit_al := scit_al + l_plat + a_plat;	--pripocitanie platov lekarov a asistentov do premennej scit_al
        END LOOP;	--koniec cyklu
    CLOSE kurzor_id;	--Zatvorenie kurzora kurzor_id.

    dbms_output.put_line('Počet zamestnancov bez udaneho platu: ' || pocet_n);	--Vypis poctu zamestnancov, ktori nemaju vedeny plat z premennej pocet_n

    RETURN(scit_al);	--Vratenie hodnoty scit_al (scitane platy zamestnancov pre oddelenie)
END funkcia_platy;
/
BEGIN
    dbms_output.put_line('Celkový plat zamestnancov na tomto oddelení: ' || funkcia_platy(11));	--Vstupom do funkcie funkcia_platy je ID oddelenia.
END;










/
--PROCEDURA
--Tato procedura vlozi alebo aktualizuje zaznam do tabulky PACIENTI. Ak sa rodne cislo uz v tabulke nachadza, nevlozi sa novy zoznam, ale aktualizuju sa udaje v riadku podla rodneho cisla (identifikatora).
CREATE OR REPLACE PROCEDURE ZAPIS_PACIENTOV(var_rodcis IN NUMBER, var_meno IN VARCHAR2, var_priezvisko IN VARCHAR2, var_telefon IN NUMBER) IS
    CURSOR kurzor_pacienti IS SELECT pacienti_rodcis FROM PACIENTI;	--Deklaracia kurzora, ktory pozostava z rodnych cisiel v tabulke PACIENTI
    var_kurzor kurzor_pacienti%ROWTYPE;	--premenna typu kurzora kurzor_pacienti
    var_zhoda NUMBER := 0;	--Podla hodnoty tejto premennej budeme vediet, ci sa v tabulke uz nenachadza pacient s rovnakym rodnym cislom.
BEGIN
    OPEN kurzor_pacienti;	--Otvorenie kurzora kurzor_pacienti s rodnymi cislami.
        LOOP	--Cyklus
            FETCH kurzor_pacienti INTO var_kurzor;	--Nacitanie zaznamu z kurzora kurzor_pacienti do premennej var_kurzor.
            EXIT WHEN kurzor_pacienti%NOTFOUND;	--Cyklus bezi dovtedy, kym kurzor ukazuje na nejaky zaznam.
            IF var_rodcis = var_kurzor.pacienti_rodcis THEN		--Ak sa v behu cyklu kurzorom najde rovnake rodne cislo, ake chceme vlozit z premennej var_rodcis...
                var_zhoda := 1;		--... premenna var_zhoda sa zmeni z 0 na 1 a podla toho vieme, ze rodne cislo sa v tabulke nachadza a teda zaznam bude neskor iba updateovany.
            END IF;  
        END LOOP;	--Koniec cyklu
    CLOSE kurzor_pacienti;	--Zatvorenie kurzora kurzor_pacienti.
    
    IF var_zhoda = 1 THEN	--Ak sa teda zhoda rodneho cisla nasla...
        UPDATE PACIENTI
        SET pacienti_meno=var_meno, pacienti_priezvisko=var_priezvisko, pacienti_telefon=var_telefon
        WHERE pacienti_rodcis = var_rodcis;		--... udaje o pacientovi sa iba aktualizuju a rodne cislo ostane. Nevytvara sa novy zaznam.
    ELSE	--V inom pripade to znamena, ze sa zhoda v rodnych cislach pacientov nenasla a to znamena, ze treba vytvorit novy zaznam s rodnym cislom, ktore sa este v tabulke nenachadza.
        INSERT INTO PACIENTI
        VALUES (var_rodcis, var_meno, var_priezvisko, var_telefon);		--Udaje sa vlozia z premennych var_rodcis, var_meno, var_priezvisko, var_telefon
    END IF;
END ZAPIS_PACIENTOV;
/
BEGIN
    ZAPIS_PACIENTOV(501, 'Anton', 'Antoniovic', 1234567890);
	--Pri tejto funkcii je nutne vlozit/aktualizovat vsetky udaje. Aj tie ktore su v tabulke nepovinne.
	--Ak niektore z udajov v tabulke PACIENTI aktualizovat nechcete, treba ako vstup napisat Ten isty udaj, ktory tam uz je.
END;










/
--TRIGGER
--Tento trigger vypise vlozene a aktualizovane udaje s datumom a casom kedy boli udaje zmenene.
--Pri UPDATING zaroven zabrani pripadnemu pokusu zmenit pacientovi rodne cislo.
--Pri UPDATING okrem novych udajov vypise aj tie stare, aby si pouzivatel mohol skontrolovat ktore zmenil za ktore.
CREATE OR REPLACE TRIGGER trigger_pacienti BEFORE INSERT OR UPDATE ON PACIENTI FOR EACH ROW
DECLARE
    var_datum VARCHAR2(30);	--Tato premenna bude pouzita na datumu a cas, kedy boli data zmenene alebo pridane.
BEGIN

    SELECT TO_CHAR(SYSDATE, 'DD.MM.YYYY HH24:MI') INTO var_datum FROM DUAL;	--SELECT na nacitanie aktualneho casu do premennej var_datum.
    dbms_output.put_line('================================================================================================================================');	--sprehladnenie vypisu.
    DBMS_OUTPUT.NEW_LINE;	--Vynechanie riadka - sprehladnenie vypisu.
	
    IF INSERTING THEN	--AK sa vklada novy zaznam.
        dbms_output.put_line('PRIDALI STE NOVÉHO PACIENTA:');	--Vypis o pridani pacienta.
        dbms_output.put_line('MENO: ' || :NEW.pacienti_meno || ',  PRIEZVISKO: ' || :NEW.pacienti_priezvisko || ',  TELEFÓNNE ČÍSLO: ' || :NEW.pacienti_telefon);	--Vypise vlozene udaje o pacientovi.
        dbms_output.put_line('V ČASE: ' || var_datum);	--Vypise datum a cas kedy boli udaje vlozene z premennej var_datum
		
		
    ELSIF UPDATING THEN	--AK sa udaje aktualizuju.
        IF :OLD.pacienti_rodcis != :NEW.pacienti_rodcis THEN	--Skontroluje sa, ci sa niekto nepokusil zmenit pacientovi rodne cislo v zazname.
            RAISE_APPLICATION_ERROR(-20001, 'NIE JE MOŽNÉ PACIENTOVI ZMENIŤ RODNÉ ČÍSLO');	--ak áno, zabrani sa prepisaniu a vypise error.
		--Ak sa v databaze nachadza nespravne rodne cislo, treba vymazat cely zaznam a pacienta vlozit znova. Aktualizovat rodne cislo sa ale nesmie.
        END IF;
        dbms_output.put_line('PACIENT SA V DATABÁZE NACHÁDZA.');	--Vypis o aktualizovani pacienta
        dbms_output.put_line('AKTUALIZÁCIA PREBEHLA: ' || var_datum);	--Vypise datum a cas kedy prebehla aktualizacia z premennej var_datum.
        DBMS_OUTPUT.NEW_LINE;	--Vynechanie riadka - sprehladnenie vypisu
        dbms_output.put_line('PôVODNÉ ÚDAJE:');	--Vypis POVODNE UDAJE
        dbms_output.put_line('MENO: ' || :OLD.pacienti_meno || ',  PRIEZVISKO: ' || :OLD.pacienti_priezvisko || ',  TELEFÓNNE ČÍSLO: ' || :OLD.pacienti_telefon);	--Vypise stare udaje o pacientovi
        DBMS_OUTPUT.NEW_LINE;	--Vynechanie riadka - sprehladnenie vypisu.
        dbms_output.put_line('NOVÉ ÚDAJE:');	--Vypis NOVE UDAJE:
        dbms_output.put_line('MENO: ' || :NEW.pacienti_meno || ',  PRIEZVISKO: ' || :NEW.pacienti_priezvisko || ',  TELEFÓNNE ČÍSLO: ' || :NEW.pacienti_telefon);	--Vypise aktualizovane udaje o pacientovi
    END IF;
	
    DBMS_OUTPUT.NEW_LINE;	--Vynechanie riadka - sprehladnenie vypisu.
    dbms_output.put_line('================================================================================================================================'); --sprehladnenie vypisu.
	
END trigger_pacienti;









/
--SCHEDULER
--Tento scheduler raz mesacne meni asistentovi s ID 10 nadriadeneho lekara (dvaja lekari si mesacne striedaju tohto asistenta)
BEGIN
    dbms_scheduler.create_job(
        job_name => 'zmena_lekara',		--Nazov scheduleru
        job_type => 'PLSQL_BLOCK',		--typ akcie scheduleru
        job_action => '
        DECLARE
                var_aktual NUMBER;	--premenna pre aktualneho nadriadeneho
            BEGIN
                SELECT LEKARI_lekari_id INTO var_aktual FROM ASISTENTI WHERE asistenti_id=10;	--Do premennej var_aktual sa nacita aktualny nadriadeny asistenta s ID 10 z LEKARI_lekari_id
                IF var_aktual=57 THEN															--Ak je aktualny nadriadeny lekar s ID 57...
                    UPDATE ASISTENTI SET LEKARI_lekari_id = 38 WHERE asistenti_id = 10;			--...zmeni sa nadriadeny na lekara s ID 38	
                ELSE
                    UPDATE ASISTENTI SET LEKARI_lekari_id = 57 WHERE asistenti_id = 10;			--Inak sa LEKARI_lekari_id zmeni na 57
                END IF;
            END;',
        start_date => TIMESTAMP '2022-05-02 21:35:00',
        repeat_interval => 'FREQ=MONTHLY; INTERVAL=1', --scheduler sa spusta raz za mesiac
        end_date => NULL,	--nema urceny cas kedy sa ma vypnut
        enabled => TRUE
    );
END;