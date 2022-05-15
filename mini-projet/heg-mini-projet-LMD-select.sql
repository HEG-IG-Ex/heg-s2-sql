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