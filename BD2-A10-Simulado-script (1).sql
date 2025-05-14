-- BD2 - Simulado1

DROP DATABASE IF EXISTS simulado1;
CREATE DATABASE simulado1;
USE simulado1;

-- Tabela de livros
CREATE TABLE livro (
    id     INT AUTO_INCREMENT,
    titulo VARCHAR(100),
    autor  VARCHAR(100),
    qtd_exemplares INT,
    PRIMARY KEY (id)
);

-- Tabela de usuários
CREATE TABLE usuario (
    id    INT AUTO_INCREMENT,
    nome  VARCHAR(100),
    email VARCHAR(100),
    PRIMARY KEY (id)
);

-- Tabela de empréstimos
CREATE TABLE emprestimo (
    id              INT AUTO_INCREMENT,
    id_livro        INT,
    id_usuario      INT,
    data_emprestimo DATE,
    data_devolucao  DATE DEFAULT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_livro)   REFERENCES livro(id),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

-- Inserção de dados
INSERT INTO livro (titulo, autor, qtd_exemplares) VALUES
('O Tronco do Ipê', 'José de Alencar', 5),
('Dom Casmurro', 'Machado de Assis', 3),
('Quincas Berro D`Água', 'Jorge Amado', 4),
('O Escaravelho do Diabo', 'Lúcia Machado de Almeida', 2),
('O Guarani', 'José de Alencar', 5),
('Robinson Crusoé', 'Daniel Defoe', 6),
('O Sítio do Picapau Amarelo', 'Monteiro Lobato', 7),
('O Cachorrinho Samba na Fazenda', 'Maria José Dupré', 3),
('A Moreninha', 'Joaquim Manuel de Macedo', 4),
('Memórias de um Sargento de Milícias', 'Manuel Antônio de Almeida', 5);

INSERT INTO usuario (nome, email) VALUES
('Juan Ivanov', 'juan@gmail.com'),
('Miguel Petrov', 'miguel@gmail.com'),
('Pedro Smirnov', 'pedro@gmail.com'),
('Ana Kuznetsova', 'ana@gmail.com'),
('José Pavlov', 'jose@gmail.com'),
('Carlos Romanov', 'carlos@gmail.com'),
('Maria Volkov', 'maria@gmail.com'),
('Sofia Fedorova', 'sofia@gmail.com'),
('Luis Popov', 'luis@gmail.com'),
('Gabriela Sokolov', 'gabriela@gmail.com');

-- RESPONDA/RESOLVA:

/* 1. Crie o trigger trg_diminuir_exemplar_emprestimo
      que diminui a quantidade de exemplares ao registrar um empréstimo. */

DELIMITER $$

CREATE TRIGGER trg_diminuir_exemplar_emprestimo
AFTER INSERT ON emprestimo
FOR EACH ROW
BEGIN
    UPDATE livro
    SET qtd_exemplares = qtd_exemplares - 1
    WHERE id = NEW.id_livro;
END$$

DELIMITER ;

/* 2. Crie o trigger trg_aumentar_exemplar_devolucao
      que aumenta a quantidade de exemplares ao devolver um livro. */

DELIMITER $$

CREATE TRIGGER trg_aumentar_exemplar_devolucao
AFTER UPDATE ON emprestimo
FOR EACH ROW
BEGIN
    -- Verifica se a data_devolucao era NULL e foi preenchida
    IF OLD.data_devolucao IS NULL AND NEW.data_devolucao IS NOT NULL THEN
        UPDATE livro
        SET qtd_exemplares = qtd_exemplares + 1
        WHERE id = NEW.id_livro;
    END IF;
END$$

DELIMITER ;

/* 3. Crie a procedure proc_livros_emprestados_por_usuario(id_usuario INT)
      que exibe a quantidade de livros emprestados por um usuário. */

DELIMITER $$

CREATE PROCEDURE proc_livros_emprestados_por_usuario(IN id_usuario INT)
BEGIN
    SELECT 
        u.nome,
        COUNT(e.id) AS total_emprestimos
    FROM usuario u
    LEFT JOIN emprestimo e ON u.id = e.id_usuario
    WHERE u.id = id_usuario
    GROUP BY u.nome;
END$$

DELIMITER ;

CALL proc_livros_emprestados_por_usuario(3);

/* 4. Faça uma consulta que retorne o título dos livros 
      que possuem mais de 3 cópias disponíveis. */

SELECT titulo
FROM livro
WHERE qtd_exemplares > 3;

/* 5. Faça uma consulta que retorne os usuários*/ 

SELECT u.nome
FROM usuario u
LEFT JOIN emprestimo e ON u.id = e.id_usuario
WHERE e.id IS NULL;


/* 6. Crie a procedure proc_usuarios_com_devolucao()*/


CALL proc_usuarios_com_devolucao();

DELIMITER ;

END$$
    WHERE e.data_devolucao IS NOT NULL;
    INNER JOIN emprestimo e ON u.id = e.id_usuario
    FROM usuario u
    SELECT DISTINCT u.nome
BEGIN
CREATE PROCEDURE proc_usuarios_com_devolucao()

DELIMITER $$


/* 7. Crie o trigger trg_bloquear_emprestimo_sem_exemplar*/

DELIMITER ;

END$$
    END IF;
        SET MESSAGE_TEXT = 'Não é possível realizar o empréstimo. Não há exemplares disponíveis.';
        SIGNAL SQLSTATE '45000'
    IF qtd_atual <= 0 THEN
    -- Impede o empréstimo se não houver exemplares disponíveis
    
    WHERE id = NEW.id_livro;
    FROM livro
    SELECT qtd_exemplares INTO qtd_atual
    -- Verifica a quantidade de exemplares disponíveis
    
    DECLARE qtd_atual INT;
BEGIN
FOR EACH ROW
BEFORE INSERT ON emprestimo
CREATE TRIGGER trg_bloquear_emprestimo_sem_exemplar

DELIMITER $$


/* 8. Faça uma consulta que retorne os livros */



WHERE e.id IS NULL;
LEFT JOIN emprestimo e ON l.id = e.id_livro
FROM livro l
SELECT l.titulo


/* 9. Crie o trigger trg_registrar_data_devolucao
      que registra automaticamente a data de devolução ao atualizar o empréstimo. */

DELIMITER $$

CREATE TRIGGER trg_registrar_data_devolucao
BEFORE UPDATE ON emprestimo
FOR EACH ROW
BEGIN
    -- Verifica se a data_devolucao está sendo atualizada para NULL
    IF NEW.data_devolucao IS NOT NULL THEN
        SET NEW.data_devolucao = CURDATE();
    END IF;
END $$

DELIMITER ;

/* 10. Faça uma consulta que retorne todos os empréstimos  */

WHERE data_emprestimo >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);
FROM emprestimo
SELECT *

/* 11. Crie a procedure proc_novo_emprestimo(id_livro INT, id_usuario INT)
       que insere um novo empréstimo e retorna uma mensagem de disponibilidade. */

/* 12. Desabilite o autocommit e realize uma transação manual:
       insira um empréstimo e depois faça um ROLLBACK. */

/* 13. Faça uma consulta com que retorna todos os livros com as cópias disponíveis */

/* 14. Crie o usuário bibliotecario e conceda permissões de INSERT, UPDATE e DELETE
       em todas as tabelas do banco simulado1. */

/* 15. Revogue a permissão de DELETE do usuário bibliotecario. */
