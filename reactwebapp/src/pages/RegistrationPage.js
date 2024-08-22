import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { registerUser } from '../services/auth';
import backgroundImage from '../assets/images/landing-bg.png'; 
import '../styles/global.css'; // Ensure your CSS file is imported
import 'bootstrap/dist/css/bootstrap.min.css'; // Import Bootstrap CSS

// List of states in Malaysia
const states = [
  "Johor", "Kedah", "Kelantan", "Malacca", "Negeri Sembilan",
  "Pahang", "Penang", "Perak", "Perlis", "Sabah",
  "Sarawak", "Selangor", "Terengganu", "Kuala Lumpur", "Labuan", "Putrajaya"
];

// List of languages
const languages = [
  "Malay", "Chinese", "Tamil", // Primary languages
  "English", "Spanish", "French", "German", "Japanese", "Korean",
  "Portuguese", "Russian", "Italian", "Arabic", "Turkish", "Hindi"
];

function RegistrationPage() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [name, setName] = useState('');
  const [hobby, setHobby] = useState('');
  const [language, setLanguage] = useState('');
  const [state, setState] = useState('');
  const navigate = useNavigate();

  const handleRegister = async () => {
    if (password !== confirmPassword) {
      alert('Passwords do not match!');
      return;
    }

    const userData = {
      email,
      password,
      name,
      hobby,
      language,
      location: state,
    };

    try {
      await registerUser(userData);
      navigate('/login');
    } catch (error) {
      alert(error.message);
    }
  };

  return (
    <div className="register-page" style={{ backgroundImage: `url(${backgroundImage})`, padding: '20px' }}>
      <div className="container">
        <h2 className="mb-4 text-center text-white"></h2>
        <div className="row justify-content-center">
          <div className="col-md-8 form-container"> {/* Apply custom class here */}
            <div className="row">
              {/* Left Column */}
              <div className="col-md-6">
                <div className="form-group">
                  <label>Email</label>
                  <input
                    type="email"
                    className="form-control"
                    placeholder="Email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                  />
                </div>
                <div className="form-group">
                  <label>Password</label>
                  <input
                    type="password"
                    className="form-control"
                    placeholder="Password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                  />
                </div>
                <div className="form-group">
                  <label>Confirm Password</label>
                  <input
                    type="password"
                    className="form-control"
                    placeholder="Confirm Password"
                    value={confirmPassword}
                    onChange={(e) => setConfirmPassword(e.target.value)}
                  />
                </div>
              </div>

              {/* Right Column */}
              <div className="col-md-6">
                <div className="form-group">
                  <label>Name</label>
                  <input
                    type="text"
                    className="form-control"
                    placeholder="Name"
                    value={name}
                    onChange={(e) => setName(e.target.value)}
                  />
                </div>
                <div className="form-group">
                  <label>Hobby</label>
                  <input
                    type="text"
                    className="form-control"
                    placeholder="Hobby"
                    value={hobby}
                    onChange={(e) => setHobby(e.target.value)}
                  />
                </div>
                <div className="form-group">
                  <label>Language Spoken</label>
                  <select
                    className="form-control"
                    value={language}
                    onChange={(e) => setLanguage(e.target.value)}
                  >
                    <option value="">Select Language</option>
                    {languages.map((lang) => (
                      <option key={lang} value={lang}>{lang}</option>
                    ))}
                  </select>
                </div>
                <div className="form-group">
                  <label>State</label>
                  <select
                    className="form-control"
                    value={state}
                    onChange={(e) => setState(e.target.value)}
                  >
                    <option value="">Select State</option>
                    {states.map((stateName) => (
                      <option key={stateName} value={stateName}>{stateName}</option>
                    ))}
                  </select>
                </div>
              </div>
            </div>
            <button className="btn btn-primary mt-3 w-100" onClick={() => navigate('/profile')}>Register</button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default RegistrationPage;
