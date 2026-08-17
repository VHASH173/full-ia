import 'package:flutter/material.dart';
import 'screens/terminal_screen.dart';
import 'screens/github_screen.dart';

void main() => runApp(NexusCode());

class NexusCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NexusCode',
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  final _screens = [
    TerminalScreen(),
    GitHubScreen(),
    Center(child: Text('OSINT Tools')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.terminal), label: 'Terminal'),
          BottomNavigationBarItem(icon: Icon(Icons.code), label: 'GitHub'),
          BottomNavigationBarItem(icon: Icon(Icons.security), label: 'OSINT'),
        ],
      ),
    );
  }
}
