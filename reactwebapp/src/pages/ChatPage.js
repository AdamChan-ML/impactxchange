import React, { useState, useEffect, useRef, useContext, useCallback, memo } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap-icons/font/bootstrap-icons.css';
import '../styles/global.css';
import { UserContext } from '../components/UserContext';

// Memoized component to prevent unnecessary re-renders
const ChatBubble = memo(({ msg, userId, users }) => (
  <div className={`chat-bubble ${msg.sender === userId ? 'self' : ''}`}>
    <div className="sender-name">
      {users[msg.sender]?.name || 'Unknown User'}
    </div>
    <div className="message-text">{msg.text}</div>
  </div>
));

function ChatPage() {
  const navigate = useNavigate();
  const { id: chatId } = useParams();
  const { userId } = useContext(UserContext);
  const [message, setMessage] = useState('');
  const [messages, setMessages] = useState([]);
  const [users, setUsers] = useState({});
  const [wsError, setWsError] = useState(null);
  const ws = useRef(null);

  // Establish WebSocket connection
  useEffect(() => {
    ws.current = new WebSocket('wss://kakilingua-be-nl2s2bqana-as.a.run.app/ws');
    ws.current.onopen = () => {
      console.log('WebSocket connection established');
      setWsError(null);
    };

    ws.current.onmessage = (event) => {
      const data = JSON.parse(event.data);
      if (data.type === 'NEW_MESSAGE' && data.chatId === chatId) {
        setMessages((prevMessages) => [...prevMessages, data.message]);
      }
    };

    ws.current.onerror = (error) => {
      console.error('WebSocket error:', error);
      setWsError('WebSocket connection error. Please try again later.');
    };

    ws.current.onclose = () => {
      console.log('WebSocket connection closed');
      setWsError('WebSocket connection closed. Unable to send messages.');
    };

    return () => {
      if (ws.current) {
        ws.current.close();
      }
    };
  }, [chatId]);

  // Fetch messages when component mounts
  useEffect(() => {
    const fetchMessages = async () => {
      try {
        const response = await fetch(`https://impactxchange-433008.de.r.appspot.com/get-messages/${chatId}`);
        const data = await response.json();
        if (response.ok) {
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

  // Use callback to optimize message sending logic
  const handleSendMessage = useCallback(() => {
    if (message.trim()) {
      const newMessage = {
        type: 'SEND_MESSAGE',
        chatId,
        senderId: userId,
        messageText: message,
      };

      if (ws.current && ws.current.readyState === WebSocket.OPEN) {
        ws.current.send(JSON.stringify(newMessage));
        setMessage('');
      } else {
        console.error('WebSocket is not open. Unable to send message.');
        setWsError('WebSocket is not open. Please try again later.');
      }
    }
  }, [message, chatId, userId]);

  const handleBackToChatList = useCallback(() => {
    navigate('/chat-list');
  }, [navigate]);

  return (
    <div className="chat-page container">
      <div className="d-flex justify-content-between align-items-center mb-3">
        <h2>Chat</h2>
        <button 
          className="btn btn-light" 
          onClick={handleBackToChatList} 
          aria-label="Back to Chat List"
        >
          <i className="bi bi-arrow-left"></i>
        </button>
      </div>

      {wsError && <div className="alert alert-danger">{wsError}</div>}

      <div className="chat-messages mb-3">
        {messages.map((msg, index) => (
          <ChatBubble key={index} msg={msg} userId={userId} users={users} />
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
