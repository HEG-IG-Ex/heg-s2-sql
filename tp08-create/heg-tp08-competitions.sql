DROP TABLE com_competition CASCADE CONSTRAINTS;
DROP TABLE com_inscription CASCADE CONSTRAINTS;
DROP TABLE com_personne CASCADE CONSTRAINTS;
DROP TABLE com_club CASCADE CONSTRAINTS;


/*======================================
     Création des tables
========================================*/

-- Competitions
CREATE TABLE com_competition (
   com_id        NUMBER(5) NOT NULL CONSTRAINT pk_com_competition PRIMARY KEY,
   com_nom       CHAR(40) NOT NULL,
   com_date      DATE NOT NULL,
   com_lieu      CHAR(40),
   com_ville     CHAR(40),
   com_prix      NUMBER(4,2) NOT NULL CONSTRAINT ch_prix CHECK(com_prix > 0),
   com_clu_id    NUMBER (5) NOT NULL,
   
   CONSTRAINT uk_com_nom_date_lieu_ville UNIQUE (com_nom, com_date, com_lieu, com_ville),
   CONSTRAINT ch_com_lieu_ville CHECK (com_lieu IS NOT NULL OR com_ville IS NOT NULL)
);

-- Personnes
CREATE TABLE com_personne (     
   per_id       NUMBER(5) NOT NULL CONSTRAINT pk_com_personne PRIMARY KEY,
   per_nom      VARCHAR(40) NOT NULL,
   per_prenom   VARCHAR(40) NOT NULL,
   per_sexe     CHAR(1) CONSTRAINT ch_sexe CHECK(per_sexe IN ('M', 'F')),
   per_email    VARCHAR(80),
   per_ville    VARCHAR(40) DEFAULT 'Genève',
   per_clu_id   NUMBER(5),
   
   CONSTRAINT uk_per_nom_prenom UNIQUE (per_nom, per_prenom)
);

-- Club
CREATE TABLE com_club (
   clu_id       NUMBER(5) NOT NULL CONSTRAINT pk_clu_id PRIMARY KEY,
   clu_nom      CHAR(40) NOT NULL CONSTRAINT uk_clu_nom UNIQUE,
   clu_ville    CHAR(40),
   clu_email    CHAR(40),
   clu_per_id   NUMBER(5),
   
   CONSTRAINT fk_club_personne FOREIGN KEY (clu_per_id) REFERENCES com_personne (per_id)
);

-- Inscription
CREATE TABLE com_inscription (
   ins_com_id   NUMBER(5),
   ins_per_id   NUMBER(5),
   
   CONSTRAINT pk_com_inscription PRIMARY KEY (ins_com_id, ins_per_id),
   CONSTRAINT fk_inscription_personne FOREIGN KEY (ins_per_id) REFERENCES com_personne (per_id),
   CONSTRAINT fk_inscription_competition FOREIGN KEY (ins_com_id) REFERENCES com_competition (com_id)     
);


/*======================================
     Contraintes Supp
========================================*/
ALTER TABLE com_personne
   ADD CONSTRAINT fk_personne_club FOREIGN KEY (per_clu_id) REFERENCES com_club (clu_id);

ALTER TABLE com_competition
   ADD CONSTRAINT fk_competition_club FOREIGN KEY (com_clu_id) REFERENCES com_club (clu_id);
   
