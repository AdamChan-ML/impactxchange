const express = require('express');
const admin = require('firebase-admin');
const cors = require('cors');
const app = express();
const crypto = require('crypto');
const http = require('http');

app.use(cors());

// Load Firebase service account key
const serviceAccount = require('./db-service-account-key.json');

const port = 3001;

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://kaki-lingua-db-default-rtdb.asia-southeast1.firebasedatabase.app" 
});

const db = admin.database();

app.use(express.json());
app.use(cors({
  origin: '*'
}));

// Setup HTTP server
const server = http.createServer(app);

// Import and setup WebSocket server
const setupWebSocketServer = require('./websocket');
setupWebSocketServer(server); // Attach WebSocket server to the same HTTP server

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

  // Users with different languages get a higher score
  if (user1.language !== user2.language) score += 3;

  return score;
}

// Helper function to sanitize user data
function sanitizeUserData(user) {
  const { email, password, ...sanitizedData } = user;
  return sanitizedData;
}

// API endponts ============================================================

// Matching API endpoint
app.get('/match-user/:userId', async (req, res) => {
  const { userId } = req.params;

  try {
    // Fetch user data
    const userSnapshot = await db.ref(`users/${userId}`).once('value');
    const currentUser = userSnapshot.val();

    if (!currentUser) {
      return res.status(404).send('User not found');
    }

    // Fetch all users
    const usersSnapshot = await db.ref('users').once('value');
    const users = usersSnapshot.val();

    // Retrieve the user's chat IDs to determine friends
    const chatsSnapshot = await db.ref(`users/${userId}/chats`).once('value');
    const chatIds = chatsSnapshot.val() || {};

    // Get the list of friends based on chat IDs
    const friends = new Set();
    await Promise.all(Object.keys(chatIds).map(async (chatId) => {
      const chatSnapshot = await db.ref(`chats/${chatId}/users`).once('value');
      const chatUsers = chatSnapshot.val() || {};

      // Exclude the current user and add other users as friends
      for (const friendId in chatUsers) {
        if (friendId !== userId) {
          friends.add(friendId);
        }
      }
    }));

    let bestMatch = null;
    let highestScore = 0;

    // Filter users: exclude current user and those already in the friends list
    const filteredUsers = Object.keys(users).filter(key => 
      key !== userId && !friends.has(key) && users[key].language !== currentUser.language
    );

    // Find the best match from the filtered users
    filteredUsers.forEach(key => {
      const otherUser = users[key];
      const score = calculateMatchingScore(currentUser, otherUser);

      if (score > highestScore) {
        highestScore = score;
        bestMatch = { userId: key, ...otherUser };
      }
    });

    if (bestMatch) {
      // Generate a unique chat ID
      const chatId = generateUniqueChatId();

      try {
        // Create a new chat in the database
        await db.ref(`chats/${chatId}`).set({
          users: {
            [userId]: true,
            [bestMatch.userId]: true,
          },
          messages: [],
        });

        // Add the chat ID to both users
        await db.ref(`users/${userId}/chats/${chatId}`).set(true);
        await db.ref(`users/${bestMatch.userId}/chats/${chatId}`).set(true);

        res.status(200).json({
          message: 'Match found!',
          match: sanitizeUserData(bestMatch),
          score: highestScore,
          chatId: chatId, // Return the chat ID to the frontend
        });
      } catch (error) {
        res.status(500).send('Error creating chat and updating users: ' + error.message);
      }
    } else {
      res.status(200).json({ message: 'No suitable match found.' });
    }
  } catch (error) {
    res.status(500).send('Error matching user: ' + error.message);
  }
});

// Add new user API endpoint
app.post('/user', async (req, res) => {
  const { email, password, name, hobby, language, location } = req.body;

  try {
    const userRef = db.ref('users').push();
    const userId = userRef.key;
    const chatId = generateUniqueChatId();

    // Create a new chat session for the user
    await db.ref(`chats/${chatId}`).set({
      users: { [userId]: true },
      messages: [],
    });

    // Add the chat ID to the user's record
    await userRef.set({
      email,
      password,
      name,
      hobby,
      language,
      location,
      chats: {
        [chatId]: true
      }
    });

    res.status(200).json({ message: 'User added successfully', userId });
  } catch (error) {
    res.status(500).json({ message: 'Error adding user', error: error.message });
  }
});

// Get user info API endpoint
app.get('/user/:userId', (req, res) => {
  const { userId } = req.params;

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

// Get messages API endpoint
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

// Get friends list API endpoint
app.get('/user/:userId/friends', async (req, res) => {
  const { userId } = req.params;

  try {
    const userSnapshot = await db.ref(`users/${userId}/chats`).once('value');
    const chatIds = userSnapshot.val();

    if (!chatIds) {
      return res.status(404).json({ message: 'No friends found' });
    }

    const friends = [];
    const friendPromises = Object.keys(chatIds).map(async (chatId) => {
      const chatSnapshot = await db.ref(`chats/${chatId}/users`).once('value');
      const usersInChat = chatSnapshot.val();

      // Find the other user in the chat
      for (const friendId in usersInChat) {
        if (friendId !== userId) {
          const friendSnapshot = await db.ref(`users/${friendId}`).once('value');
          const friendData = sanitizeUserData(friendSnapshot.val());
          friends.push({ id: friendId, ...friendData, chatId });
        }
      }
    });

    await Promise.all(friendPromises);
    res.status(200).json(friends);
  } catch (error) {
    res.status(500).json({ message: 'Error retrieving friends', error: error.message });
  }
});

// Get User By Email API
app.get('/user-by-email/:email', (req, res) => {
  const { email } = req.params;

  db.ref('users').orderByChild('email').equalTo(email).once('value')
    .then(snapshot => {
      const users = snapshot.val();
      if (users) {
        const userId = Object.keys(users)[0];
        res.status(200).json({ userId, ...users[userId] });
      } else {
        res.status(404).send('User not found');
      }
    })
    .catch(error => res.status(500).send('Error retrieving user info: ' + error));
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
  .then(() => {
    // Add the chat ID to both users' records
    return Promise.all([
      db.ref(`users/${user1}/chats/${chatId}`).set(true),
      db.ref(`users/${user2}/chats/${chatId}`).set(true)
    ]);
  })
  .then(() => res.status(200).json({ chatId }))
  .catch((error) => res.status(500).send('Error creating chat: ' + error));
});

//Testing
app.get('/testing', (req, res) => {
  res.status(200).send('Hello World');
});

// Start the server
const PORT = process.env.PORT || 3001;
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
