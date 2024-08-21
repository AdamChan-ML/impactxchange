import React from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles/global.css';

function ChatListPage() {
  const navigate = useNavigate();

  const chatList = [
    { id: 1, name: 'User A', lastMessage: 'Hello there!', time: '10:30 AM' },
    { id: 2, name: 'User B', lastMessage: 'See you soon!', time: '9:15 AM' },
  ];

  return (
    <div className="chat-list-page">
      <h2>Your Chats</h2>
      <ul className="chat-list">
        {chatList.map((chat) => (
          <li key={chat.id} className="chat-item" onClick={() => navigate(`/chat/${chat.id}`)}>
            <div className="chat-avatar">
              <img src={`https://via.placeholder.com/50?text=${chat.name.charAt(0)}`} alt={`${chat.name}'s avatar`} />
            </div>
            <div className="chat-info">
              <div className="chat-name">{chat.name}</div>
              <div className="chat-last-message">{chat.lastMessage}</div>
            </div>
            <div className="chat-time">{chat.time}</div>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default ChatListPage;
