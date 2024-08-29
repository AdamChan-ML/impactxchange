const WebSocket = require('ws');
const admin = require('firebase-admin');

// Define a buffer to store messages temporarily
const messageBuffer = {};
const BATCH_MESSAGE_COUNT = 2; // Adjust the message count threshold for batch updates

function setupWebSocketServer(server) {
  const wss = new WebSocket.Server({ server, path: '/ws' });

  wss.on('connection', (ws) => {
    console.log('New WebSocket connection');

    ws.on('message', async (message) => {
      const data = JSON.parse(message);

      if (data.type === 'SEND_MESSAGE') {
        const { chatId, senderId, messageText } = data;

        if (!chatId || !senderId || !messageText) {
          ws.send(JSON.stringify({ type: 'ERROR', message: 'Missing required fields' }));
          return;
        }

        // Add the message to the in-memory buffer
        if (!messageBuffer[chatId]) {
          messageBuffer[chatId] = [];
        }
        messageBuffer[chatId].push({
          sender: senderId,
          text: messageText,
          timestamp: Date.now(),
        });

        // Broadcast the message immediately to all connected clients
        wss.clients.forEach(client => {
          if (client.readyState === WebSocket.OPEN) {
            client.send(JSON.stringify({
              type: 'NEW_MESSAGE',
              chatId,
              message: {
                sender: senderId,
                text: messageText,
                timestamp: Date.now()
              }
            }));
          }
        });

        // If the buffer reaches the threshold, flush it to the database
        if (messageBuffer[chatId].length >= BATCH_MESSAGE_COUNT) {
          await flushMessagesToDatabase(chatId);
        }
      }
    });

    ws.on('close', () => {
      console.log('WebSocket connection closed');
    });
  });

  // Function to flush the messages to the Firebase database
  async function flushMessagesToDatabase(chatId) {
    const messagesRef = admin.database().ref(`chats/${chatId}/messages`);

    try {
      const snapshot = await messagesRef.once('value');
      const existingMessages = snapshot.val() || [];
      const newMessages = messageBuffer[chatId];

      // Append new messages to the existing ones
      const updatedMessages = existingMessages.concat(newMessages);
      
      // Save the batched messages to the database
      await messagesRef.set(updatedMessages);
      console.log(`Batch update successful for chatId: ${chatId}`);
    } catch (error) {
      console.error(`Error updating messages for chatId: ${chatId}`, error);
    }

    // Clear the buffer for this chatId after writing
    messageBuffer[chatId] = [];
  }

  return wss;
}

module.exports = setupWebSocketServer;
