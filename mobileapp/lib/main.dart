import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(UserMatchingApp());
}

class UserMatchingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Matching App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserFormScreen(),
    );
  }
}

class UserFormScreen extends StatefulWidget {
  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _interestsController = TextEditingController();
  final TextEditingController _languagesController = TextEditingController();

  List<dynamic> _matches = [];

  Future<void> _registerUser() async {
    final user = {
      'name': _nameController.text,
      'age': int.parse(_ageController.text),
      'interests': _interestsController.text.split(',').map((item) => item.trim()).toList(),
      'languages': _languagesController.text.split(',').map((item) => item.trim()).toList(),
    };

    final response = await http.post(
      Uri.parse('http://localhost:5000/api/users'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User Registered!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to register user')));
    }
  }

  Future<void> _findMatches() async {
    final user = {
      'age': int.parse(_ageController.text),
      'interests': _interestsController.text.split(',').map((item) => item.trim()).toList(),
      'languages': _languagesController.text.split(',').map((item) => item.trim()).toList(),
    };

    final response = await http.post(
      Uri.parse('http://localhost:5000/api/match'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user),
    );

    if (response.statusCode == 200) {
      setState(() {
        _matches = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to find matches')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Matching App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _interestsController,
              decoration: InputDecoration(labelText: 'Interests (comma separated)'),
            ),
            TextField(
              controller: _languagesController,
              decoration: InputDecoration(labelText: 'Languages (comma separated)'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _registerUser,
              child: Text('Register'),
            ),
            ElevatedButton(
              onPressed: _findMatches,
              child: Text('Find Matches'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _matches.length,
                itemBuilder: (context, index) {
                  final match = _matches[index];
                  return ListTile(
                    title: Text('${match['user']['name']} - Score: ${match['score']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
