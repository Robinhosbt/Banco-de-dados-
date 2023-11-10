-- Criação da tabela Pessoa
CREATE TABLE Pessoa (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    tipo VARCHAR(20) -- 'Fisica' ou 'Juridica'
);

-- Criação da tabela CNH para pessoas físicas
CREATE TABLE CNH (
    pessoa_id INT PRIMARY KEY,
    numero VARCHAR(20),
    FOREIGN KEY (pessoa_id) REFERENCES Pessoa(id)
);

-- Criação da tabela Veiculo
CREATE TABLE Veiculo (
    id INT PRIMARY KEY,
    proprietario_id INT,
    placa VARCHAR(10),
    FOREIGN KEY (proprietario_id) REFERENCES Pessoa(id)
);

-- Criação da tabela Multa
CREATE TABLE Multa (
    id INT PRIMARY KEY,
    veiculo_id INT,
    tipo VARCHAR(20), -- 'Formulario' ou 'Eletronica'
    FOREIGN KEY (veiculo_id) REFERENCES Veiculo(id)
);

-- Criação da tabela Equipamento para multas eletrônicas
CREATE TABLE Equipamento (
    id INT PRIMARY KEY,
    descricao VARCHAR(100)
);

-- Criação da tabela Registro de Multa Eletronica
CREATE TABLE RegistroMultaEletronica (
    multa_id INT PRIMARY KEY,
    equipamento_id INT,
    FOREIGN KEY (multa_id) REFERENCES Multa(id),
    FOREIGN KEY (equipamento_id) REFERENCES Equipamento(id)
);

-- Criação da tabela Recurso para multas
CREATE TABLE Recurso (
    id INT PRIMARY KEY,
    multa_id INT,
    FOREIGN KEY (multa_id) REFERENCES Multa(id)
);

-- Inserção dos dados
-- Inserir 8 pessoas, 4 físicas e 4 jurídicas

INSERT INTO Pessoa (id, nome, tipo) VALUES
(1, 'Pessoa Fisica 1', 'Fisica'),
(2, 'Pessoa Fisica 2', 'Fisica'),
(3, 'Pessoa Fisica 3', 'Fisica'),
(4, 'Pessoa Fisica 4', 'Fisica'),
(5, 'Pessoa Juridica 1', 'Juridica'),
(6, 'Pessoa Juridica 2', 'Juridica'),
(7, 'Pessoa Juridica 3', 'Juridica'),
(8, 'Pessoa Juridica 4', 'Juridica');

-- Inserir CNH para pessoas físicas
INSERT INTO CNH (pessoa_id, numero) VALUES
(1, '12345'),
(2, '54321'),
(3, '98765'),
(4, '56789');

-- Inserir veículos para pessoas jurídicas
INSERT INTO Veiculo (id, proprietario_id, placa) VALUES
(1, 5, 'ABC1234'),
(2, 5, 'XYZ5678'),
(3, 6, 'DEF4321'),
(4, 7, 'MNO8765');

-- Inserir veículos para pessoa física 2
INSERT INTO Veiculo (id, proprietario_id, placa) VALUES
(5, 2, 'GHI9876'),
(6, 2, 'JKL5432');

-- Inserir multas para veículos de pessoas jurídicas
INSERT INTO Multa (id, veiculo_id, tipo) VALUES
(1, 1, 'Formulario'),
(2, 1, 'Eletronica'),
(3, 2, 'Formulario'),
(4, 2, 'Eletronica'),
(5, 3, 'Formulario'),
(6, 3, 'Eletronica'),
(7, 4, 'Formulario'),
(8, 4, 'Eletronica');

-- Inserir equipamentos para multas eletrônicas
INSERT INTO Equipamento (id, descricao) VALUES
(1, 'Equipamento 1'),
(2, 'Equipamento 2');

-- Inserir registros de multa eletrônica
INSERT INTO RegistroMultaEletronica (multa_id, equipamento_id) VALUES
(2, 1),
(4, 1),
(6, 2),
(8, 2);

-- Inserir recursos para multas
INSERT INTO Recurso (id, multa_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8);


SELECT p.nome AS Nome, p.endereco AS Endereco
FROM Pessoa p
JOIN Veiculo v ON p.id = v.proprietario_id;

SELECT p.nome AS Nome, c.numero AS CNH
FROM Pessoa p
JOIN CNH c ON p.id = c.pessoa_id;

SELECT p.nome AS Nome_Proprietario, v.placa AS Placa_Veiculo, r.id AS ID_Recurso
FROM Pessoa p
JOIN Veiculo v ON p.id = v.proprietario_id
JOIN Multa m ON v.id = m.veiculo_id
JOIN Recurso r ON m.id = r.multa_id;

SELECT p.nome AS Nome_Proprietario, v.placa AS Placa_Veiculo, e.descricao AS Equipamento
FROM Pessoa p
JOIN Veiculo v ON p.id = v.proprietario_id
JOIN Multa m ON v.id = m.veiculo_id
JOIN RegistroMultaEletronica r ON m.id = r.multa_id
JOIN Equipamento e ON r.equipamento_id = e.id;

SELECT p.nome AS Nome_Proprietario
FROM Pessoa p
LEFT JOIN Veiculo v ON p.id = v.proprietario_id
WHERE v.id IS NULL;

SELECT tipo, COUNT(*) AS Quantidade
FROM Multa
GROUP BY tipo
ORDER BY Quantidade DESC
LIMIT 1;