import React from 'react';

function LessonCard({ word, translation, onComplete }) {
  return (
    <div className="lesson-card">
      <h2>Learn: {word}</h2>
      <p>{translation}</p>
      <button onClick={onComplete}>Complete Level</button>
    </div>
  );
}

export default LessonCard;
