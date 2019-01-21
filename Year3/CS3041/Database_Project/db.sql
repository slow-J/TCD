-- phpMyAdmin SQL Dump
-- version 4.2.12deb2+deb8u3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 26, 2018 at 11:00 AM
-- Server version: 5.5.62-0+deb8u1
-- PHP Version: 5.6.38-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `slowinsj_db`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `All_Times_50_Free`
--
CREATE TABLE IF NOT EXISTS `All_Times_50_Free` (
`Member_ID` int(11)
,`Time` varchar(20)
);
-- --------------------------------------------------------

--
-- Table structure for table `Coaches`
--

CREATE TABLE IF NOT EXISTS `Coaches` (
  `Coach_ID` int(11) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `Phone_No` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Coaches`
--

INSERT INTO `Coaches` (`Coach_ID`, `NAME`, `Phone_No`) VALUES
(1, 'Dylan Murphy', '0861233333'),
(2, 'Tony King', '0876716969'),
(3, 'Sinead Murphy', '0851234567'),
(4, 'Stephen Gordy', '0854058790'),
(5, 'Dylan Lyons', '0894358791');

-- --------------------------------------------------------

--
-- Table structure for table `Competitions`
--

CREATE TABLE IF NOT EXISTS `Competitions` (
  `Date` date NOT NULL,
  `Venue` varchar(30) NOT NULL,
  `Comp_ID` int(11) NOT NULL,
  `Division` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Competitions`
--

INSERT INTO `Competitions` (`Date`, `Venue`, `Comp_ID`, `Division`) VALUES
('2018-12-08', 'National Aquatic Centre', 1, 1),
('2018-12-15', 'National Aquatic Centre', 2, 2),
('2019-01-25', 'Sportsco', 3, 2),
('2019-02-21', 'Tallaght Swimming Pool', 4, 1),
('2018-03-15', 'Templeogue College Swimming Po', 5, 2),
('2019-08-23', 'National Aquatic Centre - Corm', 6, 2),
('2019-08-15', 'National Aquatic Centre - Corm', 7, 1);

--
-- Triggers `Competitions`
--
DELIMITER //
CREATE TRIGGER `comp_div` BEFORE INSERT ON `Competitions`
 FOR EACH ROW BEGIN
IF NEW.Division > 2 THEN SET NEW.Division = 2;
END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Members`
--

CREATE TABLE IF NOT EXISTS `Members` (
  `Member_ID` int(11) NOT NULL,
  `Age` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Emergency_Phone_No` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Members`
--

INSERT INTO `Members` (`Member_ID`, `Age`, `Name`, `Emergency_Phone_No`) VALUES
(1, 16, 'Eoin Morgan', '0861111111'),
(2, 17, 'Eoaghan Trinity', '0861123111'),
(3, 16, 'Blessing Omamo', '0861123311'),
(4, 19, 'Darragh Smelly', '0861223311'),
(5, 13, 'Nicolas Dumonts', '0881223311'),
(6, 16, 'Michael Dumonts', '0881223311'),
(7, 17, 'Nikolas Moran', '0831523311'),
(8, 15, 'Brona Nike', '0861223313'),
(9, 19, 'Sarah Cowell', '0881223981'),
(10, 15, 'Mary Mooney', '0861761116'),
(11, 17, 'Connor Gormlet', '0861123161'),
(12, 14, 'Sarah Polanski', '0881223981'),
(13, 14, 'Blessing Omamo', '0861123311'),
(14, 20, 'Darren Glynn', '0861223311'),
(15, 14, 'Nichola Morgan', '0881233323'),
(16, 19, 'Mike Durban', '0881224211'),
(17, 17, 'Sean Daly', '0831528911'),
(18, 15, 'Fionn Daly', '0861273313'),
(19, 19, 'Simon Dole', '0881241981');

-- --------------------------------------------------------

--
-- Table structure for table `Personal_Bests`
--

CREATE TABLE IF NOT EXISTS `Personal_Bests` (
  `Time` varchar(20) NOT NULL,
  `Stroke_ID` varchar(11) NOT NULL,
  `Race_ID` int(11) NOT NULL,
  `Member_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Personal_Bests`
--

INSERT INTO `Personal_Bests` (`Time`, `Stroke_ID`, `Race_ID`, `Member_ID`) VALUES
('24.8', '50_Free', 3, 2),
('1.10.62', '100_Free', 26, 3),
('1.02.15', '100_Free', 5, 6),
('1.03.62', '100_Free', 5, 8),
('1.17.62', '100_Free', 21, 9),
('1.23.78', '50_Back', 30, 9),
('1.03.62', '50_Breast', 7, 10),
('1.01.03', '100_Free', 21, 14),
('1.06.41', '50_Back', 15, 14),
('1.05.5', '100_Back', 15, 17),
('29.62', '50_Free', 16, 18),
('1.08.3', '100_Free', 21, 19);

-- --------------------------------------------------------

--
-- Table structure for table `Races`
--

CREATE TABLE IF NOT EXISTS `Races` (
  `Race_ID` int(11) NOT NULL,
  `Stroke_ID` varchar(11) NOT NULL,
  `Comp_ID` int(11) NOT NULL,
  `Age_Group` int(11) NOT NULL,
  `Referee_Name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Races`
--

INSERT INTO `Races` (`Race_ID`, `Stroke_ID`, `Comp_ID`, `Age_Group`, `Referee_Name`) VALUES
(1, '50_Free', 1, 15, 'Cian Norton'),
(2, '50_Free', 1, 16, 'Cian Norton'),
(3, '50_Free', 1, 17, 'Cian Norton'),
(4, '100_Free', 1, 15, 'Cian Norton'),
(5, '100_Free', 1, 16, 'Cian Norton'),
(6, '100_Free', 1, 17, 'Cian Norton'),
(7, '50_Breast', 1, 15, 'Cian Norton'),
(8, '100_Breast', 1, 16, 'Cian Norton'),
(9, '50_Back', 1, 17, 'Cian Norton'),
(10, '100_Back', 1, 15, 'Cian Norton'),
(11, '100_Free', 1, 16, 'Cian Norton'),
(12, '100_Free', 1, 17, 'Cian Norton'),
(13, '100_Breast', 1, 15, 'Cian Norton'),
(14, '100_Breast', 1, 16, 'Cian Norton'),
(15, '50_Back', 1, 17, 'Cian Norton'),
(16, '50_Free', 3, 15, 'Mike Brady'),
(17, '50_Free', 3, 16, 'Mike Brady'),
(18, '50_Free', 4, 17, 'Cian Norton'),
(19, '100_Free', 7, 15, 'Declan Rice'),
(20, '100_Free', 2, 16, 'Tony Martin'),
(21, '100_Free', 3, 17, 'Mike Brady'),
(22, '50_Breast', 3, 15, 'Mike Brady'),
(23, '100_Breast', 3, 16, 'Mike Brady'),
(24, '50_Back', 3, 17, 'Mike Brady'),
(25, '100_Back', 3, 15, 'Mike Brady'),
(26, '100_Free', 3, 16, 'Mike Brady'),
(27, '100_Free', 6, 17, 'Cian Norton'),
(28, '100_Breast', 3, 15, 'Mike Brady'),
(29, '100_Breast', 3, 16, 'Mike Brady'),
(30, '50_Back', 3, 17, 'Mike Brady');

-- --------------------------------------------------------

--
-- Table structure for table `Training_Sessions`
--

CREATE TABLE IF NOT EXISTS `Training_Sessions` (
  `Coach_ID` int(11) NOT NULL,
  `Stroke_ID` varchar(11) NOT NULL,
  `Day_Of_The_Week` varchar(3) NOT NULL,
  `Training_Time` time NOT NULL,
  `Parent_On_Bank` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Training_Sessions`
--

INSERT INTO `Training_Sessions` (`Coach_ID`, `Stroke_ID`, `Day_Of_The_Week`, `Training_Time`, `Parent_On_Bank`) VALUES
(4, '100_Back', 'Mon', '21:00:00', 'Connor Mor'),
(2, '100_Breast', 'Mon', '19:00:00', 'Steph Moran'),
(2, '100_Fly', 'Fri', '19:00:00', 'Mary OKeefe'),
(1, '100_Free', 'Sat', '18:00:00', 'Brain Gormlet'),
(1, '200_Back', 'Tue', '19:00:00', 'Kate Glynn'),
(4, '200_Breast', 'Fri', '06:00:00', 'Sean Gill'),
(1, '200_Fly', 'Mon', '21:00:00', 'Connor Dole'),
(3, '200_Free', 'Wed', '06:15:00', 'Colm Polanski'),
(5, '200_IM', 'Sat', '10:00:00', 'Declan Dorman'),
(4, '400_Free', 'Wed', '19:15:00', 'Alan Glynn'),
(3, '50_Back', 'Thu', '21:00:00', 'Siobhan Daly'),
(1, '50_Breast', 'Sun', '09:30:00', 'Burto Hash'),
(2, '50_Fly', 'Sat', '09:00:00', 'Cian OMeara'),
(1, '50_Free', 'Mon', '06:25:00', 'Michael Mooney');

-- --------------------------------------------------------

--
-- Stand-in structure for view `Training_Sessions_Available`
--
CREATE TABLE IF NOT EXISTS `Training_Sessions_Available` (
`Day_Of_The_Week` varchar(3)
,`Training_Time` time
);
-- --------------------------------------------------------

--
-- Structure for view `All_Times_50_Free`
--
DROP TABLE IF EXISTS `All_Times_50_Free`;

CREATE ALGORITHM=UNDEFINED DEFINER=`slowinsj`@`localhost` SQL SECURITY DEFINER VIEW `All_Times_50_Free` AS select `Personal_Bests`.`Member_ID` AS `Member_ID`,`Personal_Bests`.`Time` AS `Time` from `Personal_Bests` where (`Personal_Bests`.`Stroke_ID` = '50_Free');

-- --------------------------------------------------------

--
-- Structure for view `Training_Sessions_Available`
--
DROP TABLE IF EXISTS `Training_Sessions_Available`;

CREATE ALGORITHM=UNDEFINED DEFINER=`slowinsj`@`localhost` SQL SECURITY DEFINER VIEW `Training_Sessions_Available` AS select `Training_Sessions`.`Day_Of_The_Week` AS `Day_Of_The_Week`,`Training_Sessions`.`Training_Time` AS `Training_Time` from `Training_Sessions`;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Coaches`
--
ALTER TABLE `Coaches`
 ADD PRIMARY KEY (`Coach_ID`);

--
-- Indexes for table `Competitions`
--
ALTER TABLE `Competitions`
 ADD PRIMARY KEY (`Comp_ID`);

--
-- Indexes for table `Members`
--
ALTER TABLE `Members`
 ADD PRIMARY KEY (`Member_ID`);

--
-- Indexes for table `Personal_Bests`
--
ALTER TABLE `Personal_Bests`
 ADD PRIMARY KEY (`Member_ID`,`Stroke_ID`), ADD KEY `Race_ID` (`Race_ID`), ADD KEY `Stroke_ID` (`Stroke_ID`);

--
-- Indexes for table `Races`
--
ALTER TABLE `Races`
 ADD PRIMARY KEY (`Race_ID`), ADD KEY `Stroke_ID` (`Stroke_ID`), ADD KEY `Comp_ID` (`Comp_ID`);

--
-- Indexes for table `Training_Sessions`
--
ALTER TABLE `Training_Sessions`
 ADD PRIMARY KEY (`Stroke_ID`), ADD KEY `Coach_ID` (`Coach_ID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Personal_Bests`
--
ALTER TABLE `Personal_Bests`
ADD CONSTRAINT `Personal_Bests_ibfk_1` FOREIGN KEY (`Member_ID`) REFERENCES `Members` (`Member_ID`),
ADD CONSTRAINT `Personal_Bests_ibfk_2` FOREIGN KEY (`Race_ID`) REFERENCES `Races` (`Race_ID`),
ADD CONSTRAINT `Personal_Bests_ibfk_3` FOREIGN KEY (`Stroke_ID`) REFERENCES `Training_Sessions` (`Stroke_ID`);

--
-- Constraints for table `Races`
--
ALTER TABLE `Races`
ADD CONSTRAINT `Races_ibfk_2` FOREIGN KEY (`Comp_ID`) REFERENCES `Competitions` (`Comp_ID`),
ADD CONSTRAINT `Races_ibfk_1` FOREIGN KEY (`Stroke_ID`) REFERENCES `Training_Sessions` (`Stroke_ID`);

--
-- Constraints for table `Training_Sessions`
--
ALTER TABLE `Training_Sessions`
ADD CONSTRAINT `Training_Sessions_ibfk_1` FOREIGN KEY (`Coach_ID`) REFERENCES `Coaches` (`Coach_ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
