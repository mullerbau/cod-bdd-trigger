-- PostgreSQL
CREATE TABLE clientes (
id SERIAL,
nome VARCHAR(100),
email VARCHAR(100),
PRIMARY KEY(id)
);

CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES clientes(id),
    valor NUMERIC(10,2),
    data_pedido DATE DEFAULT CURRENT_DATE
);

CREATE TABLE log_pedidos (
id SERIAL,
mensagem TEXT,
data_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY(id)
);

DELIMITER $$
CREATE TRIGGER trg_clientes_BD
BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN
INSERT INTO log_pedidos (mensagem)
VALUES (CONCAT('Cliente ID ', OLD.id, ' será removido: ', OLD.nome));
END$$
DELIMITER ;



-- MySQL
CREATE TABLE clientes (
id INT AUTO_INCREMENT,
nome VARCHAR(100),
email VARCHAR(100),
PRIMARY KEY(id)
);

CREATE TABLE pedidos (
    id INT AUTO_INCREMENT,
    cliente_id INT,
    valor DECIMAL(10,2),
    data_pedido DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE log_pedidos (
id INT AUTO_INCREMENT,
mensagem TEXT,
data_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY(id)
);


DELIMITER $$
CREATE TRIGGER trg_pedidos_AI
AFTER INSERT ON pedidos
FOR EACH ROW
BEGIN
INSERT INTO log_pedidos (mensagem)
VALUES (
CONCAT('Novo pedido inserido para o cliente ID ', NEW.cliente_id)
);
END $$
DELIMITER ;



-- Inserindo clientes
INSERT INTO clientes (nome, email) VALUES
('João Silva', 'joao@email.com'),
('Maria Souza', 'maria@email.com');

-- Inserindo produtos

INSERT INTO pedidos (cliente_id, valor, data_pedido) VALUES
(1, 199.90, '2025-03-01'),
(1, 49.90, '2025-03-10'),
(2, 99.90, '2025-03-15');