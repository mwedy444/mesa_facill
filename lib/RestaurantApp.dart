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
            // Campo de busca
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

            // Dropdown tipo de cozinha
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

            //  faixa de preço
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

            // Lista simulada (sem dados ainda)
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Simulaco de 5 itens vazios
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.restaurant, color: Color(0xFF679EA2)),
                    title: Text('Restaurante ${index + 1}'),
                    subtitle: const Text('Cozinha - Faixa de Preço'),
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