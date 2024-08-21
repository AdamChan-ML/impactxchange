import 'package:flutter/material.dart';

void main() {
  runApp(KakiLinguaApp());
}

class KakiLinguaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kaki Lingua',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
      routes: {
        '/signin': (context) => SignInPage(),
        '/signup': (context) => SignUpPage(),
        '/signupInfo': (context) => SignUpInfoPage(),
        '/chatHistory': (context) => ChatHistoryPage(),
        '/chat': (context) => ChatPage(),
      },
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"), // Background image
                fit: BoxFit.contain,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                // App Title
                Center(
                  child: Text(
                    'Welcome Back, Buddy!',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Login Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Center(
                    child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  ),
                ),
                SizedBox(height: 20),
                // Sign Up Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Center(
                    child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"), // Background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Title
                  SizedBox(height: 30),
                  // Email Input
                  TextField(
                    decoration: InputDecoration(labelText: 'Student Email'),
                  ),
                  // Password Input
                  TextField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  // Sign In Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/chatHistory');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Forgot Password
                  TextButton(
                    onPressed: () {
                      // Navigate to forgot password
                    },
                    child: Text('Forgot password?'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20), // Adjust the margin as needed
            padding: EdgeInsets.all(20), // Padding inside the box
            decoration: BoxDecoration(
              color: Colors.white, // White background
              borderRadius: BorderRadius.circular(15), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Slight shadow for depth
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // Shadow position
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signupInfo');
                    },
                  child: Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  }
}

class SignUpInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // White box with sign-up information
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20), // Adjust the margin as needed
              padding: EdgeInsets.all(20), // Padding inside the box
              decoration: BoxDecoration(
                color: Colors.white, // White background
                borderRadius: BorderRadius.circular(15), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Slight shadow for depth
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Hobby',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Location',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Language You Speak',
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Add navigation or function here
                    },
                    child: Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ChatHistoryPage extends StatelessWidget {
  List<Map<String, dynamic>> chatHistory = [
    {
      'name': 'Person',
      'message': 'Hi, David. Hope you\'re doing...',
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
              backgroundImage: AssetImage('assets/profile_${index + 1}.jpg'),
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

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person'),
      ),
      body: ListView(
        children: [
          // Implement message bubbles here
          // Use a combination of Text and Container widgets to create the desired layout
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Send a message',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                // Implement message sending logic
              },
            ),
          ],
        ),
      ),
    );
  }
}