import 'package:flutter/material.dart';

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
