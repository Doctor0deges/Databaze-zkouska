-- INDEXY – Unikátní a fulltextový index
/* 
této části jsou definovány dva indexy nad tabulkami databáze:

  -- Unikátní index nad sloupcem Jmeno v tabulce postavy. Zajišťuje, že každá postava má jedinečné jméno.

  -- Fulltextový index nad sloupcem Popisek v tabulce dovednosti. 
      Tento index umožňuje efektivní fulltextové vyhledávání v popisech dovedností.
 */
-- Unikatni index nad jmenem postavy
CREATE UNIQUE INDEX idx_postavy_jmeno_unique
ON postavy (Jmeno);

-- pouzití
insert into Postavy (Jmena) values ("lucio");

-- Fulltextovy index nad popisem dovednosti
CREATE FULLTEXT INDEX if not exists idx_dovednosti_popisek_fulltext
ON dovednosti (Popisek);

-- pouzití
SELECT * FROM dovednosti
WHERE Popisek LIKE ’%kouzel%’;
