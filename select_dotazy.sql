-- =========================================
-- SELECT DOTAZY 
-- SELECT 1 -- Průměrný počet záznamů na jednu tabulku v databázi}
    --Tento dotaz spočítá počet řádků v každé tabulce a z těchto hodnot vypočítá průměrný počet záznamů na jednu tabulku.
SELECT
    AVG(pocet_radku) AS prumerny_pocet_zaznamu_na_tabulku
FROM (
    SELECT COUNT(*) AS pocet_radku FROM postavy
    UNION ALL
    SELECT COUNT(*) FROM tridy
    UNION ALL
    SELECT COUNT(*) FROM atributy
    UNION ALL
    SELECT COUNT(*) FROM dovednosti
    UNION ALL
    SELECT COUNT(*) FROM vybaveni
    UNION ALL
    SELECT COUNT(*) FROM atributypostavy
    UNION ALL
    SELECT COUNT(*) FROM dovednostipostavy
    UNION ALL
    SELECT COUNT(*) FROM vybavenipostavy
) t;
------------------------------------------------
-- SELECT 2 -- Vnořený SELECT 
    -- Tento dotaz nejprve spočítá, kolik postav má každá třída, z těchto hodnot vypočítá průměrný počet postav na třídu a následně vrátí pouze ty postavy, které patří do tříd s nadprůměrným počtem postav.
SELECT
    p.Postava_ID,
    p.Jmeno,
    t.Nazev AS Trida
FROM postavy p
JOIN tridy t ON p.Trida_ID = t.Trida_ID
WHERE p.Trida_ID IN (
    SELECT Trida_ID
    FROM postavy
    GROUP BY Trida_ID
    HAVING COUNT(*) > (
        SELECT AVG(pocet_postav)
        FROM (
            SELECT COUNT(*) AS pocet_postav
            FROM postavy
            GROUP BY Trida_ID
        ) x
    )
);

-- SELECT 3 -- Analytická funkce (OVER) + GROUP BY}
-- Tento dotaz pracuje s dovednostmi postav a využívá analytické funkce COUNT() OVER() a AVG() OVER(). 
-- Výstup zobrazuje:
    -- počet postav, které mají danou dovednost (GROUP BY),
    -- celkový počet všech přiřazení dovedností (analytická funkce),
    -- průměrný počet přiřazení na jednu dovednost (analytická funkce).
SELECT
    d.Dovednost_ID,
    d.Nazev AS dovednost,
    COUNT(dp.Postava_ID) AS pocet_postav_s_dovednosti,
    COUNT(dp.Postava_ID) OVER () AS celkovy_pocet_vyskytu,
    AVG(COUNT(dp.Postava_ID)) OVER () AS prumerny_pocet_na_dovednost
FROM dovednosti d
LEFT JOIN dovednostipostavy dp
    ON dp.Dovednost_ID = d.Dovednost_ID
GROUP BY d.Dovednost_ID, d.Nazev
ORDER BY pocet_postav_s_dovednosti DESC;

-- SELECT 4 – Rekurze (recursive CTE)
-- Tento dotaz předpokládá existenci hierarchie mezi postavami (pole Nadrizena_postava_ID) a snaží se sestavit strom vztahů:
    --  úroveň 0 – hlavní postavy (nemají nadřízeného),
    --  úroveň 1 – jejich podřízení,
    --  úroveň 2 – podřízení podřízených,
    --  atd.
WITH RECURSIVE hierarchie AS (
    SELECT
        p.Postava_ID,
        p.Jmeno,
        p.Nadrizena_postava_ID,
        0 AS uroven
    FROM postavy p
    WHERE p.Nadrizena_postava_ID IS NULL
    UNION ALL
    SELECT
        p2.Postava_ID,
        p2.Jmeno,
        p2.Nadrizena_postava_ID,
        h.uroven + 1 AS uroven
    FROM postavy p2
    JOIN hierarchie h ON p2.Nadrizena_postava_ID = h.Postava_ID
)
SELECT
    Postava_ID,
    Jmeno,
    Nadrizena_postava_ID,
    uroven
FROM hierarchie
ORDER BY uroven, Postava_ID;
