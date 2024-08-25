import React from 'react';
import ReactDOM from 'react-dom/client'; // Updated import
import App from './App';
import { UserProvider } from './components/UserContext'; 
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap-icons/font/bootstrap-icons.css';

// Create root and render the App component wrapped with UserProvider
const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <UserProvider>
    <App />
  </UserProvider>
);
