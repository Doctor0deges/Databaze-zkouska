-- =========================================
-- 9 LOCK – Ukazka zamykani tabulek

USE videohernipostavy;

-- zamknuti tabulky pro cteni
LOCK TABLES postavy READ;

-- zamknuti tabulky pro zapis
LOCK TABLES postavy WRITE;

-- odemknuti tabulek
UNLOCK TABLES;

-- =========================================
-- Zamykani z pohledu dvou uzivatelu 
-- =========================================

-- Uzivatel A provede WRITE LOCK:
LOCK TABLES postavy WRITE;

-- Uzivatel B se pokusi o UPDATE, ktery se neprovede a ceka:
UPDATE postavy
SET Jmeno = 'Novacek'
WHERE Postava_ID = 1;

select * from Postavy;
-- prikaz ceka, dokud A neodemkne tabulku

-- Uzivatel A odemkne tabulku:
UNLOCK TABLES;
