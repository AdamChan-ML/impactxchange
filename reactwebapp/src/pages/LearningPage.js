import React from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import LessonCard from '../components/LessonCard';

function LearningPage() {
  const { level } = useParams();
  const navigate = useNavigate();

  const lessons = {
    1: { word: 'Selamat Pagi', translation: 'Good Morning' },
    2: { word: 'Terima Kasih', translation: 'Thank You' },
    3: { word: 'Apa Khabar?', translation: 'How Are You?'}
    // More lessons to be added
  };

  const lesson = lessons[level];

  return (
    <div className="learning-page">
      <LessonCard 
        word={lesson.word} 
        translation={lesson.translation} 
        onComplete={() => navigate('/level-complete')} 
      />
    </div>
  );
}

export default LearningPage;
