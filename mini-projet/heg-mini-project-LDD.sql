/*********************************************************
    DROP
**********************************************************/
-- TRIGGER
DROP TRIGGER trg_con_id;
DROP TRIGGER trg_mod_id;
DROP TRIGGER trg_app_id;
DROP TRIGGER trg_aer_id;
DROP TRIGGER trg_vol_id;
DROP TRIGGER trg_leg_id;
DROP TRIGGER trg_rol_id;
DROP TRIGGER trg_emp_id;
DROP TRIGGER trg_pass_id;
DROP TRIGGER trg_res_id;
DROP TRIGGER trg_cla_id;
DROP TRIGGER trg_bag_id;
DROP TRIGGER trg_par_id;

-- TABLE
DROP TABLE cie_constructeur CASCADE CONSTRAINT;
DROP TABLE cie_modele CASCADE CONSTRAINT;
DROP TABLE cie_appareil CASCADE CONSTRAINT;
DROP TABLE cie_aeroport CASCADE CONSTRAINT;
DROP TABLE cie_vol CASCADE CONSTRAINT;
DROP TABLE cie_leg CASCADE CONSTRAINT;
DROP TABLE cie_occupation CASCADE CONSTRAINT;
DROP TABLE cie_role CASCADE CONSTRAINT;
DROP TABLE cie_employe CASCADE CONSTRAINT;
DROP TABLE cie_classe CASCADE CONSTRAINT;
DROP TABLE cie_reservation CASCADE CONSTRAINT;
DROP TABLE cie_passager CASCADE CONSTRAINT;
DROP TABLE cie_baggage CASCADE CONSTRAINT;
DROP TABLE cie_param CASCADE CONSTRAINT;

-- SEQUENCE
DROP SEQUENCE sq_cie_constructeur;
DROP SEQUENCE sq_cie_modele;
DROP SEQUENCE sq_cie_appareil;
DROP SEQUENCE sq_cie_aeroport;
DROP SEQUENCE sq_cie_vol;
DROP SEQUENCE sq_cie_leg;
DROP SEQUENCE sq_cie_role;
DROP SEQUENCE sq_cie_employe;
DROP SEQUENCE sq_cie_passager;
DROP SEQUENCE sq_cie_reservation;
DROP SEQUENCE sq_cie_classe;
DROP SEQUENCE sq_cie_baggage;
DROP SEQUENCE sq_cie_param;
COMMIT;


/*********************************************************
    CREATE TABLE
**********************************************************/

-- constructeur
CREATE TABLE cie_constructeur (
    con_id NUMBER CONSTRAINT pk_cie_constructeur PRIMARY KEY,
    con_nom VARCHAR(25) CONSTRAINT nn_con_nom NOT NULL CONSTRAINT uk_con_nom UNIQUE
);

-- modele
CREATE TABLE cie_modele (
    mod_id NUMBER(5) CONSTRAINT pk_cie_modele PRIMARY KEY,
    mod_code CHAR(10) CONSTRAINT nn_mod_code NOT NULL CONSTRAINT uk_mod_code UNIQUE,
    mod_nom VARCHAR(25) CONSTRAINT nn_mod_nom NOT NULL CONSTRAINT uk_mod_nom UNIQUE,
    mod_prix_catalogue NUMBER(10) CONSTRAINT ck_prix_catalogue CHECK (mod_prix_catalogue >= 0),
    mod_portee_max NUMBER(6) NOT NULL CONSTRAINT ck_porte_max CHECK (mod_portee_max >= 0),
    mod_charge_max NUMBER(6) NOT NULL CONSTRAINT ck_charge_max CHECK (mod_charge_max >= 0),
    mod_container_max NUMBER(5) CONSTRAINT ck_container_max CHECK (mod_container_max >= 0),
    mod_passager_max NUMBER (5) CONSTRAINT ck_passager_max CHECK (mod_passager_max >= 0),
    mod_con_id NUMBER CONSTRAINT nn_mod_con_id NOT NULL,
    CONSTRAINT fk_cie_modele_constructeur FOREIGN KEY (mod_con_id) REFERENCES cie_constructeur(con_id)
);

-- appareil
CREATE TABLE cie_appareil (
    app_id NUMBER(5) CONSTRAINT pk_cie_appareil PRIMARY KEY,
    app_immatriculation CHAR(10) CONSTRAINT nn_app_immatriculation NOT NULL CONSTRAINT uk_app_immatriculation UNIQUE,
    app_mise_en_service DATE,
    app_achat DATE,
    app_mod_id NUMBER(5) CONSTRAINT nn_app_mod_id NOT NULL,
    CONSTRAINT fk_cie_appareil_modele FOREIGN KEY (app_mod_id) REFERENCES cie_modele(mod_id)
);

-- aeroport
CREATE TABLE cie_aeroport (
    aer_id NUMBER(5) CONSTRAINT pk_cie_aeroport PRIMARY KEY,
    aer_code CHAR(3) CONSTRAINT nn_aer_code NOT NULL CONSTRAINT uk_aer_code UNIQUE,
    aer_nom VARCHAR(50) CONSTRAINT nn_aer_nom NOT NULL CONSTRAINT uk_aer_nom UNIQUE
);

-- vol
CREATE TABLE cie_vol (
    vol_id NUMBER(5) CONSTRAINT pk_vol_id PRIMARY KEY,
    vol_numero CHAR(10) CONSTRAINT nn_vol_id NOT NULL CONSTRAINT uk_vol_id UNIQUE,
    vol_horaire_prevu_dep TIMESTAMP CONSTRAINT nn_vol_horaire_prevu_dep NOT NULL,
    vol_horaire_prevu_arr TIMESTAMP CONSTRAINT nn_vol_horaire_prevu_arr NOT NULL,
    vol_aer_id_dest NUMBER(5) CONSTRAINT nn_vol_aer_id_dest NOT NULL,
    vol_aer_id_dep NUMBER(5) CONSTRAINT nn_vol_aer_id_dep NOT NULL,
    CONSTRAINT fk_cie_vol_aeroport_dest FOREIGN KEY (vol_aer_id_dest) REFERENCES cie_aeroport(aer_id),
    CONSTRAINT fk_cie_vol_aeroport_dep FOREIGN KEY (vol_aer_id_dep) REFERENCES cie_aeroport(aer_id)
);

-- leg
CREATE TABLE cie_leg (
    leg_id NUMBER CONSTRAINT pk_cie_leg PRIMARY KEY,
    leg_vol_id NUMBER(5) CONSTRAINT nn_leg_vol_id NOT NULL,
    leg_app_id NUMBER(5),
    leg_horaire_effectif_dep TIMESTAMP,
    leg_horaire_effectif_arr TIMESTAMP,
    CONSTRAINT fk_cie_leg_id FOREIGN KEY (leg_vol_id) REFERENCES cie_vol(vol_id),
    CONSTRAINT fk_cie_leg_appareil FOREIGN KEY (leg_app_id) REFERENCES cie_appareil(app_id)
);

-- employe
CREATE TABLE cie_employe (
    emp_id NUMBER CONSTRAINT pk_cie_employe PRIMARY KEY,
    emp_nom VARCHAR(25) CONSTRAINT nn_emp_nom NOT NULL,
    emp_prenom VARCHAR(25) CONSTRAINT nn_emp_prenom NOT NULL,
    emp_salaire NUMBER(6) CONSTRAINT nn_emp_salaire NOT NULL,
    CONSTRAINT ck_emp_salaire CHECK (emp_salaire >= 0),
    CONSTRAINT uk_emp_nom_prenom UNIQUE (emp_nom, emp_prenom)
);

-- role
CREATE TABLE cie_role (
    rol_id NUMBER(2) CONSTRAINT pk_cie_role PRIMARY KEY,
    rol_nom VARCHAR(25) CONSTRAINT nn_rol_nom NOT NULL CONSTRAINT uk_rol_nom UNIQUE,
    rol_prime NUMBER(4) CONSTRAINT nn_rol_prime NOT NULL,
    CONSTRAINT uk_rol_prime CHECK (rol_prime >= 0)
);

-- occupation
CREATE TABLE cie_occupation (
    occ_emp_id NUMBER CONSTRAINT nn_occ_emp_id NOT NULL,
    occ_leg_id NUMBER CONSTRAINT nn_occ_leg_id NOT NULL,
    occ_rol_id NUMBER(2) CONSTRAINT nn_occ_rol NOT NULL,
    CONSTRAINT pk_cie_occupation PRIMARY KEY (occ_emp_id, occ_leg_id, occ_rol_id),
    CONSTRAINT fk_cie_occupation_leg FOREIGN KEY (occ_leg_id) REFERENCES cie_leg(leg_id),
    CONSTRAINT fk_cie_occupation_employe FOREIGN KEY (occ_emp_id) REFERENCES cie_employe(emp_id),
    CONSTRAINT fk_cie_occupation_role FOREIGN KEY (occ_rol_id) REFERENCES cie_role(rol_id)
);

-- class
CREATE TABLE cie_classe (
    cla_id NUMBER(1) CONSTRAINT pk_cie_classe PRIMARY KEY,
    cla_nom VARCHAR(25) CONSTRAINT nn_cla_nom NOT NULL CONSTRAINT uk_cla_nom UNIQUE,
    cla_prix_forfaitaire NUMBER(5) CONSTRAINT nn_cla_prix_forfaitaire NOT NULL,
    CONSTRAINT ck_cla_prix_forfaitaire CHECK (cla_prix_forfaitaire >= 0)
);

-- passager
CREATE TABLE cie_passager (
    pass_id NUMBER(5) CONSTRAINT pk_cie_passager PRIMARY KEY,
    pass_numero_passport CHAR(36) CONSTRAINT nn_pass_numero_passport NOT NULL CONSTRAINT uk_pass_numero_passport UNIQUE,
    pass_nom VARCHAR(25),
    pass_prenom VARCHAR(25),
    pass_mail VARCHAR(50),
    pass_tel VARCHAR(25),
    pass_miles NUMBER(7) DEFAULT NULL CONSTRAINT ck_pass_miles CHECK (pass_miles >= 0)
);

-- reservation
CREATE TABLE cie_reservation (
    res_id NUMBER CONSTRAINT pk_cie_reservation PRIMARY KEY,
    res_ouverture DATE CONSTRAINT nn_res_ouverture NOT NULL,
    res_leg_id NUMBER CONSTRAINT nn_res_leg_id NOT NULL,
    res_cla_id NUMBER(1) CONSTRAINT nn_cla_id NOT NULL,
    res_pass_id NUMBER(5) CONSTRAINT nn_pass_id NOT NULL,
    CONSTRAINT fk_cie_reservation_leg FOREIGN KEY (res_leg_id) REFERENCES cie_leg(leg_id),
    CONSTRAINT fk_cie_reservation_classe FOREIGN KEY (res_cla_id) REFERENCES cie_classe(cla_id),
    CONSTRAINT fk_cie_reservation_passager FOREIGN KEY (res_pass_id) REFERENCES cie_passager(pass_id),
    CONSTRAINT uk_res_leg_numero_passport UNIQUE (res_leg_id, res_pass_id)
);


-- baggae
CREATE TABLE cie_baggage (
    bag_id CHAR(10) CONSTRAINT pk_cie_bagage PRIMARY KEY,
    bag_marque VARCHAR(25),
    bag_couleur VARCHAR(25),
    bag_poid NUMBER(3) CONSTRAINT ck_bag_poid CHECK (bag_poid >= 0),
    bag_pass_id NUMBER(5) CONSTRAINT nn_bag_pass_id NOT NULL,
    CONSTRAINT fk_cie_baggage_passager FOREIGN KEY (bag_pass_id) REFERENCES cie_passager(pass_id)
);

CREATE TABLE cie_param(
    par_id NUMBER CONSTRAINT pk_cie_param PRIMARY KEY,
    par_key VARCHAR(25) CONSTRAINT nn_par_key NOT NULL,
    par_value NUMBER(2) CONSTRAINT nn_par_value NOT NULL
);

COMMIT;

/*********************************************************
    AUTO INCREMENT (SEQ & TRIGGERS)
**********************************************************/

-- con_id
CREATE SEQUENCE sq_cie_constructeur START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_con_id 
BEFORE INSERT ON cie_constructeur 
FOR EACH ROW
  WHEN (NEW.con_id IS NULL)
BEGIN
    SELECT sq_cie_constructeur.NEXTVAL INTO :NEW.con_id FROM DUAL;
END;
/

-- mod_id
CREATE SEQUENCE sq_cie_modele START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_mod_id
BEFORE INSERT ON cie_modele 
FOR EACH ROW
  WHEN (NEW.mod_id IS NULL)
BEGIN
    SELECT sq_cie_modele.NEXTVAL INTO :NEW.mod_id FROM DUAL;
END;
/

-- app_id
CREATE SEQUENCE sq_cie_appareil START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_app_id
BEFORE INSERT ON cie_appareil
FOR EACH ROW
  WHEN (NEW.app_id IS NULL)
BEGIN
    SELECT sq_cie_appareil.NEXTVAL INTO :NEW.app_id FROM DUAL;
END;
/

-- aer_id
CREATE SEQUENCE sq_cie_aeroport START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_aer_id
BEFORE INSERT ON cie_aeroport
FOR EACH ROW
  WHEN (NEW.aer_id IS NULL)
BEGIN
    SELECT sq_cie_aeroport.NEXTVAL INTO :NEW.aer_id FROM DUAL;
END;
/

-- vol_id
CREATE SEQUENCE sq_cie_vol START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_vol_id
BEFORE INSERT ON cie_vol
FOR EACH ROW
  WHEN (NEW.vol_id IS NULL)
BEGIN
    SELECT sq_cie_vol.NEXTVAL INTO :NEW.vol_id FROM DUAL;
END;
/

-- leg_id
CREATE SEQUENCE sq_cie_leg START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_leg_id 
BEFORE INSERT ON cie_leg 
FOR EACH ROW
  WHEN (NEW.leg_id IS NULL)
BEGIN
    SELECT sq_cie_leg.NEXTVAL INTO :NEW.leg_id FROM DUAL;
END;
/

--rol_id
CREATE SEQUENCE sq_cie_role START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_rol_id 
BEFORE INSERT ON cie_role 
FOR EACH ROW
BEGIN
    SELECT sq_cie_role.NEXTVAL INTO :NEW.rol_id FROM DUAL;
END;
/

-- emp_id
CREATE SEQUENCE sq_cie_employe START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_emp_id 
BEFORE INSERT ON cie_employe 
FOR EACH ROW
BEGIN
    SELECT sq_cie_employe.NEXTVAL INTO :NEW.emp_id FROM DUAL;
END;
/

--pass_id
CREATE SEQUENCE sq_cie_passager START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_pass_id 
BEFORE INSERT ON cie_passager
FOR EACH ROW
BEGIN
    SELECT sq_cie_passager.NEXTVAL INTO :NEW.pass_id FROM DUAL;
END;
/

-- reservation
CREATE SEQUENCE sq_cie_reservation START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_res_id
BEFORE INSERT ON cie_reservation 
FOR EACH ROW
BEGIN
    SELECT sq_cie_reservation.NEXTVAL INTO :NEW.res_id FROM DUAL;
END;
/

-- cla_id
CREATE SEQUENCE sq_cie_classe START WITH 1 INCREMENT BY 1;
    
CREATE OR REPLACE TRIGGER trg_cla_id 
BEFORE INSERT ON cie_classe 
FOR EACH ROW
BEGIN
    SELECT sq_cie_classe.NEXTVAL INTO :NEW.cla_id FROM DUAL;
END;
/

-- bag_id
CREATE SEQUENCE sq_cie_baggage START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_bag_id 
BEFORE INSERT ON cie_baggage 
FOR EACH ROW
BEGIN
    SELECT sq_cie_baggage.NEXTVAL INTO :NEW.bag_id FROM DUAL;
END;
/

CREATE SEQUENCE sq_cie_param START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_par_id 
BEFORE INSERT ON cie_param 
FOR EACH ROW
BEGIN
    SELECT sq_cie_param.NEXTVAL INTO :NEW.par_id FROM DUAL;
END;
/
COMMIT;