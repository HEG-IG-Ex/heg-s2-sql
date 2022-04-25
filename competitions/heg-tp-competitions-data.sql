/*
    PERSONNE
    ========
    Jean BON
    Yves REMORD
    Alex TERIEUR
    Alain PROVISTE
    Alain TERIEUR
    Sam DISSOIRE
    habitant tous à Genève.
*/   
   
INSERT INTO com_personne (per_id, per_nom, per_prenom, per_sexe) VALUES (1, 'BON', 'Jean', 'M');
INSERT INTO com_personne (per_id, per_nom, per_prenom, per_sexe) VALUES (2, 'REMORD', 'Yves', 'M');
INSERT INTO com_personne (per_id, per_nom, per_prenom, per_sexe) VALUES (3, 'TERIEUR', 'Alex', 'M');
INSERT INTO com_personne (per_id, per_nom, per_prenom, per_sexe) VALUES (4, 'PROVISTE', 'Alain', 'M');
INSERT INTO com_personne (per_id, per_nom, per_prenom, per_sexe) VALUES (5, 'TERIEUR', 'Alain', 'M');
INSERT INTO com_personne (per_id, per_nom, per_prenom, per_sexe) VALUES (6, 'DISSOIRE', 'Sam', 'M');
COMMIT;

SELECT * FROM com_personne;
-- DELETE FROM com_personne;


/*
    CLUB
    ====
     « HEG-Running »
     « Football Club 62-21 »
     « Traînes-Savates BDD »
*/

INSERT INTO com_club (clu_id, clu_nom) VALUES (1, 'HEG-Running');
INSERT INTO com_club (clu_id, clu_nom) VALUES (2, 'Football Club 62-21');
INSERT INTO com_club (clu_id, clu_nom) VALUES (3, 'Traînes-Savates BDD');
COMMIT;

SELECT * FROM com_club;
-- DELETE FROM com_club;

/*
    APPARTENANCE AU CLUB
    =====================
    Yves et Alex font partie du club « HEG-Running »
    Sam du « Football Club 62-21 »
    Jean est dans le club « Traînes-Savates BDD »

*/

UPDATE com_personne SET per_clu_id = 1 WHERE per_id IN (2, 3);
UPDATE com_personne SET per_clu_id = 2 WHERE per_id = 6;
UPDATE com_personne SET per_clu_id = 3 WHERE per_id = 1;
COMMIT;

-- SELECT * FROM com_personne;

/*
    COMPETITIONS
    ============
    Une « Course diplômésHEG », 20 juin, Battelle (Carouge), « HEG-Running », 25
    Un « Tour du Campus », 26 mars, Battelle (Carouge), « HEG-Running », 10
    Une course « TouDouMollo-Run », 31 octobre, Bout-du-Monde,  « Traînes-Savates BDD », 30.-.
*/

INSERT INTO com_competition VALUES (1, 'Course diplômésHEG', '20.06.2022', 'Battelle', 'Carouge', 25, 1);
INSERT INTO com_competition VALUES (2, 'Tour du Campus', '26.03.2022', 'Battelle', 'Carouge', 10, 1);
INSERT INTO com_competition VALUES (3, 'TouDouMollo-Run', '31.10.2022', 'Bout-du-Monde', 'Genève', 30, 3);
COMMIT;

-- SELECT * FROM com_competition;

/*
    AJOUT DE PRESIDENT
    ==================
    Alex TERIEUR président « HEG-Running » & « Traînes-Savates BDD ». 
*/
UPDATE com_club SET clu_per_id = 3 WHERE clu_id IN (1, 3);

/*
    NOUVELLE PERSONNE + RESPONSABILITÉ
    ==================================
    Elsa Dorsa, présidente et participante de « HEG-SwimmingClub »
*/

INSERT INTO com_personne (per_id, per_nom, per_prenom, per_sexe) VALUES (7, 'DORSA', 'Elsa', 'F');
INSERT INTO com_club (clu_id, clu_nom) VALUES (4, 'HEG-SwimmingClub');
UPDATE com_personne SET per_clu_id = 4 WHERE per_id = 4;
UPDATE com_club SET clu_per_id = 4 WHERE clu_id = 4;
COMMIT;

/*
    NOUVELLE PARTICIPATION
    ======================
    Sam DISSOIRE et Elsa DORSA participeront au TouDouMollo-Run
    Jean BON, Yves REMORD, Alex TERIEUR => 2 compet de Battelle
*/
INSERT INTO com_inscription VALUES (3, 6);
INSERT INTO com_inscription VALUES (3, 4);
INSERT INTO com_inscription VALUES (1, 1);
INSERT INTO com_inscription VALUES (2, 1);
INSERT INTO com_inscription VALUES (1, 2);
INSERT INTO com_inscription VALUES (2, 2);
INSERT INTO com_inscription VALUES (1, 3);
INSERT INTO com_inscription VALUES (2, 3);

/*
    MAJ APPARTENANCE CLUB
    =====================
    indiquez que Alain TERIEUR fait maintenant partie du club de foot
    alors que Sam DISSOIRE n’en fait plus partie
*/
UPDATE com_personne SET per_clu_id = NULL WHERE per_id = 5;
UPDATE com_personne SET per_clu_id = 2 WHERE per_id = 6;

/*
    ANNULATION DE COMPET
    ====================
    finalement, la compétition « TouDouMollo-Run » n’aura pas lieu, supprimez-la
    SHOULD BE DONE WITH A DELETE CASCADE CONTRAINT ON THE FK
*/

DELETE FROM com_inscription WHERE ins_com_id = 3;
DELETE FROM com_competition WHERE com_id = 3;
UPDATE com_personne SET per_clu_id = NULL WHERE per_id = 1;
DELETE FROM com_club WHERE clu_id = 3;
COMMIT;

/*
    TEST DES CONTRAINTES
    ====================
*/

-- PK
INSERT INTO com_personne VALUES (1, 'Test', 'Test', 'M', NULL, DEFAULT, NULL);
INSERT INTO com_club VALUES (1, 'Test', NULL, NULL, NULL);
INSERT INTO com_competition VALUES (1, 'Test',  '01.01.1900', 'Battelle', 'Carouge', 50, 2);
INSERT INTO com_inscription VALUES (1, 1);

-- FK
INSERT INTO com_personne VALUES (20, 'Test', 'Test', 'M', NULL, DEFAULT, 99);
INSERT INTO com_club VALUES (20, 'Test', NULL, NULL, 99);
INSERT INTO com_competition VALUES (20, 'Test', '01.10.2022', 'Batelle', 'Carouge', 10, 99);
INSERT INTO com_inscription VALUES (99, 1);
INSERT INTO com_inscription VALUES (1, 99);

-- NN
INSERT INTO com_personne VALUES (20, NULL, 'Test', 'M',NULL, DEFAULT, NULL);
INSERT INTO com_club VALUES (20, NULL, NULL, NULL, NULL);
INSERT INTO com_competition VALUES (20, NULL, '01.10.2022', NULL, NULL, 10, 1);
INSERT INTO com_competition VALUES (20, 'Test', '01.10.2022', NULL, NULL, 10, NULL);

-- UK
INSERT INTO com_club VALUES (20, 'HEG-Running', NULL, NULL, NULL);
INSERT INTO com_personne VALUES (99, 'BON', 'Jean', 'M', NULL, DEFAULT, NULL);
INSERT INTO com_competition VALUES (99, 'Course diplômésHEG',  '01.01.1900', 'Battelle', 'Carouge', 10, 1);

-- CH
INSERT INTO com_personne VALUES (20, 'Test', 'Test', 'X', NULL, DEFAULT, NULL);
INSERT INTO com_competition VALUES (99, 'Test',  '20.06.2022', 'Battelle', 'Carouge', -99, 1);
