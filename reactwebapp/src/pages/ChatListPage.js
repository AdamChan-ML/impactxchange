import React from 'react';
import { useNavigate } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap-icons/font/bootstrap-icons.css';
import '../styles/global.css';

function ChatListPage() {
  const navigate = useNavigate();

  const chatList = [
    { id: 1, name: 'Jia Long', lastMessage: 'Hello there!', time: '10:30 AM' },
    { id: 2, name: 'Senushia', lastMessage: 'See you soon!', time: '9:15 AM' },
  ];

  const handleGoToProfile = () => {
    navigate('/profile'); // Update the path as needed for your profile page
  };

  return (
    <div className="chat-list-page container">
      <div className="d-flex justify-content-between align-items-center mb-3">
        <h2>Your Chats</h2>
        <button 
          className="btn btn-light" 
          onClick={handleGoToProfile} 
          aria-label="Go to Profile Page"
        >
          <i className="bi bi-house-door"></i>
        </button>
      </div>
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
