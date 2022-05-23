/*****************
 1
 ******************/
SELECT
    *
FROM
    heg_personne
WHERE
    per_clu_no = (
        SELECT
            per_clu_no
        FROM
            heg_personne
        WHERE
            per_nom = 'Dorsa'
    )
    /*****************
     2
     ******************/
SELECT
    *
FROM
    heg_competition
WHERE
    LOWER(com_ville) = (
        SELECT
            LOWER(com_ville)
        FROM
            heg_competition
        WHERE
            LOWER(com_nom) = 'triathlon heg'
    )
    AND com_date > (
        SELECT
            LOWER(com_date)
        FROM
            heg_competition
        WHERE
            LOWER(com_nom) = 'triathlon heg'
    )
    /*****************
     3
     ******************/
SELECT
    *
FROM
    heg_competition
WHERE
    com_prix > (
        SELECT
            AVG(com_prix)
        FROM
            heg_competition
    )
    /*****************
     4, 5
     ******************/
SELECT
    DISTINCT per_email || ' est le mail de ' || CASE
        per_sexe
        WHEN 'M' THEN 'Monsieur '
        ELSE 'Madame '
    END || per_nom || ' ' || per_prenom
FROM
    heg_personne
WHERE
    per_email IS NOT NULL
UNION
SELECT
    DISTINCT clu_email || ' est le mail du club ' || clu_nom
FROM
    heg_club
WHERE
    clu_email IS NOT NULL
    /*****************
     6
     ******************/
SELECT
    heg_personne. *,
    CASE
        WHEN per_clu_no IS NULL THEN 'Sans club'
        ELSE clu_nom
    END
FROM
    heg_personne
    LEFT JOIN heg_club ON clu_no = per_clu_no
WHERE
    LOWER(per_prenom) IN ('alain', 'géo')
    AND (
        per_clu_no != (
            SELECT
                clu_no
            FROM
                heg_club
            WHERE
                clu_nom = 'Football Club 62-21'
        )
        OR per_clu_no IS NULL
    )
    /*****************
     7
     ******************/
SELECT
    clu_no,
    clu_nom,
    COUNT(*)
FROM
    heg_personne
    LEFT JOIN heg_club ON per_clu_no = clu_no
GROUP BY
    clu_no,
    clu_nom
HAVING
    COUNT(*) > (
        SELECT
            COUNT(*)
        FROM
            heg_personne
        WHERE
            per_clu_no = (
                SELECT
                    clu_no
                FROM
                    heg_club
                WHERE
                    clu_nom = 'Traînes-Savates BDD'
            )
    )
    /*****************
     8
     ******************/
SELECT
    AVG(COUNT(*))
FROM
    heg_participe
GROUP BY
    par_com_no;

/*****************
 9
 ******************/
SELECT
    com_nom,
    com_date,
    com_ville,
    COUNT(par_per_no)
FROM
    heg_competition
    LEFT JOIN heg_participe ON par_com_no = com_no
GROUP BY
    com_nom,
    com_date,
    com_ville
HAVING
    COUNT(par_per_no) > (
        SELECT
            AVG(COUNT(*))
        FROM
            heg_participe
        GROUP BY
            par_com_no
    );

/*****************
 10
 ******************/
INSERT INTO
    heg_club
VALUES
    (
        (
            SELECT
                MAX(clu_no) + 1
            FROM
                heg_club
        ),
        'HEG-SkiClub',
        'skiclub@heg.ch',
        'Genève',
        NULL
    );

/*****************
 11
 ******************/
INSERT INTO
    heg_competition
VALUES
    (
        (
            SELECT
                MAX(com_no) + 1
            FROM
                heg_competition
        ),
        'Triathlon HEG',
        ADD_MONTHS(
            (
                SELECT
                    com_date
                FROM
                    heg_competition
                WHERE
                    LOWER(com_nom) = 'triathlon heg'
            ),
            -2
        ),
        (
            SELECT
                com_lieu
            FROM
                heg_competition
            WHERE
                LOWER(com_nom) = 'triathlon heg'
        ),
        (
            SELECT
                com_ville
            FROM
                heg_competition
            WHERE
                LOWER(com_nom) = 'triathlon heg'
        ),
        (
            SELECT
                MIN(com_prix)
            FROM
                heg_competition
            WHERE
                LOWER(com_ville) = (
                    SELECT
                        lower(com_ville)
                    FROM
                        heg_competition
                    WHERE
                        LOWER(com_nom) = 'triathlon heg'
                )
        ),
        (
            SELECT
                com_clu_no
            FROM
                heg_competition
            WHERE
                LOWER(com_nom) = 'triathlon heg'
        )
    );