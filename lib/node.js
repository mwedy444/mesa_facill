const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// Conexão com MySQL
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '', // tua senha do MySQL
  database: 'mesafacil'
});

// Rota para cadastrar cliente
app.post('/api/clientes', (req, res) => {
  const { nome, email, senha } = req.body;

  const sql = 'INSERT INTO clientes (nome, email, senha) VALUES (?, ?, ?)';
  db.query(sql, [nome, email, senha], (err, result) => {
    if (err) {
      console.error('Erro ao cadastrar:', err);
      return res.status(500).json({ erro: 'Erro ao cadastrar cliente' });
    }
    res.status(201).json({ mensagem: 'Cliente cadastrado com sucesso!' });
  });
});

// Iniciar servidor
app.listen(3000, () => {
  console.log('Servidor Node.js online na porta 3000');
});
