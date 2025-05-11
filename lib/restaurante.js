const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// Conexão com o banco de dados
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '', // coloca tua senha do MySQL
  database: 'mesafacil'
});

// Rota para buscar restaurantes com filtros
app.get('/api/restaurantes', (req, res) => {
  const { nome, tipo, preco } = req.query;

  let sql = 'SELECT * FROM restaurantes WHERE 1=1';
  const params = [];

  if (nome) {
    sql += ' AND nome LIKE ?';
    params.push(`%${nome}%`);
  }

  if (tipo && tipo !== 'Todos') {
    sql += ' AND tipo_cozinha = ?';
    params.push(tipo);
  }

  if (preco && preco !== 'Todos') {
    sql += ' AND faixa_preco = ?';
    params.push(preco);
  }

  db.query(sql, params, (err, results) => {
    if (err) {
      console.error('Erro ao buscar restaurantes:', err);
      return res.status(500).json({ erro: 'Erro ao buscar restaurantes' });
    }
    res.json(results);
  });
});

// Inicia o servidor
app.listen(3000, () => {
  console.log('Servidor backend online na porta 3000');
});
