import 'package:flutter/material.dart';
import 'terminal_screen.dart';
import 'editor_screen.dart';
import 'github_screen.dart';
import 'osint_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  
  final List<Widget> _screens = const [
    EditorScreen(),
    TerminalScreen(),
    GitHubScreen(),
    OsintScreen(),
  ];

  final List<String> _titles = [
    'Editor',
    'Terminal',
    'GitHub',
    'OSINT',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NexusCode - ${_titles[_selectedIndex]}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () {},
            tooltip: 'Run',
          ),
          IconButton(
            icon: const Icon(Icons.build),
            onPressed: () {},
            tooltip: 'Build',
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.code),
            label: 'Editor',
          ),
          NavigationDestination(
            icon: Icon(Icons.terminal),
            label: 'Terminal',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_tree),
            label: 'GitHub',
          ),
          NavigationDestination(
            icon: Icon(Icons.security),
            label: 'OSINT',
          ),
        ],
      ),
    );
  }
}
