import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(KakiLinguaApp());
}

class ThemeNotifier with ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class KakiLinguaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            title: 'Kaki Lingua',
            theme: ThemeData(
              brightness: themeNotifier.isDarkMode ? Brightness.dark : Brightness.light,
              primarySwatch: Colors.blue,
              // Customize other theme properties here
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
        },
      ),
    );
  }
}