import 'package:flutter/material.dart';
import 'package:http/http.dart' as http';
import 'dart:convert';

class OsintScreen extends StatefulWidget {
  const OsintScreen({super.key});

  @override
  State<OsintScreen> createState() => _OsintScreenState();
}

class _OsintScreenState extends State<OsintScreen> {
  final _usernameController = TextEditingController();
  final _domainController = TextEditingController();
  String _results = '';

  void _searchUsername() async {
    // Simulación - en producción usarías Sherlock API o similar
    setState(() {
      _results = '''
Buscando: ${_usernameController.text}

[+] Instagram: https://instagram.com/${_usernameController.text}
[+] Twitter: https://twitter.com/${_usernameController.text}
[+] GitHub: https://github.com/${_usernameController.text}
[+] Reddit: Posible match encontrado
[+] TikTok: No encontrado
[+] LinkedIn: https://linkedin.com/in/${_usernameController.text}

Total: 4 redes encontradas
''';
    });
  }

  void _scanDomain() {
    setState(() {
      _results = '''
Escaneando: ${_domainController.text}

Puertos abiertos:
- 80/tcp   (HTTP)
- 443/tcp  (HTTPS)
- 22/tcp   (SSH)

Tecnologías detectadas:
- nginx 1.18.0
- PHP 8.0
- MySQL

DNS Records:
- A: 192.168.1.1
- MX: mail.${_domainController.text}
''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'OSINT Toolkit',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          
          // Username Search
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sherlock - Username Search',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      hintText: 'username',
                      prefixIcon: Icon(Icons.person_search),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _searchUsername,
                    icon: const Icon(Icons.search),
                    label: const Text('Buscar en redes'),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Domain Scan
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nmap - Port Scanner',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _domainController,
                    decoration: const InputDecoration(
                      hintText: 'example.com',
                      prefixIcon: Icon(Icons.language),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _scanDomain,
                    icon: const Icon(Icons.radar),
                    label: const Text('Escanear puertos'),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Results
          if (_results.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0D1117),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade800),
              ),
              child: SelectableText(
                _results,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
