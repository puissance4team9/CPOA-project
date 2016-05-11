-- phpMyAdmin SQL Dump
-- version 4.0.10.15
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Mer 11 Mai 2016 à 15:02
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
