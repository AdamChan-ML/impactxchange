import React from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles/levelsPage.css'; // Import the CSS file

function LevelsPage() {
  const navigate = useNavigate();

  const levels = [
    { id: 1, title: '1', className: 'level-1' },
    { id: 2, title: '2', className: 'level-2' },
    { id: 3, title: '3', className: 'level-3' },
    { id: 4, title: '4', className: 'level-4' },
    { id: 5, title: '5', className: 'level-5' },
    { id: 'matching', title: 'Meet Someone New!', className: 'matching' },
  ];

  return (
    <div className="level-path-page">
      {levels.map((level) => (
        <button
          key={level.id}
          className={`level-button ${level.className}`}
          onClick={() => navigate(`/learn/${level.id}`)}
        >
          {level.title}
        </button>
      ))}
    </div>
  );
}

export default LevelsPage;
