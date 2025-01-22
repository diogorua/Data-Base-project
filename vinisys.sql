-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 22-Dez-2024 às 17:24
-- Versão do servidor: 10.4.32-MariaDB
-- versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `vinsyspt2`
--

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `P1_novaParticipacaoERemuneracaoTotal` (IN `p_trabalhador_id` INT, IN `p_colheita_id` INT, OUT `remuneracao_total` INT)   BEGIN 
    IF EXISTS (SELECT 1 FROM colheita WHERE COLHEITA_ID = p_colheita_id) THEN 
        INSERT INTO participa (COLHEITA_ID, TRABALHADOR_COLABORADOR_numero)  
        VALUES (p_colheita_id, p_trabalhador_id); 
 
        SELECT SUM(remuneracao) 
        INTO remuneracao_total 
        FROM participa 
        WHERE TRABALHADOR_COLABORADOR_numero = p_trabalhador_id; 
    ELSE 
        SET remuneracao_total = NULL; 
    END IF; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `P2_novaColheita` (IN `p_produtor_id` INTEGER, IN `p_regiao_id` INTEGER)   BEGIN 
DECLARE p_colheita_id integer; 
    SELECT IFNULL(MAX(COLHEITA_ID), 1) INTO p_colheita_id FROM colheita; 
IF EXISTS(SELECT 1 FROM produtor WHERE PRODUTOR_ID = p_produtor_id) AND EXISTS(SELECT 1 FROM regiao WHERE REGIAO_ID = p_regiao_id) THEN 
    	INSERT INTO colheita(REGIAO_ID, PRODUTOR_ID, COLHEITA_ID) VALUES (p_regiao_id, p_produtor_id, p_colheita_id); 
END IF; 
END$$

--
-- Funções
--
CREATE DEFINER=`root`@`localhost` FUNCTION `F1_total_horas_trabalhadas` (`p_colheita_id` INT(11)) RETURNS INT(11)  BEGIN 
    DECLARE total_horas INT(11); 
     
    SELECT SUM(horas)  
    INTO total_horas 
    FROM participa p 
    WHERE COLHEITA_ID = p_colheita_id; 
     
    IF total_horas IS NULL THEN 
    	SET total_horas = 0;  
    END IF; 
     
    RETURN total_horas; 
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `F2_area_total_cultivada` (`p_casta_id ` INT) RETURNS INT(11)  BEGIN 
DECLARE area_total INT(11); 
     
    SELECT SUM(produz.area_cultivada)  
    INTO area_total 
    FROM produz p 
    WHERE produz.CASTA_ID = p_casta_id; 
     
    IF area_total IS NULL THEN 
    	SET area_total = 0;  
    END IF; 
     
    RETURN (area_total); 
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `acompanha`
--

CREATE TABLE `acompanha` (
  `COLHEITA_ID` int(11) NOT NULL,
  `ENOLOGO_COLABORADOR_numero` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `casta`
--

CREATE TABLE `casta` (
  `CASTA_ID` int(11) NOT NULL,
  `tipo_uva` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `casta`
--

INSERT INTO `casta` (`CASTA_ID`, `tipo_uva`) VALUES
(3, 'Touriga Nacional'),
(4, 'Arinto');

-- --------------------------------------------------------

--
-- Estrutura da tabela `cliente`
--

CREATE TABLE `cliente` (
  `numero_cliente` int(11) NOT NULL,
  `nome_cliente` varchar(100) DEFAULT NULL,
  `tipo` varchar(30) DEFAULT NULL,
  `nif` char(9) DEFAULT NULL,
  `morada` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `cliente`
--

INSERT INTO `cliente` (`numero_cliente`, `nome_cliente`, `tipo`, `nif`, `morada`) VALUES
(1, 'José Oliveira', 'Particular', '123456789', 'Rua das Vinhas'),
(2, 'Adega Central', 'Empresa', '987654321', 'Avenida do Vinho');

-- --------------------------------------------------------

--
-- Estrutura da tabela `colaborador`
--

CREATE TABLE `colaborador` (
  `numero` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `colaborador`
--

INSERT INTO `colaborador` (`numero`, `nome`) VALUES
(1, 'João Silva'),
(2, 'Maria Fernandes');

-- --------------------------------------------------------

--
-- Estrutura da tabela `colheita`
--

CREATE TABLE `colheita` (
  `REGIAO_ID` int(11) NOT NULL,
  `PRODUTOR_ID` int(11) NOT NULL,
  `COLHEITA_ID` int(11) NOT NULL,
  `ano` int(11) DEFAULT NULL,
  `data_inicio` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `colheita`
--

INSERT INTO `colheita` (`REGIAO_ID`, `PRODUTOR_ID`, `COLHEITA_ID`, `ano`, `data_inicio`, `data_fim`, `quantidade`) VALUES
(1, 1, 1, 2023, '2024-12-22', NULL, NULL),
(2, 2, 2, 2024, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `contem`
--

CREATE TABLE `contem` (
  `CASTA_ID` int(11) NOT NULL,
  `EDICAO_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `contem`
--

INSERT INTO `contem` (`CASTA_ID`, `EDICAO_ID`) VALUES
(3, 1),
(4, 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `devolucao`
--

CREATE TABLE `devolucao` (
  `CLIENTE_numero_cliente` int(11) NOT NULL,
  `FATURA_num_fatura` int(11) NOT NULL,
  `DEVOLUCAO_ID` int(11) NOT NULL,
  `data_devol` date DEFAULT NULL,
  `montante` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `devolucao`
--

INSERT INTO `devolucao` (`CLIENTE_numero_cliente`, `FATURA_num_fatura`, `DEVOLUCAO_ID`, `data_devol`, `montante`) VALUES
(1, 1, 1, '2024-01-10', 100);

-- --------------------------------------------------------

--
-- Estrutura da tabela `devolvido`
--

CREATE TABLE `devolvido` (
  `VINHO_ID` int(11) NOT NULL,
  `DEVOLUCAO_ID` int(11) NOT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `preco` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `devolvido`
--

INSERT INTO `devolvido` (`VINHO_ID`, `DEVOLUCAO_ID`, `quantidade`, `preco`) VALUES
(1, 1, 2, 50);

-- --------------------------------------------------------

--
-- Estrutura da tabela `edicao`
--

CREATE TABLE `edicao` (
  `VINHO_ID` int(11) NOT NULL,
  `EDICAO_ID` int(11) NOT NULL,
  `ano` int(11) DEFAULT NULL,
  `tipo` varchar(30) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `edicao`
--

INSERT INTO `edicao` (`VINHO_ID`, `EDICAO_ID`, `ano`, `tipo`, `volume`) VALUES
(1, 1, 2023, '750ml', 750),
(2, 2, 2023, '500ml', 500);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `empresas_maiores_compras`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `empresas_maiores_compras` (
`numero_empresa` int(11)
,`nome_empresa` varchar(100)
,`nif_empresa` char(9)
,`morada_empresa` varchar(100)
,`numero_total_faturas` bigint(21)
,`volume_compras` double
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `enologo`
--

CREATE TABLE `enologo` (
  `COLABORADOR_numero` int(11) NOT NULL,
  `especializacao` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `fatura`
--

CREATE TABLE `fatura` (
  `CLIENTE_numero_cliente` int(11) NOT NULL,
  `num_fatura` int(11) NOT NULL,
  `data_fatura` date DEFAULT NULL,
  `valor_total` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `fatura`
--

INSERT INTO `fatura` (`CLIENTE_numero_cliente`, `num_fatura`, `data_fatura`, `valor_total`) VALUES
(1, 1, '2024-01-01', 500),
(2, 2, '2024-01-02', 250);

-- --------------------------------------------------------

--
-- Estrutura da tabela `ganha`
--

CREATE TABLE `ganha` (
  `EDICAO_ID` int(11) NOT NULL,
  `PREMIO_ID` int(11) NOT NULL,
  `data_distincao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `ganha`
--

INSERT INTO `ganha` (`EDICAO_ID`, `PREMIO_ID`, `data_distincao`) VALUES
(1, 1, '2023-12-01'),
(2, 2, '2023-12-02');

-- --------------------------------------------------------

--
-- Estrutura da tabela `incide`
--

CREATE TABLE `incide` (
  `COLHEITA_ID` int(11) NOT NULL,
  `VINHA_codigo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `incide`
--

INSERT INTO `incide` (`COLHEITA_ID`, `VINHA_codigo`) VALUES
(1, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `item`
--

CREATE TABLE `item` (
  `VINHO_ID` int(11) NOT NULL,
  `FATURA_num_fatura` int(11) NOT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `preco` double DEFAULT NULL,
  `dimensao` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `item`
--

INSERT INTO `item` (`VINHO_ID`, `FATURA_num_fatura`, `quantidade`, `preco`, `dimensao`) VALUES
(1, 1, 10, 50, '0,750'),
(2, 2, 5, 50, '0,500');

-- --------------------------------------------------------

--
-- Estrutura da tabela `participa`
--

CREATE TABLE `participa` (
  `COLHEITA_ID` int(11) NOT NULL,
  `TRABALHADOR_COLABORADOR_numero` int(11) NOT NULL,
  `horas` int(11) DEFAULT NULL,
  `remuneracao` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `participa`
--

INSERT INTO `participa` (`COLHEITA_ID`, `TRABALHADOR_COLABORADOR_numero`, `horas`, `remuneracao`) VALUES
(1, 1, 5, NULL);

--
-- Acionadores `participa`
--
DELIMITER $$
CREATE TRIGGER `T2_regista_data_inicio` BEFORE INSERT ON `participa` FOR EACH ROW BEGIN 
    DECLARE data_existente DATE; 
  
    SELECT data_inicio INTO data_existente 
    FROM COLHEITA 
    WHERE COLHEITA_ID = NEW.COLHEITA_ID; 
  
    IF data_existente IS NULL THEN 
        UPDATE COLHEITA 
        SET data_inicio = CURDATE() 
        WHERE COLHEITA_ID = NEW.COLHEITA_ID; 
    END IF; 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `premio`
--

CREATE TABLE `premio` (
  `PREMIO_ID` int(11) NOT NULL,
  `nome_distincao` varchar(30) DEFAULT NULL,
  `entidade` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `premio`
--

INSERT INTO `premio` (`PREMIO_ID`, `nome_distincao`, `entidade`) VALUES
(1, 'Melhor Vinho Tinto', 'Concurso Nacional'),
(2, 'Melhor Vinho Branco', 'Concurso Internacional');

-- --------------------------------------------------------

--
-- Estrutura da tabela `produtor`
--

CREATE TABLE `produtor` (
  `REGIAO_ID` int(11) NOT NULL,
  `PRODUTOR_ID` int(11) NOT NULL,
  `nome_vinicola` varchar(100) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `morada` varchar(100) DEFAULT NULL,
  `codigo_postal` char(8) DEFAULT NULL,
  `telefone` char(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `produtor`
--

INSERT INTO `produtor` (`REGIAO_ID`, `PRODUTOR_ID`, `nome_vinicola`, `email`, `morada`, `codigo_postal`, `telefone`) VALUES
(1, 1, 'Adega Douro', 'contact@adegadouro.com', 'Rua do Vinho', '1234-567', '912345678'),
(2, 2, 'Adega Alentejo', 'info@adegaalentejo.com', 'Estrada do Vinho', '7654-321', '987654321');

-- --------------------------------------------------------

--
-- Estrutura da tabela `produz`
--

CREATE TABLE `produz` (
  `VINHA_codigo` int(11) NOT NULL,
  `CASTA_ID` int(11) NOT NULL,
  `area_cultivada` int(11) DEFAULT NULL,
  `data_plantacao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `produz`
--

INSERT INTO `produz` (`VINHA_codigo`, `CASTA_ID`, `area_cultivada`, `data_plantacao`) VALUES
(1, 3, 100, '2010-03-15'),
(2, 4, 150, '2012-05-20');

--
-- Acionadores `produz`
--
DELIMITER $$
CREATE TRIGGER `T1_atualiza_area_cultivada_produz` BEFORE UPDATE ON `produz` FOR EACH ROW BEGIN 
    SET NEW.area_cultivada = OLD.area_cultivada + NEW.area_cultivada; 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `regiao`
--

CREATE TABLE `regiao` (
  `REGIAO_ID` int(11) NOT NULL,
  `denominacao` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `regiao`
--

INSERT INTO `regiao` (`REGIAO_ID`, `denominacao`) VALUES
(1, 'Douro'),
(2, 'Alentejo');

-- --------------------------------------------------------

--
-- Estrutura da tabela `trabalha`
--

CREATE TABLE `trabalha` (
  `PRODUTOR_ID` int(11) NOT NULL,
  `COLABORADOR_numero` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `trabalhador`
--

CREATE TABLE `trabalhador` (
  `TRABALHADOR_COLABORADOR_numero` int(11) DEFAULT NULL,
  `COLABORADOR_numero` int(11) NOT NULL,
  `funcao` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `trabalhador`
--

INSERT INTO `trabalhador` (`TRABALHADOR_COLABORADOR_numero`, `COLABORADOR_numero`, `funcao`) VALUES
(1, 1, 'Viticultor'),
(2, 2, 'Enólogo');

-- --------------------------------------------------------

--
-- Estrutura da tabela `vinha`
--

CREATE TABLE `vinha` (
  `codigo` int(11) NOT NULL,
  `nome_vinha` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `vinha`
--

INSERT INTO `vinha` (`codigo`, `nome_vinha`) VALUES
(1, 'Vinha Velha'),
(2, 'Vinha Nova');

-- --------------------------------------------------------

--
-- Estrutura da tabela `vinho`
--

CREATE TABLE `vinho` (
  `REGIAO_ID` int(11) NOT NULL,
  `PRODUTOR_ID` int(11) NOT NULL,
  `VINHO_ID` int(11) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `data_engarraf` date DEFAULT NULL,
  `teor_alcoolico` float DEFAULT NULL,
  `tipo` varchar(30) DEFAULT NULL,
  `classificacao` varchar(30) DEFAULT NULL,
  `aroma` varchar(30) DEFAULT NULL,
  `sabor` varchar(30) DEFAULT NULL,
  `cor` varchar(30) DEFAULT NULL,
  `stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `vinho`
--

INSERT INTO `vinho` (`REGIAO_ID`, `PRODUTOR_ID`, `VINHO_ID`, `nome`, `data_engarraf`, `teor_alcoolico`, `tipo`, `classificacao`, `aroma`, `sabor`, `cor`, `stock`) VALUES
(1, 1, 1, 'Vinho Douro Reserva', '2023-05-10', 13.5, 'Tinto', 'Reserva', 'Frutado', 'Intenso', 'Rubi', 1000),
(2, 2, 2, 'Vinho Alentejo Premium', '2023-06-15', 12, 'Branco', 'Premium', 'Floral', 'Leve', 'Dourado', 500);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `vinhos_produtores`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `vinhos_produtores` (
`nome_produtor` varchar(100)
,`nome_vinho` varchar(50)
,`tipo_vinho` varchar(30)
,`teor_alcoolico_vinho` float
,`regiao_vinho` varchar(50)
,`ano_edicao` int(11)
);

-- --------------------------------------------------------

--
-- Estrutura para vista `empresas_maiores_compras`
--
DROP TABLE IF EXISTS `empresas_maiores_compras`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `empresas_maiores_compras`  AS SELECT `c`.`numero_cliente` AS `numero_empresa`, `c`.`nome_cliente` AS `nome_empresa`, `c`.`nif` AS `nif_empresa`, `c`.`morada` AS `morada_empresa`, count(distinct `f`.`num_fatura`) AS `numero_total_faturas`, sum(ifnull(`i`.`quantidade` * `i`.`preco`,0)) AS `volume_compras` FROM ((`cliente` `c` left join `fatura` `f` on(`c`.`numero_cliente` = `f`.`CLIENTE_numero_cliente`)) left join `item` `i` on(`f`.`num_fatura` = `i`.`FATURA_num_fatura`)) WHERE `c`.`tipo` = 'Empresa' GROUP BY `c`.`numero_cliente`, `c`.`nome_cliente`, `c`.`nif`, `c`.`morada` ORDER BY sum(ifnull(`i`.`quantidade` * `i`.`preco`,0)) DESC ;

-- --------------------------------------------------------

--
-- Estrutura para vista `vinhos_produtores`
--
DROP TABLE IF EXISTS `vinhos_produtores`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vinhos_produtores`  AS SELECT `p`.`nome_vinicola` AS `nome_produtor`, `vinho`.`nome` AS `nome_vinho`, `vinho`.`tipo` AS `tipo_vinho`, `vinho`.`teor_alcoolico` AS `teor_alcoolico_vinho`, `regiao`.`denominacao` AS `regiao_vinho`, `edicao`.`ano` AS `ano_edicao` FROM (((`produtor` `p` join `vinho` on(`p`.`PRODUTOR_ID` = `vinho`.`PRODUTOR_ID`)) join `regiao` on(`vinho`.`REGIAO_ID` = `regiao`.`REGIAO_ID`)) join `edicao` on(`vinho`.`VINHO_ID` = `edicao`.`VINHO_ID`)) ;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `acompanha`
--
ALTER TABLE `acompanha`
  ADD PRIMARY KEY (`COLHEITA_ID`,`ENOLOGO_COLABORADOR_numero`),
  ADD KEY `FK_ENOLOGO_ACOMPANHA_COLHEITA` (`ENOLOGO_COLABORADOR_numero`);

--
-- Índices para tabela `casta`
--
ALTER TABLE `casta`
  ADD PRIMARY KEY (`CASTA_ID`);

--
-- Índices para tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`numero_cliente`);

--
-- Índices para tabela `colaborador`
--
ALTER TABLE `colaborador`
  ADD PRIMARY KEY (`numero`);

--
-- Índices para tabela `colheita`
--
ALTER TABLE `colheita`
  ADD PRIMARY KEY (`COLHEITA_ID`),
  ADD KEY `FK_COLHEITA_pertence_REGIAO` (`REGIAO_ID`),
  ADD KEY `FK_COLHEITA_destinada_PRODUTOR` (`PRODUTOR_ID`);

--
-- Índices para tabela `contem`
--
ALTER TABLE `contem`
  ADD PRIMARY KEY (`CASTA_ID`,`EDICAO_ID`),
  ADD KEY `FK_EDICAO_CONTEM_CASTA` (`EDICAO_ID`);

--
-- Índices para tabela `devolucao`
--
ALTER TABLE `devolucao`
  ADD PRIMARY KEY (`DEVOLUCAO_ID`),
  ADD KEY `FK_DEVOLUCAO_realiza_CLIENTE` (`CLIENTE_numero_cliente`),
  ADD KEY `FK_DEVOLUCAO_origina_FATURA` (`FATURA_num_fatura`);

--
-- Índices para tabela `devolvido`
--
ALTER TABLE `devolvido`
  ADD PRIMARY KEY (`VINHO_ID`,`DEVOLUCAO_ID`),
  ADD KEY `FK_DEVOLUCAO_DEVOLVIDO_VINHO` (`DEVOLUCAO_ID`);

--
-- Índices para tabela `edicao`
--
ALTER TABLE `edicao`
  ADD PRIMARY KEY (`EDICAO_ID`),
  ADD KEY `FK_EDICAO_tem_VINHO` (`VINHO_ID`);

--
-- Índices para tabela `enologo`
--
ALTER TABLE `enologo`
  ADD PRIMARY KEY (`COLABORADOR_numero`);

--
-- Índices para tabela `fatura`
--
ALTER TABLE `fatura`
  ADD PRIMARY KEY (`num_fatura`),
  ADD KEY `FK_FATURA_emitida_CLIENTE` (`CLIENTE_numero_cliente`);

--
-- Índices para tabela `ganha`
--
ALTER TABLE `ganha`
  ADD PRIMARY KEY (`EDICAO_ID`,`PREMIO_ID`),
  ADD KEY `FK_PREMIO_GANHA_EDICAO` (`PREMIO_ID`);

--
-- Índices para tabela `incide`
--
ALTER TABLE `incide`
  ADD PRIMARY KEY (`COLHEITA_ID`,`VINHA_codigo`),
  ADD KEY `FK_VINHA_INCIDE_COLHEITA` (`VINHA_codigo`);

--
-- Índices para tabela `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`VINHO_ID`,`FATURA_num_fatura`),
  ADD KEY `FK_ITEM_noname_FATURA` (`FATURA_num_fatura`);

--
-- Índices para tabela `participa`
--
ALTER TABLE `participa`
  ADD PRIMARY KEY (`COLHEITA_ID`,`TRABALHADOR_COLABORADOR_numero`),
  ADD KEY `FK_TRABALHADOR_PARTICIPA_COLHEITA` (`TRABALHADOR_COLABORADOR_numero`);

--
-- Índices para tabela `premio`
--
ALTER TABLE `premio`
  ADD PRIMARY KEY (`PREMIO_ID`);

--
-- Índices para tabela `produtor`
--
ALTER TABLE `produtor`
  ADD PRIMARY KEY (`PRODUTOR_ID`),
  ADD KEY `FK_PRODUTOR_tem_REGIAO` (`REGIAO_ID`);

--
-- Índices para tabela `produz`
--
ALTER TABLE `produz`
  ADD PRIMARY KEY (`VINHA_codigo`,`CASTA_ID`),
  ADD KEY `FK_CASTA_PRODUZ_VINHA` (`CASTA_ID`);

--
-- Índices para tabela `regiao`
--
ALTER TABLE `regiao`
  ADD PRIMARY KEY (`REGIAO_ID`);

--
-- Índices para tabela `trabalha`
--
ALTER TABLE `trabalha`
  ADD PRIMARY KEY (`PRODUTOR_ID`,`COLABORADOR_numero`),
  ADD KEY `FK_COLABORADOR_TRABALHA_PRODUTOR` (`COLABORADOR_numero`);

--
-- Índices para tabela `trabalhador`
--
ALTER TABLE `trabalhador`
  ADD PRIMARY KEY (`COLABORADOR_numero`),
  ADD KEY `FK_TRABALHADOR_chefia_TRABALHADOR` (`TRABALHADOR_COLABORADOR_numero`);

--
-- Índices para tabela `vinha`
--
ALTER TABLE `vinha`
  ADD PRIMARY KEY (`codigo`);

--
-- Índices para tabela `vinho`
--
ALTER TABLE `vinho`
  ADD PRIMARY KEY (`VINHO_ID`),
  ADD KEY `FK_VINHO_associado_REGIAO` (`REGIAO_ID`),
  ADD KEY `FK_VINHO_produzido_PRODUTOR` (`PRODUTOR_ID`);

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `acompanha`
--
ALTER TABLE `acompanha`
  ADD CONSTRAINT `FK_COLHEITA_ACOMPANHA_ENOLOGO` FOREIGN KEY (`COLHEITA_ID`) REFERENCES `colheita` (`COLHEITA_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ENOLOGO_ACOMPANHA_COLHEITA` FOREIGN KEY (`ENOLOGO_COLABORADOR_numero`) REFERENCES `enologo` (`COLABORADOR_numero`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `colheita`
--
ALTER TABLE `colheita`
  ADD CONSTRAINT `FK_COLHEITA_destinada_PRODUTOR` FOREIGN KEY (`PRODUTOR_ID`) REFERENCES `produtor` (`PRODUTOR_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_COLHEITA_pertence_REGIAO` FOREIGN KEY (`REGIAO_ID`) REFERENCES `regiao` (`REGIAO_ID`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `contem`
--
ALTER TABLE `contem`
  ADD CONSTRAINT `FK_CASTA_CONTEM_EDICAO` FOREIGN KEY (`CASTA_ID`) REFERENCES `casta` (`CASTA_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EDICAO_CONTEM_CASTA` FOREIGN KEY (`EDICAO_ID`) REFERENCES `edicao` (`EDICAO_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `devolucao`
--
ALTER TABLE `devolucao`
  ADD CONSTRAINT `FK_DEVOLUCAO_origina_FATURA` FOREIGN KEY (`FATURA_num_fatura`) REFERENCES `fatura` (`num_fatura`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_DEVOLUCAO_realiza_CLIENTE` FOREIGN KEY (`CLIENTE_numero_cliente`) REFERENCES `cliente` (`numero_cliente`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `devolvido`
--
ALTER TABLE `devolvido`
  ADD CONSTRAINT `FK_DEVOLUCAO_DEVOLVIDO_VINHO` FOREIGN KEY (`DEVOLUCAO_ID`) REFERENCES `devolucao` (`DEVOLUCAO_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_VINHO_DEVOLVIDO_DEVOLUCAO_` FOREIGN KEY (`VINHO_ID`) REFERENCES `vinho` (`VINHO_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `edicao`
--
ALTER TABLE `edicao`
  ADD CONSTRAINT `FK_EDICAO_tem_VINHO` FOREIGN KEY (`VINHO_ID`) REFERENCES `vinho` (`VINHO_ID`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `enologo`
--
ALTER TABLE `enologo`
  ADD CONSTRAINT `FK_ENOLOGO_COLABORADOR` FOREIGN KEY (`COLABORADOR_numero`) REFERENCES `colaborador` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `fatura`
--
ALTER TABLE `fatura`
  ADD CONSTRAINT `FK_FATURA_emitida_CLIENTE` FOREIGN KEY (`CLIENTE_numero_cliente`) REFERENCES `cliente` (`numero_cliente`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `ganha`
--
ALTER TABLE `ganha`
  ADD CONSTRAINT `FK_EDICAO_GANHA_PREMIO` FOREIGN KEY (`EDICAO_ID`) REFERENCES `edicao` (`EDICAO_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PREMIO_GANHA_EDICAO` FOREIGN KEY (`PREMIO_ID`) REFERENCES `premio` (`PREMIO_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `incide`
--
ALTER TABLE `incide`
  ADD CONSTRAINT `FK_COLHEITA_INCIDE_VINHA` FOREIGN KEY (`COLHEITA_ID`) REFERENCES `colheita` (`COLHEITA_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_VINHA_INCIDE_COLHEITA` FOREIGN KEY (`VINHA_codigo`) REFERENCES `vinha` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `FK_FATURA_ITEM_VINHO` FOREIGN KEY (`FATURA_num_fatura`) REFERENCES `fatura` (`num_fatura`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ITEM_noname_FATURA` FOREIGN KEY (`FATURA_num_fatura`) REFERENCES `fatura` (`num_fatura`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ITEM_representa_VINHO` FOREIGN KEY (`VINHO_ID`) REFERENCES `vinho` (`VINHO_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_VINHO_ITEM_FATURA` FOREIGN KEY (`VINHO_ID`) REFERENCES `vinho` (`VINHO_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `participa`
--
ALTER TABLE `participa`
  ADD CONSTRAINT `FK_COLHEITA_PARTICIPA_TRABALHADOR` FOREIGN KEY (`COLHEITA_ID`) REFERENCES `colheita` (`COLHEITA_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_TRABALHADOR_PARTICIPA_COLHEITA` FOREIGN KEY (`TRABALHADOR_COLABORADOR_numero`) REFERENCES `trabalhador` (`COLABORADOR_numero`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `produtor`
--
ALTER TABLE `produtor`
  ADD CONSTRAINT `FK_PRODUTOR_tem_REGIAO` FOREIGN KEY (`REGIAO_ID`) REFERENCES `regiao` (`REGIAO_ID`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `produz`
--
ALTER TABLE `produz`
  ADD CONSTRAINT `FK_CASTA_PRODUZ_VINHA` FOREIGN KEY (`CASTA_ID`) REFERENCES `casta` (`CASTA_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_VINHA_PRODUZ_CASTA` FOREIGN KEY (`VINHA_codigo`) REFERENCES `vinha` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `trabalha`
--
ALTER TABLE `trabalha`
  ADD CONSTRAINT `FK_COLABORADOR_TRABALHA_PRODUTOR` FOREIGN KEY (`COLABORADOR_numero`) REFERENCES `colaborador` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PRODUTOR_TRABALHA_COLABORADOR` FOREIGN KEY (`PRODUTOR_ID`) REFERENCES `produtor` (`PRODUTOR_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `trabalhador`
--
ALTER TABLE `trabalhador`
  ADD CONSTRAINT `FK_TRABALHADOR_COLABORADOR` FOREIGN KEY (`COLABORADOR_numero`) REFERENCES `colaborador` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_TRABALHADOR_chefia_TRABALHADOR` FOREIGN KEY (`TRABALHADOR_COLABORADOR_numero`) REFERENCES `trabalhador` (`COLABORADOR_numero`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Limitadores para a tabela `vinho`
--
ALTER TABLE `vinho`
  ADD CONSTRAINT `FK_VINHO_associado_REGIAO` FOREIGN KEY (`REGIAO_ID`) REFERENCES `regiao` (`REGIAO_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_VINHO_produzido_PRODUTOR` FOREIGN KEY (`PRODUTOR_ID`) REFERENCES `produtor` (`PRODUTOR_ID`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
