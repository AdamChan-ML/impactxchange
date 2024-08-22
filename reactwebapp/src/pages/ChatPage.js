import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap-icons/font/bootstrap-icons.css';
import '../styles/global.css';

function ChatPage() {
  const navigate = useNavigate();
  const chatId = '-O4p5NA_fK6avzFXmCjE';
  const userId = '-O4ntyNmi0_Jjg2-P6do'; // Current logged-in user
  const [message, setMessage] = useState('');
  const [messages, setMessages] = useState([]);
  const [users, setUsers] = useState({});

  useEffect(() => {
    console.log("Fetching messages for chatId:", chatId);
    const fetchMessages = async () => {
      try {
        const response = await fetch(`http://localhost:3001/get-messages/${chatId}`);
        const data = await response.json();
        if (response.ok) {
          console.log("Messages fetched:", data);
          setMessages(data.messages);
          setUsers(data.users);
        } else {
          console.error("Error retrieving messages:", data);
        }
      } catch (error) {
        console.error("Error retrieving messages:", error);
      }
    };

    fetchMessages();
  }, [chatId]);

  const handleSendMessage = async () => {
    if (message.trim()) {
      const newMessage = { text: message, sender: userId };

      try {
        console.log('Sending message:', newMessage);
        const response = await fetch('http://localhost:3001/send-message', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            chatId,
            senderId: userId,
            messageText: message,
          }),
        });

        if (response.ok) {
          console.log("Message sent:", message);
          setMessages([...messages, newMessage]);
          setMessage('');
        } else {
          const errorData = await response.json();
          console.error('Error sending message:', errorData);
        }
      } catch (error) {
        console.error('Error sending message:', error);
      }
    }
  };

  const handleBackToChatList = () => {
    navigate('/chat-list');
  };

  return (
    <div className="chat-page container">
      <div className="d-flex justify-content-between align-items-center mb-3">
        <h2>
          Chat with {users[userId === '-O4ntyNmi0_Jjg2-P6do' ? '-O4nyJlrtc2TGr5VFinZ' : '-O4ntyNmi0_Jjg2-P6do']?.name}
        </h2>
        <button 
          className="btn btn-light" 
          onClick={handleBackToChatList} 
          aria-label="Back to Chat List"
        >
          <i className="bi bi-arrow-left"></i>
        </button>
      </div>
      <div className="chat-messages mb-3">
        {messages.map((msg, index) => (
          <div
            key={index}
            className={`chat-bubble ${msg.sender === userId ? 'self' : ''}`}
          >
            <div className="sender-name">
              {users[msg.sender]?.name || 'Unknown User'}
            </div>
            <div className="message-text">{msg.text}</div>
          </div>
        ))}
      </div>
      <div className="chat-input d-flex">
        <input
          type="text"
          placeholder="Type a message..."
          value={message}
          onChange={(e) => setMessage(e.target.value)}
          className="form-control me-2"
        />
        <button onClick={handleSendMessage} className="btn btn-primary">
          Send
        </button>
      </div>
    </div>
  );
}

export default ChatPage;
