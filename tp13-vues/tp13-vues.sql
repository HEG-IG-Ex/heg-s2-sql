-- 1) Vue sur les participant ayant participé à des compets à Batelle
CREATE OR REPLACE VIEW vw_per_com_battelle ("Prénom", "Nom", "Compétititions", "Date") AS
SELECT per_prenom, per_nom, com_nom, com_date
FROM heg_personne
JOIN heg_participe ON per_no = par_per_no
JOIN heg_competition ON par_com_no = com_no
WHERE LOWER(com_lieu) = 'battelle'
ORDER BY per_nom, per_prenom ASC;


-- 2) Vue sur les personnes  n'ayant jamais participé à des compets à Batelle
SELECT DISTINCT per_no, per_nom, per_prenom FROM heg_personne
LEFT JOIN heg_participe ON par_per_no = per_no
LEFT JOIN heg_competition ON par_com_no = com_no
WHERE (LOWER(com_lieu) != 'battelle' OR com_lieu IS NULL)
ORDER BY per_nom




-- 3) Vue sur le nombre de participants par type de compétitions
CREATE OR REPLACE VIEW vw_com_cnt_part ("Compétitions", "Nombre de participants") AS
SELECT com_nom, COUNT(par_per_no) AS cnt_participant
FROM heg_participe
INNER JOIN heg_competition ON com_no = par_com_no
GROUP BY com_nom;


-- 4) Vue sur les femmes des clubs de Lausanne
CREATE OR REPLACE VIEW vw_femme_clu_lausanne (Numéro, Prénom, Nom, Sexe, Club) AS
SELECT per_no, per_prenom, per_nom, per_sexe, clu_nom FROM heg_personne 
JOIN heg_club ON clu_no = per_clu_no
WHERE per_sexe = 'F' 
AND LOWER(clu_ville) = 'lausanne';


-- 5) test sur la vue n° 4
UPDATE vw_femme_clu_lausanne SET Prénom = 'Charles' WHERE Numéro = 20;
-- Après la modif de nom, la personne est encore la car elle respecte la condition Sexe = 'F'
UPDATE vw_femme_clu_lausanne SET Sexe = 'M' WHERE Numéro = 20;
-- Après la modif de sexe, la personne disparait de la vue  car elle ne respecte plus la condition Sexe = 'F'

-- Correction
UPDATE heg_personne SET per_prenom = 'Charlotte' WHERE per_no = 20;
UPDATE heg_personne SET per_sexe = 'F' WHERE per_no = 20;

CREATE OR REPLACE VIEW vw_femme_clu_lausanne (Numéro, Prénom, Nom, Sexe, Club) AS
    SELECT per_no, per_prenom, per_nom, per_sexe, clu_nom FROM heg_personne 
    JOIN heg_club ON clu_no = per_clu_no
    WHERE per_sexe = 'F' 
    AND LOWER(clu_ville) = 'lausanne'
    WITH CHECK OPTION;
    
UPDATE vw_femme_clu_lausanne SET Prénom = 'Charles' WHERE Numéro = 20;
-- Après la modif de nom, la personne est encore la car elle respecte la condition Sexe = 'F'
UPDATE vw_femme_clu_lausanne SET Sexe = 'M' WHERE Numéro = 20;
-- Après la tentative de modification, ORA-01402: view WITH CHECK OPTION where-clause violation 


-- 6) Vue sur les clubs à Genève
CREATE OR REPLACE VIEW vw_club_geneve AS
SELECT * FROM heg_club
WHERE LOWER(clu_ville) = 'genève'
WITH CHECK OPTION;

-- 7) Insertgrâce à la vue n°6
INSERT INTO vw_club_geneve (clu_no, clu_nom, clu_ville) VALUES (7, 'BasketClub', 'Genève');
INSERT INTO heg_club (clu_no, clu_nom, clu_ville) VALUES (8, 'VolleyClub', 'Nyon');

-- 8) Dictionnaries :
-- Tables permettant des
-- vw_jamais participe_batelle - toutes les colonnes
-- vw_femme_club_lausanne - toutes sauf le per_club_no CAR key-preserved
-- vw_club_geneve - toutes les colonnes
SELECT * FROM user_updatable_columns WHERE UPPER(table_name) LIKE 'VW%'; 