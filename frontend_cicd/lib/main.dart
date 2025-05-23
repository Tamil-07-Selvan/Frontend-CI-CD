import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaxSumApp());
}

class MaxSumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MaxSumPage());
  }
}

class MaxSumPage extends StatefulWidget {
  @override
  _MaxSumPageState createState() => _MaxSumPageState();
}

class _MaxSumPageState extends State<MaxSumPage> {
  final TextEditingController _arrayController = TextEditingController();
  final TextEditingController _windowSizeController = TextEditingController();
  String _result = "";

  Future<void> getMaxSum() async {
    final uri = Uri.parse("https://backend-ci-cd-hsks.onrender.com/max-sum"); // Replace with Render URL if deployed
    
    final response = await http.post(uri,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "array": _arrayController.text.split(',').map((e) => int.parse(e.trim())).toList(),
        "windowSize": int.parse(_windowSizeController.text)
      }),
    );

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      setState(() {
        _result = "Maximum Sum: ${jsonRes['result']}";
      });
    } else {
      setState(() {
        _result = "Error occurred.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Max Sum in Sliding Window")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _arrayController, decoration: InputDecoration(labelText: "Enter array (comma-separated)")),
            TextField(controller: _windowSizeController, decoration: InputDecoration(labelText: "Window size"), keyboardType: TextInputType.number),
            ElevatedButton(onPressed: getMaxSum, child: Text("Calculate")),
            SizedBox(height: 20),
            Text(_result, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
