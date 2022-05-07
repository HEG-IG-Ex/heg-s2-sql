/* ----------------------------------------------------------------------------
Script : 62-21 - BDD - 10-Revision-Course-CreerEnv.sql    Auteur : Ch. Stettler
Objet  : Création des tables - Modèle Course
---------------------------------------------------------------------------- */

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !!!!!          REMARQUE IMPORTANTE           !!!!!
-- !!!!!   CE SCRIPT NE DOIT PAS ÊTRE MODIFIÉ   !!!!!
-- !!!!!   ==================================   !!!!!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

-- Vous devez exécuter une fois ce script pour créer l'environnement initial
-- puis faire vos requêtes dans un autre script.
-- Vous n'avez pas accès à ce script pour effectuer des modifications !!!!!

--------------------------------------------------------------------------
-- Création des tables de base et insertion des données initiales
--------------------------------------------------------------------------

-- suppression des tables de base fournies
DROP TABLE rev_coureur;
DROP TABLE rev_club;
DROP TABLE rev_categorie;
--DROP TABLE rev_parcours;

-- création des tables de base fournies
CREATE TABLE rev_categorie (
   cat_no       NUMBER(5)  CONSTRAINT pk_rev_categorie PRIMARY KEY,
   cat_nom      VARCHAR2(20),
   cat_sexe     VARCHAR2(1),
   cat_anneeMin NUMBER(4),
   cat_anneeMax NUMBER(4),
   cat_heure    VARCHAR2(5),
   cat_parcours VARCHAR2(2),
   cat_prix     NUMBER(2)
);

CREATE TABLE rev_club (
   clu_no       NUMBER(5)  CONSTRAINT pk_rev_club PRIMARY KEY,
   clu_nom      VARCHAR2(30)
);

CREATE TABLE rev_coureur (
   cou_no       NUMBER(5)  CONSTRAINT pk_rev_coureur PRIMARY KEY,
   cou_nom      VARCHAR2(20),
   cou_prenom   VARCHAR2(20),
   cou_sexe     VARCHAR2(1),
   cou_annee    NUMBER(5),
   cou_temps    NUMBER(4,2),
   cou_cat_no   NUMBER(5)  CONSTRAINT fk_rev_coureur_categorie REFERENCES rev_categorie (cat_no),
   cou_clu_no   NUMBER(5)  CONSTRAINT fk_rev_coureur_club REFERENCES rev_club (clu_no)
);

-- insertion des données initiales
INSERT INTO rev_categorie VALUES (1, 'Juniors',  'M', 2004, 2010, '14h',   '1P', 20);
INSERT INTO rev_categorie VALUES (2, 'Elites H', 'M', 1991, 2003, '17h',   '2G', 35);
INSERT INTO rev_categorie VALUES (3, 'Hommes',   'M', 1990, 1971, '15h30', '2g', 30);
INSERT INTO rev_categorie VALUES (4, 'Vétérans', 'M', 1900, 1970, '15h',   '1g', 30);
INSERT INTO rev_categorie VALUES (7, 'Juniores', 'F', 2004, 2010, '14h30', '1p', 20);
INSERT INTO rev_categorie VALUES (8, 'Elites F', 'F', 2003, 1991, '16h30', '2G', 35);
INSERT INTO rev_categorie VALUES (9, 'Femmes',   'F', 1900, 1990, '16h',   '1G', 30);
COMMIT;

INSERT INTO rev_club VALUES ( 1, 'Stade Genève Athlétisme');
INSERT INTO rev_club VALUES ( 2, 'Athletisme Viseu-Genève');
INSERT INTO rev_club VALUES ( 3, 'Versoix Athlétisme');
INSERT INTO rev_club VALUES ( 4, 'Etoile Sportive');
INSERT INTO rev_club VALUES ( 5, 'Plainpalais-Satus');
INSERT INTO rev_club VALUES ( 6, 'Ain-Est Athlétisme');
INSERT INTO rev_club VALUES ( 7, 'Les Foulees Chablaisiennes');
INSERT INTO rev_club VALUES ( 8, 'Fsg Meyrin');
INSERT INTO rev_club VALUES ( 9, 'Fsg Collonge-Bellerive');
INSERT INTO rev_club VALUES (10, 'Bernex-Confignon');
INSERT INTO rev_club VALUES (11, 'Fsg Versoix');
INSERT INTO rev_club VALUES (12, 'Foulée d''Annemasse');
COMMIT;

INSERT INTO rev_coureur VALUES (1, 'Romero', 'Anita', 'F', 1975, 26.21, 9, 7);
INSERT INTO rev_coureur VALUES (2, 'Belet', 'Alan', 'M', 2001, 43.07, 2, 12);
INSERT INTO rev_coureur VALUES (3, 'Correia', 'Gaël', 'M', 1967, 24.29, 4, 4);
INSERT INTO rev_coureur VALUES (4, 'Juvet', 'Cyril', 'M', 2010, 19.25, 1, 12);
INSERT INTO rev_coureur VALUES (5, 'Sasso', 'Emma', 'F', 1970, 26.18, 9, 1);
INSERT INTO rev_coureur VALUES (6, 'Birch', 'Gerald', 'M', 1996, 45.55, 2, 2);
INSERT INTO rev_coureur VALUES (7, 'Coupat', 'Zohra', 'F', 1994, 43.03, 8, 2);
INSERT INTO rev_coureur VALUES (8, 'Arson', 'Nadège', 'F', 2004, 19.04, 7, 9);
INSERT INTO rev_coureur VALUES (9, 'Engi', 'Joël', 'M', 1970, 26.27, 4, 10);
INSERT INTO rev_coureur VALUES (10, 'Gury', 'Olivia', 'F', 2010, 19.05, 7, 6);
INSERT INTO rev_coureur VALUES (11, 'Erni', 'Audrey', 'F', 1986, 23.28, 9, 4);
INSERT INTO rev_coureur VALUES (12, 'Mees', 'Lika', 'F', 1992, 55.22, 8, 7);
INSERT INTO rev_coureur VALUES (13, 'Berset', 'Rita', 'F', 2009, 20.24, 7, 9);
INSERT INTO rev_coureur VALUES (14, 'Leloup', 'Julie', 'F', 1998, 45.16, 8, 9);
INSERT INTO rev_coureur VALUES (15, 'Liard', 'Laura', 'F', 1989, 22.11, 9, 4);
INSERT INTO rev_coureur VALUES (16, 'Micco', 'Nadège', 'F', 2002, 46.13, 8, 12);
INSERT INTO rev_coureur VALUES (17, 'Björk', 'Olivia', 'F', 1952, 24.41, 9, 5);
INSERT INTO rev_coureur VALUES (18, 'Von Arx', 'Alan', 'M', 2001, 48.07, 2, NULL);
INSERT INTO rev_coureur VALUES (19, 'Correia', 'Imam', 'M', 2006, 20.31, 1, 1);
INSERT INTO rev_coureur VALUES (20, 'Chalmin', 'John', 'M', 1968, 23.05, 4, 9);
INSERT INTO rev_coureur VALUES (21, 'Marque', 'Marco', 'M', 1958, 27.09, 4, 10);
INSERT INTO rev_coureur VALUES (22, 'Wells', 'Audrey', 'F', 1998, 56.08, 8, 3);
INSERT INTO rev_coureur VALUES (23, 'Testuz', 'Lika', 'F', 1998, 51.59, 8, 12);
INSERT INTO rev_coureur VALUES (24, 'Avila', 'Jez', 'M', 2007, 20.52, 1, 6);
INSERT INTO rev_coureur VALUES (25, 'Blanc', 'Rita', 'F', 1999, 51.41, 8, 12);
INSERT INTO rev_coureur VALUES (26, 'Dhonneur', 'Mario', 'M', 1981, 52.17, 3, 9);
INSERT INTO rev_coureur VALUES (27, 'Doyard', 'Dario', 'M', 1949, 23.01, 4, 6);
INSERT INTO rev_coureur VALUES (28, 'Sita', 'Julie', 'F', 1963, 23.38, 9, 9);
INSERT INTO rev_coureur VALUES (29, 'Tari', 'Laura', 'F', 2006, 20.39, 7, 1);
INSERT INTO rev_coureur VALUES (30, 'Juvet', 'Carlos', 'M', 1993, 50.12, 2, 11);
INSERT INTO rev_coureur VALUES (31, 'Gros', 'Hervé', 'M', 2008, 27.54, 1, 10);
INSERT INTO rev_coureur VALUES (32, 'Bellon', 'Coco', 'M', 1976, 46.05, 3, 11);
INSERT INTO rev_coureur VALUES (33, 'Silva', 'Marie', 'F', 1997, 49.51, 8, 9);
INSERT INTO rev_coureur VALUES (34, 'Revil', 'Jessy', 'F', 2001, 43.24, 8, 9);
INSERT INTO rev_coureur VALUES (35, 'Antigny', 'Andy', 'M', 1972, 46.27, 3, 11);
INSERT INTO rev_coureur VALUES (36, 'Praz', 'Edit', 'F', 1946, 25.33, 9, 5);
INSERT INTO rev_coureur VALUES (37, 'Kaciel', 'Yves', 'M', 1986, 46.23, 3, 9);
INSERT INTO rev_coureur VALUES (38, 'Beati', 'Aline', 'F', 1960, 28.03, 9, 12);
INSERT INTO rev_coureur VALUES (39, 'Brunel', 'Gladys', 'F', 1999, 57.38, 8, 1);
INSERT INTO rev_coureur VALUES (40, 'Gomez', 'Rachel', 'F', 2005, 18.42, 7, 12);
INSERT INTO rev_coureur VALUES (41, 'Rapido', 'Aline', 'F', 1959, 23.38, 9, 11);
INSERT INTO rev_coureur VALUES (42, 'Berney', 'Yves', 'M', 2000, 44.08, 2, 12);
INSERT INTO rev_coureur VALUES (43, 'Riem', 'Celia', 'F', 1997, 43.38, 8, 6);
INSERT INTO rev_coureur VALUES (44, 'Bovet', 'Silvia', 'F', 2004, 19.04, 7, 10);
INSERT INTO rev_coureur VALUES (45, 'Guillod', 'Marcy', 'F', 1954, 23.03, 9, 2);
INSERT INTO rev_coureur VALUES (46, 'Noel', 'Lise', 'F', 1994, 52.58, 8, 7);
INSERT INTO rev_coureur VALUES (47, 'Ojulu', 'Nadia', 'F', 1942, 23.08, 9, 3);
INSERT INTO rev_coureur VALUES (48, 'Souto', 'Réka', 'F', 2003, 52.05, 8, 2);
INSERT INTO rev_coureur VALUES (49, 'Peufly', 'Brian', 'M', 2004, 27.31, 1, 10);
INSERT INTO rev_coureur VALUES (50, 'Irlé', 'Cécile', 'F', 1996, 54.47, 8, 10);
INSERT INTO rev_coureur VALUES (51, 'Uzel', 'Nadia', 'F', 1997, 55.06, 8, 2);
INSERT INTO rev_coureur VALUES (52, 'Dingens', 'Max', 'M', 2002, 43.25, 2, 12);
INSERT INTO rev_coureur VALUES (53, 'Souihi', 'Ariel', 'M', 1992, 44.39, 2, 1);
INSERT INTO rev_coureur VALUES (54, 'Emery', 'Ana', 'F', 1981, 26.57, 9, NULL);
INSERT INTO rev_coureur VALUES (55, 'Moog', 'Hélène', 'F', 1993, 46.55, 8, 1);
INSERT INTO rev_coureur VALUES (56, 'Laurent', 'Walid', 'M', 1975, 52.2, 3, 7);
INSERT INTO rev_coureur VALUES (57, 'Oliach', 'Cyril', 'M', 1973, 48.15, 3, 5);
INSERT INTO rev_coureur VALUES (58, 'David', 'laura', 'F', 1991, 56.52, 8, 2);
INSERT INTO rev_coureur VALUES (59, 'Rojas', 'Emily', 'F', 2005, 19.26, 7, 1);
INSERT INTO rev_coureur VALUES (60, 'Ponzio', 'Cyril', 'M', 1981, 57.5, 3, 12);
INSERT INTO rev_coureur VALUES (61, 'Juric', 'Paul', 'M', 1954, 23.2, 4, 12);
INSERT INTO rev_coureur VALUES (62, 'Michal', 'Fumika', 'F', 2004, 18.56, 7, 4);
INSERT INTO rev_coureur VALUES (63, 'Lala', 'Karine', 'F', 1955, 26.42, 9, 5);
INSERT INTO rev_coureur VALUES (64, 'Punzi', 'Damien', 'M', 2001, 50.41, 2, 12);
INSERT INTO rev_coureur VALUES (65, 'Volorio', 'Pascal', 'M', 1990, 49.49, 3, 4);
INSERT INTO rev_coureur VALUES (66, 'Boch', 'Jeremy', 'M', 1965, 27.54, 4, 7);
INSERT INTO rev_coureur VALUES (67, 'Roux', 'Emile', 'M', 1986, 56.04, 3, 7);
INSERT INTO rev_coureur VALUES (68, 'Marin', 'Arnaud', 'M', 1999, 44.12, 2, 3);
INSERT INTO rev_coureur VALUES (69, 'Jornod', 'Teryn', 'F', 1994, 43.35, 8, 1);
INSERT INTO rev_coureur VALUES (70, 'Bessat', 'Davy', 'M', 1966, 28.05, 4, 10);
INSERT INTO rev_coureur VALUES (71, 'Gall', 'Céline', 'F', 1964, 22.04, 9, 12);
INSERT INTO rev_coureur VALUES (72, 'Diet', 'Karen', 'F', 2006, 20.2, 7, 10);
INSERT INTO rev_coureur VALUES (73, 'Louis', 'Anahi', 'F', 2001, 45.46, 8, 9);
INSERT INTO rev_coureur VALUES (74, 'Kurt', 'Amaury', 'M', 2000, 48.43, 2, 4);
INSERT INTO rev_coureur VALUES (75, 'Bitaine', 'Matt', 'M', 1991, 47.32, 2, 1);
INSERT INTO rev_coureur VALUES (76, 'Souza', 'Jade', 'F', 2002, 46.15, 8, 4);
INSERT INTO rev_coureur VALUES (77, 'Verda', 'Muriel', 'F', 1997, 47.06, 8, 11);
INSERT INTO rev_coureur VALUES (78, 'Lavy', 'Pablo', 'M', 1994, 43.5, 2, 5);
INSERT INTO rev_coureur VALUES (79, 'Neil', 'Anna', 'F', 1943, 26.16, 9, 8);
INSERT INTO rev_coureur VALUES (80, 'Ramer', 'Angela', 'F', 1944, 22.29, 9, 1);
INSERT INTO rev_coureur VALUES (81, 'Siatka', 'Petros', 'M', 2000, 51.12, 2, 10);
INSERT INTO rev_coureur VALUES (82, 'Kroug', 'Sylvie', 'F', 1992, 45.14, 8, 5);
INSERT INTO rev_coureur VALUES (83, 'Roux', 'laura', 'F', 2009, 19.49, 7, 3);
INSERT INTO rev_coureur VALUES (84, 'Fajon', 'David', 'M', 1945, 26.35, 4, 1);
INSERT INTO rev_coureur VALUES (85, 'Morel', 'Sarah', 'F', 1974, 27.38, 9, 2);
INSERT INTO rev_coureur VALUES (86, 'Costa', 'Serge', 'M', 1993, 44.56, 2, 9);
INSERT INTO rev_coureur VALUES (87, 'Corda', 'Julie', 'F', 1948, 23.42, 9, 2);
INSERT INTO rev_coureur VALUES (88, 'Singh', 'Tarek', 'M', 2005, 29.07, 1, 11);
INSERT INTO rev_coureur VALUES (89, 'Leven', 'Yafiza', 'F', 2000, 46.34, 8, 9);
INSERT INTO rev_coureur VALUES (90, 'Ryska', 'Joana', 'F', 1981, 22.35, 9, NULL);
INSERT INTO rev_coureur VALUES (91, 'Venel', 'Herve', 'M', 2009, 19.3, 1, 8);
INSERT INTO rev_coureur VALUES (92, 'Bolay', 'Samir', 'M', 1942, 23.52, 4, 3);
INSERT INTO rev_coureur VALUES (93, 'Brosi', 'Elena', 'F', 1988, 27.43, 9, 9);
INSERT INTO rev_coureur VALUES (94, 'Joret', 'Audrey', 'F', 1979, 22.38, 9, 6);
INSERT INTO rev_coureur VALUES (95, 'Busel', 'Nicolas', 'M', 2001, 48.31, 2, 4);
INSERT INTO rev_coureur VALUES (96, 'Farine', 'Roland', 'M', 1968, 25.05, 4, NULL);
INSERT INTO rev_coureur VALUES (97, 'Freitag', 'Marry', 'F', 2007, 19.14, 7, 4);
INSERT INTO rev_coureur VALUES (98, 'Krul', 'Jerome', 'M', 1953, 24.57, 4, 11);
INSERT INTO rev_coureur VALUES (99, 'Schmied', 'Karen', 'F', 1974, 22.34, 9, 11);
INSERT INTO rev_coureur VALUES (100, 'Fuchs', 'Olena', 'F', 2003, 45.2, 8, 12);
INSERT INTO rev_coureur VALUES (101, 'Ramin', 'Telma', 'F', 2004, 18.21, 7, 7);
INSERT INTO rev_coureur VALUES (102, 'Boyle', 'Paula', 'F', 1964, 25.34, 9, 8);
INSERT INTO rev_coureur VALUES (103, 'Rhyn', 'Mark', 'M', 1958, 25.33, 4, 11);
INSERT INTO rev_coureur VALUES (104, 'Overney', 'Sarah', 'F', 1994, 50.49, 8, 2);
INSERT INTO rev_coureur VALUES (105, 'Gamez', 'Mia', 'F', 1997, 43.01, 8, 4);
INSERT INTO rev_coureur VALUES (106, 'Cler', 'Ana', 'F', 2005, 18.32, 7, 4);
INSERT INTO rev_coureur VALUES (107, 'Denk', 'Harald', 'M', 2005, 29.04, 1, NULL);
INSERT INTO rev_coureur VALUES (108, 'Palmai', 'Ati', 'M', 1944, 26.13, 4, 7);
INSERT INTO rev_coureur VALUES (109, 'Lake', 'Alice', 'F', 1978, 23.5, 9, 7);
INSERT INTO rev_coureur VALUES (110, 'Musy', 'Patric', 'M', 1982, 46.25, 3, 4);
INSERT INTO rev_coureur VALUES (111, 'Cleto', 'Emese', 'F', 2009, 20.13, 7, 7);
INSERT INTO rev_coureur VALUES (112, 'Pernot', 'Julia', 'F', 2004, 19.12, 7, 8);
INSERT INTO rev_coureur VALUES (113, 'Faës', 'Ana', 'F', 1991, 43.1, 8, 12);
INSERT INTO rev_coureur VALUES (114, 'Moulin', 'Maite', 'F', 1995, 49.59, 8, 10);
INSERT INTO rev_coureur VALUES (115, 'Cordoba', 'Antoine', 'M', 1985, 55.23, 3, NULL);
INSERT INTO rev_coureur VALUES (116, 'Toso', 'Laurie', 'F', 1994, 44.08, 8, 12);
INSERT INTO rev_coureur VALUES (117, 'Belo', 'Karim', 'M', 2009, 19.09, 1, 9);
INSERT INTO rev_coureur VALUES (118, 'Teti', 'Rubem', 'M', 2006, 19.08, 1, 3);
INSERT INTO rev_coureur VALUES (119, 'Beney', 'Jeremy', 'M', 1992, 47.42, 2, NULL);
INSERT INTO rev_coureur VALUES (120, 'Ajdini', 'Jorge', 'M', 2008, 19.56, 1, 10);
INSERT INTO rev_coureur VALUES (121, 'Favre', 'Sophie', 'F', 1997, 48.49, 8, NULL);
INSERT INTO rev_coureur VALUES (122, 'Fredji', 'Benoît', 'M', 1943, 23.45, 4, 7);
INSERT INTO rev_coureur VALUES (123, 'Carino', 'Fabio', 'M', 1995, 48.54, 2, 5);
INSERT INTO rev_coureur VALUES (124, 'Colin', 'Clare', 'F', 2004, 18.32, 7, NULL);
INSERT INTO rev_coureur VALUES (125, 'Frey', 'Yann', 'M', 1945, 27.16, 4, 8);
INSERT INTO rev_coureur VALUES (126, 'Suter', 'David', 'M', 1944, 25.25, 4, 3);
INSERT INTO rev_coureur VALUES (127, 'Jeite', 'Yves', 'F', 2004, 19.31, 7, 11);
INSERT INTO rev_coureur VALUES (128, 'Raveh', 'Sophie', 'F', 2006, 19.38, 7, 4);
INSERT INTO rev_coureur VALUES (129, 'Terrier', 'Benoit', 'M', 1963, 25.05, 4, 11);
INSERT INTO rev_coureur VALUES (130, 'Jaggi', 'Anne', 'F', 1974, 26.29, 9, 2);
INSERT INTO rev_coureur VALUES (131, 'Rumer', 'Abdel', 'M', 1999, 45.03, 2, 2);
INSERT INTO rev_coureur VALUES (132, 'Cruz', 'Sandra', 'F', 1972, 27.47, 9, 3);
INSERT INTO rev_coureur VALUES (133, 'Henry', 'Irene', 'F', 2010, 20.25, 7, 6);
INSERT INTO rev_coureur VALUES (134, 'Weder', 'Julie', 'F', 2005, 20.04, 7, 11);
INSERT INTO rev_coureur VALUES (135, 'Ebot', 'Senta', 'F', 1996, 50.25, 8, 12);
INSERT INTO rev_coureur VALUES (136, 'Neri', 'Maria', 'F', 1991, 51.07, 8, 8);
INSERT INTO rev_coureur VALUES (137, 'Lopez', 'Khoa', 'M', 2007, 19.32, 1, 6);
INSERT INTO rev_coureur VALUES (138, 'Pernot', 'Loïc', 'M', 1972, 50.39, 3, 1);
INSERT INTO rev_coureur VALUES (139, 'Bionda', 'Maria', 'F', 1999, 47.04, 8, 4);
INSERT INTO rev_coureur VALUES (140, 'Bovay', 'Sophie', 'F', 2004, 19.1, 7, 2);
INSERT INTO rev_coureur VALUES (141, 'Bubach', 'Sarah', 'F', 1996, 43.27, 8, 4);
INSERT INTO rev_coureur VALUES (142, 'Romero', 'Julia', 'F', 1958, 27.54, 9, 2);
INSERT INTO rev_coureur VALUES (143, 'Clerc', 'Sabine', 'F', 1997, 54.52, 8, 5);
INSERT INTO rev_coureur VALUES (144, 'Soudan', 'Javier', 'M', 1996, 43.36, 2, 7);
INSERT INTO rev_coureur VALUES (145, 'Urraza', 'Ingrid', 'F', 1991, 56.42, 8, 11);
INSERT INTO rev_coureur VALUES (146, 'Sottas', 'Audrey', 'F', 1978, 26.12, 9, 2);
INSERT INTO rev_coureur VALUES (147, 'Naciri', 'Joël', 'M', 1962, 26.51, 4, NULL);
INSERT INTO rev_coureur VALUES (148, 'Diaz', 'Rolf', 'M', 1976, 52.11, 3, 6);
INSERT INTO rev_coureur VALUES (149, 'Gachet', 'Olivier', 'M', 1992, 44.32, 2, 8);
INSERT INTO rev_coureur VALUES (150, 'Shibib', 'Till', 'M', 1978, 56.36, 3, 11);
INSERT INTO rev_coureur VALUES (151, 'Hudd', 'Julie', 'F', 2003, 59.43, 8, 11);
INSERT INTO rev_coureur VALUES (152, 'Mollet', 'Sara', 'F', 1996, 45.12, 8, 8);
INSERT INTO rev_coureur VALUES (153, 'Camos', 'Fany', 'F', 1974, 22.34, 9, 8);
INSERT INTO rev_coureur VALUES (154, 'Fort', 'Eric', 'M', 2002, 45.45, 2, 10);
INSERT INTO rev_coureur VALUES (155, 'Burdet', 'Chris', 'M', 1966, 26.51, 4, 3);
INSERT INTO rev_coureur VALUES (156, 'Masset', 'Reda', 'M', 2010, 18.05, 1, 6);
INSERT INTO rev_coureur VALUES (157, 'Kamel', 'Elena', 'F', 1960, 26.55, 9, NULL);
INSERT INTO rev_coureur VALUES (158, 'Gagnon', 'Kyra', 'F', 1993, 57.4, 8, 7);
INSERT INTO rev_coureur VALUES (159, 'Rochat', 'Jason', 'M', 1986, 46.05, 3, 6);
INSERT INTO rev_coureur VALUES (160, 'Salami', 'Marc', 'M', 1975, 56.23, 3, 1);
INSERT INTO rev_coureur VALUES (161, 'Denis', 'Emma', 'F', 2002, 47.42, 8, 6);
INSERT INTO rev_coureur VALUES (162, 'Hoenen', 'Carole', 'F', 2007, 18.23, 7, 4);
INSERT INTO rev_coureur VALUES (163, 'Maury', 'Gina', 'F', 2004, 20.26, 7, 12);
INSERT INTO rev_coureur VALUES (164, 'Martin', 'Sarah', 'F', 2004, 18.24, 7, 10);
INSERT INTO rev_coureur VALUES (165, 'Meisss', 'Erika', 'F', 1977, 27.02, 9, 3);
INSERT INTO rev_coureur VALUES (166, 'Kamili', 'Olga', 'F', 1982, 24.56, 9, 1);
INSERT INTO rev_coureur VALUES (167, 'Mckeon', 'Carlo', 'M', 2007, 19.22, 1, 6);
INSERT INTO rev_coureur VALUES (168, 'Belloni', 'Chris', 'M', 2007, 20.26, 1, 4);
INSERT INTO rev_coureur VALUES (169, 'Skibo', 'Aline', 'F', 2009, 20.22, 7, 7);
INSERT INTO rev_coureur VALUES (170, 'Emery', 'Maud', 'F', 1953, 27.2, 9, 7);
INSERT INTO rev_coureur VALUES (171, 'Folgar', 'Njazi', 'M', 1947, 27.1, 4, 1);
INSERT INTO rev_coureur VALUES (172, 'Perret', 'Cedric', 'M', 1986, 53.07, 3, 6);
INSERT INTO rev_coureur VALUES (173, 'Meier', 'Marc', 'M', 1969, 28.49, 4, 12);
INSERT INTO rev_coureur VALUES (174, 'Wyss', 'Betty', 'F', 2003, 48.31, 8, 7);
INSERT INTO rev_coureur VALUES (175, 'Zorev', 'Aude', 'F', 2008, 19.47, 7, 1);
INSERT INTO rev_coureur VALUES (176, 'Berces', 'Anne', 'F', 1992, 46.35, 8, 7);
INSERT INTO rev_coureur VALUES (177, 'Godmé', 'Chris', 'M', 1997, 44.01, 2, 2);
INSERT INTO rev_coureur VALUES (178, 'Rivera', 'Torage', 'M', 1953, 25.48, 4, 3);
INSERT INTO rev_coureur VALUES (179, 'Lagger', 'Sara', 'F', 2010, 20.1, 7, 1);
INSERT INTO rev_coureur VALUES (180, 'Di Leo', 'Fabian', 'M', 1982, 53.36, 3, 11);
INSERT INTO rev_coureur VALUES (181, 'Hoek', 'Steven', 'M', 1972, 50.35, 3, 4);
INSERT INTO rev_coureur VALUES (182, 'Richer', 'Marie', 'F', 2010, 21.59, 7, 12);
INSERT INTO rev_coureur VALUES (183, 'Kaadze', 'Fleur', 'F', 1988, 24.4, 9, NULL);
INSERT INTO rev_coureur VALUES (184, 'Pion', 'Miguel', 'M', 2003, 50.05, 2, 8);
INSERT INTO rev_coureur VALUES (185, 'Hayoz', 'Iman', 'M', 2010, 20.38, 1, 5);
INSERT INTO rev_coureur VALUES (186, 'Orsat', 'Hadrien', 'M', 1990, 46.22, 3, 7);
INSERT INTO rev_coureur VALUES (187, 'Junod', 'Muriel', 'F', 1949, 24.38, 9, 5);
INSERT INTO rev_coureur VALUES (188, 'Todic', 'Petra', 'F', 2007, 18.54, 7, 11);
INSERT INTO rev_coureur VALUES (189, 'Fleury', 'Mauro', 'M', 1971, 56.41, 3, 10);
INSERT INTO rev_coureur VALUES (190, 'Lima', 'Amir', 'M', 2008, 18.54, 1, 4);
INSERT INTO rev_coureur VALUES (191, 'Erdos', 'Yvan', 'M', 1991, 43.13, 2, 7);
INSERT INTO rev_coureur VALUES (192, 'Dupuis', 'Simon', 'M', 1968, 25.16, 4, 6);
INSERT INTO rev_coureur VALUES (193, 'Bidet', 'Olga', 'F', 1977, 26.33, 9, 10);
INSERT INTO rev_coureur VALUES (194, 'Pappes', 'Jörg', 'M', 1980, 57.28, 3, 10);
INSERT INTO rev_coureur VALUES (195, 'Jobé', 'Olga', 'F', 2001, 46.25, 8, 10);
INSERT INTO rev_coureur VALUES (196, 'Alkan', 'Rémy', 'M', 2005, 18.56, 1, 3);
INSERT INTO rev_coureur VALUES (197, 'Lagana', 'Bryn', 'F', 2000, 46.18, 8, 6);
INSERT INTO rev_coureur VALUES (198, 'Fente', 'Anna', 'F', 1968, 27.58, 9, 8);
INSERT INTO rev_coureur VALUES (199, 'Capelle', 'Erika', 'F', 2003, 55.43, 8, 7);
COMMIT;
