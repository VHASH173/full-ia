import 'package:flutter/material.dart';

class TerminalScreen extends StatefulWidget {
  const TerminalScreen({super.key});

  @override
  State<TerminalScreen> createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
  final TextEditingController _inputController = TextEditingController();
  final List<String> _history = [];
  final ScrollController _scrollController = ScrollController();

  void _executeCommand() {
    final command = _inputController.text.trim();
    if (command.isEmpty) return;

    setState(() {
      _history.add('\$ $command');
      
      // Simular respuestas
      if (command == 'help') {
        _history.add('Comandos disponibles:');
        _history.add('  ls       - Listar archivos');
        _history.add('  pwd      - Directorio actual');
        _history.add('  git      - Comandos git');
        _history.add('  clear    - Limpiar terminal');
      } else if (command == 'ls') {
        _history.add('main.dart');
        _history.add('pubspec.yaml');
        _history.add('README.md');
      } else if (command == 'pwd') {
        _history.add('/home/nexuscode/project');
      } else if (command == 'clear') {
        _history.clear();
      } else if (command.startsWith('git')) {
        _history.add('Git no disponible en modo simulado');
        _history.add('Usa la pestaña GitHub');
      } else {
        _history.add('Comando no encontrado: $command');
      }
      
      _inputController.clear();
    });

    // Auto-scroll al final
    Future.delayed(const Duration(milliseconds: 50), () {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: const Color(0xFF0D1117),
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final line = _history[index];
                final isPrompt = line.startsWith('\$');
                
                return SelectableText(
                  line,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: isPrompt ? Colors.green : Colors.white,
                  ),
                );
              },
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: const Color(0xFF161B22),
          child: Row(
            children: [
              const Text('\$', style: TextStyle(color: Colors.green)),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _inputController,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Escribe un comando...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => _executeCommand(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.green),
                onPressed: _executeCommand,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
