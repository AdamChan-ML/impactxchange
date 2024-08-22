import React, { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles/matchingPage.css'; // Import the CSS file

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
          background="transparent" /* Updated to transparent to fit the background */
          speed="1"
          className="lottie-player"
          loop
          autoplay
        ></lottie-player>
      </div>
    </div>
  );
}

export default MatchingPage;
