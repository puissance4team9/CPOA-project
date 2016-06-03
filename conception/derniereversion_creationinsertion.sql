-- phpMyAdmin SQL Dump
-- version 4.0.10.15
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Ven 03 Juin 2016 à 16:11
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
(28, 1044220),
(28, 1081380),
(5, 1125520),
(26, 1132830),
(32, 1138980),
(13, 1140280),
(14, 1140280),
(35, 1196320),
(8, 1248710),
(16, 1248710),
(6, 1267180),
(11, 1267180),
(8, 1319610),
(13, 1319610),
(14, 1319610),
(9, 1434270),
(13, 1434270);

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
CREATE TRIGGER `DIVORCE` AFTER UPDATE ON `EVENEMENT`
 FOR EACH ROW BEGIN
	
	update VIP set codeStatut='Divorcé' WHERE numVip=NEW.numVip;
	update VIP set codeStatut='Divorcé' WHERE  numVip=NEW.numVipConjoint;

END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `Mariage`;
DELIMITER //
CREATE TRIGGER `Mariage` BEFORE INSERT ON `EVENEMENT`
 FOR EACH ROW BEGIN 

	declare cpt1 integer;
	declare cpt2 integer;
	declare msg varchar(255);
    DECLARE EXIST_Mariage CONDITION FOR SQLSTATE '45003';

	select count(*) into cpt1 from VIP
	where numVip = NEW.numVip  and codeStatut<> 'Marié';
	
	select count(*) into cpt2 from VIP
	where numVip=NEW.numVipConjoint  and codeStatut<> 'Marié';


    if cpt1 <> 0 OR cpt2 <> 0 then 
		CALL Deja_Mariage;
    END IF;


	update VIP set codeStatut='Marié' where numVip=NEW.numVip;
	update VIP set codeStatut='Marié' where numVip=NEW.numVipConjoint;
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
  `idPhotoF` varchar(20) NOT NULL,
  PRIMARY KEY (`numVisa`),
  KEY `LibelleGenre` (`LibelleGenre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `FILM`
--

INSERT INTO `FILM` (`numVisa`, `titre`, `LibelleGenre`, `annee`, `idPhotoF`) VALUES
(1044220, ' Alice au pays des merveilles', 'Fantastique', 2010, 'F1.jpg'),
(1081380, 'SWEENEY TODD, LE DIABOLIQUE BARBIER DE FLEET STREET', 'Fantastique', 2008, 'F2.jpg'),
(1125520, 'Nos jours heureux', 'Comédie', 2006, 'F3.jpg'),
(1132830, 'All the Boys Love Mandy Lane', 'Horreur', 2008, 'F4.jpg'),
(1138980, 'Mission : Impossible III', 'Action', 2006, 'F5.jpg'),
(1140280, 'Harry Potter et l''école des sorciers', 'Fantastique', 2001, 'F6.jpg'),
(1196320, 'V pour Vendetta', 'Thriller', 2005, 'F7.jpg'),
(1248710, 'Captain America : First Avenger', 'Science Fiction', 2011, 'F8.jpg'),
(1267180, 'Hunger Games', 'Fantastique', 2012, 'F9.jpg'),
(1319610, 'HARRY POTTER ET LA COUPE DE FEU', 'Fantastique', 2005, 'F10.jpg'),
(1434270, 'Slumdog Millionaire', 'Action', 2008, '11.jpg');

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
  `numeroSenquentId` int(7) NOT NULL,
  `date` date NOT NULL,
  `lieu` varchar(30) NOT NULL,
  PRIMARY KEY (`numVip`,`numeroSenquentId`)
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
(4, 1044220),
(4, 1081380),
(5, 1081380),
(30, 1125520),
(26, 1132830),
(31, 1132830),
(33, 1138980),
(25, 1140280),
(29, 1140280),
(19, 1196320),
(19, 1248710),
(34, 1267180),
(17, 1319610),
(19, 1434270);

-- --------------------------------------------------------

--
-- Structure de la table `UTILISATEUR`
--

CREATE TABLE IF NOT EXISTS `UTILISATEUR` (
  `Login` varchar(30) NOT NULL,
  `Password` int(30) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
