import React from 'react';
import { useNavigate } from 'react-router-dom';
import LevelItem from '../components/LevelItem'; 

function LevelsPage() {
  const navigate = useNavigate();

  const levels = [
    { id: 1, title: 'Level 1: Selamat Pagi' },
    { id: 2, title: 'Level 2: Terima Kasih' },
    // More levels to be added...
  ];

  return (
    <div className="level-path-page">
      <h2>Select a Level</h2>
      <ul>
        {levels.map((level) => (
          <LevelItem key={level.id} level={level} onClick={(id) => navigate(`/learn/${id}`)} />
        ))}
      </ul>
    </div>
  );
}

export default LevelsPage;
