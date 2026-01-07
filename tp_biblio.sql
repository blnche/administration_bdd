-- =====================================
-- TP Base de données - Bibliothèque
-- Nom : Blanche Peltier
-- Date : 06-01-2026
-- =====================================

-- ===== DDL =====
-- 1
CREATE DATABASE bibliothequeuniv;
\c bibliothequeuniv
-- 2
CREATE TABLE Etudiant (
    id_etud SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    date_inscription DATE DEFAULT CURRENT_DATE,
    solde_amende NUMERIC(5,2) DEFAULT 0 CHECK (solde_amende>=0)
);

CREATE TABLE Livre (
    isbn CHAR(13) PRIMARY KEY,
    titre VARCHAR(200) NOT NULL,
    editeur VARCHAR(100),
    annee INT CHECK (1900 < annee AND annee < 2027),
    exemplaires_dispo INT DEFAULT 1 CHECK (exemplaires_dispo >= 0) --UPDATED TO ALLOW ZERO
);

CREATE TABLE Emprunt (
    id_emprunt SERIAL PRIMARY KEY,
    id_etud INT NOT NULL,
    isbn CHAR(13) NOT NULL,
    date_emprunt DATE NOT NULL,
    date_retour DATE,
    amende NUMERIC(5,2) DEFAULT 0,
    FOREIGN KEY (id_etud) REFERENCES Etudiant(id_etud) ON DELETE RESTRICT,
    FOREIGN KEY (isbn) REFERENCES Livre(isbn) ON DELETE RESTRICT
);

-- 3
CREATE INDEX idx_nom ON Etudiant(nom);
CREATE INDEX idx_date_emprunt ON Emprunt(date_emprunt);
\d+Etudiant
-- INSERT Invalide
-- INSERT INTO Etudiant (nom, age) VALUES ('Alice', 16);

-- ===== POPULATION DML =====

-- ETUDIANTS
INSERT INTO Etudiant (nom, prenom, email, solde_amende) VALUES
('Martin', 'Léa', 'lea.martin@univ.fr', 2.50),
('Durand', 'Paul', 'paul.durand@univ.fr', 0),
('Bernard', 'Alice', 'alice.bernard@univ.fr', 0),
('Petit', 'Lucas', 'lucas.petit@univ.fr', 1.00),
('Robert', 'Emma', 'emma.robert@univ.fr', 0),
('Richard', 'Noah', 'noah.richard@univ.fr', 0),
('Dubois', 'Chloé', 'chloe.dubois@univ.fr', 3.50),
('Moreau', 'Hugo', 'hugo.moreau@univ.fr', 0),
('Laurent', 'Inès', 'ines.laurent@univ.fr', 0),
('Simon', 'Adam', 'adam.simon@univ.fr', 0),
('Michel', 'Camille', 'camille.michel@univ.fr', 0),
('Garcia', 'Lina', 'lina.garcia@univ.fr', 0),
('Fournier', 'Tom', 'tom.fournier@univ.fr', 0),
('Roux', 'Sarah', 'sarah.roux@univ.fr', 0),
('Girard', 'Nathan', 'nathan.girard@univ.fr', 0),
('Andre', 'Julie', 'julie.andre@univ.fr', 0),
('Lefevre', 'Ethan', 'ethan.lefevre@univ.fr', 0),
('Mercier', 'Manon', 'manon.mercier@univ.fr', 0),
('Blanc', 'Louis', 'louis.blanc@univ.fr', 0),
('Guerin', 'Zoé', 'zoe.guerin@univ.fr', 0),
('Boyer', 'Maxime', 'maxime.boyer@univ.fr', 4.00),
('Chevalier', 'Anna', 'anna.chevalier@univ.fr', 0),
('Francois', 'Leo', 'leo.francois@univ.fr', 0),
('Legrand', 'Mila', 'mila.legrand@univ.fr', 0),
('Perrin', 'Jules', 'jules.perrin@univ.fr', 0);

-- LIVRES
-- Modification de la constraint de la table Livre pour accepter 0 en valeur pour exemplaires_dispo (cf screenshots)
INSERT INTO Livre (isbn, titre, editeur, annee, exemplaires_dispo) VALUES
('9780131103627', 'The C Programming Language', 'Prentice Hall', 1988, 1),
('9780201633610', 'Design Patterns', 'Addison-Wesley', 1994, 0),
('9780132350884', 'Clean Code', 'Prentice Hall', 2008, 2),
('9780134494166', 'Clean Architecture', 'Prentice Hall', 2017, 1),
('9780262033848', 'Introduction to Algorithms', 'MIT Press', 2009, 0),
('9780134685991', 'Effective Java', 'Addison-Wesley', 2018, 1),
('9781491950357', 'Learning Python', 'O’Reilly', 2013, 1),
('9781449331818', 'JavaScript: The Good Parts', 'O’Reilly', 2008, 1),
('9780131101630', 'Structure and Interpretation of Computer Programs', 'MIT Press', 1996, 0),
('9780596007126', 'Head First Design Patterns', 'O’Reilly', 2004, 1),
('9780131177055', 'Database System Concepts', 'McGraw-Hill', 2010, 1),
('9780136083252', 'Operating System Concepts', 'Wiley', 2011, 1),
('9780201485677', 'Refactoring', 'Addison-Wesley', 1999, 1),
('9780133594140', 'Computer Networks', 'Pearson', 2013, 1),
('9780137903955', 'Artificial Intelligence', 'Pearson', 2020, 1),
('9780135974445', 'Software Engineering', 'Pearson', 2014, 1),
('9781492037255', 'Fluent Python', 'O’Reilly', 2015, 1),
('9780596517748', 'Programming Python', 'O’Reilly', 2010, 1),
('9780134757599', 'Algorithms', 'Addison-Wesley', 2011, 1),
('9780131873254', 'Advanced Programming in Unix', 'Addison-Wesley', 2004, 1);

-- EMPRUNTS
INSERT INTO Emprunt (id_etud, isbn, date_emprunt, date_retour, amende) VALUES
(1,'9780131103627','2024-01-01','2024-01-10',0),
(2,'9780132350884','2024-01-02','2024-01-12',0),
(3,'9780134494166','2024-01-03','2024-01-14',0),
(4,'9781491950357','2024-01-04','2024-01-15',0),
(5,'9781449331818','2024-01-05','2024-01-16',0),
(6,'9780596007126','2024-01-06','2024-01-17',0),
(7,'9780131177055','2024-01-07','2024-01-18',0),
(8,'9780136083252','2024-01-08','2024-01-19',0),
(9,'9780201485677','2024-01-09','2024-01-20',0),
(10,'9780133594140','2024-01-10','2024-01-21',0),
(11,'9780137903955','2024-01-11','2024-01-22',0),
(12,'9780135974445','2024-01-12','2024-01-23',0),
(13,'9781492037255','2024-01-13','2024-01-24',0),
(14,'9780596517748','2024-01-14','2024-01-25',0),
(15,'9780134757599','2024-01-15','2024-01-26',0),
(16,'9780131873254','2024-01-16','2024-01-27',0),
(17,'9780131103627','2024-01-17','2024-01-28',0),
(18,'9780132350884','2024-01-18','2024-01-29',0),
(19,'9780134494166','2024-01-19','2024-01-30',0),
(20,'9781491950357','2024-01-20','2024-01-31',0),
(21,'9781449331818','2024-01-21','2024-02-01',0),
(22,'9780596007126','2024-01-22','2024-02-02',0),
(23,'9780131177055','2024-01-23','2024-02-03',0),
(24,'9780136083252','2024-01-24','2024-02-04',0),
(25,'9780201485677','2024-01-25','2024-02-05',0),
(1,'9780133594140','2024-01-26','2024-02-06',0),
(2,'9780137903955','2024-01-27','2024-02-07',0),
(3,'9780135974445','2024-01-28','2024-02-08',0),
(4,'9781492037255','2024-01-29','2024-02-09',0),
(5,'9780596517748','2024-01-30','2024-02-10',0);
INSERT INTO Emprunt (id_etud, isbn, date_emprunt) VALUES
(6,'9780134757599','2024-02-01'),
(7,'9780131873254','2024-02-02'),
(8,'9780131103627','2024-02-03'),
(9,'9780132350884','2024-02-04'),
(10,'9780134494166','2024-02-05');
INSERT INTO Emprunt (id_etud, isbn, date_emprunt, date_retour, amende) VALUES
(1,'9781491950357','2024-01-01','2024-01-20',3.00),
(4,'9781449331818','2024-01-02','2024-01-25',5.50),
(7,'9780596007126','2024-01-03','2024-01-22',4.00),
(21,'9780131177055','2024-01-04','2024-01-24',5.00),
(22,'9780136083252','2024-01-05','2024-01-26',5.50);

SELECT COUNT(*) FROM Emprunt;

-- ===== REQUETES AVANCEES =====

-- 1 Jointure 3 tables : Étudiants + livres empruntés + éditeur (INNER JOIN).
SELECT Etudiant.nom,
Emprunt.id_etud,
Livre.titre,
Livre.editeur
FROM Etudiant
INNER JOIN Emprunt
ON Etudiant.id_etud = Emprunt.id_etud
INNER JOIN Livre
ON Emprunt.isbn = Livre.isbn;

-- 2 Livres jamais empruntés (RIGHT JOIN ou NOT EXISTS).
SELECT * FROM Emprunt
RIGHT JOIN Livre
ON Emprunt.isbn = Livre.isbn
WHERE Emprunt.id_emprunt IS NULL;

-- 3 Top 5 étudiants par nb emprunts (GROUP BY , COUNT, ORDER BY , LIMIT).
SELECT Etudiant.nom,
COUNT (Emprunt.id_emprunt) AS nb_emprunts
FROM Etudiant
LEFT JOIN Emprunt
ON Etudiant.id_etud = Emprunt.id_etud
GROUP BY Etudiant.nom
ORDER BY nb_emprunts DESC
LIMIT 5;

-- 4 Emprunts retard (sous-requête : date_retour > (SELECT date_emprunt +14)).
SELECT * FROM Emprunt e1
WHERE e1.date_retour > (
    SELECT e2.date_emprunt + INTERVAL '14 days'
    FROM Emprunt e2
    WHERE e2.id_emprunt = e1.id_emprunt
);

-- 5 Moyenne amende par éditeur (GROUP BY editeur, AVG, HAVING>1).
SELECT Livre.editeur,
    AVG(Emprunt.amende) AS moyenne_amende
FROM Emprunt
LEFT JOIN Livre
ON Emprunt.isbn = Livre.isbn
GROUP BY Livre.editeur
HAVING AVG(Emprunt.amende) > 1;

--6 Étudiants en retard avec livre + amende totale (JOIN + sous-requête SUM).
SELECT e.nom,
    e.prenom,
    e.email,
    total.total_amende
FROM Etudiant e
INNER JOIN (
    SELECT id_etud,
        SUM(amende) AS total_amende
    FROM Emprunt e1
    WHERE date_retour > (
        SELECT date_emprunt + INTERVAL '14 days'
        FROM Emprunt e2
        WHERE e2.id_emprunt = e1.id_emprunt
    )
    GROUP BY id_etud
) AS total
ON e.id_etud = total.id_etud;

-- 7 Mise à jour : Incrémentez exemplaires_dispo pour livres rendus (UPDATE JOIN).
UPDATE Livre l
SET exemplaires_dispo = exemplaires_dispo + 1
FROM Emprunt e
WHERE l.isbn = e.isbn
  AND e.date_retour IS NOT NULL;


-- 8 Suppression : Supprimez emprunts >1 an (DELETE avec sous-requête).
-- Ici j'ai modifié 1 an par 1 mois car sinon tous mes rows auraient été delete
DELETE FROM Emprunt
WHERE date_emprunt < CURRENT_DATE - INTERVAL '1 month';

-- 9 Fenêtrage : Rang emprunts par étudiant (ROW_NUMBER() OVER (PARTITION BY id_etud)).
SELECT 
    id_etud,
    isbn,
    date_emprunt,
    date_retour,
    amende,
    ROW_NUMBER() OVER (PARTITION BY id_etud ORDER BY date_emprunt) AS rang_emprunt
FROM Emprunt
ORDER BY id_etud, rang_emprunt;

-- 10 Agrégat conditionnel : Nb retard / total par mois (EXTRACT YEAR/MONTH).
SELECT
    EXTRACT(YEAR FROM date_emprunt) AS annee,
    EXTRACT(MONTH FROM date_emprunt) AS mois,
    COUNT(*) AS total_emprunts,
    COUNT(*) FILTER (WHERE date_retour > date_emprunt + INTERVAL '14 days') AS retard,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE date_retour > date_emprunt + INTERVAL '14 days') / COUNT(*),
        2
    ) AS pourcentage_retard
FROM Emprunt
GROUP BY annee, mois
ORDER BY annee, mois;

-- ===== ADMNISTRATION DCL ET VUES =====

-- 1
CREATE ROLE bibliothecaire LOGIN PASSWORD 'bibpass';
CREATE ROLE etudiant_ro LOGIN PASSWORD 'etupass';
GRANT CONNECT ON DATABASE bibliothequeuniv TO bibliothecaire, etudiant_ro;

-- 2 
-- Bibliothécaire
GRANT ALL PRIVILEGES ON Etudiant, Livre, Emprunt TO bibliothecaire;

GRANT USAGE ON SEQUENCE Etudiant_id_etud_seq TO bibliothecaire;
GRANT USAGE ON SEQUENCE Emprunt_id_emprunt_seq TO bibliothecaire;

-- Étudiant
GRANT SELECT ON Etudiant, Livre, Emprunt TO etudiant_ro;
GRANT INSERT ON Emprunt TO etudiant_ro;

REVOKE UPDATE, DELETE ON Etudiant, Livre, Emprunt FROM etudiant_ro;

-- Ici consigne flou : on grant select et insert on emprunt a l'etudiant mais on revoke tous les privilieges puis on regrant select ? Le test pour insert ne sera pas OK.


-- 3
CREATE VIEW v_emprunts_retard AS
SELECT
    e.id_etud,
    e.nom,
    e.prenom,
    l.titre,
    emp.date_emprunt,
    emp.date_retour,
    emp.amende
FROM Emprunt emp
JOIN Etudiant e ON emp.id_etud = e.id_etud
JOIN Livre l ON emp.isbn = l.isbn
WHERE emp.date_retour > emp.date_emprunt + INTERVAL '14 days';


CREATE VIEW v_stats_livres AS
SELECT
    l.isbn,
    l.titre,
    COUNT(e.id_emprunt) AS nb_emprunts,
    ROUND(
        100.0 * l.exemplaires_dispo /
        (l.exemplaires_dispo + COUNT(e.id_emprunt)),
        2
    ) AS pourcentage_dispo
FROM Livre l
LEFT JOIN Emprunt e ON l.isbn = e.isbn
GROUP BY l.isbn, l.titre, l.exemplaires_dispo;

GRANT SELECT ON v_emprunts_retard, v_stats_livres TO PUBLIC;

-- ===== ANALYSE ET RAPPORT =====

-- 1
CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE INDEX idx_etudiant_nom_trgm
ON Etudiant
USING gin (nom gin_trgm_ops);

-- L'index n'est pas utilise car table trop petite.

-- 2