--15a
CREATE VIEW pohlad AS SELECT lekari_id, lekari_titul, lekari_meno, lekari_priezvisko, lekari_plat FROM LEKARI WHERE lekari_id >= 100 AND lekari_id <= 150;


--1a, 1b, 2a, 10a, 13a
SELECT X.NEMOCNICA_nemocnica_id, SUM(Y.nemocnica_supcis) FROM ODDELENIE X JOIN NEMOCNICA Y ON X.NEMOCNICA_nemocnica_id = nemocnica_id 
WHERE Y.nemocnica_supcis > 40 GROUP BY X.NEMOCNICA_nemocnica_id HAVING X.NEMOCNICA_nemocnica_id > 10 ORDER BY X.NEMOCNICA_nemocnica_id;


--3a
SELECT lekari_meno AS MENO, lekari_priezvisko AS PRIEZVISKO FROM LEKARI UNION SELECT asistenti_meno, asistenti_priezvisko FROM ASISTENTI;


--3b, 3c
SELECT pacienti_rodcis FROM PACIENTI MINUS SELECT oddelenie_id FROM ODDELENIE INTERSECT SELECT asistenti_id FROM ASISTENTI;


--4a, 4b, 16a
SELECT X.lekari_meno, X.lekari_priezvisko, X.lekari_plat FROM (SELECT * FROM LEKARI WHERE lekari_meno != 'Haze') X 
WHERE X.lekari_plat > (SELECT MAX(Y.lekari_plat) FROM POHLAD Y WHERE Y.lekari_priezvisko != 'Saberton') ORDER BY X.lekari_plat;


--4c
SELECT Y.oddelenie_id, Y.oddelenie_nazov, (SELECT nemocnica_mesto FROM NEMOCNICA X WHERE Y.NEMOCNICA_nemocnica_id = X.nemocnica_id) MESTO FROM ODDELENIE Y;


--4d, 13b
SELECT asistenti_meno, asistenti_priezvisko, PACIENTI_pacienti_rodcis FROM LEK_PAC JOIN ASISTENTI USING(LEKARI_lekari_id) 
WHERE EXISTS(SELECT 1 FROM LEK_PAC) ORDER BY asistenti_priezvisko, asistenti_meno;


--5a, 5b, 8a, 8b, 11a
SELECT X.nemocnica_id, X.nemocnica_mesto, 
COUNT(Y.oddelenie_id) OVER (PARTITION BY Y.NEMOCNICA_nemocnica_id) POCET,
ROW_NUMBER() OVER (ORDER BY X.nemocnica_id) RIADOK,
RANK() OVER (ORDER BY X.nemocnica_id) RANK
FROM NEMOCNICA X JOIN ODDELENIE Y ON Y.NEMOCNICA_nemocnica_id = X.nemocnica_id WHERE X.nemocnica_mesto NOT IN('Wanmingang', 'Mucifal', 'Huiwan');


--6a, 6b
SELECT pacienti_meno, pacienti_priezvisko, TO_CHAR(ADD_MONTHS(sysdate, 2), 'DD.MM.YYYY') AS Preventivka  FROM PACIENTI WHERE pacienti_rodcis = 27;


--7a, 9a, 13c, 13d, 14a
SELECT CONCAT(CONCAT(CONCAT(CONCAT(Z.lekari_titul, ' '), Z.lekari_meno), ' '), Z.lekari_priezvisko) AS LEKARI, 
NVL(X.pacienti_meno, 'NEMA PACIENTA') AS MENO_PACIENTA, NVL(X.pacienti_priezvisko, 'NEMA PACIENTA') AS PRIEZVISKO_PACIENTA 
FROM PACIENTI X RIGHT OUTER JOIN LEK_PAC Y ON X.pacienti_rodcis = Y.PACIENTI_pacienti_rodcis FULL OUTER JOIN LEKARI Z ON Y.LEKARI_lekari_id = lekari_id;


--9b, 9c
SELECT lekari_id, ROUND(SQRT(lekari_plat)) FROM LEKARI;


--12a
SELECT asistenti_meno, asistenti_priezvisko, LEKARI_lekari_id FROM ASISTENTI WHERE LEKARI_lekari_id = 198;


--17a
INSERT INTO NEMOCNICA (nemocnica_id, nemocnica_nazov, nemocnica_ulica, nemocnica_supcis, nemocnica_mesto)
SELECT (SELECT MAX(nemocnica_id)+1 FROM NEMOCNICA), nemocnica_nazov, 'Slnecna', 559, 'Sered' FROM NEMOCNICA WHERE nemocnica_id = 68;


--18a
UPDATE NEMOCNICA SET nemocnica_ulica = (SELECT nemocnica_ulica FROM NEMOCNICA WHERE nemocnica_id = 96) WHERE nemocnica_id = 111;

--19a
DELETE FROM NEMOCNICA WHERE (nemocnica_id) IN (SELECT MAX(nemocnica_id) FROM NEMOCNICA);