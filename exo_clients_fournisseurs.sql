drop database if exists ClientsFournisseurs;
create database ClientsFournisseurs;
use ClientsFournisseurs;


create table fournisseurs(
    nomF VARCHAR(45) primary key,
    adresseF varchar(150)
);

create table prix(
    nomF varchar(45),
    nomP varchar(45),
    couts int(5),
    index ind_prix_nomp (nomP),
    constraint pk_prix primary key (nomF,nomP),
    constraint fk_prix_fourn foreign key (nomF) REFERENCES fournisseurs(nomF)
);

create table clients(
    nomC varchar(45) primary key,
    adresseC varchar(150),
    solde int
);

create table commandes(
    numCom int primary key auto_increment,
    nomC varchar(45),
    nomP varchar(45),
    quantite smallint,
    constraint fk_com_nomc foreign key (nomc) references clients(nomc),
    constraint fk_com_nomP foreign key (nomP) references prix(nomp)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/db_clients_fournisseurs/fournisseurs.csv' 
INTO TABLE fournisseurs
FIELDS TERMINATED BY ';' 
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(nomF, adresseF);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/db_clients_fournisseurs/clients.csv' 
INTO TABLE clients
FIELDS TERMINATED BY ';' 
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/db_clients_fournisseurs/prix.csv' 
INTO TABLE prix
FIELDS TERMINATED BY ';' 
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/db_clients_fournisseurs/commandes.csv' 
INTO TABLE commandes
FIELDS TERMINATED BY ';' 
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(nomC, nomP, quantite);

-- Questions

-- Question a
SELECT c.nomP, c.nomC
FROM commandes AS c
WHERE c.nomC = 'Jean';

-- Question b
SELECT p.nomF, p.nomP
FROM prix AS p 
INNER JOIN commandes AS c ON c.nomP = p.nomP
WHERE c.nomC = 'paul';

-- Question c
SELECT f.nomF, f.adresseF 
FROM fournisseurs AS f 
INNER JOIN prix AS p ON f.nomF = p.nomF
WHERE p.nomP = 'parpaing' AND p.couts < 1200;

-- Question d
SELECT DISTINCT cl.nomC, cl.adresseC, f.nomF, f.adresseF
FROM fournisseurs AS f
INNER JOIN prix AS p ON f.nomF = p.nomF
INNER JOIN commandes AS c ON p.nomP = c.nomP
INNER JOIN clients AS cl ON c.NomC = cl.NomC
WHERE c.NomP = 'Briques';

-- Question e
SELECT p.nomF, p.nomP
FROM prix AS p 
INNER JOIN commandes AS c ON c.nomP = p.nomP
WHERE c.nomC = 'jean';