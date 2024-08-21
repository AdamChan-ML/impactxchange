import React from 'react';
import { useNavigate } from 'react-router-dom';

function MatchSuccessPage() {
  const navigate = useNavigate();

  const matchedUser = {
    hobbies: ['Reading', 'Traveling'],
    languageProficiency: 'Intermediate',
  };

  return (
    <div className="match-success-page">
      <h2>Match Found!</h2>
      <p>Hobbies: {matchedUser.hobbies.join(', ')}</p>
      <p>Language Proficiency: {matchedUser.languageProficiency}</p>
      <button onClick={() => navigate('/chat/1')}>Start Chatting</button>
    </div>
  );
}

export default MatchSuccessPage;
