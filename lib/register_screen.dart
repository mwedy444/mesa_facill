import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nomeController = TextEditingController();
  final enderecoController = TextEditingController();
  final tipoCozinhaController = TextEditingController();
  final faixaPrecoController = TextEditingController();
  final horarioController = TextEditingController();
  final telefoneController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  Widget buildTextField(String label, TextEditingController controller, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildDropdownField(String label, TextEditingController controller, List<String> opcoes) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        value: controller.text.isNotEmpty ? controller.text : null,
        items: opcoes
            .map((opcao) => DropdownMenuItem(
                  value: opcao,
                  child: Text(opcao),
                ))
            .toList(),
        onChanged: (valor) {
          setState(() {
            controller.text = valor!;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Cadastrar Restaurante',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  buildTextField("Nome do Restaurante", nomeController),
                  buildTextField("Endereço", enderecoController),
                  buildDropdownField("Tipo de Cozinha", tipoCozinhaController, [
                    'Brasileira', 'Italiana', 'Japonesa', 'Mexicana', 'Chinesa', 'Vegetariana', 'Outros'
                  ]),
                  buildDropdownField("Faixa de Preço", faixaPrecoController, [
                    'Barato', 'Médio', 'Caro'
                  ]),
                  buildTextField("Horário de Funcionamento", horarioController),
                  buildTextField("Telefone", telefoneController),
                  buildTextField("Email", emailController),
                  buildTextField("Senha", senhaController, obscure: true),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF67AEA2),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text("Cadastrar Restaurante"),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Já tem conta? Entrar"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
