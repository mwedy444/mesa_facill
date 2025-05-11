app.get('/api/restaurantes', (req, res) => {
  const sql = 'SELECT * FROM restaurantes';
  db.query(sql, (err, results) => {
    if (err) {
      return res.status(500).json({ erro: 'Erro ao buscar restaurantes' });
    }
    res.json(results);
  });
});
