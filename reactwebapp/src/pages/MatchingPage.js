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
    </div>
  );
}

export default MatchingPage;
