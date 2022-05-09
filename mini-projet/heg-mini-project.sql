/*********************************************************
    DROP
**********************************************************/
-- TRIGGER
DROP TRIGGER trg_con_id;
DROP TRIGGER trg_leg_id;
DROP TRIGGER trg_rol_id;
DROP TRIGGER trg_emp_id;
DROP TRIGGER trg_res_code;
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
DROP SEQUENCE sq_cie_reservation;
DROP SEQUENCE sq_cie_classe;
DROP SEQUENCE sq_cie_baggage;
COMMIT;


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
    aer_nom VARCHAR(50) NOT NULL UNIQUE,
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
    pass_numero_passport CHAR(36),
    pass_nom VARCHAR(25),
    pass_prenom VARCHAR(25),
    pass_mail VARCHAR(50),
    pass_tel VARCHAR(25),
    pass_miles NUMBER(7)  DEFAULT NULL CONSTRAINT ck_pass_miles CHECK (pass_miles >= 0),
    CONSTRAINT pk_cie_passager PRIMARY KEY (pass_numero_passport)
);

-- reservation
CREATE TABLE cie_reservation (
    res_code NUMBER,
    res_ouverture DATE NOT NULL,
    res_leg_id NUMBER NOT NULL,
    res_cla_id NUMBER(1) NOT NULL,
    res_pass_numero_passport CHAR(36) NOT NULL,
    CONSTRAINT pk_cie_reservation PRIMARY KEY (res_code),
    CONSTRAINT fk_cie_reservation_leg FOREIGN KEY (res_leg_id) REFERENCES cie_leg(leg_id),
    CONSTRAINT fk_cie_reservation_classe FOREIGN KEY (res_cla_id) REFERENCES cie_classe(cla_id),
    CONSTRAINT fk_cie_reservation_passager FOREIGN KEY (res_pass_numero_passport) REFERENCES cie_passager(pass_numero_passport),
    CONSTRAINT uk_res_leg_numero_passport UNIQUE (res_leg_id, res_pass_numero_passport)
);


-- baggae
CREATE TABLE cie_baggage (
    bag_id CHAR(10),
    bag_marque VARCHAR(25),
    bag_couleur VARCHAR(25),
    bag_poid NUMBER(3) CHECK (bag_poid >= 0),
    bag_pass_numero_passport CHAR(36) NOT NULL,
    CONSTRAINT pk_cie_bagage PRIMARY KEY (bag_id),
    CONSTRAINT fk_cie_baggage_passager FOREIGN KEY (bag_pass_numero_passport) REFERENCES cie_passager(pass_numero_passport)
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

-- reservation
CREATE SEQUENCE sq_cie_reservation START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_res_code
BEFORE INSERT ON cie_reservation 
FOR EACH ROW
BEGIN
    SELECT sq_cie_reservation.NEXTVAL INTO :NEW.res_code FROM DUAL;
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

COMMIT;

ALTER SESSION SET nls_date_format = 'DD-MM-YYYY';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT='DD-MM-YYYY HH24:MI:SS';

INSERT INTO cie_constructeur (con_nom) VALUES ('Boeing');
INSERT INTO cie_constructeur (con_nom) VALUES ('Airbus');

INSERT INTO cie_modele VALUES('747-8', '747 Commercial Transport', 418000000, 12150, 442,30,467,1);
INSERT INTO cie_modele VALUES('787-8', '787 Dreamliner', 248000000, 13530, 228,28,250,1);
INSERT INTO cie_modele VALUES('A380', 'Airbus 380 Super Jumbo', 436000000, 15200, 575, 38, 853, 2);
INSERT INTO cie_modele VALUES('A320-2', 'Airbus 320-200 Mid-Range', 101000000, 6150, 68, 12, 180, 2);

INSERT INTO cie_appareil VALUES ('HBIJK', '20-03-2021', '20-01-2021', '747-8');
INSERT INTO cie_appareil VALUES ('HBJYA', '20-01-1992', '20-04-1992', 'A380');


INSERT INTO cie_aeroport VALUES ('GVA', 'Genève Aéroport');
INSERT INTO cie_aeroport VALUES ('YUL', 'Aéroport International Montréal-Trudeau');
INSERT INTO cie_aeroport VALUES ('LHR', 'London Heathrow Airport');
INSERT INTO cie_aeroport VALUES ('JFK', 'John F. Kennedy International Airport');

INSERT INTO cie_vol VALUES ('AC885',  TO_DATE('01-05-2022 21:00:00', 'dd-mm-yyyy hh24:mi:ss'), TO_DATE('02-05-2022 08:00:00', 'dd-mm-yyyy hh24:mi:ss'),'GVA', 'YUL');
INSERT INTO cie_vol VALUES ('AC442',  TO_DATE('01-05-2022 07:20:00', 'dd-mm-yyyy hh24:mi:ss'), TO_DATE('01-05-2022 08:00:00', 'dd-mm-yyyy hh24:mi:ss'),'GVA', 'LHR');

INSERT INTO cie_leg (leg_vol_numero, leg_app_immatriculation, leg_horaire_effectif_dep, leg_horaire_effectif_arr) VALUES ('AC442', 'HBIJK', TO_DATE('01-05-2022 07:35:00', 'dd-mm-yyyy hh24:mi:ss'), TO_DATE('01-05-2022 08:23:00', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO cie_leg (leg_vol_numero, leg_app_immatriculation, leg_horaire_effectif_dep, leg_horaire_effectif_arr) VALUES ('AC885', 'HBJYA', TO_DATE('01-05-2022 21:05:00', 'dd-mm-yyyy hh24:mi:ss'), TO_DATE('02-05-2022 08:23:00', 'dd-mm-yyyy hh24:mi:ss'));
COMMIT;


INSERT INTO cie_employe (emp_nom, emp_prenom, emp_salaire) VALUES ('Tigh', 'Saul', 95000);
INSERT INTO cie_employe (emp_nom, emp_prenom, emp_salaire) VALUES ('Adama', 'William', 105000);
INSERT INTO cie_employe (emp_nom, emp_prenom, emp_salaire) VALUES ('Baltar', 'Gaius', 90000);
INSERT INTO cie_employe (emp_nom, emp_prenom, emp_salaire) VALUES ('Adama', 'Lee', 105000);
INSERT INTO cie_employe (emp_nom, emp_prenom, emp_salaire) VALUES ('Thrace', 'Kara', 120000);
INSERT INTO cie_employe (emp_nom, emp_prenom, emp_salaire) VALUES ('Valerii', 'Sharon', 110000);
INSERT INTO cie_employe (emp_nom, emp_prenom, emp_salaire) VALUES ('Agathin', 'Karl', 85000);
INSERT INTO cie_employe (emp_nom, emp_prenom, emp_salaire) VALUES ('Gaeta', 'Felix', 90000);
INSERT INTO cie_employe (emp_nom, emp_prenom, emp_salaire) VALUES ('Dualla', 'Anastasia', 100000);
INSERT INTO cie_employe (emp_nom, emp_prenom, emp_salaire) VALUES ('Anders', 'Samuel', 100000);

INSERT INTO cie_role (rol_nom, rol_prime) VALUES ('Pilote', 500);
INSERT INTO cie_role (rol_nom, rol_prime) VALUES ('Co-Pilote', 400);
INSERT INTO cie_role (rol_nom, rol_prime) VALUES ('Chef de cabine', 300);
INSERT INTO cie_role (rol_nom, rol_prime) VALUES ('Hôte/Hôtesse', 200);

INSERT INTO cie_occupation VALUES (1,1,1);
INSERT INTO cie_occupation VALUES (2,1,2);
INSERT INTO cie_occupation VALUES (3,1,3);
INSERT INTO cie_occupation VALUES (4,1,4);
INSERT INTO cie_occupation VALUES (5,1,4);
INSERT INTO cie_occupation VALUES (6,2,1);
INSERT INTO cie_occupation VALUES (7,2,2);
INSERT INTO cie_occupation VALUES (8,2,3);
INSERT INTO cie_occupation VALUES (9,2,4);
INSERT INTO cie_occupation VALUES (10,2,4);
COMMIT;


INSERT INTO cie_passager VALUES('945dd77c-7b33-4652-98ca-6e4ed2636414','Nurton','Alessandra','Alessandra_Nurton8760@gompie.com','7-711-674-5871',DEFAULT);
INSERT INTO cie_passager VALUES('5b30e61e-6a96-4569-beb3-bf8487e54b94','Judd','Logan','Logan_Judd4877@elnee.tech','5-714-413-4425',DEFAULT);
INSERT INTO cie_passager VALUES('24dec3a5-bf1d-48cb-bc38-d91a200ad0ff','Vollans','Lexi','Lexi_Vollans6883@vetan.org','0-400-542-5255',DEFAULT);
INSERT INTO cie_passager VALUES('f759f51b-8d1a-4c94-9848-577ef57880b8','Denton','Samantha','Samantha_Denton2366@eirey.tech','3-071-130-6466',DEFAULT);
INSERT INTO cie_passager VALUES('5d69fa68-e04c-479a-b10d-b345edb9caf3','Cunningham','Janelle','Janelle_Cunningham7304@deavo.com','1-587-447-0542',DEFAULT);
INSERT INTO cie_passager VALUES('902d48fc-56d9-4502-9e5c-db03f5b1ff7b','Rixon','Michael','Michael_Rixon1243@bauros.biz','8-307-344-6435',DEFAULT);
INSERT INTO cie_passager VALUES('5b3866af-a15e-4769-a0c6-4d5e96955463','Calderwood','Mavis','Mavis_Calderwood4733@jiman.org','7-866-636-8165',DEFAULT);
INSERT INTO cie_passager VALUES('5da51dc8-44cf-4b5b-b69b-288a2aa31a90','Fall','Carl','Carl_Fall2476@bungar.biz','5-847-882-5023',DEFAULT);
INSERT INTO cie_passager VALUES('b40d4b4b-26f4-4f76-8394-ca8bd7629988','Hilton','Aileen','Aileen_Hilton2474@naiker.biz','0-804-730-5505',DEFAULT);
INSERT INTO cie_passager VALUES('b148e556-3124-4dda-9495-aeb3d01ac134','Hooper','Isabella','Isabella_Hooper5472@ubusive.com','0-528-252-8606',41);
INSERT INTO cie_passager VALUES('a7186bd0-eeb0-4018-8ff9-e47f4c1936c7','Neville','Hank','Hank_Neville7582@dionrab.com','0-263-435-0765',60);
INSERT INTO cie_passager VALUES('16dcf1e0-0062-4111-8930-621880c65470','Chadwick','Aileen','Aileen_Chadwick3894@liret.org','0-232-348-8333',64);
INSERT INTO cie_passager VALUES('a3e13691-5423-4108-8e64-b6e4b9ffbd15','Bradley','Henry','Henry_Bradley2169@corti.com','7-510-612-8718',30);
INSERT INTO cie_passager VALUES('19ab4eb0-73cc-4e1e-8a17-c9616400278c','Dyson','Marjorie','Marjorie_Dyson6612@bulaffy.com','4-741-224-8835',30);
INSERT INTO cie_passager VALUES('01a22d72-7de1-47ef-ac79-7ee686dce239','Mason','Carter','Carter_Mason9176@bretoux.com','7-837-666-3082',46);

INSERT INTO cie_classe (cla_nom, cla_prix_forfaitaire) VALUES ('Economic', 100);
INSERT INTO cie_classe (cla_nom, cla_prix_forfaitaire) VALUES ('Economic-flex', 150);
INSERT INTO cie_classe (cla_nom, cla_prix_forfaitaire) VALUES ('Business', 200);
INSERT INTO cie_classe (cla_nom, cla_prix_forfaitaire) VALUES ('First', 400);

INSERT INTO cie_reservation  (res_ouverture, res_leg_id, res_cla_id, res_pass_numero_passport)  VALUES ('20.04.2022', 1, 1, '945dd77c-7b33-4652-98ca-6e4ed2636414');
INSERT INTO cie_reservation  (res_ouverture, res_leg_id, res_cla_id, res_pass_numero_passport)  VALUES ('10.04.2022', 1, 1, '5b30e61e-6a96-4569-beb3-bf8487e54b94');
INSERT INTO cie_reservation  (res_ouverture, res_leg_id, res_cla_id, res_pass_numero_passport)  VALUES ('26.03.2022', 1, 2, '24dec3a5-bf1d-48cb-bc38-d91a200ad0ff');
INSERT INTO cie_reservation  (res_ouverture, res_leg_id, res_cla_id, res_pass_numero_passport)  VALUES ('10.02.2022', 1, 3, 'f759f51b-8d1a-4c94-9848-577ef57880b8');
INSERT INTO cie_reservation  (res_ouverture, res_leg_id, res_cla_id, res_pass_numero_passport)  VALUES ('02.01.2022', 1, 4, '5d69fa68-e04c-479a-b10d-b345edb9caf3');
INSERT INTO cie_reservation  (res_ouverture, res_leg_id, res_cla_id, res_pass_numero_passport)  VALUES ('18.12.2021', 1, 4, '902d48fc-56d9-4502-9e5c-db03f5b1ff7b');
INSERT INTO cie_reservation  (res_ouverture, res_leg_id, res_cla_id, res_pass_numero_passport)  VALUES ('06.11.2021', 1, 2, 'a3e13691-5423-4108-8e64-b6e4b9ffbd15');
INSERT INTO cie_reservation  (res_ouverture, res_leg_id, res_cla_id, res_pass_numero_passport)  VALUES ('30.04.2022', 1, 2, '19ab4eb0-73cc-4e1e-8a17-c9616400278c');
INSERT INTO cie_reservation  (res_ouverture, res_leg_id, res_cla_id, res_pass_numero_passport)  VALUES ('13.04.2022', 1, 1, '01a22d72-7de1-47ef-ac79-7ee686dce239');
INSERT INTO cie_reservation  (res_ouverture, res_leg_id, res_cla_id, res_pass_numero_passport)  VALUES ('20.04.2022', 2, 1, '5b3866af-a15e-4769-a0c6-4d5e96955463');
INSERT INTO cie_reservation  (res_ouverture, res_leg_id, res_cla_id, res_pass_numero_passport)  VALUES ('20.04.2022', 2, 1, '5da51dc8-44cf-4b5b-b69b-288a2aa31a90');
INSERT INTO cie_reservation  (res_ouverture, res_leg_id, res_cla_id, res_pass_numero_passport)  VALUES ('26.03.2022', 2, 2, 'b40d4b4b-26f4-4f76-8394-ca8bd7629988');
INSERT INTO cie_reservation  (res_ouverture, res_leg_id, res_cla_id, res_pass_numero_passport)  VALUES ('10.02.2022', 2, 2, 'b148e556-3124-4dda-9495-aeb3d01ac134');
INSERT INTO cie_reservation  (res_ouverture, res_leg_id, res_cla_id, res_pass_numero_passport)  VALUES ('02.01.2022', 2, 2, 'a7186bd0-eeb0-4018-8ff9-e47f4c1936c7');
INSERT INTO cie_reservation  (res_ouverture, res_leg_id, res_cla_id, res_pass_numero_passport)  VALUES ('18.12.2021', 2, 3, '16dcf1e0-0062-4111-8930-621880c65470');

INSERT INTO cie_baggage(bag_marque, bag_couleur, bag_poid, bag_pass_numero_passport) VALUES('Red Hot Poker Plant','Barbie Pink',21, '945dd77c-7b33-4652-98ca-6e4ed2636414');
INSERT INTO cie_baggage(bag_marque, bag_couleur, bag_poid, bag_pass_numero_passport) VALUES('Water Lily','Champagne',47, '5b30e61e-6a96-4569-beb3-bf8487e54b94');
INSERT INTO cie_baggage(bag_marque, bag_couleur, bag_poid, bag_pass_numero_passport) VALUES('Bindweed','Magenta',53, '24dec3a5-bf1d-48cb-bc38-d91a200ad0ff');
INSERT INTO cie_baggage(bag_marque, bag_couleur, bag_poid, bag_pass_numero_passport) VALUES('Ironwood','Camel',8, 'f759f51b-8d1a-4c94-9848-577ef57880b8');
INSERT INTO cie_baggage(bag_marque, bag_couleur, bag_poid, bag_pass_numero_passport) VALUES('Manzanita','Mauve',18, '5d69fa68-e04c-479a-b10d-b345edb9caf3');
INSERT INTO cie_baggage(bag_marque, bag_couleur, bag_poid, bag_pass_numero_passport) VALUES('Pansy','Brown',4, '902d48fc-56d9-4502-9e5c-db03f5b1ff7b');
INSERT INTO cie_baggage(bag_marque, bag_couleur, bag_poid, bag_pass_numero_passport) VALUES('Cabbage','Purple',26, 'a3e13691-5423-4108-8e64-b6e4b9ffbd15');
INSERT INTO cie_baggage(bag_marque, bag_couleur, bag_poid, bag_pass_numero_passport) VALUES('Elephant Ear','Ruby',16, '19ab4eb0-73cc-4e1e-8a17-c9616400278c');
INSERT INTO cie_baggage(bag_marque, bag_couleur, bag_poid, bag_pass_numero_passport) VALUES('Snowdrop','Fuchsia',51, '01a22d72-7de1-47ef-ac79-7ee686dce239');
INSERT INTO cie_baggage(bag_marque, bag_couleur, bag_poid, bag_pass_numero_passport) VALUES('Apple','Capri',3, '5b3866af-a15e-4769-a0c6-4d5e96955463');
INSERT INTO cie_baggage(bag_marque, bag_couleur, bag_poid, bag_pass_numero_passport) VALUES('Bearberry','Cyan',32, '5da51dc8-44cf-4b5b-b69b-288a2aa31a90');
INSERT INTO cie_baggage(bag_marque, bag_couleur, bag_poid, bag_pass_numero_passport) VALUES('Lily','Magenta',16 ,'b40d4b4b-26f4-4f76-8394-ca8bd7629988');
INSERT INTO cie_baggage(bag_marque, bag_couleur, bag_poid, bag_pass_numero_passport) VALUES('Guaco','Beige',2, 'b148e556-3124-4dda-9495-aeb3d01ac134');
INSERT INTO cie_baggage(bag_marque, bag_couleur, bag_poid, bag_pass_numero_passport) VALUES('Apple','White',9 ,'a7186bd0-eeb0-4018-8ff9-e47f4c1936c7');
INSERT INTO cie_baggage(bag_marque, bag_couleur, bag_poid, bag_pass_numero_passport) VALUES('Cucumber','Champagne',5 ,'16dcf1e0-0062-4111-8930-621880c65470');
COMMIT;
