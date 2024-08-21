import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import LandingPage from './pages/LandingPage'; 
import RegistrationPage from './pages/RegistrationPage';
import LoginPage from './pages/LoginPage';
import UserProfile from './pages/UserProfile';
import LevelsPage from './pages/LevelsPage';
import LearningPage from './pages/LearningPage';
import LevelCompletePage from './pages/LevelCompletePage';
import ChatListPage from './pages/ChatListPage';
import ChatPage from './pages/ChatPage';
import MatchingPage from './pages/MatchingPage';
import MatchSuccessPage from './pages/MatchSuccessPage';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<LandingPage />} />
        <Route path="/register" element={<RegistrationPage />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/profile" element={<UserProfile />} />
        <Route path="/levels" element={<LevelsPage />} />
        <Route path="/learn/:level" element={<LearningPage />} />
        <Route path="/level-complete" element={<LevelCompletePage />} />
        <Route path="/chat-list" element={<ChatListPage />} />
        <Route path="/chat/:id" element={<ChatPage />} />
        <Route path="/learn/matching" element={<MatchingPage />} />
        <Route path="/match-success" element={<MatchSuccessPage />} />
      </Routes>
    </Router>
  );
}

export default App;
