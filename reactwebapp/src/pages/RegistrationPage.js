import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
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
    const emailPattern = /^[^\s@]+@([^\s@]+\.)+edu\.my$/;
    if (!emailPattern.test(email)) {
      alert('Email must end with .edu.my');
      return;
    }

    if (!email || !password || !confirmPassword || !name || !hobby || !language || !state) {
      alert('Please fill in all fields.');
      return;
    }

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
      const response = await fetch('https://impactxchange-4fc6d.as.r.appspot.com/user', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(userData),
      });
  
      const result = await response.json();
  
      if (response.ok) {
        navigate(`/profile/${result.userId}`);
      } else {
        alert(result.message || 'Registration failed');
      }
    } catch (error) {
      alert('Error: ' + error.message);
    }
  };  
  
  // Inline styles to ensure dark grey background
  const styles = {
    registerPage: {
      backgroundColor: '#333', // Dark grey background
      color: '#f5f5f5', // Light text color
      minHeight: '100vh', // Full viewport height
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      padding: '20px',
    },
    formContainer: {
      backgroundColor: '#444', // Slightly lighter grey for form container
      borderRadius: '8px',
      padding: '20px',
      width: '100%',
      maxWidth: '600px',
    },
    button: {
      backgroundColor: '#007bff', // Bootstrap primary color
      border: 'none',
      color: '#fff',
      padding: '10px 20px',
      borderRadius: '5px',
      cursor: 'pointer',
      width: '100%',
    },
    buttonHover: {
      backgroundColor: '#0056b3', // Darker blue for hover
    }
  };

  return (
    <div style={styles.registerPage}>
      <div style={styles.formContainer}>
        <h2 className="mb-4 text-center">Register</h2>
        <div className="row justify-content-center">
          <div className="col-md-12">
            <div className="row">
              <div className="col-md-6">
                <div className="form-group">
                  <label htmlFor="email">Email</label>
                  <input
                    type="email"
                    className="form-control"
                    id="email"
                    placeholder="Email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    aria-label="Email"
                  />
                </div>
                <div className="form-group">
                  <label htmlFor="password">Password</label>
                  <input
                    type="password"
                    className="form-control"
                    id="password"
                    placeholder="Password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    aria-label="Password"
                  />
                </div>
                <div className="form-group">
                  <label htmlFor="confirmPassword">Confirm Password</label>
                  <input
                    type="password"
                    className="form-control"
                    id="confirmPassword"
                    placeholder="Confirm Password"
                    value={confirmPassword}
                    onChange={(e) => setConfirmPassword(e.target.value)}
                    aria-label="Confirm Password"
                  />
                </div>
              </div>

              <div className="col-md-6">
                <div className="form-group">
                  <label htmlFor="name">Name</label>
                  <input
                    type="text"
                    className="form-control"
                    id="name"
                    placeholder="Name"
                    value={name}
                    onChange={(e) => setName(e.target.value)}
                    aria-label="Name"
                  />
                </div>
                <div className="form-group">
                  <label htmlFor="hobby">Hobby</label>
                  <input
                    type="text"
                    className="form-control"
                    id="hobby"
                    placeholder="Hobby"
                    value={hobby}
                    onChange={(e) => setHobby(e.target.value)}
                    aria-label="Hobby"
                  />
                </div>
                <div className="form-group">
                  <label htmlFor="language">Language Spoken</label>
                  <select
                    className="form-control"
                    id="language"
                    value={language}
                    onChange={(e) => setLanguage(e.target.value)}
                    aria-label="Language Spoken"
                  >
                    <option value="">Select Language</option>
                    {languages.map((lang) => (
                      <option key={lang} value={lang}>{lang}</option>
                    ))}
                  </select>
                </div>
                <div className="form-group">
                  <label htmlFor="state">State</label>
                  <select
                    className="form-control"
                    id="state"
                    value={state}
                    onChange={(e) => setState(e.target.value)}
                    aria-label="State"
                  >
                    <option value="">Select State</option>
                    {states.map((stateName) => (
                      <option key={stateName} value={stateName}>{stateName}</option>
                    ))}
                  </select>
                </div>
              </div>
            </div>
            <button
              style={styles.button}
              onMouseOver={e => e.currentTarget.style.backgroundColor = styles.buttonHover.backgroundColor}
              onMouseOut={e => e.currentTarget.style.backgroundColor = styles.button.backgroundColor}
              onClick={handleRegister}
            >
              Register
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default RegistrationPage;
