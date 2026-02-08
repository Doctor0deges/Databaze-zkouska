-- VIEW – Podstatné informace z více tabulek
Tento VIEW sdružuje důležité informace o postavách z několika tabulek (postavy, tridy,
dovednosti, vybaveni). Výsledkem je přehled, který obsahuje pouze smysluplná data:
jméno postavy, její třídu, dovednosti a vybavení. Ve výstupu se nenachází žádné cizí klíče
ani technické identifikátory.
Při konstrukci VIEW jsou použity různé typy spojení:
• INNER JOIN pro povinný vztah postava – třída,
• LEFT JOIN pro volitelné dovednosti a vybavení.
CREATE or replace VIEW v_postavy_prehled AS
SELECT
p.Jmeno AS Postava,
t.Nazev AS Trida,
GROUP_CONCAT(DISTINCT d.Nazev ORDER BY d.Nazev SEPARATOR ’, ’) AS Dovednosti
,
GROUP_CONCAT(DISTINCT v.Nazev ORDER BY v.Nazev SEPARATOR ’, ’) AS Vybaveni
FROM postavy p
INNER JOIN tridy t
ON p.Trida_ID = t.Trida_ID
LEFT JOIN dovednostipostavy dp
ON dp.Postava_ID = p.Postava_ID
LEFT JOIN dovednosti d
ON d.Dovednost_ID = dp.Dovednost_ID
LEFT JOIN vybavenipostavy vp
ON vp.Postava_ID = p.Postava_ID
LEFT JOIN vybaveni v
ON v.Vybaveni_ID = vp.Vybaveni_ID
GROUP BY
4
p.Jmeno,
t.Nazev;
