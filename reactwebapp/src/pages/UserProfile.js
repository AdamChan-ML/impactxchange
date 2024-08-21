import React from 'react';
import { useNavigate } from 'react-router-dom';

function UserProfile() {
  const navigate = useNavigate();

  return (
    <div className="user-profile-page">
      <h2>Your Profile</h2>
      <button onClick={() => navigate('/levels')}>Go to Levels</button>
      <button onClick={() => navigate('/chat-list')}>Chat List</button>
    </div>
  );
}

export default UserProfile;
