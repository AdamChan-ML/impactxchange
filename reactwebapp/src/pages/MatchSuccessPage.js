import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import '../styles/matchSuccessPage.css'; // Ensure this path is correct
import avatarImage from '../assets/images/avatar-m.jpg';

function MatchSuccessPage() {
  const [matchData, setMatchData] = useState(null);
  const navigate = useNavigate();

  useEffect(() => {
    const fetchMatchData = async () => {
      try {
        const response = await fetch('http://localhost:3001/match-user/-O57LKryPkkQG6PNhQBv');
        const data = await response.json();
        setMatchData(data.match);
        
        if (data.chatId) {
          navigate(`/chat/${data.chatId}`);
        }
      } catch (error) {
        console.error('Error fetching match data:', error);
      }
    };

    fetchMatchData();
  }, [navigate]);

  return (
    <div className="match-success-page d-flex flex-column align-items-center justify-content-center min-vh-100 p-4">
      <div className="text-center mb-4">
        <h2 className="text-brown">🎉 Found Your KAKI! 🎉</h2>
      </div>
      {matchData ? (
        <div className="card mx-auto bg-light-brown p-4 shadow-lg" style={{ maxWidth: '100%', width: '800px' }}>
          <div className="d-flex justify-content-center mb-3">
            <img 
              src={avatarImage} 
              alt={`${matchData.name}'s Avatar`} 
              className="img-fluid rounded-circle d-flex justify-content-center mb-3"
              style={{ maxWidth: '150px', border: '4px solid #6F4F28' }} 
            />
          </div>
          <div className="card-body text-center">
            <h4 className="card-title text-brown mb-2">{matchData.name}</h4>
            <p className="card-text"><strong>Hobby:</strong> {matchData.hobby}</p>
            <p className="card-text"><strong>Language:</strong> {matchData.language}</p>
            <button
              onClick={() => navigate('/chat/1')}
              className="btn btn-brown btn-lg mt-3"
            >
              Start Chatting
            </button>
          </div>
        </div>
      ) : (
        <p className="text-center text-brown">🔄 Loading match information...</p>
      )}
    </div>
  );
}

export default MatchSuccessPage;
