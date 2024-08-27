import React from 'react';
import '../styles/learningPage.css';

function LessonCard({ word, pronunciation, translation, language, onComplete }) {
  return (
    <div className="lesson-card">
      <h2>Level 1 ({language})</h2>
      <h1 className="lesson-word"><strong>{word}</strong></h1>
      <p className="lesson-pronunciation">Pronunciation: <span>{pronunciation}</span></p>
      <div className="lesson-translation-box">
        <p>Meaning:</p>
        <h2>{translation}</h2>
      </div>
      <button onClick={onComplete} className="complete-btn">Complete Lesson</button>
    </div>
  );
}

export default LessonCard;
