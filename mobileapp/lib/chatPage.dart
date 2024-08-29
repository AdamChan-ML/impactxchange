import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'api_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatPage extends StatefulWidget {
  final String chatId = '56f51b4f84c027b657db243479ed6081';
  final String currentUserId = '-O5LaqhSXq9XWRp-wJr9';

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Map<String, dynamic>> messages = [];
  final ApiService apiService = ApiService();
  WebSocketChannel? channel;
  TextEditingController messageController = TextEditingController();
  late Box messageBox;

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    await Hive.initFlutter();
    messageBox = await Hive.openBox('chat_${widget.chatId}');
    await fetchMessages();
    // Connect to the WebSocket server
    channel = IOWebSocketChannel.connect('wss://kakilingua-be-nl2s2bqana-as.a.run.app/ws');

    // Listen for incoming messages
    channel?.stream.listen((message) {
      final decodedMessage = _parseMessage(message);
      if (decodedMessage != null) {
        setState(() {
          messages.add(decodedMessage);
        });
        saveMessages(); // Save new messages to Hive
      }
    }, onDone: () {
      print('WebSocket connection closed');
    }, onError: (error) {
      print('WebSocket error: $error');
    });
  }

  Map<String, dynamic>? _parseMessage(dynamic message) {
    try {
      final data = jsonDecode(message);
      if (data['type'] == 'NEW_MESSAGE' && data['chatId'] == widget.chatId) {
        return {
          'sender': data['message']['sender'],
          'text': data['message']['text'],
          'timestamp': data['message']['timestamp'],
        };
      }
    } catch (e) {
      print('Error parsing message: $e');
    }
    return null;
  }

  @override
  void dispose() {
    channel?.sink.close();
    super.dispose();
  }

  Future<void> fetchMessages() async {
    try {
      // Load messages from Hive
      final cachedMessages = messageBox.get('messages', defaultValue: []);
      if (cachedMessages.isNotEmpty) {
        setState(() {
          messages = List<Map<String, dynamic>>.from(cachedMessages);
        });
      }

      // Fetch messages from API
      final response = await apiService.getMessages(widget.chatId);
      if (response != null) {
        final newMessages = List<Map<String, dynamic>>.from(response['messages']);
        setState(() {
          messages = newMessages;
        });
        saveMessages(); // Save fetched messages to Hive
      }
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  Future<void> saveMessages() async {
    try {
      final messagesMap = messages.map((e) => e).toList();
      await messageBox.put('messages', messagesMap);
    } catch (e) {
      print('Error saving messages: $e');
    }
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      final message = {
        'type': 'SEND_MESSAGE',
        'chatId': widget.chatId,
        'senderId': widget.currentUserId,
        'messageText': messageController.text,
      };

      try {
        channel?.sink.add(jsonEncode(message)); // Send message as JSON
        messageController.clear();
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
        title: Text('Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.report),
            onPressed: () {
              reportMessage();
            },
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
             rateChat();
            },
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
                final isCurrentUser = message['sender'] == widget.currentUserId;
                return Align(
                  alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isCurrentUser ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      message['text'],
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