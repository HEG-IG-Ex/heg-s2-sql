/*********************************************************
    DROP
**********************************************************/
-- TRIGGER
DROP TRIGGER trg_con_id;
DROP TRIGGER trg_leg_id;
DROP TRIGGER trg_rol_id;
DROP TRIGGER trg_emp_id;
DROP TRIGGER trg_cla_id;
DROP TRIGGER trg_bag_id;

-- TABLE
DROP TABLE cie_constructeur CASCADE CONSTRAINT;
DROP TABLE cie_modele CASCADE CONSTRAINT;
DROP TABLE cie_appareil CASCADE CONSTRAINT;
DROP TABLE cie_vol CASCADE CONSTRAINT;
DROP TABLE cie_leg CASCADE CONSTRAINT;
DROP TABLE cie_aeroport CASCADE CONSTRAINT;
DROP TABLE cie_occupation CASCADE CONSTRAINT;
DROP TABLE cie_role CASCADE CONSTRAINT;
DROP TABLE cie_employe CASCADE CONSTRAINT;
DROP TABLE cie_classe CASCADE CONSTRAINT;
DROP TABLE cie_reservation CASCADE CONSTRAINT;
DROP TABLE cie_passager CASCADE CONSTRAINT;
DROP TABLE cie_baggage CASCADE CONSTRAINT;

-- SEQUENCE
DROP SEQUENCE sq_cie_constructeur;
DROP SEQUENCE sq_cie_leg;
DROP SEQUENCE sq_cie_role;
DROP SEQUENCE sq_cie_employe;
DROP SEQUENCE sq_cie_classe;
DROP SEQUENCE sq_cie_baggage;


/*********************************************************
    CREATE TABLE
**********************************************************/

-- constructeur
CREATE TABLE cie_constructeur (
    con_id NUMBER,
    con_nom VARCHAR(25) 
            CONSTRAINT nn_con_nom NOT NULL 
            CONSTRAINT uk_con_nom UNIQUE,
    CONSTRAINT pk_cie_constructeur PRIMARY KEY (con_id)
);

-- modele
CREATE TABLE cie_modele (
    mod_code CHAR(10),
    mod_nom VARCHAR(25) NOT NULL UNIQUE,
    mod_prix_catalogue NUMBER(10) DEFAULT 0 CHECK (mod_prix_catalogue >= 0),
    mod_portee_max NUMBER(6) NOT NULL CHECK (mod_portee_max >= 0),
    mod_charge_max NUMBER(6) NOT NULL CHECK (mod_charge_max >= 0),
    mod_container_max NUMBER(5) CHECK (mod_container_max >= 0),
    mod_passager_max NUMBER (5) CHECK (mod_passager_max >= 0),
    mod_con_id NUMBER NOT NULL,
    CONSTRAINT pk_cie_modele PRIMARY KEY (mod_code),
    CONSTRAINT fk_cie_modele_constructeur FOREIGN KEY (mod_con_id) REFERENCES cie_constructeur(con_id)
);

-- appareil
CREATE TABLE cie_appareil (
    app_immatriculation CHAR(10),
    app_mise_en_service DATE,
    app_achat DATE,
    app_mod_code CHAR(10) NOT NULL,
    CONSTRAINT pk_cie_appareil PRIMARY KEY (app_immatriculation),
    CONSTRAINT fk_cie_appareil_modele FOREIGN KEY (app_mod_code) REFERENCES cie_modele(mod_code)
);

-- aeroport
CREATE TABLE cie_aeroport (
    aer_code CHAR(3),
    aer_nom VARCHAR(25) NOT NULL UNIQUE,
    CONSTRAINT pk_cie_aeroport PRIMARY KEY (aer_code)
);

-- vol
CREATE TABLE cie_vol (
    vol_numero CHAR(10),
    vol_horaire_prevu_dep TIMESTAMP NOT NULL,
    vol_horaire_prevu_arr TIMESTAMP NOT NULL,
    vol_aer_code_dest CHAR(3),
    vol_aer_code_dep CHAR(3),
    CONSTRAINT pk_cie_vol PRIMARY KEY (vol_numero),
    CONSTRAINT fk_cie_vol_aeroport_dest FOREIGN KEY (vol_aer_code_dest) REFERENCES cie_aeroport(aer_code),
    CONSTRAINT fk_cie_vol_aeroport_dep FOREIGN KEY (vol_aer_code_dep) REFERENCES cie_aeroport(aer_code)
);

-- leg
CREATE TABLE cie_leg (
    leg_id NUMBER,
    leg_vol_numero CHAR(10),
    leg_app_immatriculation CHAR(10),
    leg_horaire_effectif_dep TIMESTAMP,
    leg_horaire_effectif_arr TIMESTAMP,
    CONSTRAINT pk_cie_leg PRIMARY KEY (leg_id),
    CONSTRAINT fk_cie_leg_vol FOREIGN KEY (leg_vol_numero) REFERENCES cie_vol(vol_numero),
    CONSTRAINT fk_cie_leg_appareil FOREIGN KEY (leg_app_immatriculation) REFERENCES cie_appareil(app_immatriculation)
);

-- employe
CREATE TABLE cie_employe (
    emp_id NUMBER,
    emp_nom VARCHAR(25) NOT NULL,
    emp_prenom VARCHAR(25) NOT NULL,
    emp_salaire NUMBER(6) NOT NULL CHECK (emp_salaire >= 0),
    CONSTRAINT pk_cie_employe PRIMARY KEY (emp_id)
);

-- role
CREATE TABLE cie_role (
    rol_id NUMBER(2),
    rol_nom VARCHAR(25) NOT NULL UNIQUE,
    rol_prime NUMBER(4) NOT NULL CHECK (rol_prime >= 0),
    CONSTRAINT pk_cie_role PRIMARY KEY (rol_id)
);

-- occupation
CREATE TABLE cie_occupation (
    occ_emp_id NUMBER NOT NULL,
    occ_leg_id NUMBER NOT NULL,
    occ_rol_id NUMBER(2) NOT NULL,
    CONSTRAINT pk_cie_occupation PRIMARY KEY (occ_emp_id, occ_leg_id, occ_rol_id),
    CONSTRAINT fk_cie_occupation_leg FOREIGN KEY (occ_leg_id) REFERENCES cie_leg(leg_id),
    CONSTRAINT fk_cie_occupation_employe FOREIGN KEY (occ_emp_id) REFERENCES cie_employe(emp_id),
    CONSTRAINT fk_cie_occupation_role FOREIGN KEY (occ_rol_id) REFERENCES cie_role(rol_id)
);

-- class
CREATE TABLE cie_classe (
    cla_id NUMBER(1),
    cla_nom VARCHAR(25) NOT NULL UNIQUE,
    cla_prix_forfaitaire NUMBER(5) NOT NULL CHECK (cla_prix_forfaitaire >= 0),
    CONSTRAINT pk_cie_classe PRIMARY KEY (cla_id)
);

-- passager
CREATE TABLE cie_passager (
    pass_numero_passport CHAR(25),
    pass_nom VARCHAR(25),
    pass_prenom VARCHAR(25),
    pass_mail VARCHAR(25),
    pass_tel VARCHAR(25),
    pass_miles NUMBER(7) CHECK (pass_miles >= 0),
    CONSTRAINT pk_cie_passager PRIMARY KEY (pass_numero_passport)
);

-- reservation
CREATE TABLE cie_reservation (
    res_code CHAR(25),
    res_ouverture DATE NOT NULL,
    res_vol_numero CHAR(10) NOT NULL,
    res_cla_id NUMBER(1) NOT NULL,
    res_pass_numero_passport CHAR(25) NOT NULL,
    CONSTRAINT pk_cie_reservation PRIMARY KEY (res_code),
    CONSTRAINT fk_cie_reservation_vol FOREIGN KEY (res_vol_numero) REFERENCES cie_vol(vol_numero),
    CONSTRAINT fk_cie_reservation_classe FOREIGN KEY (res_cla_id) REFERENCES cie_classe(cla_id),
    CONSTRAINT fk_cie_reservation_passager FOREIGN KEY (res_pass_numero_passport) REFERENCES cie_passager(pass_numero_passport)
);


-- baggae
CREATE TABLE cie_baggage (
    bag_id CHAR(10),
    bag_marque VARCHAR(25),
    bag_couleur VARCHAR(25),
    bag_poid NUMBER(3) CHECK (bag_poid >= 0),
    bag_pass_numero_passport CHAR(25) NOT NULL,
    CONSTRAINT pk_cie_bagage PRIMARY KEY (bag_id),
    CONSTRAINT fk_cie_baggage_passager FOREIGN KEY (bag_pass_numero_passport) REFERENCES cie_passager(pass_numero_passport)
);

/*********************************************************
    AUTO INCREMENT
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
