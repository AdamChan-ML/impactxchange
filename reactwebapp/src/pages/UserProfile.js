import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import avatarFemaleImage from '../assets/images/avatar-f.jpg';
import avatarMaleImage from '../assets/images/avatar-m.jpg';

// Component starts here
function UserProfile() {
  const [profile, setProfile] = useState(null); // State to store user profile data
  const navigate = useNavigate();
  const userId = '-O4ntyNmi0_Jjg2-P6do'; // Example ID, replace with dynamic ID if needed

  // Fetch user data from API on component mount
  useEffect(() => {
    fetch(`http://localhost:3001/user/${userId}`)
      .then(response => response.json())
      .then(data => setProfile(data))
      .catch(error => console.error('Error fetching user data:', error));
  }, [userId]);

  // Loading state
  if (!profile) {
    return <div>Loading profile...</div>;
  }

  // Component UI
  return (
    <div className="user-profile-page" style={{ padding: '20px', fontFamily: 'Arial, sans-serif' }}>
      <div style={{ display: 'flex', alignItems: 'center' }}>
        {/* User Avatar */}
        <img
          src={avatarMaleImage}
          alt="User Avatar"
          style={{ borderRadius: '50%', width: '100px', height: '100px', marginRight: '20px' }}
        />
        <div>
          {/* User name and language */}
          <h1>{profile.name}</h1>
          <p style={{ color: 'red', fontWeight: 'bold' }}>Malay Native Speaker</p>
        </div>
      </div>

      {/* Kaki points and trustworthiness */}
      <div style={{ marginTop: '20px' }}>
        <div style={{
          backgroundColor: '#ff6b6b',
          color: 'white',
          borderRadius: '10px',
          padding: '10px',
          display: 'inline-block'
        }}>
          <p>Trustworthiness</p>
          <p style={{ fontWeight: 'bold' }}>KAKI POINTS: 9500</p>
        </div>
      </div>

      {/* Friends section */}
      <div style={{ marginTop: '30px' }}>
        <h3>Friends</h3>
        <div style={{ display: 'flex', gap: '10px' }}>
          <div style={{ textAlign: 'center' }}>
            <img src={avatarMaleImage} alt="Friend 1" style={{ width: '50px', borderRadius: '50%' }} />
            <p>Jia Long</p>
          </div>
          <div style={{ textAlign: 'center' }}>
            <img src={avatarFemaleImage} alt="Friend 2" style={{ width: '50px', borderRadius: '50%' }} />
            <p>Senushia</p>
          </div>
          <div style={{ textAlign: 'center' }}>
            <img src={avatarFemaleImage} alt="Friend 3" style={{ width: '50px', borderRadius: '50%' }} />
            <p>Amirah</p>
          </div>
        </div>
      </div>

      {/* Profile section */}
      <div style={{ marginTop: '30px', padding: '20px', backgroundColor: '#f8d7da', borderRadius: '10px' }}>
        <h3>Profile</h3>
        <p><strong>Name:</strong> {profile.name}</p>
        <p><strong>Hobby:</strong> {profile.hobby}</p>
        <p><strong>Languages:</strong> {profile.language}</p>
        <p><strong>Location:</strong> {profile.location}</p>
        <button onClick={() => navigate('/edit-profile')} style={{ backgroundColor: '#f44336', color: 'white', padding: '5px 10px', border: 'none', borderRadius: '5px' }}>
          Edit
        </button>
      </div>

      {/* Learning level section */}
      <div style={{ marginTop: '30px', padding: '20px', backgroundColor: '#fbe9e7', borderRadius: '10px' }}>
        <h3>Learning Level</h3>
        <p><strong>Level 1</strong></p>
        <button onClick={() => navigate('/levels')} style={{ backgroundColor: '#6200ea', color: 'white', padding: '10px 20px', borderRadius: '5px' }}>
          Start Learning
        </button>
      </div>
    </div>
  );
}

export default UserProfile;
