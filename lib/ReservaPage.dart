import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurantes',
      theme: ThemeData(
        primaryColor: const Color(0xFF679EA2),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF679EA2),
          foregroundColor: Colors.white,
        ),
      ),
      home: RestaurantFilterScreen(),
    );
  }
}

class RestaurantFilterScreen extends StatefulWidget {
  @override
  _RestaurantFilterScreenState createState() => _RestaurantFilterScreenState();
}

class _RestaurantFilterScreenState extends State<RestaurantFilterScreen> {
  final TextEditingController searchController = TextEditingController();
  String selectedCuisine = 'Todos';
  String selectedPrice = 'Todos';

  final List<String> cuisines = [
    'Todos',
    'Italiana',
    'Japonesa',
    'Brasileira',
    'Moçambicana',
    'Indiana',
  ];

  final List<String> prices = ['Todos', '\$', '\$\$', '\$\$\$'];

  List<dynamic> restaurantes = [];
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregarRestaurantes();
  }

  Future<List<dynamic>> buscarRestaurantes() async {
    final response = await http.get(
      Uri.parse('http://<teu_ip_local>:3000/api/restaurantes'), // ← troque pelo teu IP real
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao carregar restaurantes');
    }
  }

  void carregarRestaurantes() async {
    try {
      final dados = await buscarRestaurantes();
      setState(() {
        restaurantes = dados;
        carregando = false;
      });
    } catch (e) {
      setState(() {
        carregando = false;
      });
      print('Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Restaurantes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Buscar por nome',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: selectedCuisine,
              decoration: const InputDecoration(
                labelText: 'Tipo de Cozinha',
                border: OutlineInputBorder(),
              ),
              items: cuisines.map<DropdownMenuItem<String>>((String cuisine) {
                return DropdownMenuItem<String>(
                  value: cuisine,
                  child: Text(cuisine),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedCuisine = value ?? 'Todos';
                });
              },
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: selectedPrice,
              decoration: const InputDecoration(
                labelText: 'Faixa de Preço',
                border: OutlineInputBorder(),
              ),
              items: prices.map<DropdownMenuItem<String>>((String price) {
                return DropdownMenuItem<String>(
                  value: price,
                  child: Text(price),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedPrice = value ?? 'Todos';
                });
              },
            ),
            const SizedBox(height: 20),

            Expanded(
              child: carregando
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: restaurantes.length,
                itemBuilder: (context, index) {
                  final restaurante = restaurantes[index];
                  return ListTile(
                    leading: const Icon(Icons.restaurant, color: Color(0xFF679EA2)),
                    title: Text(restaurante['nome']),
                    subtitle: Text(
                        '${restaurante['tipo_cozinha']} - ${restaurante['faixa_preco']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
