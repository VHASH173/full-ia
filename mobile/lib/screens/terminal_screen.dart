import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class TerminalScreen extends StatefulWidget {
  @override
  _TerminalScreenState createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
  late IO.Socket socket;
  final TextEditingController _controller = TextEditingController();
  List<String> output = [];
  
  @override
  void initState() {
    super.initState();
    socket = IO.io('http://localhost:3000', 
      IO.OptionBuilder().setTransports(['websocket']).build());
    
    socket.on('output', (data) {
      setState(() => output.add(data));
    });
  }

  void _sendCommand() {
    socket.emit('command', _controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Nexus Terminal'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: output.length,
              itemBuilder: (_, i) => Text(
                output[i],
                style: TextStyle(color: Colors.green, fontFamily: 'monospace'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Text('\$ ', style: TextStyle(color: Colors.green)),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'ls, pwd, git clone...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _sendCommand(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.green),
                  onPressed: _sendCommand,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
