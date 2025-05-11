import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mesa Fácil - Perfil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserProfilePage(),
    );
  }
}

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String _userName = 'WINX PDM';
  String _userEmail = 'winx.pdm@example.com';
  String _userPhone = '(XX) XXXXX-XXXX';

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sair do Aplicativo'),
        content: Text('Tem certeza que deseja sair?'),
        actions: [
          TextButton(
            child: Text('Não'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Sim'),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Você foi desconectado!')),
              );
            },
          ),
        ],
      ),
    );
  }

  void _editarPerfil() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          currentName: _userName,
          currentEmail: _userEmail,
          currentPhone: _userPhone,
        ),
      ),
    );

    if (result != null && result is Map) {
      setState(() {
        _userName = result['name'];
        _userEmail = result['email'];
        _userPhone = result['phone'];
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Perfil atualizado com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Perfil'),
        backgroundColor: Color(0xFF679EA2),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Color(0xFF679EA2).withAlpha((0.3 * 255).toInt()),
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Color(0xFF679EA2),
                ),
              ),
              SizedBox(height: 20),
              Text(
                _userName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                _userEmail,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 30),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.email, color: Color(0xFF679EA2)),
                      title: Text('Email'),
                      subtitle: Text(_userEmail),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.phone, color: Color(0xFF679EA2)),
                      title: Text('Telefone'),
                      subtitle: Text(_userPhone),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _editarPerfil,
                icon: Icon(Icons.edit),
                label: Text('Editar Perfil'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF679EA2),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _logout,
                icon: Icon(Icons.logout),
                label: Text('Sair'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final String currentName;
  final String currentEmail;
  final String currentPhone;

  EditProfilePage({
    required this.currentName,
    required this.currentEmail,
    required this.currentPhone,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _emailController = TextEditingController(text: widget.currentEmail);
    _phoneController = TextEditingController(text: widget.currentPhone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    Navigator.pop(context, {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
        backgroundColor: Color(0xFF679EA2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Telefone'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Salvar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF679EA2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}