import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { sendOTP, registerUser } from '../services/auth';
import backgroundImage from '../assets/images/landing-bg.png'; 
import '../styles/global.css';

function RegistrationPage() {
  const [email, setEmail] = useState('');
  const [otp, setOTP] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const navigate = useNavigate();

  const handleEmailVerification = async () => {
    if (email.endsWith('.edu.my')) {
      await sendOTP(email);
      alert('OTP sent to your email!');
    } else {
      alert('Email must end with .edu.my');
    }
  };

  const handleRegister = async () => {
    if (password !== confirmPassword) {
      alert('Passwords do not match!');
      return;
    }

    await registerUser({ email, otp, password });
    navigate('/login');
  };

  return (
    <div className="register-page">
      <h2>Register</h2>
      <input
        type="email"
        placeholder="Email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
      />
      <button onClick={handleEmailVerification}>Verify Email</button>
      <input
        type="text"
        placeholder="OTP"
        value={otp}
        onChange={(e) => setOTP(e.target.value)}
      />
      <input
        type="password"
        placeholder="Password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
      />
      <input
        type="password"
        placeholder="Confirm Password"
        value={confirmPassword}
        onChange={(e) => setConfirmPassword(e.target.value)}
      />
      <button onClick={handleRegister}>Register</button>
    </div>
  );
}

export default RegistrationPage;
