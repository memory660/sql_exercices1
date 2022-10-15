CREATE TABLE `employe` (
  `id` int(11) NOT NULL,
  `no` int(11) NOT NULL,
  `nom` varchar(64) NOT NULL,
  `date_embauche` datetime NOT NULL,
  `salaire` int(11) NOT NULL,
  `commission` int(11) NOT NULL,
  `dep_id` int(11) NOT NULL,
  `profession` varchar(66) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `employe` (`id`, `no`, `nom`, `date_embauche`, `salaire`, `commission`, `dep_id`, `profession`) VALUES
(1, 1, 'joe', '2022-10-31 11:16:59', 1000, 400, 3, 'ingé'),
(2, 2, 'robert', '2012-06-01 11:17:33', 2000, 300, 1, 'infirmier'),
(3, 3, 'jim', '2016-10-01 11:19:39', 3000, 300, 2, 'vendeur'),
(4, 4, 'lucy', '2019-10-01 11:20:09', 2000, 100, 3, 'ingé'),
(5, 5, 'jack', '2019-02-13 11:20:56', 4000, 200, 3, 'technicien');

CREATE TABLE `departement` (
  `id` int(11) NOT NULL,
  `nom` varchar(64) NOT NULL,
  `dir` int(11) NOT NULL,
  `ville` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `departement` (`id`, `nom`, `dir`, `ville`) VALUES
(1, 'commercial', 30, 'paris'),
(2, 'developpement', 20, 'montpellier'),
(3, 'production', 50, 'lille');