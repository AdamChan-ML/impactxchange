const express = require('express');
const admin = require('firebase-admin');
const app = express();
const crypto = require('crypto'); // Add this to generate unique IDs
const cors = require('cors'); // Add this to enable CORS

app.use(cors()); // Enable CORS
// Load Firebase service account key
const serviceAccount = require('./db-service-account-key.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://kaki-lingua-db-default-rtdb.asia-southeast1.firebasedatabase.app" 
});

const db = admin.database();

app.use(express.json()); // To parse incoming JSON request bodies

// Helper function to generate unique chat IDs
function generateUniqueChatId() {
  return crypto.randomBytes(16).toString('hex'); // Generates a 32-character unique ID
}

// Add new user API endpoint
app.post('/add-user', (req, res) => {
  const { email, password, name, hobby, language, location } = req.body;

  // Save user data to Firebase Realtime Database
  const userRef = db.ref('users').push();
  userRef.set({
    email,
    password,
    name,
    hobby,
    language,
    location
  })
  .then(() => res.status(200).send('User added successfully'))
  .catch(error => res.status(500).send('Error adding user: ' + error));
});

// Send message API endpoint
app.post('/send-message', (req, res) => {
  const { chatId, senderId, messageText } = req.body;

  if (!chatId || !senderId || !messageText) {
    return res.status(400).send('Missing required fields');
  }

  const messagesRef = db.ref(`chats/${chatId}/messages`);
  messagesRef.once('value', (snapshot) => {
    let messages = snapshot.val() || [];
    const newMessage = {
      sender: senderId,
      text: messageText,
      timestamp: Date.now()
    };
    messages.push(newMessage);
    messagesRef.set(messages)
      .then(() => res.status(200).send('Message sent'))
      .catch((error) => res.status(500).send('Error sending message: ' + error));
  });
});

//Testing
app.get('/testing', (req, res) => {
  res.status(200).send('Hello World');
});

// Get message API endpoint
app.get('/get-messages/:chatId', (req, res) => {
  const { chatId } = req.params;

  db.ref(`chats/${chatId}/messages`).once('value')
    .then(snapshot => {
      const messages = snapshot.val() || [];
      const userIds = new Set();
      messages.forEach(msg => userIds.add(msg.sender));

      const userPromises = Array.from(userIds).map(userId =>
        db.ref(`users/${userId}`).once('value').then(userSnapshot => ({
          [userId]: userSnapshot.val()
        }))
      );

      Promise.all(userPromises).then(users => {
        const userData = Object.assign({}, ...users);
        res.status(200).json({ messages, users: userData });
      });
    })
    .catch(error => res.status(500).send('Error retrieving messages: ' + error));
});

// Create chat API endpoint
app.post('/create-chat', (req, res) => {
  const { user1, user2 } = req.body;

  // Validate the input
  if (!user1 || !user2) {
    return res.status(400).send('Missing required user IDs');
  }

  // Create a new chat session in Firebase with a unique ID
  const chatRef = db.ref('chats').push();  // This automatically generates a unique chat ID
  const chatId = chatRef.key;              // Get the generated chat ID

  // Set the chat data in Firebase
  chatRef.set({
    users: {
      [user1]: true,
      [user2]: true
    },
    messages: [] // Start with an empty message array
  })
  .then(() => res.status(200).json({ chatId }))
  .catch((error) => res.status(500).send('Error creating chat: ' + error));
});

// Start the server
const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
