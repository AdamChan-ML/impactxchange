import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import './api_service.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Map<String, dynamic>> messages = [];
  Map<String, dynamic> users = {};
  final ApiService apiService = ApiService();
  TextEditingController messageController = TextEditingController();

  String currentUserId = '-O4nyJlrtc2TGr5VFinZ';  // Replace with the actual current user ID
  String chatId = '-O4p5NA_fK6avzFXmCjE';  // Replace with the actual chat ID

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  void fetchMessages() async {
    try {
      final response = await apiService.getMessages(chatId);
      if (response != null) {
        setState(() {
          messages = List<Map<String, dynamic>>.from(response['messages']);
          users = Map<String, dynamic>.from(response['users']);
        });
      }
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  void sendMessage() async {
    String messageText = messageController.text;
    if (messageText.isNotEmpty) {
      // Add message to local list for immediate feedback
      setState(() {
        messages.add({
          'sender': currentUserId,
          'text': messageText,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        });
        messageController.clear();
      });

      // Send message to server
      try {
        final response = await apiService.sendMessage(
          chatId: chatId,
          senderId: currentUserId,
          messageText: messageText,
        );

        // if (response == null) {
        //   // Handle the case where the message fails to send, e.g., show a toast
        //   print('Failed to send message');
        // } else {
        //   // Optionally refresh messages
        //   fetchMessages();
        // }
      } catch (e) {
        print('Error sending message: $e');
      }
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
              onPressed: () {
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
                final message = messages[index];
                final user = users[message['sender']];
                return Align(
                  alignment: message['sender'] == currentUserId
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: message['sender'] == currentUserId
                          ? Colors.blue
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user != null ? user['name'] : 'Unknown User',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          message['text'],
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
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

