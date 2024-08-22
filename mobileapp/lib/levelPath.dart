import 'package:flutter/material.dart';

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

