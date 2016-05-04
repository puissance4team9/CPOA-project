-- phpMyAdmin SQL Dump
-- version 4.0.10.15
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Ven 29 Avril 2016 à 11:43
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
  PRIMARY KEY (`numVisa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `GENRE`
--

CREATE TABLE IF NOT EXISTS `GENRE` (
  `LibelleGenre` varchar(50) NOT NULL,
  PRIMARY KEY (`LibelleGenre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `PAYS`
--

CREATE TABLE IF NOT EXISTS `PAYS` (
  `nomPays` varchar(30) NOT NULL,
  PRIMARY KEY (`nomPays`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `codeRole` varchar(2) NOT NULL,
  `nomPays` varchar(30) NOT NULL,
  `codeStatut` varchar(1) NOT NULL,
  PRIMARY KEY (`numVip`),
  KEY `nomPays` (`nomPays`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `CASTING`
--
ALTER TABLE `CASTING`
  ADD CONSTRAINT `fk_numvisa2` FOREIGN KEY (`numVisa`) REFERENCES `FILM` (`numVisa`),
  ADD CONSTRAINT `fk-numvip3` FOREIGN KEY (`numVip`) REFERENCES `VIP` (`numVip`);

--
-- Contraintes pour la table `EVENEMENT`
--
ALTER TABLE `EVENEMENT`
  ADD CONSTRAINT `fk_numvip` FOREIGN KEY (`numVip`) REFERENCES `VIP` (`numVip`);

--
-- Contraintes pour la table `PHOTO`
--
ALTER TABLE `PHOTO`
  ADD CONSTRAINT `fk-numvip4` FOREIGN KEY (`numVip`) REFERENCES `VIP` (`numVip`);

--
-- Contraintes pour la table `REALISATEUR`
--
ALTER TABLE `REALISATEUR`
  ADD CONSTRAINT `fk_numvisa` FOREIGN KEY (`numVisa`) REFERENCES `FILM` (`numVisa`),
  ADD CONSTRAINT `fk_numvip2` FOREIGN KEY (`numVip`) REFERENCES `VIP` (`numVip`);

--
-- Contraintes pour la table `VIP`
--
ALTER TABLE `VIP`
  ADD CONSTRAINT `fk_nomPays` FOREIGN KEY (`nomPays`) REFERENCES `PAYS` (`nomPays`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
