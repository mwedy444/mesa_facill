import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nomeController = TextEditingController(text: "Restaurante Exemplo");
  final enderecoController = TextEditingController(text: "Rua Principal, 123");
  final contatoController = TextEditingController(text: "(+258) 99-999-9999");

  List<Map<String, dynamic>> cardapio = [
    {'nome': 'Pizza Margherita', 'preco': 35.0},
    {'nome': 'Lasanha', 'preco': 42.0},
  ];

  List<String> fotos = [];

  void _editarItem(int index) {
    final nomeItem = TextEditingController(text: cardapio[index]['nome']);
    final precoItem = TextEditingController(text: cardapio[index]['preco'].toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Editar Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nomeItem, decoration: const InputDecoration(labelText: 'Nome do Prato')),
            TextField(controller: precoItem, decoration: const InputDecoration(labelText: 'Preço'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                cardapio[index] = {
                  'nome': nomeItem.text,
                  'preco': double.tryParse(precoItem.text) ?? 0.0
                };
              });
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _adicionarItem() {
    final nomeItem = TextEditingController();
    final precoItem = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Adicionar Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nomeItem, decoration: const InputDecoration(labelText: 'Nome do Prato')),
            TextField(controller: precoItem, decoration: const InputDecoration(labelText: 'Preço'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                cardapio.add({
                  'nome': nomeItem.text,
                  'preco': double.tryParse(precoItem.text) ?? 0.0
                });
              });
              Navigator.pop(context);
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  void _gerenciarFotos() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Gerenciar Fotos'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  fotos.add("foto_${fotos.length + 1}.jpg");
                });
              },
              child: const Text('Upload Foto'),
            ),
            const SizedBox(height: 10),
            ...fotos.map<Widget>((foto) => ListTile(
              title: Text(foto),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    fotos.remove(foto);
                  });
                  Navigator.pop(context);
                  _gerenciarFotos();
                },
              ),
            ))
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fechar')),
        ],
      ),
    );
  }

  void _salvarPerfil() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Perfil salvo com sucesso!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão do Perfil'),
        backgroundColor: const Color(0xFF67AEA2),
        actions: [
          IconButton(onPressed: _salvarPerfil, icon: const Icon(Icons.save)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nomeController, decoration: const InputDecoration(labelText: 'Nome')),
            TextField(controller: enderecoController, decoration: const InputDecoration(labelText: 'Endereço')),
            TextField(controller: contatoController, decoration: const InputDecoration(labelText: 'Contato')),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Cardápio", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                IconButton(icon: const Icon(Icons.add), onPressed: _adicionarItem),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: cardapio.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = cardapio[index];
                return ListTile(
                  title: Text(item['nome']),
                  subtitle: Text('R\$ ${item['preco'].toStringAsFixed(2)}'),
                  trailing: Wrap(
                    children: [
                      IconButton(icon: const Icon(Icons.edit), onPressed: () => _editarItem(index)),
                      IconButton(icon: const Icon(Icons.delete), onPressed: () => setState(() => cardapio.removeAt(index))),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text("Fotos do Restaurante", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Wrap(
              spacing: 8,
              children: fotos.map((foto) => Chip(label: Text(foto), onDeleted: () => setState(() => fotos.remove(foto)))).toList(),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _gerenciarFotos,
              icon: const Icon(Icons.photo),
              label: const Text('Gerenciar Fotos'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF67AEA2)),
            ),
          ],
        ),
      ),
    );
  }
}
