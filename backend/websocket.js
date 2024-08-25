const WebSocket = require('ws');
const admin = require('firebase-admin');
const crypto = require('crypto');

function setupWebSocketServer(server) {
  const wss = new WebSocket.Server({ server, path: '/ws' }); // Attach to the existing HTTP server and set the path

  wss.on('connection', (ws) => {
    console.log('New WebSocket connection');

    ws.on('message', (message) => {
      const data = JSON.parse(message);

      if (data.type === 'SEND_MESSAGE') {
        const { chatId, senderId, messageText } = data;

        if (!chatId || !senderId || !messageText) {
          ws.send(JSON.stringify({ type: 'ERROR', message: 'Missing required fields' }));
          return;
        }

        const messagesRef = admin.database().ref(`chats/${chatId}/messages`);
        messagesRef.once('value', (snapshot) => {
          let messages = snapshot.val() || [];
          const newMessage = {
            sender: senderId,
            text: messageText,
            timestamp: Date.now()
          };
          messages.push(newMessage);
          messagesRef.set(messages)
            .then(() => {
              wss.clients.forEach(client => {
                if (client.readyState === WebSocket.OPEN) {
                  client.send(JSON.stringify({ type: 'NEW_MESSAGE', chatId, message: newMessage }));
                }
              });
            })
            .catch((error) => ws.send(JSON.stringify({ type: 'ERROR', message: 'Error sending message: ' + error })));
        });
      }
    });

    ws.on('close', () => {
      console.log('WebSocket connection closed');
    });
  });

  return wss;
}

module.exports = setupWebSocketServer;
