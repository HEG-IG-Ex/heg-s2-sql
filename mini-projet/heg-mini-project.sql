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
    con_id NUMBER(5),
    con_nom CHAR(40),

    CONSTRAINT pk_cie_constructeur PRIMARY KEY (con_id)
);

CREATE TABLE cie_modele (
    mod_code CHAR(10),
    mod_nom CHAR(25),
    mod_prix_catalogue NUMBER,
    mod_portee_max NUMBER(6),
    mod_charge_max NUMBER(5),
    mod_container_max NUMBER(5),
    mod_passager_max NUMBER (5),
    mod_con_id NUMBER(5),

    CONSTRAINT pk_cie_modele PRIMARY KEY (mod_code)
);

CREATE TABLE cie_appareil (
    app_immatriculation CHAR(10),
    app_mise_en_service DATE,
    app_achat DATE,
    app_mod_code CHAR(10),

    CONSTRAINT pk_cie_appareil PRIMARY KEY (app_immatriculation)
);

CREATE TABLE cie_vol (
    vol_numero CHAR(10),
    vol_horaire DATE,
    vol_date DATE,
    vol_aer_code_dest CHAR(10),
    vol_aer_code_depart CHAR(10),
    vol_app_immatriculation CHAR(10),

    CONSTRAINT pk_cie_vol PRIMARY KEY (vol_numero)
);

CREATE TABLE cie_aeroport (
    aer_code CHAR(10),
    aer_nom CHAR(25),

    CONSTRAINT pk_cie_aeroport PRIMARY KEY (aer_code)
);

CREATE TABLE cie_occupation (
    occ_emp_id CHAR(10),
    occ_vol_numero CHAR(10),
    occ_rol_id CHAR(10),
    
    CONSTRAINT pk_cie_occupation PRIMARY KEY (occ_emp_id, occ_vol_numero, occ_rol_id)
);

CREATE TABLE cie_employe (
    emp_id CHAR(10),
    emp_nom VARCHAR(25),
    emp_prenom VARCHAR(25),
    emp_salaire NUMBER,


    CONSTRAINT pk_cie_employe PRIMARY KEY (emp_id)
);


CREATE TABLE cie_role (
    rol_id NUMBER,
    rol_nom CHAR(25),
    rol_prime NUMBER,
    
    CONSTRAINT pk_cie_role PRIMARY KEY (rol_id)
);


CREATE TABLE cie_reservation (
    res_code VARCHAR(25),
    res_ouverture DATE,
    res_vol_numero CHAR(10),
    res_cla_id CHAR(10),
    res_pass_numero_passport VARCHAR(25),
    
    CONSTRAINT pk_cie_reservation PRIMARY KEY (res_code)
);

CREATE TABLE cie_classe (
    cla_id CHAR(10),
    cla_nom CHAR(10),
    cla_prix_forfaitaire CHAR(10),
    
    CONSTRAINT pk_cie_classe PRIMARY KEY (cla_id)
);

CREATE TABLE cie_passager (
    pass_numero_passport VARCHAR(25),
    pass_nom VARCHAR(25),
    pass_prenom VARCHAR(25),
    pass_mail VARCHAR(25),
    pass_tel VARCHAR(25),
    pass_miles NUMBER,
    
    CONSTRAINT pk_cie_passager PRIMARY KEY (pass_numero_passport)
);

CREATE TABLE cie_bagage (
    bag_id CHAR(10),
    bag_marque VARCHAR(25),
    bag_couleur VARCHAR(25),
    bag_poid VARCHAR(25),
    bag_pass_numero_passport VARCHAR(25),
    
    CONSTRAINT pk_cie_bagage PRIMARY KEY (bag_id)
);
