
-- BADC5, IFSP-PRC, 2022 (1s)
-- Jefferson Roberto Piaia Martines
-- Lucas Brancatti Pasqualetto
-- Leandro Mendonca Rodini Henares
-- Thomas Dechen Ferreira
-- Thomas Rodrigues Martins Pereira

-- Instrucoes basicas:
-- Nomear o script como GrupoX.sql (onde X e' tema do grupo)
-- Seguir rigorosamente a sintaxe do PostgreSQL
-- Este script precisa ser escrito de modo que possa ser executado completamente sem apresentar erros

-- ----------------------------

-- [1] ESQUEMAS
-- Criacao de pelo menos 1 esquema
-- Nesse(s) esquema(s) serao criados: tabelas, visoes, funcoes, procedimentos, gatilhos, sequencias etc (vide secoes seguintes)


CREATE SCHEMA tb;
CREATE SCHEMA vw;
-- ----------------------------
-- [2] TABELAS
-- Criacao das tabelas e de suas restricoes (chaves primarias, unicidades, valores padrao, checagem e nao nulos)
-- Pelo menos 1 UNIQUE, 1 DEFAULT, 1 CHECK
-- Definicao das chaves estrangeiras das tabelas com acoes referenciais engatilhadas
-- As restricoes criadas com ALTER TABLE devem aparecer logo apos a tabela correspondente

-- Por exemplo (desconsiderando os comentarios '--'):
--CREATE TABLE esquema.nometabela1(
-- colunas,
-- restricoes
--);
-- ALTER TABLE esquema.nometabela1 ADD CONSTRAINT...


CREATE TABLE tb.veterinario(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(60),
	cpf VARCHAR(15) UNIQUE,
	registro VARCHAR(15) UNIQUE,
   	dataDeNasc DATE,
	logradouro VARCHAR(100),
	numero INT,
	telefone VARCHAR(14),
	email VARCHAR(320),
	salario FLOAT CHECK (salario >= 1200),
	vetChefe BOOLEAN DEFAULT false,
	quantConsulta INT NOT NULL,
	valorConsulta INT NOT NULL
);

CREATE TABLE tb.tutor(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(60),
	cpf VARCHAR(15) UNIQUE,
	dataDeNasc DATE,
	logradouro VARCHAR(100),
	numero INT,
	telefone VARCHAR(14),
	email VARCHAR(60)
);

CREATE TABLE tb.animal(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(60),
	raca VARCHAR(20),
	dataDeNasc DATE,
	idTutor INT
);

CREATE TABLE tb.agendamento(
	id SERIAL PRIMARY KEY,
	data DATE NOT NULL, -- CHECK (data >= CURRENT_DATE)
	hora time NOT NULL,
	idVet INT,
	idTutor INT,
	idAnimal INT
);

ALTER TABLE tb.animal
ADD FOREIGN KEY (idTutor) REFERENCES tb.tutor(id)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE tb.agendamento
ADD FOREIGN KEY (idVet) REFERENCES tb.veterinario(id)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE tb.agendamento
ADD FOREIGN KEY (idTutor) REFERENCES tb.tutor(id)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE tb.agendamento
ADD FOREIGN KEY (idAnimal) REFERENCES tb.animal(id)
ON UPDATE CASCADE ON DELETE CASCADE;

-- ----------------------------
-- [3] CARGA DE DADOS
-- 100 tuplas no total e identificar quem fez as insercoes

--veterinario
INSERT INTO tb.veterinario(nome, cpf, registro, dataDeNasc, logradouro, numero, telefone, email, salario, vetChefe, quantConsulta, valorConsulta) 
VALUES ('antonio', '723.327.723-72', 'reg1Aveton3561', '1986-04-12', 'rua martim de sa', 2000, '(19)99852-3551', 'antoniovet@gmail.com', 1200, true, 0, 100);

INSERT INTO tb.veterinario(nome, cpf, registro, dataDeNasc, logradouro, numero, telefone, email, salario, quantConsulta, valorConsulta) 
VALUES ('flavia', '521.458.756-32', 'reg2Aveton54786', '1992-12-22', 'rua sao jose', 532, '(19)99752-6637', 'flaviavet@gmail.com', 1200, 13, 100);

INSERT INTO tb.veterinario(nome, cpf, registro, dataDeNasc, logradouro, numero, telefone, email, salario, quantConsulta, valorConsulta) 
VALUES ('luma', '542.658.321-02', 'reg3Aveton87452', '2000-06-06', 'rua boa morte', 1520, '(19)99903-0502', 'lumavet@gmail.com', 1200, 0, 100);

--tutor
INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('thomas', '513.848.245-70', '2001-03-11', 'av. independencia', 244, '(91)96874-3538', 'thomas@gmail.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('jefferson', '463.979.720-62', '2001-05-18', 'av. rio das pedras', 245, '(43)99238-4282', 'mliano1440@eatneha.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('tiago', '699.300.330-92', '2002-08-22', 'av. jardim', 246, '(83)98076-7661', 'breezeless@ucyeh.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email)  
VALUES ('pedro', '853.144.750-06', '2001-07-16', 'av. europa', 247, '(97)99852-4710', '3may@brucewaynesells.ga');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('ana', '429.948.000-71', '2000-08-18', 'av. oriente', 248, '(84)98815-4755', 'satar@lompikachi.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('lucia', '724.294.170-90', '2000-12-12', 'av. viola', 249, '(69)98169-4147', 'catledyx@bedul.net');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('maria', '456.725.250-08', '1999-02-25', 'av. alfredo', 250, '(79)98898-9454', 'alenkina2000@bogsmail.me');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email)  
VALUES ('matheus', '910.076.920-73', '1998-03-16', 'av. alberto', 251, '(96)97960-7359', 'dashovadasha@playfunplus.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('thalita', '955.040.060-31', '1997-04-27', 'av. vollet', 252, '(69)98596-7718', 'svetkaluga@roadbike.ga');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('paula', '120.705.240-00', '1990-01-29', 'av. sachs', 253, '(68)98075-5472', 'paula150692@wpdork.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('roberto', '951.026.930-18', '1998-09-07', 'av. mirante', 254, '(83)98605-2509', '03xoms@wpdork.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('albert', '965.015.750-60', '1995-07-26', 'av. industria', 255, '(66)96765-3340', 'arkasha94judo@omdiaco.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('natanael', '731.110.770-98', '2000-09-11', 'av. cana de acucar', 256, '(63)98370-2968', 'natethegreat@kangsohang.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('katia', '499.293.470-62', '1994-08-15', 'av. leontino', 257, '(74)99597-7225', 'ciaradatnig@aiuepd.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('valentina', '870.230.210-19', '2002-04-08', 'av. paz', 258, '(82)98481-9443', 'ayupovavalentina@machinetest.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email)  
VALUES ('valeria', '865.292.560-75', '1992-07-04', 'av. liberdade', 259, '(63)99186-7964', 'bazhanovvalera@masjoco.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('marcio', '208.513.710-51', '2001-09-12', 'av. boa morte', 260, '(68)99651-2761', 'vikkaming@fnaul.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('andre', '908.636.250-88', '1999-11-08', 'av. beira mar', 261, '(71)99448-2476', 'fasted18@bedulsenpai.net');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('carlos', '598.382.850-99', '1997-02-05', 'av. pescador', 262, '(86)98005-0885', 'niceguy5f167@hdetsun.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email)  
VALUES ('carla', '749.246.110-00', '1999-06-19', 'av. gloria', 263, '(47)96826-9835', 'mishkara@email-temp.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('diego', '940.513.800-68', '2005-12-22', 'av. lar', 264, '(84)98705-4995', 'antpoc@janurganteng.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('patricia', '294.033.130-80', '2001-08-17', 'av. alpíste', 265, '(82)98115-9812', 'blakeja@massagefin.club');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('jose', '228.983.270-77', '1996-04-03', 'av. praca nossa', 266, '(98)98568-6306', 'joseribeiro@kongshuon.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('cINTia', '950.491.040-84', '1994-01-24', 'av. dolores', 267, '(82)98066-3643', 'klingon03@typery.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('rafael', '767.532.470-68', '2003-10-28', 'av. palmares', 268, '(79)98542-3167', 'dancer5200@bogsmail.me');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email)  
VALUES ('christine', '434.077.780-31', '1998-04-14', 'av. gaviao', 269, '(66)98972-3259', 'christine7@ucyeh.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('lucas', '123.321.123-12', '2000-12-04', 'av. conselheiro', 400, '(19)90000-0001', 'lucas@gmail.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('rinaldo', '124.421.124-14', '1968-02-13', 'rua promissao', 1000, '(19)90990-0002', 'rinaldo@gmail.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('christoffer', '153.351.153-15', '1979-08-16', 'rua sao joao', 105, '(19)99020-0401', 'chris@gmail.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('neusa', '922.457.663-04', '1969-07-27', 'rua prudente de morais', 3005, '(19)89523-6352', 'neusa@gmail.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('david', '999.999.999-99', '1961-03-22', 'rua fernando souza costa', 125, '(19)99343-3521', 'david@gmail.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('kallel', '852.258.852-52', '2001-07-25', 'rua regente feijo', 255, '(19)96352-4178', 'kallel@gmail.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('raquel', '744.147.741-41', '1953-06-11', 'rua begonhas', 1002, '(19)99330-0032', 'raquel@gmail.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('mara', '963.369.852-45', '1963-04-18', 'rua joao sampaio', 602, '(19)98745-6321', 'mara@gmail.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('pedro', '111.111.111-22', '2000-06-10', 'rodovia samuel de castro neves', 1037, '(19)91234-5687', 'pedrom@gmail.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('filipi', '222.222.222-33', '2001-03-15', 'rodovia samuel de castro neves', 1037, '(19)96541-2398', 'filipim@gmail.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('selma', '369.852.147-08', '1954-07-21', 'rua da palma', 001, '(19)94528-9761', 'selma@gmail.com');

INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('silvana', '785.587.745-65', '1968-01-17', 'rua professor pedro de mello', 59, '(19)98837-4512', 'silvana@gmail.com');
INSERT INTO tb.tutor(nome, cpf, dataDeNasc, logradouro, numero, telefone, email) 
VALUES ('mohammad', '761.447.245-35', '1974-06-21', 'rua professor pedro ferreira', 229, '(19)98877-5621', 'mohammad@gmail.com');


--animal
INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('bob', 'cachorro', '2020-12-04', 01);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor)  
VALUES ('maradona', 'cachorro', '2020-10-07', 02);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('romario', 'cachorro', '2020-09-15', 03);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor)  
VALUES ('tilapia', 'cachorro', '2019-10-12', 04);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor)  
VALUES ('rodolfo', 'porco', '2017-07-04', 05);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('nemo', 'peixe', '2020-04-18', 06);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('tchu', 'gato', '2016-09-14', 07);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor)  
VALUES ('shurastey', 'cachorro', '2014-02-26', 08);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('wood', 'cachorro', '2018-01-05', 09);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('slinky', 'cachorro', '2017-06-21', 10);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('fred', 'calopsita', '2018-07-09', 11);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor)  
VALUES ('martin', 'peixe', '2016-09-15', 12);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('pit', 'cachorro', '2021-06-14', 13);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor)  
VALUES ('bart', 'cachorro', '2019-06-18', 14);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('bark', 'cachorro', '2018-09-12', 15);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('salada', 'gato', '2016-11-12', 16);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('rob', 'porco', '2019-07-26', 17);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('taz', 'cachorro', '2015-01-09', 18);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor)  
VALUES ('juma', 'gato', '2020-04-28', 19);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor)  
VALUES ('nala', 'gato', '2018-08-13', 20);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('felix', 'peixe', '2020-04-18', 21);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('aslam', 'cachorro', '2015-09-25', 22);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor)  
VALUES ('simba', 'porco', '2016-11-19', 23);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('teo', 'cachorro', '2017-12-12', 24);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('poppy', 'gato', '2020-02-07', 25);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('flip', 'cachorro', '2019-08-13', 26);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('mel', 'gato', '2013-02-01', 27);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('lelo', 'gato', '2020-04-15', 27);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('preta', 'gato', '2009-10-20', 27);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('sidinha', 'gato', '2020-09-14', 27);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('buck', 'cachorro', '2021-04-19', 28);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('rudy', 'cachorro', '2021-04-19', 28);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('ursita', 'cachorro', '2021-11-22', 29);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('marry', 'gato', '2020-12-23', 30);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('lola', 'gato', '2020-09-14', 30);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('princesa', 'cachorro', '2019-05-30', 31);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('pituca', 'cachorro', '2020-01-15', 31);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('jonas', 'tartaruga', '2010-04-15', 32);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('valentina', 'tartaruga', '2011-10-02', 32);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('cacau', 'cachorro', '2015-03-29', 33);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('preta', 'gato', '2017-05-19', 33);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('vitorio', 'gato', '2015-03-29', 33);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('tunico', 'gato', '2006-08-25', 33);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('rebeca', 'cachorro', '2011-06-09', 33);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('nina', 'gato', '2016-01-02', 34);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('will', 'gato', '2016-07-10', 34);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('bili', 'boi', '2020-03-14', 35);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('jhonas', 'boi', '2020-03-14', 35);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('alberto', 'boi', '2020-03-14', 35);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('safira', 'cachorro', '2016-11-19', 36);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('prete', 'cachorro', '2021-03-16', 36);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('juquinha', 'gato', '2015-07-24', 37);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('amora', 'gato', '2017-02-14', 37);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('diego', 'cachorro', '2014-07-04', 37);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('joana', 'calopsita', '2013-09-05', 37);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('eliza', 'calopsita', '2013-09-05', 37);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('safira', 'tartaruga', '2000-03-28', 37);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('julie', 'gato', '2015-06-18', 38);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('rapaiz', 'gato', '2014-10-30', 38);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('jolie', 'cachorro', '2016-02-28', 38);

INSERT INTO tb.animal(nome, raca, dataDeNasc, idTutor) 
VALUES ('pretinha', 'cachorro', '2010-09-02', 38);

--agendamento

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-17', '13:30:00', 01, 01, 01);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-21', '14:00:00', 02, 02, 02);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-16', '13:30:00', 03, 03, 03);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-20', '15:30:00', 03, 11, 11);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-17', '12:30:00', 01, 10, 10);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-30', '16:00:00', 03, 06, 06);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-22', '16:30:00', 02, 05, 05);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-24', '15:30:00', 02, 04, 04);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-17', '17:30:00', 03, 07, 07);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-27', '15:30:00', 03, 08, 08);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-18', '14:00:00', 02, 08, 12);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-18', '14:30:00', 03, 13, 13);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-18', '15:00:00', 01, 14, 14);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-18', '15:30:00', 03, 13, 15);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-18', '16:00:00', 02, 11, 16);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-18', '16:30:00', 03, 15, 17);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-19', '13:00:00', 01, 16, 18);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-19', '13:30:00', 02, 17, 19);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-19', '14:00:00', 01, 16, 20);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-19', '14:30:00', 03, 11, 21);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-19', '15:00:00', 02, 18, 22);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-19', '15:30:00', 01, 19, 23);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-19', '16:00:00', 03, 20, 24);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-19', '16:30:00', 02, 21, 25);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-19', '17:00:00', 01, 18, 26);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-20', '13:00:00', 03, 17, 27);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-20', '13:30:00', 02, 21, 28);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-20', '14:00:00', 01, 22, 29);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-20', '14:30:00', 03, 23, 30);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-20', '15:00:00', 02, 24, 31);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-20', '15:30:00', 01, 25, 32);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-20', '16:00:00', 03, 26, 33);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-20', '16:30:00', 02, 27, 34);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-21', '13:00:00', 01, 28, 35);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-21', '13:30:00', 03, 29, 36);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-21', '14:00:00', 02, 30, 37);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-21', '14:30:00', 01, 30, 38);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-21', '15:00:00', 03, 31, 39);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-21', '15:30:00', 02, 31, 40);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-21', '16:00:00', 01, 32, 41);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-21', '16:30:00', 03, 33, 42);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-22', '13:00:00', 02, 34, 43);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-22', '13:30:00', 01, 34, 44);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-22', '14:00:00', 03, 35, 45);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-22', '14:30:00', 02, 36, 46);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-22', '15:00:00', 01, 37, 47);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-06-22', '15:30:00', 03, 38, 48);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-07-02', '14:00:00', 02, 10, 10);

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-07-03', '13:00:00', 01, 11, 11);

-- -----------------------
-- [4] CONSULTAS
-- Alem do comando SELECT correspondente, fornecer o que se pede

-- [4.1] Listagem
-- Usar juncao(oes) (JOINs), filtro(s) (WHERE), ordenacao (ORDER BY)
-- Enunciado: mostrar ao veterinario os agendamentos de determinado dia
-- Importancia na aplicacao: auxiliar o veterinario sobre o nome do tutor, 
-- o nome do animal e a hora da consulta de determinado dia.
-- Usuario(s) atendido(s): veterinario


SELECT t.nome as nome_tutor,
	a.nome AS nome_animal,
    ag.hora AS horario_de_atendimento
FROM tb.animal a 
INNER JOIN tb.agendamento ag 
ON (a.id = ag.idAnimal)
INNER JOIN tb.tutor t 
ON (t.id = ag.idTutor)
WHERE ag.data = '2022-06-20' AND idVet = 3
ORDER BY ag.hora ASC;


-- [4.2] Relatorio
-- Usar juncao(oes) (JOINs), filtro(s) (WHERE), agrupamento (GROUP BY) e funcao de agregacao (count, sum, avg, etc)
-- Enunciado: mostrar ao veterinario a quantidade de determinado animal agendado em determinado dia.
-- Importancia na aplicacao: auxiliar o veterinario sobre a quantia de um animal a ser atendido em determinado dia.
-- Usuario(s) atendido(s): veterinario

SELECT v.nome AS nome_veterinario, count(a.raca) AS qtd_do_animal_agendado
FROM tb.agendamento ag 
LEFT JOIN tb.animal a on (a.id = idAnimal)
LEFT JOIN tb.veterinario v on (v.id = idVet)
WHERE a.raca = 'gato' AND ag.data = '2022-06-20'
GROUP BY v.nome
ORDER BY v.nome ASC;

-- -------------------------
-- [5] VISOES


-- [5.1] Visao
-- A visao deve ter, no minimo, as caracteristicas de 4.1
-- Enunciado: criar uma visão que mostre o nome do tutor, nome do animal, horario de atendimento do dia e receba como parametro
-- uma data e um id do veterinário.
-- Importancia na aplicacao: diminuir a complexidade, possibilitando utilizar a view em outras consultas, sendo possível
-- aprenas referencia-la.
-- Usuario(s) atendido(s): veterinario

CREATE VIEW vw.atendimento_do_dia (nome_tutor, nome_animal, horario_de_atendimento) AS
SELECT t.nome, a.nome, ag.hora, ag.data, ag.idVet
FROM tb.animal a
INNER JOIN tb.agendamento ag 
ON (a.id = ag.idAnimal)
INNER JOIN tb.tutor t 
ON (t.id = ag.idTutor);


-- [5.2] Consulta na visao
-- Consultar a visao criada em 5.1 realizando filtro(s) (WHERE)
-- Enunciado: criar um select que utilize a view, passando os parâmetros necessários. 
-- Importancia na aplicacao: através de um select é possivel acessar os dados pré definidos na view, e passar os parametros de data
-- e idVet.
-- Usuario(s) atendido(s): veterinarios

SELECT nome_tutor, nome_animal, horario_de_atendimento
FROM vw.atendimento_do_dia
WHERE data = '2022-06-20'
AND idvet = 3
ORDER BY horario_de_atendimento ASC;

-- [5.3] Visao materializada
-- A visao deve ter, no minimo, as caracteristicas de 4.2
-- Enunciado: criar uma visão materializada que mostre o nome do veterinario, a quantidade da raça informada, e a raça,
-- recebendo como parâmentro a raca.
-- Importancia na aplicacao: ao utilizar a visão materializada é possivel ganhar performance utilizando dados ja consolidados.
-- Usuario(s) atendido(s): veterinario

CREATE MATERIALIZED VIEW vw.atende_tipo_animal (veterinario_nome, quantidade_tipo_animal) AS 
SELECT v.nome, count(a.raca), a.raca
FROM tb.agendamento ag 
LEFT JOIN tb.animal a on (a.id = idAnimal)
LEFT JOIN tb.veterinario v on (v.id = idVet)
GROUP BY v.nome, raca;

-- [5.4] Consulta na visao materializada
-- Consultar a visao criada em 4.2 realizando filtro(s) (WHERE)
-- Enunciado: criar um select que utilize a materialized view, passando como parametro a raca.
-- Importancia na aplicacao: como a busca por raca quase não muda, utiliza-lo se torna viável. 
-- Usuario(s) atendido(s): veterinarios

SELECT veterinario_nome, quantidade_tipo_animal, raca
FROM vw.atende_tipo_animal
WHERE raca = 'gato';

-- [5.5] Atualizacao da visao materializada
-- Comente brevemente sobre a necessidade de atualizacao e qual seria a frequencia/periodicidade
-- R: A visão sempre roda uma query, ja a visão materializada guarda os dados, mas precisa ser atualizada através do refresh,
-- sua frequencia pode ser a cada uma semana ou um mês, depende da necessidade dos dados.

REFRESH MATERIALIZED VIEW vw.atende_tipo_animal;


-- ---------------------------------------------
-- [6] DESEMPENHO DO PROCESSAMENTO DAS CONSULTAS
-- Primeiro analise o desempenho das suas consultas 4.1., 4.2, 5.2 e 5.4, verificando custo e tempo das operacoes
-- Depois de analisa-las, comente a necessidade da criacao ou nao de um indice e justifique a escolha pelo tipo de indice.
-- Selecione uma dentre essas consultas (a mais importante delas) e apresente aquilo que se pede abaixo.

-- [6.1] EXPLAIN 
EXPLAIN
SELECT t.nome as nome_tutor,
	a.nome AS nome_animal,
	ag.hora AS horario_de_atendimento
FROM tb.animal a 
INNER JOIN tb.agendamento ag 
ON (a.id = ag.idAnimal)
INNER JOIN tb.tutor t 
ON (t.id = ag.idTutor)
WHERE ag.data = '2022-06-20' AND idVet = 3
ORDER BY ag.hora ASC;

-- Sort  (cost=11.89..11.90 rows=1 width=152)
--  Sort Key: ag.hora
--   ->  Nested Loop  (cost=1.89..11.88 rows=1 width=152)
--         ->  Hash Join  (cost=1.75..3.60 rows=1 width=18)
--               Hash Cond: (a.id = ag.idanimal)
--               ->  Seq Scan on animal a  (cost=0.00..1.61 rows=61 width=10)
--               ->  Hash  (cost=1.73..1.73 rows=1 width=16)
--                     ->  Seq Scan on agendamento ag  (cost=0.00..1.73 rows=1 width=16)
--                           Filter: ((data = '2022-06-20'::date) AND (idvet = 3))
--         ->  Index Scan using tutor_pkey on tutor t  (cost=0.14..8.16 rows=1 width=142)
--               Index Cond: (id = ag.idtutor)
--(11 rows)

-- [6.2] EXPLAIN ANALYZE

EXPLAIN ANALYZE
SELECT t.nome as nome_tutor,
	a.nome AS nome_animal,
	ag.hora AS horario_de_atendimento
FROM tb.animal a 
INNER JOIN tb.agendamento ag 
ON (a.id = ag.idAnimal)
INNER JOIN tb.tutor t 
ON (t.id = ag.idTutor)
WHERE ag.data = '2022-06-20' AND idVet = 3
ORDER BY ag.hora ASC;


-- Sort  (cost=11.89..11.90 rows=1 width=152) (actual time=0.088..0.090 rows=4 loops=1)
--   Sort Key: ag.hora
--   Sort Method: quicksort  Memory: 25kB
--   ->  Nested Loop  (cost=1.89..11.88 rows=1 width=152) (actual time=0.067..0.082 rows=4 loops=1)
--         ->  Hash Join  (cost=1.75..3.60 rows=1 width=18) (actual time=0.055..0.064 rows=4 loops=1)
--               Hash Cond: (a.id = ag.idanimal)
--               ->  Seq Scan on animal a  (cost=0.00..1.61 rows=61 width=10) (actual time=0.016..0.019 rows=61 loops=1)
--               ->  Hash  (cost=1.73..1.73 rows=1 width=16) (actual time=0.021..0.021 rows=4 loops=1)
--                     Buckets: 1024  Batches: 1  Memory Usage: 9kB
--                     ->  Seq Scan on agendamento ag  (cost=0.00..1.73 rows=1 width=16) (actual time=0.012..0.016 rows=4 loops=1)
--                           Filter: ((data = '2022-06-20'::date) AND (idvet = 3))
--                           Rows Removed by Filter: 46
--         ->  Index Scan using tutor_pkey on tutor t  (cost=0.14..8.16 rows=1 width=142) (actual time=0.004..0.004 rows=1 loops=4)
--               Index Cond: (id = ag.idtutor)
-- Planning Time: 0.284 ms
-- Execution Time: 0.160 ms
-- (16 rows)

-- [6.3] Comentarios e justificativas para o indice 
-- Considerar custo e tempo das operacoes, por exemplo
-- Sem o index o tempo de execução era de 0.160 e após aplicar o "SET enable_seqscan = OFF;" e habilitar a busca
-- por index "SET enable_indexscan = ON;" a mesma operação cai para 0.102, assim agilizando na hora da consulta no banco.

-- [6.4] CREATE INDEX e PARAMETROS (Set)
-- Crie o indice, verifique se o indice ja esta sendo usado no processamento da consulta e, caso nao esteja, ajuste os parametros

CREATE INDEX corta_tempo ON tb.agendamento (hora);
SET enable_seqscan = OFF;
SET enable_indexscan = ON;

-- após realizar o explain analyze caso queria voltar ao padrão a busca utilizar "reset all".

-- Nested Loop  (cost=0.43..29.82 rows=1 width=152) (actual time=0.073..0.097 rows=4 loops=1)
--   ->  Nested Loop  (cost=0.28..21.54 rows=1 width=18) (actual time=0.055..0.072 rows=4 loops=1)
--         ->  Index Scan using corta_tempo on agendamento ag  (cost=0.14..13.12 rows=1 width=16) (actual time=0.040..0.051 rows=4 loops=1)
--               Filter: ((data = '2022-06-20'::date) AND (idvet = 3))
--               Rows Removed by Filter: 46
--         ->  Index Scan using animal_pkey on animal a  (cost=0.14..8.16 rows=1 width=10) (actual time=0.004..0.004 rows=1 loops=4)
--               Index Cond: (id = ag.idanimal)
--   ->  Index Scan using tutor_pkey on tutor t  (cost=0.14..8.16 rows=1 width=142) (actual time=0.005..0.005 rows=1 loops=4)
--         Index Cond: (id = ag.idtutor)
-- Planning Time: 0.215 ms
-- Execution Time: 0.102 ms
--(11 rows)

-- ---------------------------------------------
-- [7] FUNCOES INTERNAS
-- Usar funcoes internas nas operacoes em tabelas do banco de dados

CREATE OR REPLACE FUNCTION aumenta_consulta(um_valor REAL)
RETURNS REAL AS $$
BEGIN

RETURN (SELECT valorConsulta
			FROM tb.veterinario v
			WHERE id = 1) * um_valor;
 		
END;

$$ LANGUAGE 'plpgsql';

-- Explicar aqui o que o comando abaixo faz e sua utilidade na aplicacao
-- o select abaixo mostra o valor de uma consulta se for atualizada	
SELECT nome, valorConsulta, aumenta_consulta(1.5) FROM tb.veterinario;

-- Explicar aqui o que o comando abaixo faz e sua utilidade na aplicacao
-- Redigir abaixo o INSERT (apagar esta linha)

-- Explicar aqui o que o comando abaixo faz e sua utilidade na aplicacao
UPDATE tb.veterinario SET valorConsulta = aumenta_consulta(1.5);
-- o update acima atualiza o valor da consulta

-- Explicar aqui o que o comando abaixo faz e sua utilidade na aplicacao
DELETE FROM tb.veterinario WHERE aumenta_consulta(1.5) > 10000;
-- o delete acima delete qualquer veterinario que o aumento da consulta ultrapasse 1000 reais

-- ---------------------------------------------
-- [8] USER-DEFINED FUNCTION (UDF)
-- Vislumbrar a criacao de uma funcao (UDF) para o banco de dados.
-- Comentar a utilidade da funcao na aplicacao.
-- Redigir o comando CREATE OR REPLACE FUNCTION correspondente usando PL/pgSQL.
-- Redigir um comando SQL que chame a funcao, explicando o que sua chamada faz.
-- A funcao devera' ter parametro(s).

-- Comentar aqui a utilidade da funcao na aplicacao : essa funcao atualiza o salario de um determinado veterinario se ele tiver mais de 12 atendimentos no mes.

CREATE OR REPLACE FUNCTION salario_final(um_nome VARCHAR)
RETURNS numeric(10, 2) as $$

DECLARE

consultas_total tb.veterinario.quantConsulta%type;

BEGIN

SELECT quantConsulta INTO consultas_total
FROM tb.veterinario v
WHERE v.nome = um_nome;

IF consultas_total > 12 THEN
RETURN (SELECT v.salario
FROM tb.veterinario v
WHERE v.nome = um_nome) + (((consultas_total * 100 ) - 1200) / 1.25 );

END IF;

RETURN consultas_total;

END

$$ LANGUAGE 'plpgsql';

-- Explicar aqui o que a chamada abaixo faz
-- SELECT ou INSERT ou UPDATE ou DELETE abaixo para chamar a funcao (apagar esta linha)
-- o select abaixo mostra o salario de determinado veterinario com sua atualizacao.
SELECT nome, salario, salario_final('antonio') FROM tb.veterinario;

-- o update abaixo atualiza o salario do veterinario.
UPDATE tb.veterinario SET salario = salario_final('flavia');

-- o delete abaixo deleta determinado veterinário se o salario dele ficar a cima de 2000.
DELETE FROM tb.veterinario WHERE salario_final('luma') > 20000;



-- ---------------------------------------------
-- [9] STORED PROCEDURE
-- Vislumbrar a criacao de um procedimento armazenado para o banco de dados.
-- Comentar a utilidade do procedimento na aplicacao.
-- Redigir o comando CREATE OR REPLACE PROCEDURE correspondente usando PL/pgSQL.
-- Redigir um comando SQL que chame o procedimento, explicando o que sua chamada faz.
-- O procedimento devera' ter parametro(s).

-- Comentar a utilidade do procedimento na aplicacao aqui: essa procedure faz uma troca de veterinario caso aconteca algo.

CREATE OR REPLACE PROCEDURE troca_veterinario(um_nome varchar, outro_nome varchar, uma_data date)
AS $$

BEGIN

UPDATE tb.agendamento ag
SET idVet = (SELECT v.id
FROM tb.veterinario v
WHERE v.nome = outro_nome)
WHERE ag.data >= uma_data AND idVet = (select v.id 
FROM tb.veterinario v
WHERE v.nome = um_nome) ;

RETURN;

END;

$$ LANGUAGE 'plpgsql';

-- Explicar aqui o que a chamada abaixo faz
-- a chamada abaixo atualiza o veterinario dos agendamentos a partir de determinada data.
CALL troca_veterinario('luma', 'flavia', '2022-06-26');


-- ---------------------------------------------
-- [10] TRIGGER
-- Revisar as aplicacoes em potencial para bancos de dados ativos (e gatilhos).
-- Vislumbrar a criacao de um gatilho e de uma funcao engatilhada para o banco de dados.
-- Se necessario redigir logo abaixo outros comandos SQL necessarios (criacao de coluna, atualizacao de tuplas etc):


-- [10.1] ROW
-- Comentar aqui a utilidade, para a aplicacao, do gatilho em nivel de tupla e da sua funcao engatilhada.

-- Redigir o comando CREATE OR REPLACE FUNCTION correspondente usando PL/pgSQL

CREATE OR REPLACE FUNCTION consultas_mensal()
RETURNS TRIGGER 
AS $$
BEGIN

IF (TG_OP = 'INSERT') THEN
	UPDATE tb.veterinario
	SET quantConsulta = quantConsulta + 1 
	WHERE id = new.idVet;
RETURN NEW;

ELSIF (TG_OP = 'UPDATE') THEN
	UPDATE tb.veterinario
	SET quantConsulta = quantConsulta + 1 
	WHERE id = new.idVet;
		IF (TG_OP = 'UPDATE') THEN
			UPDATE tb.veterinario
			SET quantConsulta = quantConsulta - 1 
			WHERE id = old.idVet;
			RETURN OLD;
		END IF;
	RETURN NEW;

ELSIF (TG_OP = 'DELETE') THEN
	UPDATE tb.veterinario
	SET quantCONsulta = quantCONsulta - 1 
	WHERE id = old.idVet;
RETURN OLD;

END IF;

RETURN NULL;

END;

$$ LANGUAGE 'plpgsql';

-- Redigir o comando CREATE TRIGGER correspondente ao gatilho em nivel de tupla usando PL/pgSQL

CREATE TRIGGER ajuste_consulta
AFTER INSERT OR UPDATE OR DELETE ON tb.agendamento
FOR EACH ROW EXECUTE FUNCTION consultas_mensal();


-- Redigir pelo menos 1 comando SQL que dispare o gatilho em nivel de tupla
-- Descrever o que acontece no banco de dados quando e' disparado
-- toda vez que e inserido, atualizado ou deletado algo da tabela de agendamentos, esse trigger atualiza a quantidade de consultas presente na tabela de veterinario.

INSERT INTO tb.agendamento(data, hora, idVet, idTutor, idAnimal) 
VALUES ('2022-07-17', '15:00:00', 03, 34, 45);



-- [10.2] STATEMENT
-- Comentar aqui a utilidade, para a aplicacao, do gatilho em nivel de sentenca e da sua funcao engatilhada.
-- Redigir o comando CREATE OR REPLACE FUNCTION correspondente usando PL/pgSQL


-- Redigir o comando CREATE TRIGGER correspondente ao gatilho em nivel de sentenca usando PL/pgSQL


-- Redigir pelo menos 1 comando SQL que dispare o gatilho em nivel de sentenca
-- Descrever o que acontece no banco de dados quando e' disparado




-- ---------------------------------------------
-- [11] SEGURANCA




-- [11.1] ACESSO REMOTO (pg_hba.conf)

-- # PostgreSQL Client Authentication Configuration File
-- # ===================================================
-- #
-- # Refer to the "Client Authentication" section in the PostgreSQL
-- # documentation for a complete description of this file.  A short
-- # synopsis follows.
-- #
-- # This file controls: which hosts are allowed to connect, how clients
-- # are authenticated, which PostgreSQL user names they can use, which
-- # databases they can access.  Records take one of these forms:
-- #
-- # local         DATABASE  USER  METHOD  [OPTIONS]
-- # host          DATABASE  USER  ADDRESS  METHOD  [OPTIONS]
-- # hostssl       DATABASE  USER  ADDRESS  METHOD  [OPTIONS]
-- # hostnossl     DATABASE  USER  ADDRESS  METHOD  [OPTIONS]
-- # hostgssenc    DATABASE  USER  ADDRESS  METHOD  [OPTIONS]
-- # hostnogssenc  DATABASE  USER  ADDRESS  METHOD  [OPTIONS]
-- #
-- # (The uppercase items must be replaced by actual values.)
-- #
-- # The first field is the connection type:
-- # - "local" is a Unix-domain socket
-- # - "host" is a TCP/IP socket (encrypted or not)
-- # - "hostssl" is a TCP/IP socket that is SSL-encrypted
-- # - "hostnossl" is a TCP/IP socket that is not SSL-encrypted
-- # - "hostgssenc" is a TCP/IP socket that is GSSAPI-encrypted
-- # - "hostnogssenc" is a TCP/IP socket that is not GSSAPI-encrypted
-- #
-- # DATABASE can be "all", "sameuser", "samerole", "replication", a
-- # database name, or a comma-separated list thereof. The "all"
-- # keyword does not match "replication". Access to replication
-- # must be enabled in a separate record (see example below).
-- #
-- # USER can be "all", a user name, a group name prefixed with "+", or a
-- # comma-separated list thereof.  In both the DATABASE and USER fields
-- # you can also write a file name prefixed with "@" to include names
-- # from a separate file.
-- #
-- # ADDRESS specifies the set of hosts the record matches.  It can be a
-- # host name, or it is made up of an IP address and a CIDR mask that is
-- # an integer (between 0 and 32 (IPv4) or 128 (IPv6) inclusive) that
-- # specifies the number of significant bits in the mask.  A host name
-- # that starts with a dot (.) matches a suffix of the actual host name.
-- # Alternatively, you can write an IP address and netmask in separate
-- # columns to specify the set of hosts.  Instead of a CIDR-address, you
-- # can write "samehost" to match any of the server's own IP addresses,
-- # or "samenet" to match any address in any subnet that the server is
-- # directly connected to.
-- #
-- # METHOD can be "trust", "reject", "md5", "password", "scram-sha-256",
-- # "gss", "sspi", "ident", "peer", "pam", "ldap", "radius" or "cert".
-- # Note that "password" sends passwords in clear text; "md5" or
-- # "scram-sha-256" are preferred since they send encrypted passwords.
-- #
-- # OPTIONS are a set of options for the authentication in the format
-- # NAME=VALUE.  The available options depend on the different
-- # authentication methods -- refer to the "Client Authentication"
-- # section in the documentation for a list of which options are
-- # available for which authentication methods.
-- #
-- # Database and user names containing spaces, commas, quotes and other
-- # special characters must be quoted.  Quoting one of the keywords
-- # "all", "sameuser", "samerole" or "replication" makes the name lose
-- # its special character, and just match a database or username with
-- # that name.
-- #
-- # This file is read on server startup and when the server receives a
-- # SIGHUP signal.  If you edit the file on a running system, you have to
-- # SIGHUP the server for the changes to take effect, run "pg_ctl reload",
-- # or execute "SELECT pg_reload_conf()".
-- #
-- # Put your actual configuration here
-- # ----------------------------------
-- #
-- # If you want to allow non-local connections, you need to add more
-- # "host" records.  In that case you will also need to make PostgreSQL
-- # listen on a non-local interface via the listen_addresses
-- # configuration parameter, or via the -i or -h command line switches.



-- # TYPE  DATABASE        USER            ADDRESS                 METHOD

-- # "local" is for Unix domain socket connections only
-- local   all             all                                     scram-sha-256
-- # IPv4 local connections:
-- host    all             all             127.0.0.1/32            scram-sha-256
-- host	clinica_vet		   desenvolvedor   10.128.70.0/24		   scram-sha-256
-- host	clinica_vet		   antonio		   10.128.70.0/24		   scram-sha-256
-- host	clinica_vet		   flavia		   10.128.70.0/24		   scram-sha-256
-- host	clinica_vet		   luma		       10.128.70.0/24		   scram-sha-256
-- host	clinica_vet		   rinaldo		   10.128.70.0/24		   scram-sha-256
-- host	clinica_vet		   paula		   10.128.70.0/24		   scram-sha-256
-- host	clinica_vet		   selma		   10.128.70.0/24		   scram-sha-256
-- # IPv6 local connections:
-- host    all             all             ::1/128                 scram-sha-256
-- # Allow replication connections from localhost, by a user with the
-- # replication privilege.
-- local   replication     all                                     scram-sha-256
-- host    replication     all             127.0.0.1/32            scram-sha-256
-- host    replication     all             ::1/128                 scram-sha-256



-- [11.2] PAPEIS (Roles)
-- Criar papeis de usuarios e de grupos
-- Nessa criacao, considerar tanto papeis da equipe (administracao/desenvolvimento) quanto papeis de usuarios da aplicacao
-- Para cada papel criado adicionar um comentario antes explicando qual e' a utilidade dele na aplicacao

-- Desenvolvedor: papel do criador do banco de dados clínica veterinária, sendo um superusuario tem acesso total ao banco e cria papeis.
CREATE role desenvolvedor;
ALTER role desenvolvedor WITH nosuperuser createrole login password'desenvolvedor' createdb;

CREATE role antonio;
ALTER role antonio WITH nosuperuser login password'antonio';
CREATE role flavia;
ALTER role flavia WITH nosuperuser login password'flavia';
CREATE role luma;
ALTER role luma WITH nosuperuser login password'luma';
-- veterinários: grupo com todos os veterinários da clínica
CREATE role veterinarios;
GRANT veterinarios TO antonio, flavia, luma;
GRANT CONNECT ON DATABASE clinica_vet TO veterinarios;


CREATE role rinaldo;
ALTER role rinaldo WITH nosuperuser login password'rinaldo';
CREATE role thomas;
ALTER role thomas WITH nosuperuser login password'thomas';
CREATE role paula;
ALTER role paula WITH nosuperuser login password'paula';
CREATE role selma;
ALTER role selma WITH nosuperuser login password'selma';

-- tutores: grupo com alguns tutores da clinica
CREATE role tutores;
GRANT tutores TO rinaldo, selma, paula, thomas;
GRANT CONNECT ON DATABASE clinica_vet TO tutores;

-- [11.3] PRIVILEGIOS DE ACESSO (Grant)

-- [11.3.1]
-- Assegurar os privilegios necessarios para o(s) papel(is) poder(em) criar o(s) esquema(s) da Secao 1
-- Usuario(s) podem conceder esse acesso alem do superusuario: desenvolvedor
-- Apagar essa linha e adicionar os comandos necessarios

GRANT CREATE ON DATABASE clinica_vet TO desenvolvedor;
GRANT usage ON SCHEMA tb, vw TO veterinarios, tutores;
GRANT CREATE ON DATABASE clinica_vet TO antonio;

-- [11.3.2]
-- Assegurar os privilegios necessarios para o(s) papel(is) poder(em) criar a(s) tabela(s), as sequencias e as restricoes da Secao 2 e as visoes da Secao 5
-- Usuario(s) podem conceder esse acesso alem do superusuario: desenvolvedor
-- Apagar essa linha e adicionar os comandos necessarios

GRANT CREATE ON SCHEMA tb, vw TO desenvolvedor;
GRANT CREATE ON SCHEMA tb, vw TO veterinarios;

-- [11.3.3]
-- Assegurar os privilegios necessarios para o(s) papel(is) poder(em) inserir e atualizar tuplas, conforme a Secao 3
-- Usuario(s) podem conceder esse acesso alem do superusuario: desenvolvedor
-- Apagar essa linha e adicionar os comandos necessarios

GRANT INSERT ON TABLE tb.veterinario TO antonio;
GRANT INSERT ON TABLE tb.tutor, tb.animal, tb.agendamento TO tutores;
GRANT INSERT ON TABLE tb.veterinario TO veterinarios;
GRANT DELETE ON TABLE tb.agendamento TO veterinarios, tutores;

-- [11.3.4]
-- Assegurar os privilegios necessarios para o(s) papel(is) poder(em) executar as consultas das Secoes 4 e 5
-- Usuario(s) podem conceder esse acesso alem do superusuario: desenvolvedor
-- Apagar essa linha e adicionar os comandos necessarios

GRANT SELECT ON tb.veterinario, tb.tutor, tb.animal, tb.agendamento TO antonio;
GRANT SELECT ON vw.atendimento_do_dia TO veterinarios;
GRANT SELECT ON vw.atende_tipo_animal TO veterinarios;
GRANT SELECT ON vw.atendimento_do_dia TO tutores;

-- [11.3.5]
-- Assegurar os privilegios necessarios para o(s) papel(is) poder(em) executar os comandos da Secao 7
-- Usuario(s) podem conceder esse acesso alem do superusuario: desenvolvedor
-- Apagar essa linha e adicionar os comandos necessarios

GRANT EXECUTE ON FUNCTION aumenta_consulta TO antonio;

-- [11.3.6]
-- Assegurar os privilegios necessarios para o(s) papel(is) poder(em) executar as subrotinas das Secoes 8, 9 e 10
-- Assegurar tambem os privilegios para executar os comandos que realizam as chamadas (ou disparos) daquelas subrotinas
-- Usuario(s) podem conceder esse acesso alem do superusuario: desenvolvedor
-- Apagar essa linha e adicionar os comandos necessarios

GRANT EXECUTE ON FUNCTION salario_final TO antonio;
GRANT EXECUTE ON PROCEDURE troca_veterinario TO antonio;


-- [11.4] PRIVILEGIOS DE ACESSO (Revoke)

-- [11.4.1]
-- Revogar o acesso em 11.3.1 de pelo menos 1 papel
-- Usuario(s) podem revogar esse acesso alem do superusuario: desenvolvedor
-- Apague esta linha e redija o comando aqui

REVOKE CREATE ON DATABASE clinica_vet FROM antonio;

-- [11.4.2]
-- Revogar o acesso em 11.3.2 de pelo menos 1 papel
-- Usuario(s) podem revogar esse acesso alem do superusuario: desenvolvedor
-- Apague esta linha e redija o comando aqui

REVOKE CREATE ON SCHEMA tb, vw FROM veterinarios;

-- [11.4.3]
-- Revogar o acesso em 11.3.3 de pelo menos 1 papel
-- Usuario(s) podem revogar esse acesso alem do superusuario: desenvolvedor
-- Apague esta linha e redija o comando aqui

REVOKE INSERT ON TABLE tb.veterinario FROM veterinarios;

-- [11.4.4]
-- Revogar o acesso em 11.3.4 de pelo menos 1 papel
-- Usuario(s) podem revogar esse acesso alem do superusuario: desenvolvedor
-- Apague esta linha e redija o comando aqui

REVOKE SELECT ON vw.atendimento_do_dia FROM tutores;

-- [11.4.5]
-- Revogar o acesso em 11.3.5 de pelo menos 1 papel
-- Usuario(s) podem revogar esse acesso alem do superusuario: desenvolvedor
-- Apague esta linha e redija o comando aqui

REVOKE ALL ON FUNCTION aumenta_consulta FROM public;

-- [11.4.6]
-- Revogar o acesso em 11.3.6 de pelo menos 1 papel
-- Usuario(s) podem revogar esse acesso alem do superusuario: desenvolvedor
-- Apague esta linha e redija o comando aqui

REVOKE ALL ON FUNCTION salario_final FROM public;
REVOKE ALL ON PROCEDURE troca_veterinario FROM public;

-- Se for necessario para executar os comandos seguintes, assegure novamente os privilegios de acesso revogados acima
-- Apague esta linha e redija os comandos a partir daqui



-- ---------------------------------------------
-- [12] TRANSACOES
-- Nao incluir aqui
-- Usar/entregar o modelo proprio para esse topico