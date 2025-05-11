CREATE DATABASE IF NOT EXISTS mesafacil;
USE mesafacil;

CREATE TABLE IF NOT EXISTS restaurantes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  tipo_cozinha VARCHAR(50) NOT NULL,
  faixa_preco VARCHAR(10) NOT NULL
);

INSERT INTO restaurantes (nome, tipo_cozinha, faixa_preco) VALUES
('Pasta e Sabor', 'Italiana', '$$'),
('Sushi House', 'Japonesa', '$$$'),
('Churrasco Grill', 'Brasileira', '$$'),
('Casa Moçambicana', 'Moçambicana', '$'),
('Curry Point', 'Indiana', '$$'),
('Tenda do Sabor', 'Moçambicana', '$$'),
('Spaghetti Top', 'Italiana', '$$'),
('Bambu Sushi', 'Japonesa', '$$');
