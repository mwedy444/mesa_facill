import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  String mensagem = '';
  bool carregando = false;

  Future<void> cadastrarCliente() async {
    setState(() {
      carregando = true;
    });
//mas aqui nao tenho a certeza, peco para verem
    const url = 'http://localhost:3000/api/clientes'; // aqui deve ser   IP da maquina real se testares em celular
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nome': nomeController.text,
        'email': emailController.text,
        'senha': senhaController.text,
      }),
    );

    setState(() {
      carregando = false;
      if (response.statusCode == 201) {
        mensagem = 'Cadastro realizado com sucesso!';
        nomeController.clear();
        emailController.clear();
        senhaController.clear();
      } else {
        mensagem = 'Erro ao cadastrar: ${response.body}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF679EA2),
      appBar: AppBar(
        title: const Text('Cadastro de Cliente'),
        backgroundColor: const Color(0xFF2F4E52),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: senhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: carregando ? null : cadastrarCliente,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F4E52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: carregando
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    'CADASTRAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                mensagem,
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
