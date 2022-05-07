/*========================
    1
=========================*/
SELECT
    per. *,
    clu_nom
FROM
    heg_personne PER
    LEFT JOIN heg_club ON per_clu_no = clu_no;


/*========================
    2
=========================*/
SELECT
    per_nom,
    per_prenom
FROM
    heg_personne;


/******************************************************************************
    CONDITIONS
*******************************************************************************/

/*========================
    3
=========================*/
SELECT
    per_nom,
    per_prenom
FROM
    heg_personne
WHERE
    per_prenom = 'Alain';

/*========================
    4
=========================*/
SELECT
    per_nom,
    per_prenom
FROM
    heg_personne
WHERE
    per_sexe = 'F'
    AND per_clu_no = 3;

/*========================
    5
=========================*/
SELECT
    per_nom,
    per_prenom
FROM
    heg_personne
WHERE
    per_no IN (2, 3, 4, 6, 9);

/*========================
    6
=========================*/
SELECT
    per_nom,
    per_prenom
FROM
    heg_personne
WHERE
    per_prenom LIKE 'A%';

/*========================
    7
=========================*/+
SELECT
    per_nom,
    per_prenom
FROM
    heg_personne
WHERE
    per_sexe = 'M'
    AND per_clu_no IS NULL
ORDER BY
    per_nom,
    per_prenom ASC;

/*========================
    8
=========================*/
SELECT
    per_nom,
    per_ville
FROM
    heg_personne
WHERE
    INITCAP(per_ville) != 'Genève';

/*========================
    9
=========================*/
SELECT
    *
FROM
    heg_personne
WHERE
    per_email LIKE '%@heg.ch';

/*========================
    10
=========================*/
SELECT
    com_nom,
    com_lieu,
    com_date
FROM
    heg_competition
WHERE
    com_date >= '01.06.2022'
    AND com_date <= '30.06.2022'
ORDER BY
    com_date ASC;




/******************************************************************************
    CONCATENATION
*******************************************************************************/


/*========================
    11
=========================*/
SELECT
    (per_prenom || ' ' || per_nom) AS "Nom Complet"
FROM
    heg_personne;

/*========================
    12
=========================*/
SELECT
    (
        'Le ' || com_Date || ' a lieu à ' || com_lieu || ' la compétition : ' || com_nom
    )
FROM
    heg_competition
ORDER BY
    com_date;



/******************************************************************************
    JOINTURE
*******************************************************************************/

/*========================
    13
=========================*/
SELECT
    per_prenom,
    per_nom
FROM
    heg_personne
WHERE
    per_clu_no IS NULL;

/*========================
    14
=========================*/
SELECT
    per_prenom,
    per_nom,
    clu_nom
FROM
    heg_personne
    INNER JOIN heg_club ON per_clu_no = clu_no;

/*========================
    15
=========================*/
SELECT
    per_prenom,
    per_nom,
    clu_nom
FROM
    heg_personne
    INNER JOIN heg_club ON per_clu_no = clu_no
WHERE
    INITCAP(clu_ville) = 'Genève';

/*========================
    16
=========================*/
SELECT
    per_prenom,
    per_nom,
    clu_nom
FROM
    heg_personne
    LEFT JOIN heg_club ON per_clu_no = clu_no;

/*========================
    17
=========================*/
SELECT
    *
FROM
    heg_club
    LEFT JOIN heg_personne ON per_clu_no = clu_no
ORDER BY
    clu_no;

/*========================
    18
=========================*/
SELECT
    heg_club. *,
    (per_prenom || ' ' || per_nom) AS "president"
FROM
    heg_club
    LEFT JOIN heg_personne ON clu_per_no = per_no;

/*========================
    19
=========================*/
SELECT
    heg_competition. *,
    clu_nom AS "Club Organisateur"
FROM
    heg_competition
    LEFT JOIN heg_club ON com_clu_no = clu_no;

/*========================
    20
=========================*/
SELECT
    per_prenom,
    per_nom,
    com_nom,
    com_date
FROM
    heg_participe
    INNER JOIN heg_personne ON par_per_no = per_no
    INNER JOIN heg_competition ON par_com_no = com_no;

/*========================
    21
=========================*/
SELECT
    per_prenom,
    per_nom
FROM
    heg_participe
    INNER JOIN heg_personne ON par_per_no = per_no
GROUP BY
    per_prenom,
    per_nom;

/*========================
    22
=========================*/
SELECT
    per_prenom,
    per_nom
FROM
    heg_participe
    INNER JOIN heg_personne ON par_per_no = per_no
    INNER JOIN (
        SELECT
            com_no
        FROM
            heg_competition
        WHERE
            EXTRACT(
                YEAR
                FROM
                    com_date
            ) = 2022
    ) ON par_com_no = com_no
GROUP BY
    per_prenom,
    per_nom;

/*========================
    23
=========================*/
SELECT
    per_prenom,
    per_nom
FROM
    heg_personne
    LEFT JOIN heg_participe ON per_no = par_per_no
WHERE
    par_com_no IS NULL

/*========================
    24
=========================*/
SELECT
    membre.per_nom,
    membre.per_prenom,
    full_club.clu_nom,
    full_club. "President"
FROM
    heg_personne membre
    LEFT JOIN (
        SELECT
            clu_no,
            clu_nom,
            president.per_prenom || ' ' || president.per_nom AS "President"
        FROM
            heg_club
            LEFT JOIN heg_personne president ON clu_per_no = president.per_no
    ) full_club ON per_clu_no = full_club.clu_no