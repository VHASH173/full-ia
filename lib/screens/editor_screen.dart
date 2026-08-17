import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter/services.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  late CodeController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = CodeController(
      text: '''// Bienvenido a NexusCode
// Escribe tu código aquí

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}''',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: const Color(0xFF161B22),
          child: Row(
            children: [
              const Icon(Icons.file_open, size: 16),
              const SizedBox(width: 8),
              const Text('main.dart'),
              const Spacer(),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.save, size: 16),
                label: const Text('Guardar'),
              ),
            ],
          ),
        ),
        Expanded(
          child: CodeField(
            controller: _controller,
            textStyle: const TextStyle(fontFamily: 'monospace', fontSize: 14),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
