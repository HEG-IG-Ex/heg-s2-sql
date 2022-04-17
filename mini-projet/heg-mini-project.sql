DROP cie_constructeur CASCADE CONSTRAINT;
DROP cie_modele CASCADE CONSTRAINT;
DROP cie_appareil CASCADE CONSTRAINT;
DROP cie_vol CASCADE CONSTRAINT;
DROP cie_aeroport CASCADE CONSTRAINT;
DROP cie_occupation CASCADE CONSTRAINT;
DROP cie_role CASCADE CONSTRAINT;
DROP cie_employe CASCADE CONSTRAINT;
DROP cie_classe CASCADE CONSTRAINT;
DROP cie_reservation CASCADE CONSTRAINT;
DROP cie_passager CASCADE CONSTRAINT;
DROP cie_bagage CASCADE CONSTRAINT;

CREATE TABLE cie_constructeur (
   con_id        NUMBER(5) NOT NULL CONSTRAINT pk_con_id PRIMARY KEY,
   con_nom       CHAR(40) NOT NULL,
   
   CONSTRAINT uk_con_nom UNIQUE (con_nom)
);

CREATE TABLE cie_modele (
   mod_code            CHAR(10) CONSTRAINT pk_mod_code PRIMARY KEY,
   mod_nom             CHAR(25) CONSTRAINT nn_mod_nom NOT NULL,
   mod_prix_catalogue  NUMBER CONSTRAINT nn_mod_prix_catalogue NOT NULL,
   mod_portee_max      NUMBER(6) DEFAULT 0 CONSTRAINT ch_mod_container_max CHECK(mod_container_max >= 0),
   mod_charge_max      NUMBER(5) DEFAULT 0 CONSTRAINT ch_mod_container_max CHECK(mod_container_max >= 0),
   mod_container_max   NUMBER(5) DEFAULT 0 CONSTRAINT ch_mod_container_max CHECK(mod_container_max >= 0),
   mod_passager_max    NUMBER (5) DEFAULT 0 CONSTRAINT mod_passager_max CHECK(mod_passager_max >= 0),
   mod_con_id          NUMBER(5)
);
