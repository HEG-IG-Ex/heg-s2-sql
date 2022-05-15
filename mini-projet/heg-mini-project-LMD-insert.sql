ALTER SESSION SET nls_date_format = 'DD-MM-YYYY';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT='DD-MM-YYYY HH24:MI:SS';

INSERT INTO cie_param VALUES (NULL, 'Supp. de prix par kg', 5);

INSERT INTO cie_constructeur (con_nom) VALUES ('Boeing');
INSERT INTO cie_constructeur (con_nom) VALUES ('Airbus');

INSERT INTO cie_modele VALUES(NULL, '747-8', '747 Commercial Transport', 418000000, 12150, 442,30,467,1);
INSERT INTO cie_modele VALUES(NULL, '787-8', '787 Dreamliner', 248000000, 13530, 228,28,250,1);
INSERT INTO cie_modele VALUES(NULL, 'A380', 'Airbus 380 Super Jumbo', 436000000, 15200, 575, 38, 853, 2);
INSERT INTO cie_modele VALUES(NULL, 'A320-2', 'Airbus 320-200 Mid-Range', 101000000, 6150, 68, 12, 180, 2);

INSERT INTO cie_appareil VALUES (NULL, 'HBIJK', '20-03-2021', '20-01-2021', 1);
INSERT INTO cie_appareil VALUES (NULL, 'HBJYA', '20-01-1992', '20-04-1992', 3);

INSERT INTO cie_aeroport VALUES (NULL, 'GVA', 'Genève Aéroport');
INSERT INTO cie_aeroport VALUES (NULL, 'YUL', 'Aéroport International Montréal-Trudeau');
INSERT INTO cie_aeroport VALUES (NULL, 'LHR', 'London Heathrow Airport');
INSERT INTO cie_aeroport VALUES (NULL, 'JFK', 'John F. Kennedy International Airport');

INSERT INTO cie_vol VALUES (NULL, 'AC885',  TO_DATE('01-05-2022 21:00:00', 'dd-mm-yyyy hh24:mi:ss'), TO_DATE('02-05-2022 08:00:00', 'dd-mm-yyyy hh24:mi:ss'),1, 2);
INSERT INTO cie_vol VALUES (NULL, 'AC442',  TO_DATE('01-05-2022 07:20:00', 'dd-mm-yyyy hh24:mi:ss'), TO_DATE('01-05-2022 08:00:00', 'dd-mm-yyyy hh24:mi:ss'),1, 3);

INSERT INTO cie_leg VALUES (NULL, 2, 1, TO_DATE('01-05-2022 07:35:00', 'dd-mm-yyyy hh24:mi:ss'), TO_DATE('01-05-2022 08:23:00', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO cie_leg VALUES (NULL, 1, 2, TO_DATE('01-05-2022 21:05:00', 'dd-mm-yyyy hh24:mi:ss'), TO_DATE('02-05-2022 08:23:00', 'dd-mm-yyyy hh24:mi:ss'));
COMMIT;


INSERT INTO cie_employe VALUES (NULL, 'Tigh', 'Saul', 95000);
INSERT INTO cie_employe VALUES (NULL, 'Adama', 'William', 105000);
INSERT INTO cie_employe VALUES (NULL, 'Baltar', 'Gaius', 90000);
INSERT INTO cie_employe VALUES (NULL, 'Adama', 'Lee', 105000);
INSERT INTO cie_employe VALUES (NULL, 'Thrace', 'Kara', 120000);
INSERT INTO cie_employe VALUES (NULL, 'Valerii', 'Sharon', 110000);
INSERT INTO cie_employe VALUES (NULL, 'Agathin', 'Karl', 85000);
INSERT INTO cie_employe VALUES (NULL, 'Gaeta', 'Felix', 90000);
INSERT INTO cie_employe VALUES (NULL, 'Dualla', 'Anastasia', 100000);
INSERT INTO cie_employe VALUES (NULL, 'Anders', 'Samuel', 100000);

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


INSERT INTO cie_passager VALUES(NULL, '945dd77c-7b33-4652-98ca-6e4ed2636414','Nurton','Alessandra','Alessandra_Nurton8760@gompie.com','7-711-674-5871',DEFAULT);
INSERT INTO cie_passager VALUES(NULL, '5b30e61e-6a96-4569-beb3-bf8487e54b94','Judd','Logan','Logan_Judd4877@elnee.tech','5-714-413-4425',DEFAULT);
INSERT INTO cie_passager VALUES(NULL, '24dec3a5-bf1d-48cb-bc38-d91a200ad0ff','Vollans','Lexi','Lexi_Vollans6883@vetan.org','0-400-542-5255',DEFAULT);
INSERT INTO cie_passager VALUES(NULL, 'f759f51b-8d1a-4c94-9848-577ef57880b8','Denton','Samantha','Samantha_Denton2366@eirey.tech','3-071-130-6466',DEFAULT);
INSERT INTO cie_passager VALUES(NULL, '5d69fa68-e04c-479a-b10d-b345edb9caf3','Cunningham','Janelle','Janelle_Cunningham7304@deavo.com','1-587-447-0542',DEFAULT);
INSERT INTO cie_passager VALUES(NULL, '902d48fc-56d9-4502-9e5c-db03f5b1ff7b','Rixon','Michael','Michael_Rixon1243@bauros.biz','8-307-344-6435',DEFAULT);
INSERT INTO cie_passager VALUES(NULL, '5b3866af-a15e-4769-a0c6-4d5e96955463','Calderwood','Mavis','Mavis_Calderwood4733@jiman.org','7-866-636-8165',DEFAULT);
INSERT INTO cie_passager VALUES(NULL, '5da51dc8-44cf-4b5b-b69b-288a2aa31a90','Fall','Carl','Carl_Fall2476@bungar.biz','5-847-882-5023',DEFAULT);
INSERT INTO cie_passager VALUES(NULL, 'b40d4b4b-26f4-4f76-8394-ca8bd7629988','Hilton','Aileen','Aileen_Hilton2474@naiker.biz','0-804-730-5505',DEFAULT);
INSERT INTO cie_passager VALUES(NULL, 'b148e556-3124-4dda-9495-aeb3d01ac134','Hooper','Isabella','Isabella_Hooper5472@ubusive.com','0-528-252-8606',41);
INSERT INTO cie_passager VALUES(NULL, 'a7186bd0-eeb0-4018-8ff9-e47f4c1936c7','Neville','Hank','Hank_Neville7582@dionrab.com','0-263-435-0765',60);
INSERT INTO cie_passager VALUES(NULL, '16dcf1e0-0062-4111-8930-621880c65470','Chadwick','Aileen','Aileen_Chadwick3894@liret.org','0-232-348-8333',64);
INSERT INTO cie_passager VALUES(NULL, 'a3e13691-5423-4108-8e64-b6e4b9ffbd15','Bradley','Henry','Henry_Bradley2169@corti.com','7-510-612-8718',30);
INSERT INTO cie_passager VALUES(NULL, '19ab4eb0-73cc-4e1e-8a17-c9616400278c','Dyson','Marjorie','Marjorie_Dyson6612@bulaffy.com','4-741-224-8835',30);
INSERT INTO cie_passager VALUES(NULL, '01a22d72-7de1-47ef-ac79-7ee686dce239','Mason','Carter','Carter_Mason9176@bretoux.com','7-837-666-3082',46);

INSERT INTO cie_classe (cla_nom, cla_prix_forfaitaire) VALUES ('Economic', 100);
INSERT INTO cie_classe (cla_nom, cla_prix_forfaitaire) VALUES ('Economic-flex', 150);
INSERT INTO cie_classe (cla_nom, cla_prix_forfaitaire) VALUES ('Business', 200);
INSERT INTO cie_classe (cla_nom, cla_prix_forfaitaire) VALUES ('First', 400);

INSERT INTO cie_reservation VALUES (NULL, '20.04.2022', 1, 1, 1);
INSERT INTO cie_reservation VALUES (NULL, '10.04.2022', 1, 1, 2);
INSERT INTO cie_reservation VALUES (NULL, '26.03.2022', 1, 2, 3);
INSERT INTO cie_reservation VALUES (NULL, '10.02.2022', 1, 3, 4);
INSERT INTO cie_reservation VALUES (NULL, '02.01.2022', 1, 4, 5);
INSERT INTO cie_reservation VALUES (NULL, '18.12.2021', 1, 4, 6);
INSERT INTO cie_reservation VALUES (NULL, '06.11.2021', 1, 2, 13);
INSERT INTO cie_reservation VALUES (NULL, '30.04.2022', 1, 2, 14);
INSERT INTO cie_reservation VALUES (NULL, '13.04.2022', 1, 1, 15);
INSERT INTO cie_reservation VALUES (NULL, '20.04.2022', 2, 1, 7);
INSERT INTO cie_reservation VALUES (NULL, '20.04.2022', 2, 1, 8);
INSERT INTO cie_reservation VALUES (NULL, '26.03.2022', 2, 2, 9);
INSERT INTO cie_reservation VALUES (NULL, '10.02.2022', 2, 2, 10);
INSERT INTO cie_reservation VALUES (NULL, '02.01.2022', 2, 2, 11);
INSERT INTO cie_reservation VALUES (NULL, '18.12.2021', 2, 3, 12);

INSERT INTO cie_baggage VALUES(NULL, 'Red Hot Poker Plant','Barbie Pink',21, 1);
INSERT INTO cie_baggage VALUES(NULL, 'Water Lily','Champagne',47, 2);
INSERT INTO cie_baggage VALUES(NULL, 'Bindweed','Magenta',53, 3);
INSERT INTO cie_baggage VALUES(NULL, 'Ironwood','Camel',8, 4);
INSERT INTO cie_baggage VALUES(NULL, 'Manzanita','Mauve',18, 5);
INSERT INTO cie_baggage VALUES(NULL, 'Pansy','Brown',4, 6);
INSERT INTO cie_baggage VALUES(NULL, 'Cabbage','Purple',26, 7);
INSERT INTO cie_baggage VALUES(NULL, 'Elephant Ear','Ruby',16, 8);
INSERT INTO cie_baggage VALUES(NULL, 'Snowdrop','Fuchsia',51, 9);
INSERT INTO cie_baggage VALUES(NULL, 'Apple','Capri',3, 10);
INSERT INTO cie_baggage VALUES(NULL, 'Bearberry','Cyan',32, 11);
INSERT INTO cie_baggage VALUES(NULL, 'Lily','Magenta',16 , 12);
INSERT INTO cie_baggage VALUES(NULL, 'Guaco','Beige',2, 13);
INSERT INTO cie_baggage VALUES(NULL, 'Apple','White',9 ,14);
INSERT INTO cie_baggage VALUES(NULL, 'Cucumber','Champagne',5 , 15);
COMMIT;
