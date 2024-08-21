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
        '/profile': (context) => UserProfileScreen(),
        '/chatHistory': (context) => ChatHistoryPage(),
        '/chat': (context) => ChatPage(),
        '/levelPath': (context) => LevelPathPage(),
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
                      Navigator.pushNamed(context, '/profile');
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
                      Navigator.pushNamed(context, '/profile');
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

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<String> messages = [];

  TextEditingController messageController = TextEditingController();

  void sendMessage() {
    String message = messageController.text;
    if (message.isNotEmpty) {
      setState(() {
        messages.add(message);
        messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight, // Align the message to the right
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      messages[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: sendMessage,
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile1.png'),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Person', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('Chinese Native Speaker'),
                      Text('Learning Level: Level 1'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('Badges'),
                  SizedBox(width: 16),
                  Icon(Icons.star),
                  Text('Trustworthiness'),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/levelPath');
                    },
                    child: Text('Start Learning'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/chatHistory');
                    },
                    child: Text('Chat'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('Friends'),
              SizedBox(height: 8),
              Row(
                children: [
                  CircleAvatar(radius: 25, child: Icon(Icons.add)),
                  SizedBox(width: 8),
                  CircleAvatar(radius: 25, child: Text('J')),
                  SizedBox(width: 8),
                  CircleAvatar(radius: 25, child: Text('T')),
                  SizedBox(width: 8),
                  CircleAvatar(radius: 25, child: Text('Q')),
                  SizedBox(width: 8),
                  CircleAvatar(radius: 25, child: Text('B')),
                ],
              ),
              SizedBox(height: 16),
              Text('Profile'),
              SizedBox(height: 8),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Name: Person'),
              ),
              ListTile(
                leading: Icon(Icons.star),
                title: Text('Hobby: Football, Music'),
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text('Languages: Chinese, Spanish'),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Location: Sunway'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle edit profile action
                },
                child: Text('Edit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LevelPathPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/levelsmap.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          
          // Level buttons
          Positioned(
            bottom: 50,
            left: 50,
            child: _buildLevelButton('Level 1'),
          ),
          Positioned(
            bottom: 150,
            right: 50,
            child: _buildLevelButton('Level 2'),
          ),
          Positioned(
            bottom: 350,
            left: 80,
            child: _buildLevelButton('Level 3'),
          ),
          Positioned(
            top: 300,
            right: 40,
            child: _buildLevelButton('Level 4'),
          ),
          Positioned(
            top: 200,
            left: 40,
            child: _buildLevelButton('Level 5'),
          ),
          
          // Meet someone button
          Positioned(
            top: 100,
            left: 120,
            child: ElevatedButton(
              onPressed: () {
                // Handle meet someone action
              },
              child: Text('Meet someone!'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD38160),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelButton(String text) {
    return ElevatedButton(
      onPressed: () {
        // Handle level button press
      },
      child: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFD38160),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      ),
    );
  }
}

