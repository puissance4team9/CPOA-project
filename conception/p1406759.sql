-- phpMyAdmin SQL Dump
-- version 4.0.10.15
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Mer 25 Mai 2016 à 15:48
-- Version du serveur: 5.1.73
-- Version de PHP: 5.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `p1406759`
--

-- --------------------------------------------------------

--
-- Structure de la table `CASTING`
--

CREATE TABLE IF NOT EXISTS `CASTING` (
  `numVip` int(7) NOT NULL,
  `numVisa` int(7) NOT NULL,
  PRIMARY KEY (`numVip`,`numVisa`),
  KEY `fk_numvisa2` (`numVisa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `CASTING`
--

INSERT INTO `CASTING` (`numVip`, `numVisa`) VALUES
(2, 1081380),
(7, 1125520),
(12, 1125520),
(14, 1125520),
(5, 1138980),
(6, 1138980),
(11, 1138980),
(3, 1196320),
(16, 1248710),
(10, 1267180),
(8, 1319610),
(9, 1434270),
(13, 1434270),
(9, 1896230),
(15, 1896230);

-- --------------------------------------------------------

--
-- Structure de la table `EVENEMENT`
--

CREATE TABLE IF NOT EXISTS `EVENEMENT` (
  `numVip` int(7) NOT NULL,
  `dateMariage` date NOT NULL,
  `numVipConjoint` int(7) NOT NULL,
  `lieuMariage` varchar(30) NOT NULL,
  `dateDivorce` date DEFAULT NULL,
  PRIMARY KEY (`numVip`,`dateMariage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déclencheurs `EVENEMENT`
--
DROP TRIGGER IF EXISTS `DIVORCE`;
DELIMITER //
CREATE TRIGGER `DIVORCE` BEFORE INSERT ON `EVENEMENT`
 FOR EACH ROW BEGIN
	
	update VIP set codeStatut='D' WHERE numVip=NEW.numVip and numVip=NEW.numVipConjoint;

END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `FILM`
--

CREATE TABLE IF NOT EXISTS `FILM` (
  `numVisa` int(7) NOT NULL,
  `titre` varchar(100) NOT NULL,
  `LibelleGenre` varchar(50) NOT NULL,
  `annee` int(11) NOT NULL,
  PRIMARY KEY (`numVisa`),
  KEY `LibelleGenre` (`LibelleGenre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `FILM`
--

INSERT INTO `FILM` (`numVisa`, `titre`, `LibelleGenre`, `annee`) VALUES
(1044220, ' Alice au pays des merveilles', 'Fantastique', 2010),
(1081380, 'SWEENEY TODD, LE DIABOLIQUE BARBIER DE FLEET STREET', 'Fantastique', 2008),
(1125520, 'Nos jours heureux', 'Comédie', 2006),
(1132830, 'All the Boys Love Mandy Lane', 'Horreur', 2008),
(1138980, 'Mission : Impossible III', 'Action', 2006),
(1140280, 'Harry Potter et l''école des sorciers', 'Fantastique', 2001),
(1196320, 'V pour Vendetta', 'Thriller', 2005),
(1248710, 'Captain America : First Avenger', 'Science Fiction', 2011),
(1267180, 'Hunger Games', 'Fantastique', 2012),
(1319610, 'HARRY POTTER ET LA COUPE DE FEU', 'Fantastique', 2005),
(1434270, 'Slumdog Millionaire', 'Action', 2008),
(1896230, 'L''Orphelinat', 'Horreur', 2008);

--
-- Déclencheurs `FILM`
--
DROP TRIGGER IF EXISTS `EXIST_FILM`;
DELIMITER //
CREATE TRIGGER `EXIST_FILM` BEFORE INSERT ON `FILM`
 FOR EACH ROW BEGIN 

	declare cpt integer;
	declare msg varchar(255);
    DECLARE EXIST_FILM CONDITION FOR SQLSTATE '45001';

	select count(*) into cpt from FILM
	where numVisa = NEW.numVisa and titre=NEW.titre and LibelleGenre=NEW.LibelleGenre and annee=NEW.annee;


    if cpt <> 0 then 
		CALL EXIST_FILM;
    END IF; 
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `GENRE`
--

CREATE TABLE IF NOT EXISTS `GENRE` (
  `LibelleGenre` varchar(50) NOT NULL,
  PRIMARY KEY (`LibelleGenre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `GENRE`
--

INSERT INTO `GENRE` (`LibelleGenre`) VALUES
('Action'),
('Comédie'),
('Fantastique'),
('Horreur'),
('Science Fiction'),
('Thriller');

-- --------------------------------------------------------

--
-- Structure de la table `PAYS`
--

CREATE TABLE IF NOT EXISTS `PAYS` (
  `nomPays` varchar(30) NOT NULL,
  PRIMARY KEY (`nomPays`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `PAYS`
--

INSERT INTO `PAYS` (`nomPays`) VALUES
('D'),
('FR'),
('UK'),
('US');

-- --------------------------------------------------------

--
-- Structure de la table `PHOTO`
--

CREATE TABLE IF NOT EXISTS `PHOTO` (
  `numVip` int(7) NOT NULL,
  `photoId` int(7) NOT NULL,
  `date` date NOT NULL,
  `lieu` varchar(30) NOT NULL,
  PRIMARY KEY (`numVip`,`photoId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `REALISATEUR`
--

CREATE TABLE IF NOT EXISTS `REALISATEUR` (
  `numVip` int(7) NOT NULL,
  `numVisa` int(7) NOT NULL,
  PRIMARY KEY (`numVip`,`numVisa`),
  KEY `fk_numvisa` (`numVisa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `REALISATEUR`
--

INSERT INTO `REALISATEUR` (`numVip`, `numVisa`) VALUES
(17, 1044220),
(4, 1081380),
(26, 1132830),
(25, 1140280),
(19, 1196320),
(19, 1248710),
(23, 1267180),
(23, 1319610),
(28, 1434270);

-- --------------------------------------------------------

--
-- Structure de la table `UTILISATEUR`
--

CREATE TABLE IF NOT EXISTS `UTILISATEUR` (
  `Login` varchar(30) NOT NULL,
  `Password` int(30) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `VIP`
--

CREATE TABLE IF NOT EXISTS `VIP` (
  `numVip` int(7) NOT NULL AUTO_INCREMENT,
  `nomVip` varchar(30) NOT NULL,
  `prenomVip` varchar(30) NOT NULL,
  `dateNaissance` date NOT NULL,
  `lieuNaissance` varchar(30) NOT NULL,
  `codeRole` varchar(2) NOT NULL,
  `nomPays` varchar(30) NOT NULL,
  `codeStatut` varchar(1) NOT NULL,
  `Sexe` text NOT NULL,
  PRIMARY KEY (`numVip`),
  KEY `nomPays` (`nomPays`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=30 ;

--
-- Contenu de la table `VIP`
--

INSERT INTO `VIP` (`numVip`, `nomVip`, `prenomVip`, `dateNaissance`, `lieuNaissance`, `codeRole`, `nomPays`, `codeStatut`, `Sexe`) VALUES
(1, 'JOLIE', 'Angelina', '1975-06-04', 'Los Angeles', 'AR', 'US', 'M', 'F'),
(2, 'PITT', 'Brad', '1963-12-18', 'Shawnee', 'A', 'US', 'M', 'M'),
(3, 'WILLIS', 'Bruce', '1955-03-19', 'Idar-Oberstein', 'A', 'US', 'M', 'M'),
(4, 'BURTON', 'Tim', '1958-08-25', 'Burbank', 'AR', 'US', 'D', 'M'),
(5, 'SY', 'Omar', '1978-01-20', 'Trappes', 'AR', 'FR', 'M', 'M'),
(6, 'HUTCHERSON', 'Josh', '1992-10-12', 'Union', 'A', 'US', 'C', 'M'),
(7, 'DICAPRIO', 'Leonardo', '1974-11-11', 'Hollywood', 'A', 'US', 'M', 'M'),
(8, 'MORETZ', 'Chloë', '1997-02-10', 'Atlanta', 'A', 'US', 'C', 'F'),
(9, 'CARTER', 'Helena', '1966-05-26', 'Londres', 'A', 'UK', 'M', 'F'),
(10, 'CLOONEY', 'George', '1961-05-06', 'Lexington', 'AR', 'US', 'M', 'M'),
(11, 'LAWRENCE', 'Jennifer', '1990-08-15', 'Louisville', 'AR', 'UK', 'C', 'F'),
(12, 'COTILLARD', 'Marion', '1975-09-30', 'Paris', 'AR', 'FR', 'M', 'F'),
(13, 'WATSON', 'Emma', '1990-04-15', 'Paris', 'A', 'UK', 'C', 'F'),
(14, 'RADCLIFFE', 'Daniel', '1989-07-23', 'Londres', 'A', 'UK', 'C', 'M'),
(15, 'LAMY', 'Alexandra', '1971-10-14', 'Alès', 'AR', 'FR', 'D', 'F'),
(16, 'DUJARDIN', 'Jean', '1972-06-19', 'Rueil-Malmaison', 'AR', 'FR', 'D', 'M'),
(17, 'NEWELL', 'Mike', '1942-03-28', 'St Albans', 'R', 'UK', 'M', 'M'),
(19, 'SPIELBERG', 'Steven', '1946-11-18', 'Ohio', 'R', 'US', 'M', 'M'),
(21, 'BRANTLEY', 'Betsy', '1955-09-20', 'Rutherfordton', 'A', 'US', 'D', 'F'),
(22, 'MOORE', 'Demi', '1962-11-11', 'Roswell', 'AR', 'US', 'D', 'F'),
(23, 'BESSON', 'Luc', '1959-03-18', 'Paris', 'R', 'FR', 'M', 'M'),
(25, 'NOLAN', 'Christopher', '1970-07-30', 'Londres', 'R', 'UK', 'M', 'M'),
(26, 'BLIER', 'Bertrand', '1939-03-14', 'Paris', 'R', 'FR', 'M', 'M'),
(28, 'ANDERS', 'Sean', '1969-06-05', 'DeForest', 'AR', 'US', 'C', 'M');

--
-- Déclencheurs `VIP`
--
DROP TRIGGER IF EXISTS `EXIST_VIP`;
DELIMITER //
CREATE TRIGGER `EXIST_VIP` BEFORE INSERT ON `VIP`
 FOR EACH ROW BEGIN 

	declare cpt integer;
	declare msg varchar(255);
    DECLARE EXIST_VIP CONDITION FOR SQLSTATE '45000';

	select count(*) into cpt from VIP
	where nomVip = NEW.nomVip and prenomVip=NEW.prenomVip and dateNaissance=NEW.dateNaissance and lieuNaissance=NEW.lieuNaissance;


    if cpt <> 0 then 
		CALL EXIST_VIP;
    END IF; 
END
//
DELIMITER ;

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `CASTING`
--
ALTER TABLE `CASTING`
  ADD CONSTRAINT `fk-numvip3` FOREIGN KEY (`numVip`) REFERENCES `VIP` (`numVip`),
  ADD CONSTRAINT `fk_numvisa2` FOREIGN KEY (`numVisa`) REFERENCES `FILM` (`numVisa`);

--
-- Contraintes pour la table `EVENEMENT`
--
ALTER TABLE `EVENEMENT`
  ADD CONSTRAINT `fk_numvip` FOREIGN KEY (`numVip`) REFERENCES `VIP` (`numVip`);

--
-- Contraintes pour la table `FILM`
--
ALTER TABLE `FILM`
  ADD CONSTRAINT `fk-genre` FOREIGN KEY (`LibelleGenre`) REFERENCES `GENRE` (`LibelleGenre`);

--
-- Contraintes pour la table `PHOTO`
--
ALTER TABLE `PHOTO`
  ADD CONSTRAINT `fk-numvip4` FOREIGN KEY (`numVip`) REFERENCES `VIP` (`numVip`);

--
-- Contraintes pour la table `REALISATEUR`
--
ALTER TABLE `REALISATEUR`
  ADD CONSTRAINT `fk_numvip2` FOREIGN KEY (`numVip`) REFERENCES `VIP` (`numVip`),
  ADD CONSTRAINT `fk_numvisa` FOREIGN KEY (`numVisa`) REFERENCES `FILM` (`numVisa`);

--
-- Contraintes pour la table `VIP`
--
ALTER TABLE `VIP`
  ADD CONSTRAINT `fk_nomPays` FOREIGN KEY (`nomPays`) REFERENCES `PAYS` (`nomPays`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
