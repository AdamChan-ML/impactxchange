import React from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import '../styles/learningPage.css';

function LevelCompletePage() {
  const { level } = useParams();  // Get the current level from the URL
  const navigate = useNavigate();

  // Convert level to a number and add 1 to get the next level
  const currentLevel = parseInt(level, 10);
  const nextLevel = isNaN(currentLevel) ? null : currentLevel + 1;

  return (
    <div className="level-complete-page">
      <h2>Level Complete!</h2>
      <p>You've earned 100 Kaki Points!</p>
      <button onClick={() => navigate('/levels')}>Back to Levels</button>
      {nextLevel !== null && (
        <button onClick={() => navigate(`/learn/${nextLevel}`)}>Next Level</button>
      )}
    </div>
  );
}

export default LevelCompletePage;
