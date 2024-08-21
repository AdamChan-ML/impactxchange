import React from 'react';
import { useNavigate } from 'react-router-dom';

function LevelCompletePage() {
  const navigate = useNavigate();

  return (
    <div className="level-complete-page">
      <h2>Level Complete!</h2>
      <p>You've earned 100 Kaki Points!</p>
      <button onClick={() => navigate('/levels')}>Back to Levels</button>
      <button onClick={() => navigate('/learn/next-level')}>Next Level</button>
    </div>
  );
}

export default LevelCompletePage;
