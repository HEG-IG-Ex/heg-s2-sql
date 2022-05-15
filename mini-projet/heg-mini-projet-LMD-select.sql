-- Revenu par vol et nombre de passager
SELECT
    leg_vol_numero,
    COUNT(*) AS "Nombre de passagers",
    SUM(cla_prix_forfaitaire) AS "Revenus Forfaitaires"
FROM
    cie_reservation
    INNER JOIN cie_classe ON res_cla_id = cla_id
    INNER JOIN cie_leg ON res_leg_id = leg_id
GROUP BY
    leg_id,
    leg_vol_numero;

-- RFrais supp par passager pour excès de baggage
SELECT
    pass_nom || ' ' || pass_prenom,
    bag_poid AS "Poids du bagage",
    (bag_poid - 20) AS "Kilos en trop",
    TO_CHAR(
        (bag_poid - 20) * (
            SELECT
                par_value
            FROM
                cie_param
            WHERE
                par_id = 1
        ),
        'fmC99G999D00'
    ) AS "Frais supplémentaire"
FROM
    cie_baggage
    INNER JOIN cie_passager ON pass_id = bag_pass_id
WHERE
    bag_poid > 20 -- Nb Avion par consructeur
    -- Nb Avion par contructeur
SELECT
    con_nom,
    COUNT(*)
FROM
    cie_modele
    INNER JOIN cie_constructeur ON con_id = mod_con_id
GROUP BY
    con_id,
    con_nom
SELECT
    vol_numero,
    vol_horaire_prevu_dep,
    leg_horaire_effectif_dep - vol_horaire_prevu_dep AS retard_depart,
    leg_horaire_effectif_arr - vol_horaire_prevu_arr AS retard_arrive
FROM
    cie_leg
    INNER JOIN cie_vol ON vol_id = leg_vol_id -- Prime payé par vol
SELECT
    leg_id,
    vol_numero,
    SUM(rol_prime)
FROM
    cie_occupation
    INNER JOIN cie_role ON rol_id = occ_rol_id
    INNER JOIN cie_leg ON leg_id = occ_leg_id
    INNER JOIN cie_vol ON vol_id = leg_vol_id
GROUP BY
    leg_id,
    vol_numero --SAlaire moyen des employés
SELECT
    TO_CHAR(AVG(emp_salaire), 'fmC99G999D00') F ROM cie_employe -- poids des bagage par vol
SELECT
    vol_numero,
    SUM(bag_poid) AS "Poids Total"
FROM
    cie_reservation
    INNER JOIN cie_passager ON pass_id = res_pass_id
    INNER JOIN cie_baggage ON pass_id = bag_pass_id
    INNER JOIN cie_leg ON leg_id = res_leg_id
    INNER JOIN cie_vol ON vol_id = leg_vol_id
GROUP BY
    vol_id,
    leg_id,
    vol_numero