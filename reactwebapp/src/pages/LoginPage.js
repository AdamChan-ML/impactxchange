import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const LoginPage = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const navigate = useNavigate();  // Hook to navigate programmatically

  const handleLogin = async (e) => {
    e.preventDefault();
    setError('');

    try {
      // Fetch user data by email
      const response = await axios.get(`https://impactxchange-4fc6d.as.r.appspot.com/user-by-email/${email}`);
      const userData = response.data;

      console.log("User data fetched:", userData);  // Debugging: Check what data is fetched

      // Check if the passwords match
      if (userData.password === password) {
        console.log("Passwords match, navigating to profile...");
        // Navigate to the user's profile page
        navigate(`/profile/${userData.userId}`);
      } else {
        console.log("Passwords do not match.");
        setError('Invalid email or password.');
      }
    } catch (error) {
      console.error("Login error:", error);
      setError('Invalid email or password.');
    }
  };

  // Inline styles
  const styles = {
    body: {
      margin: 0,
      padding: 0,
      fontFamily: 'Arial, sans-serif',
      backgroundColor: '#333',
      color: 'white',
    },
    loginPage: {
      display: 'flex',
      justifyContent: 'center',
      alignItems: 'center',
      height: '100vh',
      backgroundColor: '#333',
      color: 'white'
    },
    container: {
      backgroundColor: '#444',
      padding: '20px',
      borderRadius: '8px',
      boxShadow: '0 4px 8px rgba(0, 0, 0, 0.3)',
      width: '300px',
      textAlign: 'center',
    },
    title: {
      color: '#ffa362',
      marginBottom: '20px',
    },
    formGroup: {
      marginBottom: '15px',
      textAlign: 'left',
    },
    label: {
      display: 'block',
      marginBottom: '5px',
    },
    input: {
      width: '100%',
      padding: '8px',
      border: '1px solid #666',
      borderRadius: '4px',
      backgroundColor: '#555',
      color: 'white',
    },
    button: {
      backgroundColor: '#555',
      border: 'none',
      color: 'white',
      padding: '10px 15px',
      borderRadius: '4px',
      cursor: 'pointer',
      fontSize: '16px',
    },
    buttonHover: {
      backgroundColor: '#666',
    },
    error: {
      color: '#ff4d4d',
      marginTop: '10px',
    }
  };

  return (
    <div style={styles.loginPage}>
      <div style={styles.container}>
        <h1 style={styles.title}>KAKI LINGUA</h1>
        <h2>Login</h2>
        <form onSubmit={handleLogin}>
          <div style={styles.formGroup}>
            <label htmlFor="email" style={styles.label}>Email:</label>
            <input 
              id="email"
              type="email" 
              value={email} 
              onChange={(e) => setEmail(e.target.value)} 
              required 
              style={styles.input}
            />
          </div>
          <div style={styles.formGroup}>
            <label htmlFor="password" style={styles.label}>Password:</label>
            <input 
              id="password"
              type="password" 
              value={password} 
              onChange={(e) => setPassword(e.target.value)} 
              required 
              style={styles.input}
            />
          </div>
          {error && <p style={styles.error}>{error}</p>}
          <button type="submit" style={styles.button} onMouseOver={e => e.currentTarget.style.backgroundColor = styles.buttonHover.backgroundColor} onMouseOut={e => e.currentTarget.style.backgroundColor = styles.button.backgroundColor}>
            Login
          </button>
        </form>
      </div>
    </div>
  );
};

export default LoginPage;
