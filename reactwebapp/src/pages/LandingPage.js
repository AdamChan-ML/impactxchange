import React from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles/global.css';

function LandingPage() {
  const navigate = useNavigate();

  return (
    <div className="landing-page">
      <h1>Welcome to Kaki Lingua</h1>
      <button onClick={() => navigate('/login')}>Login</button>
      <button onClick={() => navigate('/register')}>Register</button>
    </div>
  );
}

export default LandingPage;
