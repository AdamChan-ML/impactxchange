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

  return (
    <div className="login-page">
      <h2>Login</h2>
      <form onSubmit={handleLogin}>
        <div>
          <label>Email:</label>
          <input 
            type="email" 
            value={email} 
            onChange={(e) => setEmail(e.target.value)} 
            required 
          />
        </div>
        <div>
          <label>Password:</label>
          <input 
            type="password" 
            value={password} 
            onChange={(e) => setPassword(e.target.value)} 
            required 
          />
        </div>
        {error && <p className="error">{error}</p>}
        <button type="submit">Login</button>
      </form>
    </div>
  );
};

export default LoginPage;
