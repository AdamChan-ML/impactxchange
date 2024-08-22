import 'package:flutter/material.dart';

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
                  showMatchedPersonInfo('Peter', 25, 'Football, Music', 'Chinese, Spanish', 'Sunway', 'Trustworthiness');
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

