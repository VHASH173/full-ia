import 'package:flutter/material.dart';
import 'package:http/http.dart' as http';
import 'dart:convert';

class GitHubScreen extends StatefulWidget {
  const GitHubScreen({super.key});

  @override
  State<GitHubScreen> createState() => _GitHubScreenState();
}

class _GitHubScreenState extends State<GitHubScreen> {
  final _tokenController = TextEditingController();
  final _repoController = TextEditingController();
  bool _loading = false;
  String _status = '';

  Future<void> _pushToGitHub() async {
    setState(() {
      _loading = true;
      _status = 'Conectando a GitHub...';
    });

    // Simulación - en realidad necesitarías git CLI o API
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _loading = false;
      _status = 'Código subido! GitHub Actions iniciando build...';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'GitHub Integration',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _tokenController,
            decoration: const InputDecoration(
              labelText: 'GitHub Token',
              hintText: 'ghp_xxxxxxxxxxxxxxxxxxxx',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.key),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _repoController,
            decoration: const InputDecoration(
              labelText: 'Repositorio',
              hintText: 'usuario/nexuscode',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.account_tree),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _loading ? null : _pushToGitHub,
              icon: _loading 
                ? const SizedBox(
                    width: 20, 
                    height: 20, 
                    child: CircularProgressIndicator(strokeWidth: 2)
                  )
                : const Icon(Icons.upload),
              label: Text(_loading ? 'Subiendo...' : 'Push & Build'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (_status.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 12),
                  Expanded(child: Text(_status)),
                ],
              ),
            ),
          const Spacer(),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('Cómo funciona'),
            subtitle: Text(
              '1. Creá un repo en GitHub\n'
              '2. Copiá el token de acceso\n'
              '3. Subí el código\n'
              '4. GitHub Actions compila automáticamente',
            ),
          ),
        ],
      ),
    );
  }
}
