-- phpMyAdmin SQL Dump
-- version 4.0.10.15
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Ven 03 Juin 2016 à 16:40
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
(1, 15),
(36, 15),
(25, 16),
(28, 1044220),
(28, 1081380),
(5, 1125520),
(26, 1132830),
(32, 1138980),
(13, 1140280),
(14, 1140280),
(35, 1196320),
(2, 1248710),
(6, 1267180),
(11, 1267180),
(13, 1319610),
(14, 1319610),
(8, 1434270),
(9, 1434270),
(28, 1434270),
(7, 1963253),
(12, 1963253),
(22, 1963253);

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
(15, 'Maléfique', 'Fantastique', 2014, 'F15.jpg'),
(16, 'The Amazing Spider-Man', 'Fantastique', 2012, 'F16.jpg'),
(1044220, ' Alice au pays des merveilles', 'Fantastique', 2010, 'F1.jpg'),
(1081380, 'SWEENEY TODD, LE DIABOLIQUE BARBIER DE FLEET STREET', 'Fantastique', 2008, 'F2.jpg'),
(1125520, 'Nos jours heureux', 'Comédie', 2006, 'F3.jpg'),
(1132830, 'All the Boys Love Mandy Lane', 'Horreur', 2008, 'F4.jpg'),
(1138980, 'Mission : Impossible III', 'Action', 2006, 'F5.jpg'),
(1140280, 'Harry Potter et l''école des sorciers', 'Fantastique', 2001, 'F6.jpg'),
(1196320, 'V pour Vendetta', 'Thriller', 2005, 'F7.jpg'),
(1248710, 'Fight Club', 'Thriller', 1999, '8.jpg'),
(1267180, 'Hunger Games', 'Fantastique', 2012, 'F9.jpg'),
(1319610, 'HARRY POTTER ET LA COUPE DE FEU', 'Fantastique', 2005, 'F10.jpg'),
(1434270, 'Dark Shadow', 'Fantastique', 2012, 'F14.jpg'),
(1963253, 'Inception', 'Fantastique', 2010, 'F13.jpg');

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
(31, 1132830),
(33, 1138980),
(29, 1140280),
(19, 1196320),
(19, 1248710),
(34, 1267180),
(17, 1319610),
(4, 1434270);

-- --------------------------------------------------------

--
-- Structure de la table `VIP`
--

CREATE TABLE IF NOT EXISTS `VIP` (
  `numVip` int(7) NOT NULL AUTO_INCREMENT,
  `nomVip` varchar(30) NOT NULL,
  `prenomVip` varchar(30) NOT NULL,
  `civilite` varchar(3) NOT NULL,
  `dateNaissance` date NOT NULL,
  `lieuNaissance` varchar(30) NOT NULL,
  `codeRole` varchar(30) NOT NULL,
  `nomPays` varchar(30) NOT NULL,
  `codeStatut` varchar(30) NOT NULL,
  `idPhoto` varchar(11) NOT NULL,
  PRIMARY KEY (`numVip`),
  KEY `nomPays` (`nomPays`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=41 ;

--
-- Contenu de la table `VIP`
--

INSERT INTO `VIP` (`numVip`, `nomVip`, `prenomVip`, `civilite`, `dateNaissance`, `lieuNaissance`, `codeRole`, `nomPays`, `codeStatut`, `idPhoto`) VALUES
(1, 'JOLIE', 'Angelina', 'Mme', '1975-06-04', 'Los Angeles', 'Acteur', 'US', 'Marié', '1.jpg'),
(2, 'PITT', 'Brad', 'M', '1963-12-18', 'Shawnee', 'Acteur', 'US', 'Marié', 'V2.jpg'),
(4, 'BURTON', 'Tim', 'M', '1958-08-25', 'Burbank', 'Realisateur', 'US', 'Divorcé', '4.jpg'),
(5, 'SY', 'Omar', 'M', '1978-01-20', 'Trappes', 'Acteur', 'FR', 'Marié', '5.jpg'),
(6, 'HUTCHERSON', 'Josh', 'M', '1992-10-12', 'Union', 'Acteur', 'US', 'Célibataire', 'V6.jpg'),
(7, 'DICAPRIO', 'Leonardo', 'M', '1974-11-11', 'Hollywood', 'Acteur', 'US', 'Marié', 'V7.jpg'),
(8, 'MORETZ', 'Chloë', 'Mme', '1997-02-10', 'Atlanta', 'Acteur', 'US', 'Célibataire', 'V8.jpg'),
(9, 'CARTER', 'Helena', 'Mme', '1966-05-26', 'Londres', 'Acteur', 'UK', 'Marié', '9.jpg'),
(11, 'LAWRENCE', 'Jennifer', 'Mme', '1990-08-15', 'Louisville', 'Acteur', 'UK', 'Célibataire', 'V11.jpg'),
(12, 'COTILLARD', 'Marion', 'Mme', '1975-09-30', 'Paris', 'Acteur', 'FR', 'Marié', 'V12.jpg'),
(13, 'WATSON', 'Emma', 'Mme', '1990-04-15', 'Paris', 'Acteur', 'UK', 'Célibataire', 'V13.jpg'),
(14, 'RADCLIFFE', 'Daniel', 'M', '1989-07-23', 'Londres', 'Acteur', 'UK', 'Célibataire', 'V14.jpg'),
(17, 'NEWELL', 'Mike', 'M', '1942-03-28', 'St Albans', 'Realisateur', 'UK', 'Marié', 'V17.jpg'),
(19, 'SPIELBERG', 'Steven', 'M', '1946-11-18', 'Ohio', 'Realisateur', 'US', 'Marié', 'V19.jpg'),
(22, 'Page', 'Ellen', 'Mme', '1987-02-21', 'Nouvelle Ecosse', 'Acteur', 'US', 'Celibataire', '22.jpg'),
(25, 'STONE', 'Emma', 'Mme', '1988-11-06', 'Arizona', 'Acteur', 'US', 'Célibataire', 'V25.jpg'),
(26, 'HEARD', 'AMBER', 'Mme', '1986-04-22', 'Texas', 'Acteur', 'US', 'Célibataire', 'V26.jpg'),
(28, 'Deep', 'Johnny', 'M', '1963-06-09', 'Owensbor', 'Acteur', 'US', 'Célibataire', 'V28.jpg'),
(29, 'Colombu', 'Chris', 'M', '1958-06-10', 'PennSylvanie', 'Realisateur', 'US', 'Marié', 'V29.jpg'),
(30, 'Toledano', 'Eric', 'M', '1971-08-03', 'Paris', 'Realisateur', 'FR', 'Celibataire', 'V30.jpg'),
(31, 'Levine', 'Jonathan', 'M', '1976-06-18', 'New York', 'Realisateur', 'US', 'Divorcé', 'V31.jpg'),
(32, 'Cruise', 'Tom', 'M', '1962-07-03', 'Syracuse', 'Acteur', 'US', 'Marié', 'V32.jpg'),
(33, 'Abrams', 'J.J', 'M', '1966-06-27', 'New York', 'Realisateur', 'US', 'Marié', 'V33.jpg'),
(34, 'Ross', 'Gary', 'M', '1956-11-03', 'Los Angeles', 'Realisateur', 'US', 'Celibataire', 'V34.jpg'),
(35, 'Portman', 'Nathalie', 'Mme', '1981-10-09', 'Jérusalem', 'Acteur', 'US', 'Divorcé', 'V35.jpg'),
(36, 'Fanning', 'Elle', 'Mme', '1998-04-10', 'Géorgie', 'Acteur', 'US', 'Celibataire', 'V36.jpg');

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
