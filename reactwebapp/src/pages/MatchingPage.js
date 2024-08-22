import React, { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

function MatchingPage() {
  const navigate = useNavigate();

  useEffect(() => {
    const timer = setTimeout(() => {
      navigate('/match-success');
    }, 3000);

    return () => clearTimeout(timer);
  }, [navigate]);

  return (
    <div className="matching-page">
      <h2>Finding a match...</h2>
      <div>
            <lottie-player
            src="https://lottie.host/2721afed-1c46-4d41-8602-8e674f6411b1/FKEfA1eaWr.json"
            background="##FFFFFF"
            speed="1"
            style={{ width: '300px', height: '300px' }}
            loop
            autoplay
            ></lottie-player>
        </div>
    </div>
  );
}

export default MatchingPage;
