-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.25-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para clinicaestetica
DROP DATABASE IF EXISTS `clinicaestetica`;
CREATE DATABASE IF NOT EXISTS `clinicaestetica` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `clinicaestetica`;

-- Copiando estrutura para tabela clinicaestetica.consulta
DROP TABLE IF EXISTS `consulta`;
CREATE TABLE IF NOT EXISTS `consulta` (
  `codConsulta` int(11) NOT NULL AUTO_INCREMENT,
  `cliente` varchar(200) NOT NULL,
  `cpf` varchar(15) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `hora` varchar(15) NOT NULL,
  `dataD` varchar(15) NOT NULL,
  `proce` int(11) NOT NULL,
  PRIMARY KEY (`codConsulta`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela clinicaestetica.consulta: ~4 rows (aproximadamente)
INSERT INTO `consulta` (`codConsulta`, `cliente`, `cpf`, `telefone`, `hora`, `dataD`, `proce`) VALUES
	(18, 'Emily Ferreira', '159.147.258-58', '(16)99632-2541', '8:00', '06/12/2022', 15),
	(19, 'Dayane Núbia', '126.354.258-95', '(35)99147-4845', '9:00', '15/12/2022', 12),
	(20, 'Geovana Reis', '147.258.369-96', '(15)9856-4715', '16:00', '19/12/2022', 13),
	(21, 'André Pacheco', '258.741.547-87', '(33)98142-4942', '14:00', '22/12/2022', 10);

-- Copiando estrutura para procedure clinicaestetica.consultaLogin
DROP PROCEDURE IF EXISTS `consultaLogin`;
DELIMITER //
CREATE PROCEDURE `consultaLogin`(usuario varchar(100), senha varchar(100))
BEGIN
Select * from usuarios where usuarios.nome = usuario and usuarios.senha = senha;
END//
DELIMITER ;

-- Copiando estrutura para procedure clinicaestetica.lista_consultas
DROP PROCEDURE IF EXISTS `lista_consultas`;
DELIMITER //
CREATE PROCEDURE `lista_consultas`()
BEGIN
SELECT codConsulta, cliente, cpf, telefone, hora, dataD, procedimento.nomeProcedimento from consulta inner join procedimento on consulta.proce = procedimento.codProcedimento;
END//
DELIMITER ;

-- Copiando estrutura para procedure clinicaestetica.lista_procedimentos
DROP PROCEDURE IF EXISTS `lista_procedimentos`;
DELIMITER //
CREATE PROCEDURE `lista_procedimentos`()
BEGIN
SELECT * FROM procedimento;
END//
DELIMITER ;

-- Copiando estrutura para tabela clinicaestetica.procedimento
DROP TABLE IF EXISTS `procedimento`;
CREATE TABLE IF NOT EXISTS `procedimento` (
  `codProcedimento` int(11) NOT NULL AUTO_INCREMENT,
  `nomeProcedimento` varchar(200) NOT NULL,
  PRIMARY KEY (`codProcedimento`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela clinicaestetica.procedimento: ~7 rows (aproximadamente)
INSERT INTO `procedimento` (`codProcedimento`, `nomeProcedimento`) VALUES
	(9, 'Limpeza de pele'),
	(10, 'Peeling de cristal'),
	(11, 'Microagulhamento facial '),
	(12, 'Eletrolifting'),
	(13, 'Drenagem linfática'),
	(14, 'Depilação a laser'),
	(15, 'Rinoplastia');

-- Copiando estrutura para procedure clinicaestetica.proc_alteraConsulta
DROP PROCEDURE IF EXISTS `proc_alteraConsulta`;
DELIMITER //
CREATE PROCEDURE `proc_alteraConsulta`(
	IN `cliente` VARCHAR(200),
	IN `cpf` VARCHAR(20),
	IN `telefone` VARCHAR(20),
	IN `hora` VARCHAR(15),
	IN `dataD` VARCHAR(15),
	IN `proce` INT,
	IN `idAlterar` INT
)
BEGIN
update consulta set cliente=cliente, cpf=cpf, telefone=telefone, hora=hora, dataD=dataD, proce=proce WHERE codConsulta = idAlterar;
END//
DELIMITER ;

-- Copiando estrutura para procedure clinicaestetica.proc_alteraProcedimento
DROP PROCEDURE IF EXISTS `proc_alteraProcedimento`;
DELIMITER //
CREATE PROCEDURE `proc_alteraProcedimento`(
	IN `nome` VARCHAR(200),
	IN `cod` INT
)
BEGIN
update procedimento set nomeProcedimento=nome WHERE codProcedimento = cod;
END//
DELIMITER ;

-- Copiando estrutura para procedure clinicaestetica.proc_apagarConsulta
DROP PROCEDURE IF EXISTS `proc_apagarConsulta`;
DELIMITER //
CREATE PROCEDURE `proc_apagarConsulta`(
	IN `cod` INT
)
BEGIN
delete from consulta where codConsulta = cod;
END//
DELIMITER ;

-- Copiando estrutura para procedure clinicaestetica.proc_apagarProcedimento
DROP PROCEDURE IF EXISTS `proc_apagarProcedimento`;
DELIMITER //
CREATE PROCEDURE `proc_apagarProcedimento`(
	IN `cod` INT
)
BEGIN
delete from procedimento where codProcedimento = cod;
END//
DELIMITER ;

-- Copiando estrutura para procedure clinicaestetica.proc_insereConsulta
DROP PROCEDURE IF EXISTS `proc_insereConsulta`;
DELIMITER //
CREATE PROCEDURE `proc_insereConsulta`(
	IN `cliente` VARCHAR(200),
	IN `cpf` VARCHAR(20),
	IN `telefone` VARCHAR(20),
	IN `hora` VARCHAR(15),
	IN `dataD` VARCHAR(15),
	IN `proce` INT
)
BEGIN
insert into consulta(cliente, cpf, telefone, hora, dataD, proce) values (cliente, cpf, telefone, hora, dataD, proce);
END//
DELIMITER ;

-- Copiando estrutura para procedure clinicaestetica.proc_insereProcedimento
DROP PROCEDURE IF EXISTS `proc_insereProcedimento`;
DELIMITER //
CREATE PROCEDURE `proc_insereProcedimento`(IN `nomeProcedimento` VARCHAR(200))
BEGIN
insert into procedimento(nomeProcedimento) values (nomeProcedimento);
END//
DELIMITER ;

-- Copiando estrutura para tabela clinicaestetica.usuarios
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `idusuarios` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `senha` varchar(100) NOT NULL,
  PRIMARY KEY (`idusuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela clinicaestetica.usuarios: ~2 rows (aproximadamente)
INSERT INTO `usuarios` (`idusuarios`, `nome`, `senha`) VALUES
	(3, 'adm', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
	(4, 'emily@gmail.com', '6d56b4401b8919219a66510271f9be248016d573a4b2a0306be24ed6073c258a');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
