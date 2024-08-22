import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://impactxchange-433008.de.r.appspot.com';

class ApiService {
  // 1. Add New User
  Future<void> addUser({
    required String email,
    required String password,
    required String name,
    required String hobby,
    required String language,
    required String location,
  }) async {
    final url = Uri.parse('$baseUrl/user');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'name': name,
        'hobby': hobby,
        'language': language,
        'location': location,
      }),
    );

    if (response.statusCode == 200) {
      print('User added successfully');
    } else {
      print('Failed to add user: ${response.body}');
    }
  }

  // 2. Get User Info
  Future<Map<String, dynamic>?> getUserInfo(String userId) async {
    final url = Uri.parse('$baseUrl/user/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      print('User not found');
    } else {
      print('Failed to retrieve user info: ${response.body}');
    }
    return null;
  }

  // 3. Match User
  Future<Map<String, dynamic>?> matchUser(String userId) async {
    final url = Uri.parse('$baseUrl/match-user/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      print('User not found');
    } else {
      print('Failed to match user: ${response.body}');
    }
    return null;
  }

  // 4. Send Message
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String messageText,
  }) async {
    final url = Uri.parse('$baseUrl/send-message');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'chatId': chatId,
        'senderId': senderId,
        'messageText': messageText,
      }),
    );

    if (response.statusCode == 200) {
      print('Message sent successfully');
    } else if (response.statusCode == 400) {
      print('Bad request: Missing required fields');
    } else {
      print('Failed to send message: ${response.body}');
    }
  }

  // 5. Get Messages
  Future<Map<String, dynamic>?> getMessages(String chatId) async {
    final url = Uri.parse('$baseUrl/get-messages/$chatId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Failed to retrieve messages: ${response.body}');
    }
    return null;
  }

  // 6. Create Chat
  Future<String?> createChat({
    required String user1,
    required String user2,
  }) async {
    final url = Uri.parse('$baseUrl/create-chat');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user1': user1,
        'user2': user2,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['chatId'];
    } else if (response.statusCode == 400) {
      print('Bad request: Missing required user IDs');
    } else {
      print('Failed to create chat: ${response.body}');
    }
    return null;
  }
}
