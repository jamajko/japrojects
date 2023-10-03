-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hostiteľ: 127.0.0.1
-- Čas generovania: Po 03.Máj 2021, 19:00
-- Verzia serveru: 10.4.17-MariaDB
-- Verzia PHP: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáza: `recenzie`
--

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `user`
--

CREATE TABLE `user` (
  `ID` int(11) NOT NULL,
  `Meno` varchar(30) NOT NULL,
  `Pravidelnost` tinyint(1) NOT NULL,
  `Pohlavie` char(1) NOT NULL,
  `Hodnotenie` enum('1','2','3','4','5') NOT NULL,
  `Komentar` text NOT NULL,
  `Cas` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `user`
--

INSERT INTO `user` (`ID`, `Meno`, `Pravidelnost`, `Pohlavie`, `Hodnotenie`, `Komentar`, `Cas`) VALUES
(36, 'Adam', 1, 'm', '4', 'Celkom fajn hra.', '2021-05-01 13:42:23'),
(41, 'Erika', 0, 'z', '3', '', '2021-05-03 00:45:58'),
(42, 'Juraj', 1, 'm', '5', '', '2021-05-03 00:46:10'),
(43, 'Majo', 1, 'm', '4', 'Rozhodnutia naozaj majú dopad na dianie.', '2021-05-03 02:15:48'),
(44, 'Andrej', 0, 'm', '1', 'Otras toto, však to sa ani nedá hrať. ', '2021-05-03 03:32:46'),
(45, 'Lea', 1, 'z', '5', '', '2021-05-03 03:34:31'),
(46, 'Michal', 1, 'm', '4', 'Celkom fajn', '2021-05-03 03:34:54'),
(54, 'Anonym', 1, 'm', '4', 'Je to dosť dobré.<br />\r\nPo dlhej dobe interaktívny film, kde som mal pocit, že moje rozhodnutia k niečomu boli.<br />\r\nConorová linka bola super, nie že by s ostatnými postavami bola nuda,<br />\r\nale úplne v pohode by príbeh fungoval aj keby to bolo hlavne o ňom.<br />\r\n', '2021-05-03 17:32:03');

--
-- Kľúče pre exportované tabuľky
--

--
-- Indexy pre tabuľku `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT pre exportované tabuľky
--

--
-- AUTO_INCREMENT pre tabuľku `user`
--
ALTER TABLE `user`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
