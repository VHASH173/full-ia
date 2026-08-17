import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GitHubScreen extends StatefulWidget {
  @override
  _GitHubScreenState createState() => _GitHubScreenState();
}

class _GitHubScreenState extends State<GitHubScreen> {
  final _tokenController = TextEditingController();
  final _repoController = TextEditingController();
  bool loading = false;
  String status = '';

  Future<void> _cloneRepo() async {
    setState(() => loading = true);
    
    final response = await http.post(
      Uri.parse('http://localhost:3000/clone'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'repo': _repoController.text,
        'token': _tokenController.text,
      }),
    );
    
    setState(() {
      loading = false;
      status = jsonDecode(response.body)['success'] 
        ? 'Repo clonado!' 
        : 'Error al clonar';
    });
  }

  Future<void> _buildApp() async {
    setState(() => loading = true);
    
    final response = await http.post(
      Uri.parse('http://localhost:3000/build'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'projectPath': '/tmp/${_repoController.text}',
        'type': 'flutter',
      }),
    );
    
    final result = jsonDecode(response.body);
    setState(() {
      loading = false;
      status = result['success'] 
        ? 'Build exitoso! URL: ${result['downloadUrl']}' 
        : 'Error en build';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GitHub Integration')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tokenController,
              decoration: InputDecoration(
                labelText: 'GitHub Token',
                hintText: 'ghp_xxxxxxxxxxxx',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _repoController,
              decoration: InputDecoration(
                labelText: 'Repo (user/repo)',
                hintText: 'miusuario/miapp',
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: loading ? null : _cloneRepo,
                    child: Text('Clonar'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: loading ? null : _buildApp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text('Build APK'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            if (loading) CircularProgressIndicator(),
            Text(status, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
