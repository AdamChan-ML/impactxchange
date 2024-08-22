import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatHistoryPage extends StatelessWidget {
  List<Map<String, dynamic>> chatHistory = [
    {
      'name': 'Peter',
      'message': 'Hi, Peter. Hope you\'re doing...',
      'timestamp': '29 mar',
    },
    {
      'name': 'Merry An.',
      'message': 'Are you ready for today\'s part..',
      'timestamp': '12 mar',
    },
    {
      'name': 'John Walton',
      'message': 'I\'m sending you a parcel rece..',
      'timestamp': '08 Feb',
    },
    {
      'name': 'Monica Randawa',
      'message': 'Hope you\'re doing well today..',
      'timestamp': '02 Feb',
    },
    {
      'name': 'Innoxent Jay',
      'message': 'Let\'s get back to the work, You..',
      'timestamp': '25 Jan',
    },
    {
      'name': 'Harry Samit',
      'message': 'Listen david, i have a problem..',
      'timestamp': '18 Jan',
    },
    {
      'name': 'Jonnas Autron',
      'message': 'Hi, David. Hope you\'re doing...',
      'timestamp': '18 Jan',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat History'),
      ),
      body: ListView.builder(
        itemCount: chatHistory.length,
        itemBuilder: (context, index) {
          final chat = chatHistory[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/profile${index + 1}.png'),
            ),
            title: Text(chat['name']),
            subtitle: Text(chat['message']),
            trailing: Text(chat['timestamp']),
            onTap: () {
              // Navigate to the chat page
              Navigator.pushNamed(context, '/chat', arguments: chat);
            },
          );
        },
      ),
    );
  }
}

