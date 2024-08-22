const express = require('express');
const admin = require('firebase-admin');
const cors = require('cors');  // Import cors
const app = express();
const crypto = require('crypto'); // Add this to generate unique IDs

app.use(cors()); // Enable CORS
// Load Firebase service account key
const serviceAccount = require('./db-service-account-key.json');

const port = 3001;

// // Enable CORS for all origins
// app.use(cors({
//   origin: 'http://localhost:3000'  
// }));

// Parse JSON bodies
app.use(express.json());

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

// Helper function to extract the domain from an email
function getEmailDomain(email) {
  return email.split('@')[1];
}

// Helper function to calculate the matching score
function calculateMatchingScore(user1, user2) {
  let score = 0;

  if (user1.location === user2.location) score += 3;
  if (user1.hobby === user2.hobby) score += 2;
  if (getEmailDomain(user1.email) === getEmailDomain(user2.email)) score += 2;
  if (user1.language !== user2.language) score += 3;

  return score;
}

// Helper function to sanitize user data
function sanitizeUserData(user) {
  const { email, password, ...sanitizedData } = user;
  return sanitizedData;
}

// Matching API endpoint
app.get('/match-user/:userId', (req, res) => {
  const { userId } = req.params;

  db.ref('users').once('value', snapshot => {
    const users = snapshot.val();
    const currentUser = users[userId];

    if (!currentUser) {
      return res.status(404).send('User not found');
    }

    let bestMatch = null;
    let highestScore = 0;

    Object.keys(users).forEach(key => {
      if (key !== userId) {  // Don't match with oneself
        const otherUser = users[key];
        const score = calculateMatchingScore(currentUser, otherUser);

        if (score > highestScore) {
          highestScore = score;
          bestMatch = otherUser;
        }
      }
    });

    if (bestMatch) {
      res.status(200).json({
        message: 'Match found!',
        match: sanitizeUserData(bestMatch), // Use sanitized user data
        score: highestScore
      });
    } else {
      res.status(200).json({ message: 'No suitable match found.' });
    }
  })
  .catch(error => res.status(500).send('Error matching user: ' + error));
});

// Add new user API endpoint
app.post('/user', (req, res) => {
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

// Get user info API endpoint
app.get('/user/:userId', (req, res) => {
  const { userId } = req.params;

  // Retrieve user data from Firebase Realtime Database
  db.ref(`users/${userId}`).once('value')
    .then(snapshot => {
      const userInfo = snapshot.val();
      if (userInfo) {
        res.status(200).json(userInfo);
      } else {
        res.status(404).send('User not found');
      }
    })
    .catch(error => res.status(500).send('Error retrieving user info: ' + error));
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
