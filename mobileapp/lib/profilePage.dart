import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './main.dart'; // Ensure this import is correct based on your project structure

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          Switch(
            value: themeNotifier.isDarkMode,
            onChanged: (value) {
              themeNotifier.toggleTheme();
            },
          ),
        ],
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
                      Text(
                        'Jia Ern',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/community');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 147, 234, 150),
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(16),
                    ),
                    child: Icon(Icons.sports_soccer),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Handle music button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 247, 152, 184),
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(16),
                    ),
                    child: Icon(Icons.music_note),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Handle book button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 148, 187, 255),
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(16),
                    ),
                    child: Icon(Icons.book_sharp),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('Profile'),
              SizedBox(height: 8),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Name: Jia Ern'),
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