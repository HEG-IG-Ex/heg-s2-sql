/*========================
 1
 =========================*/
SELECT
    com_nom,
    NVL(
        TO_CHAR(com_prix, 'fmC99G999D00'),
        'Non indiqué'
    ) AS "Prix"
FROM
    heg_competition
ORDER BY
    com_date;

/*========================
 2
 =========================*/
SELECT
    TO_CHAR(ROUND(AVG(com_prix)), 'fmC99G999D00') AS "Prix Moyen des compétitions"
FROM
    heg_competition
WHERE
    com_prix IS NOT NULL

    /*========================
     3
     =========================*/
SELECT
    COUNT(*) AS "Nombre d'organisation"
FROM
    heg_competition
WHERE
    com_nom = 'Tour du Campus'
GROUP BY
    com_nom

    /*========================
     4
     =========================*/
SELECT
    *
FROM
    (
        SELECT
            TO_CHAR(MAX(com_prix), 'fmC99G999D00') AS "Prix le plus élevé"
        FROM
            heg_competition
        WHERE
            com_ville = 'Carouge'
    ) max_calcul
    CROSS JOIN (
        SELECT
            TO_CHAR(MIN(com_prix), 'fmC99G999D00') AS "Prix le plus bas"
        FROM
            heg_competition
        WHERE
            com_ville = 'Carouge'
    ) min_calcul

    /*========================
     5
     =========================*/
SELECT
    heg_competition. *,
    CONCAT(TO_CHAR(ROUND(com_date - SYSDATE), '9999'), 'j') AS "Jours avant le lancement"
FROM
    heg_competition
WHERE
    com_date >= SYSDATE
ORDER BY
    com_date

    /*========================
     6
     =========================*/
SELECT
    com_nom,
    COUNT(*) AS "Nombre d'occurences",
    TO_CHAR(MIN(com_prix), 'fmC99G999D00') AS "La moins chère",
    TO_CHAR(ROUND(AVG(com_prix)), 'fmC99G999D00') AS "Le prix moyen",
    TO_CHAR(MAX(com_prix), 'fmC99G999D00') AS "La plus chère"
FROM
    heg_competition
GROUP BY
    com_nom

    /*========================
     7
     =========================*/
SELECT
    com_lieu || ' (' || com_ville || ')' AS "Lieu",
    COUNT(*) AS "nb_compet"
FROM
    heg_competition
GROUP BY
    com_lieu,
    com_ville
ORDER BY
    "nb_compet" DESC

    /*========================
     8
     =========================*/
SELECT
    com_lieu,
    COUNT(par_per_no)
FROM
    heg_competition
    LEFT JOIN heg_participe ON com_no = par_com_no
GROUP BY
    com_lieu
ORDER BY
    com_lieu

    /*========================
     9
     =========================*/
SELECT
    com_lieu,
    CASE
        COUNT(par_per_no)
        WHEN 0 THEN 'Aucun participant'
        WHEN 1 THEN 'Un seul participant'
        ELSE TO_CHAR(COUNT(par_per_no)) || ' participants'
    END AS "Participants"
FROM
    heg_competition
    LEFT JOIN heg_participe ON com_no = par_com_no
GROUP BY
    com_lieu
ORDER BY
    com_lieu

    /*========================
     10
     =========================*/
SELECT
    EXTRACT(YEAR FROM com_date) AS yr,
    EXTRACT(MONTH FROM com_date) AS mon,
    COUNT(*) AS nb_compet
FROM
    heg_competition
GROUP BY
    EXTRACT(
        YEAR
        FROM
            com_date
    ),
    EXTRACT(
        MONTH
        FROM
            com_date
    )
ORDER BY
    yr,
    mon

    /*========================
     11
     =========================*/
SELECT
    com_lieu,
    COUNT(*) AS nb_compet
FROM
    heg_competition
GROUP BY
    com_lieu
HAVING
    COUNT(*) = 1

    /*========================
     12 
     =========================*/
SELECT
    com_lieu,
    TO_CHAR(AVG(com_prix), 'fmC99G999D00') AS avg_price
FROM
    heg_competition
GROUP BY
    com_lieu
HAVING
    AVG(com_prix) <= 40

    /*========================
     13
     =========================*/
SELECT
    com_lieu,
    COUNT(*)
FROM
    heg_competition
WHERE
    com_prix < 40
GROUP BY
    com_lieu
HAVING
    COUNT(*) >= 2

    /*========================
     14
     =========================*/
SELECT
    price_category,
    COUNT(*)
FROM
    (
        SELECT
            CASE
                WHEN com_prix < 20 THEN 'Bon marché (moins de 20.-)'
                WHEN com_prix < 40 THEN 'Prix standard (moins de 40.-)'
                WHEN com_prix >= 40 THEN 'Chère (40.- et plus)'
                ELSE 'Non défini'
            END AS price_category
        FROM
            heg_competition
    )
GROUP BY
    price_category