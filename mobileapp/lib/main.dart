import 'package:flutter/material.dart';
import './landingPage.dart';
import './signinPage.dart';
import './signupPage.dart';
import './profilePage.dart';
import './communityPage.dart';
import './chatPage.dart';
import './levelPath.dart';
import './learningScreen.dart';
import './learningScreen2Page.dart';
import './matchingScreenPage.dart';
import './chathistory.dart';
import './signupInfo.dart';

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
        '/community': (context) => CommunityPage(),
      },
    );
  }
}
