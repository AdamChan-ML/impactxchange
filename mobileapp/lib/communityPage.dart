import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  final String communityName = 'Football';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$communityName Community'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Community Header
            Text(
              'Welcome to the $communityName Community!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Community Description
            Text(
              'Here you can find all the latest updates, discussions, and events related to $communityName.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            // Example Community Content
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Replace with actual number of posts or events
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text('$communityName Post #$index'),
                      subtitle: Text('Description of $communityName post #$index.'),
                      trailing: Icon(Icons.more_vert),
                      onTap: () {
                        // Handle post tap
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}