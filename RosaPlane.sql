CREATE DATABASE rosaplane;

USE rosaplane;

CREATE TABLE destinos(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nomeDestino VARCHAR(100),
    pais VARCHAR(100),
    descricao VARCHAR(100)
);

CREATE TABLE pacotes(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    idDestino INT,
    nomePacote VARCHAR(100),
    preco INT,
    dataInicio DATE,
    dataTermino DATE,
    FOREIGN KEY (idDestino) REFERENCES destinos(id)
);

CREATE TABLE clientes(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nomeCliente VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(100),
    endereco VARCHAR(100)
);

CREATE TABLE reservas(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    idCliente INT,
    idPacote INT,
    dataReserva DATE,
    numPessoas INT,
    statusReserva VARCHAR(100),
    FOREIGN KEY (idCliente) REFERENCES clientes(id),
    FOREIGN KEY (idPacote) REFERENCES pacotes(id)
);

INSERT INTO destinos (nomeDestino, pais, descricao) VALUE 
('Praia', 'Havai', 'praias lindas'),
('Neve', 'Chile', 'neve gelada'),
('Torre Eiffel', 'Paris', 'grande cidade');

INSERT INTO pacotes (idDestino, nomePacote, preco,  dataInicio, dataTermino) VALUE
(1, 'Praia Paradisiaca', 5000, '2024-10-25', '2024-11-01'),
(2, 'Neve Branquinha', 7000, '2025-01-06', '2025-02-10'),
(3, 'Grande Torre', 3000, '2025-12-25', '2026-01-15');

INSERT INTO clientes (nomeCliente, email, telefone, endereco) VALUES
('Giovanna','giovanna@gmail.com','698765','carapicuiba'),
('Arthur','arthur@gmail.com','84634','cotia'),
('Amanda','amanda@gmail.com','6463746','osasco');

INSERT INTO reservas (idCliente, idPacote, dataReserva, numPessoas, statusReserva) VALUES
( 1, 1, '2024-10-20', 100, 'confirmada'),
( 2, 2, '2025-01-06', 300, 'pendente'),
( 3, 3, '2025-12-25', 50, 'cancelada');

SELECT * FROM destinos;
SELECT * FROM pacotes;
SELECT * FROM clientes;
SELECT * FROM reservas;


CREATE VIEW view_pacotes_destinos AS
SELECT pacotes.id, pacotes.nomePacote, pacotes.preco, destinos.nomeDestino, destinos.pais, pacotes.dataInicio, pacotes.dataTermino
FROM pacotes
JOIN destinos ON pacotes.idDestino = destinos.id;

CREATE VIEW view_reservas_completas AS
SELECT reservas.id, clientes.nomeCliente, clientes.email, pacotes.nomePacote, reservas.dataReserva, reservas.numPessoas, reservas.statusReserva
FROM reservas
JOIN clientes ON reservas.idCliente = clientes.id
JOIN pacotes ON reservas.idPacote = pacotes.id;

SELECT nomePacote, preco 
FROM pacotes 
WHERE preco > 4000;

SELECT * 
FROM reservas 
WHERE statusReserva = 'confirmada';

SELECT clientes.nomeCliente, pacotes.nomePacote, reservas.dataReserva, reservas.statusReserva 
FROM reservas
JOIN clientes ON reservas.idCliente = clientes.id
JOIN pacotes ON reservas.idPacote = pacotes.id
WHERE clientes.nomeCliente = 'Giovanna';

SELECT pacotes.nomePacote, destinos.nomeDestino 
FROM pacotes
JOIN destinos ON pacotes.idDestino = destinos.id
WHERE destinos.nomeDestino = 'Praia';
