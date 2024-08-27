import React from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import '../styles/learningPage.css';

function LearningPage() {
  const { level } = useParams();
  const navigate = useNavigate();

  const lessons = {
    1: { 
      word: 'Selamat Pagi', 
      pronunciation: 'sə-lah-maht pah-gee', 
      translation: 'Good Morning', 
      language: 'Malay', 
      example: 'Selamat pagi kepada semua (sə-lah-maht pah-gee kuh-pah-dah sə-moo-ah)', 
      exampleTranslation: 'Good morning to all' 
    },
    2: { 
      word: 'Terima Kasih', 
      pronunciation: 'tuh-ree-mah kah-see', 
      translation: 'Thank You', 
      language: 'Malay', 
      example: 'Terima kasih banyak (tuh-ree-mah kah-see bah-nyak)', 
      exampleTranslation: 'Thank you very much' 
    },
    3: {
      word: 'Apa Khabar?', 
      pronunciation: 'ah-pah kah-bar', 
      translation: 'How are you?', 
      language: 'Malay', 
      example: 'Apa khabar, kawan? (ah-pah kah-bar, kah-wan)', 
      exampleTranslation: 'How are you, friend?' 
    },
    4: {
      word: '你好', 
      pronunciation: 'Nǐ hǎo', 
      translation: 'Hello', 
      language: 'Chinese', 
      example: '你好，今天怎么样？ (Nǐ hǎo, jīn tiān zěn me yàng?)', 
      exampleTranslation: 'Hello, how is today going?' 
    },
    5: {
      word: 'நன்றி', 
      pronunciation: 'Nanri', 
      translation: 'Thank You', 
      language: 'Tamil', 
      example: 'நன்றி உங்கள் உதவிக்கு (Nanri ungal uthavikku)', 
      exampleTranslation: 'Thank you for your help' 
    }
  };  

  const lesson = lessons[level];

  return (
    <div className="container learning-page">
      {lesson ? (
        <>
          <h2 className="level-title">Level {level} ({lesson.language})</h2>
          <div className="lesson-structure">
            {/* Word Section */}
            <div className="word-box">
              <h1 className="word-text">{lesson.word}</h1>
              <p className="pronunciation-text">{lesson.pronunciation}</p> {/* Pronunciation under word */}
            </div>
            
            {/* Meaning Section */}
            <div className="meaning-box">
              <h3>Meaning:</h3>
              <p className="meaning-text">{lesson.translation}</p>
            </div>
          </div>

          {/* Example Section */}
          <div className="example-box">
            <h3>Examples</h3>
            <p><strong>{lesson.language}:</strong> <span className="example-text">{lesson.example}</span></p>
            <p><strong>Translation:</strong> {lesson.exampleTranslation}</p>
          </div>

          {/* Complete Lesson Button */}
          <button 
            className="next-button" 
            onClick={() => navigate('/level-complete')}
          >
            Complete Lesson
          </button>
        </>
      ) : (
        <p>Lesson not found</p>
      )}
    </div>
  );
}

export default LearningPage;
