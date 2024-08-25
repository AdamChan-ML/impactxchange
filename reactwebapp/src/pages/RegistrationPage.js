import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles/global.css';
import 'bootstrap/dist/css/bootstrap.min.css';

const states = ["Johor", "Kedah", "Kelantan", "Malacca", "Negeri Sembilan", "Pahang", "Penang", "Perak", "Perlis", "Sabah", "Sarawak", "Selangor", "Terengganu", "Kuala Lumpur", "Labuan", "Putrajaya"];
const languages = ["Malay", "Chinese", "Tamil", "English", "Spanish", "French", "German", "Japanese", "Korean", "Portuguese", "Russian", "Italian", "Arabic", "Turkish", "Hindi"];

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
    // Email validation check
    const emailPattern = /^[^\s@]+@([^\s@]+\.)+edu\.my$/;
    if (!emailPattern.test(email)) {
      alert('Email must end with .edu.my');
      return;
    }

    // Check if any required field is empty
    if (!email || !password || !confirmPassword || !name || !hobby || !language || !state) {
      alert('Please fill in all fields.');
      return;
    }

    // Password match check
    if (password !== confirmPassword) {
      alert('Passwords do not match. Please check again.');
      return;
    }
  
    const userData = {
      email,
      password,
      hobby,
      language,
      location: state,
      name,
    };
  
    try {
      const response = await fetch('http://localhost:3001/user', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(userData),
      });
  
      // Parse JSON directly from the response
      const result = await response.json();
  
      if (response.ok) {
        // Redirect to the profile page with the userId
        navigate(`/profile/${result.userId}`);
      } else {
        // Alert error message if the response is not okay
        alert(result.message || 'Registration failed');
      }
    } catch (error) {
      // Handle fetch errors
      alert('Error: ' + error.message);
    }
  };  
  
  return (
    <div className="register-page" style={{ padding: '20px' }}>
      <div className="container">
        <h2 className="mb-4 text-center"></h2>
        <div className="row justify-content-center">
          <div className="col-md-8 form-container">
            <div className="row">
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
            <button className="btn btn-primary mt-3 w-100" onClick={handleRegister}>Register</button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default RegistrationPage;
