import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
        '/level1': (context) => LearningScreen(),
        '/matching': (context) => MatchingScreen(),
        '/level2': (context) => LearningScreen2(),
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
                    textAlign: TextAlign.center,
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
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Centered Content with White Box Overlay
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                padding: EdgeInsets.all(20), // Padding inside the white box
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9), // Slight transparency
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4), // Shadow position
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
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
                    labelText: 'Student Email',
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

  void reportMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController reportController = TextEditingController();
        return AlertDialog(
          title: Text("Report Message"),
          content: TextField(
            controller: reportController,
            decoration: InputDecoration(hintText: "Enter your reason for reporting"),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Handle the report submission here
                print('Reported: ${reportController.text}');
                Navigator.of(context).pop();
              },
              child: Text("Report"),
            ),
          ],
        );
      },
    );
  }

  void rateChat() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double rating = 0.0;
        TextEditingController ratingController = TextEditingController();

        return AlertDialog(
          title: Text("Rate This Person"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (value) {
                  rating = value;
                },
              ),
              SizedBox(height: 16),
              TextField(
                controller: ratingController,
                decoration: InputDecoration(hintText: "Additional comments (optional)"),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Handle the rating submission here
                print('Rating: $rating, Comments: ${ratingController.text}');
                Navigator.of(context).pop();
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Chat'),
            IconButton(
              icon: Icon(Icons.home),
              onPressed: (){
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.report),
            onPressed: reportMessage,
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: rateChat,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
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
                      Text('Kaki Points: 1250'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('Badges:'),
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
                  SizedBox(width: 8),
                  CircleAvatar(radius: 25, child: Text('J')),
                  SizedBox(width: 8),
                  CircleAvatar(radius: 25, child: Text('T')),
                  SizedBox(width: 8),
                  CircleAvatar(radius: 25, child: Text('Q')),
                  SizedBox(width: 8),
                  CircleAvatar(radius: 25, child: Text('B')),
                  SizedBox(width: 8),
                  CircleAvatar(radius: 25, child: Text('A')),
                ],
              ),
              SizedBox(height: 16),
              Text('Communities'),
              SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(width: 8),
                  CircleAvatar(radius: 25, child: Icon(Icons.sports_soccer), backgroundColor: const Color.fromARGB(255, 147, 234, 150)),
                  SizedBox(width: 8),
                  CircleAvatar(radius: 25, child: Icon(Icons.music_note), backgroundColor: const Color.fromARGB(255, 247, 152, 184),),
                  SizedBox(width: 8),
                  CircleAvatar(radius: 25, child: Icon(Icons.book_sharp), backgroundColor: const Color.fromARGB(255, 148, 187, 255),),
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
            child: _buildLevelButton('Level 1', context),
          ),
          Positioned(
            bottom: 150,
            right: 50,
            child: _buildLevelButton('Level 2', context),
          ),
          Positioned(
            bottom: 350,
            left: 80,
            child: _buildLevelButton('Level 3', context),
          ),
          Positioned(
            top: 300,
            right: 40,
            child: _buildLevelButton('Level 4', context),
          ),
          Positioned(
            top: 200,
            left: 40,
            child: _buildLevelButton('Level 5', context),
          ),
          
          // Meet someone button
          Positioned(
            top: 100,
            left: 120,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/matching');  
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

  Widget _buildLevelButton(String text, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (text == 'Level 1') {
          Navigator.pushNamed(context, '/level1');
        } else if (text == 'Level 2') {
          Navigator.pushNamed(context, '/level2');
        } else {
          Navigator.pushNamed(context, '/level2');
        }
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

class LearningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level 1 (Malay)'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },  
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Pagi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12.0), 
              decoration: BoxDecoration(
                color: Colors.purple[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Meaning:\nGood Morning',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('Examples:'),
            SizedBox(height: 8),
            Text('Selamat pagi kepada semua = Good morning to all'),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/level2');
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class LearningScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level 2 (Malay)'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },  
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nasi Lemak',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12.0), 
              decoration: BoxDecoration(
                color: Colors.purple[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Meaning:\nNasi lemak is a dish originating in Malay cuisine that consists of fragrant rice cooked in coconut milk and pandan leaf. ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('Examples:'),
            Image.asset('assets/nasilemak.jpg'),
            SizedBox(height: 16),
            Text('Recommended Places: \n1. Village Park Restaurant \n2. Nasi Lemak Bumbung \n3. Nasi Lemak Tanglin'),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Handle "Next" button action
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class MatchingScreen extends StatefulWidget {
  @override
  _MatchingScreenState createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  bool isMatched = false;

  @override
  void initState() {
    super.initState();
    _startMatchingProcess();
  }

  void _startMatchingProcess() async {
    // Simulate a network request or some async task
    await Future.delayed(Duration(seconds: 3)); // Simulate a 3-second delay
    setState(() {
      isMatched = true;
    });
  }
  
  void showMatchedPersonInfo(String name, int age, String interests, String language, String location, String badge) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Matched Successfully!"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Name: $name"),
            Text("Age: $age"),
            Text("Interests: $interests"),
            Text("Language: $language"),
            Text("Location: $location"),
            Row(
              children: [
                Text("Badges: "),
                Icon(Icons.star),
                Text("$badge"),
              ],
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close"),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isMatched ? "Matched Successfully!" : "Matching someone for you....",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile1.png'), // Replace with your image
                ),
                SizedBox(width: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: isMatched ? AssetImage('assets/profile2.png') : null, // Replace with your image
                  backgroundColor: Colors.grey.shade300,
                  child: isMatched
                      ? null
                      : Icon(Icons.person, size: 50, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (!isMatched)
              CircularProgressIndicator()
            else ...[
              Icon(Icons.check_circle, color: Colors.green, size: 50),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showMatchedPersonInfo('Person', 25, 'Football, Music', 'Chinese, Spanish', 'Sunway', 'Trustworthiness');
                },
                child: Text('View Matched Person'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/chat');
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Start Chatting",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

