// pages/LearningPage.js
import React from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import LessonCard from '../components/LessonCard';
import '../styles/learningPage.css';

function LearningPage() {
  const { level } = useParams();
  const navigate = useNavigate();

  const lessons = {
    1: { word: 'Selamat Pagi', pronunciation: 'sə-lah-maht pah-gee', translation: 'Good Morning', language: 'Malay' },
    2: { word: 'Terima Kasih', pronunciation: 'tuh-ree-mah kah-see', translation: 'Thank You', language: 'Malay' },
    3: { word: 'Apa Khabar?', pronunciation: 'ah-pah kah-bar', translation: 'How Are You?', language: 'Malay' },
    4: { word: '早上好', pronunciation: 'Zǎo shang hǎo', translation: 'Good Morning', language: 'Chinese' },
    5: { word: 'நன்றி', pronunciation: 'Nanri', translation: 'Thank You', language: 'Tamil' }
  };

  const lesson = lessons[level];

  return (
    <div className="learning-page">
      {lesson ? (
        <LessonCard 
          word={lesson.word} 
          pronunciation={lesson.pronunciation}
          translation={lesson.translation} 
          language={lesson.language}
          onComplete={() => navigate('/level-complete')} 
        />
      ) : (
        <p>Lesson not found</p>
      )}
    </div>
  );
}

export default LearningPage;
