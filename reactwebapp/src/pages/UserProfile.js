import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap-icons/font/bootstrap-icons.css';
import avatarFemaleImage from '../assets/images/avatar-f.jpg';
import avatarMaleImage from '../assets/images/avatar-m.jpg';

function UserProfile() {
  const [profile, setProfile] = useState(null);
  const navigate = useNavigate();
  const userId = '-O4ntyNmi0_Jjg2-P6do'; // Example ID, replace with dynamic ID if needed

  useEffect(() => {
    fetch(`https://impactxchange-433008.de.r.appspot.com/user/${userId}`)
      .then(response => response.json())
      .then(data => setProfile(data))
      .catch(error => console.error('Error fetching user data:', error));
  }, [userId]);

  if (!profile) {
    return <div>Loading profile...</div>;
  }

  return (
    <div className="container mt-4">
      <div className="row mb-4 align-items-center">
        <div className="col-md-4 d-flex justify-content-center">
          <img
            src={avatarMaleImage}
            alt="User Avatar"
            className="img-fluid rounded-circle"
            style={{ width: '150px', height: '150px' }}
          />
        </div>
        <div className="col-md-8">
          <h1>{profile.name}</h1>
          <p className="text-danger font-weight-bold">Malay Native Speaker</p>
        </div>
      </div>

      <div className="row mb-4">
        <div className="col-md-8">
          <div className="p-3 mb-3 bg-light rounded">
            <h3>Profile</h3>
            <p><strong>Name:</strong> {profile.name}</p>
            <p><strong>Hobby:</strong> {profile.hobby}</p>
            <p><strong>Languages:</strong> {profile.language}</p>
            <p><strong>Location:</strong> {profile.location}</p>
            <button 
              onClick={() => navigate('/edit-profile')}
              className="btn btn-danger"
            >
              Edit
            </button>
          </div>
        </div>
        <div className="col-md-4">
          <div className="p-3 mb-3 bg-danger text-white rounded">
            <h4>Trustworthiness</h4>
            <p className="font-weight-bold">KAKI POINTS: 9500</p>
          </div>
          <div className="p-3 bg-warning text-dark rounded">
            <h4>Learning Level</h4>
            <p><strong>Level 1</strong></p>
            <button 
              onClick={() => navigate('/levels')}
              className="btn btn-primary"
            >
              Start Learning
            </button>
          </div>
        </div>
      </div>

      <div className="row mt-4">
        <div className="col">
          <h3>Friends</h3>
          <div className="d-flex gap-3">
            <div className="text-center">
              <button onClick={() => navigate('/chat/1')}><img src={avatarMaleImage} alt="Friend 1" className="img-fluid rounded-circle" style={{ width: '50px', height: '50px' }} /></button>
              <p>Jia Long</p>
            </div>
            <div className="text-center">
              <button><img src={avatarFemaleImage} alt="Friend 2" className="img-fluid rounded-circle" style={{ width: '50px', height: '50px' }} /></button>
              <p>Senushia</p>
            </div>
            <div className="text-center">
              <button><img src={avatarFemaleImage} alt="Friend 3" className="img-fluid rounded-circle" style={{ width: '50px', height: '50px' }} /></button>
              <p>Amirah</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default UserProfile;
