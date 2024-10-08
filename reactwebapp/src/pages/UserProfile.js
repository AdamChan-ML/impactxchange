import React, { useEffect, useState, useContext } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { Helmet } from 'react-helmet';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap-icons/font/bootstrap-icons.css';
import avatarFemaleWebP from '../assets/images/avatar-f.webp';
import avatarMaleWebP from '../assets/images/avatar-m.webp';
import avatarFemaleImage from '../assets/images/avatar-f.jpg';
import avatarMaleImage from '../assets/images/avatar-m.jpg';
import { UserContext } from '../components/UserContext';

function UserProfile() {
  const [profile, setProfile] = useState(null);
  const [friends, setFriends] = useState([]);
  const navigate = useNavigate();
  const { userId } = useParams();
  const { setUserId } = useContext(UserContext);

  useEffect(() => {
    setUserId(userId);

    // Fetch user profile data
    fetch(`https://impactxchange-433008.de.r.appspot.com/user/${userId}`)
      .then(response => response.json())
      .then(data => setProfile(data))
      .catch(error => console.error('Error fetching user data:', error));

    // Fetch friends list
    fetch(`https://impactxchange-4fc6d.as.r.appspot.com/user/${userId}/friends`)
      .then(response => response.json())
      .then(data => setFriends(data))
      .catch(error => console.error('Error fetching friends:', error));
  }, [userId, setUserId]);

  if (!profile) {
    return <div>Loading profile...</div>;
  }

  return (
    <>
      {/* Use Helmet to preload critical resources */}
      <Helmet>
        <link rel="preload" href={avatarMaleImage} as="image" />
        <link rel="preconnect" href="https://impactxchange-433008.de.r.appspot.com" />
        <link rel="preconnect" href="http://localhost:3001" />
      </Helmet>
      
      <div className="container mt-4">
        <div className="row mb-4 align-items-center">
          <div className="col-md-4 d-flex justify-content-center">
            {/* Serve images in next-gen format (WebP) with fallback to JPEG */}
            <picture>
              <source srcSet={avatarMaleWebP} type="image/webp" />
              <img
                src={avatarMaleImage}
                alt="User Avatar"
                className="img-fluid rounded-circle"
                style={{ width: '150px', height: '150px' }} 
                loading="lazy" // Enable lazy loading
              />
            </picture>
          </div>
          <div className="col-md-8">
            <h1>{profile.name}</h1>
            <p className="text-danger font-weight-bold">Malay Native Speaker</p>
          </div>
        </div>

        <div className="row mb-4">
          <div className="col-md-8">
            <div className="p-3 mb-3 bg-light rounded">
              <h2>Profile</h2> {/* Adjust heading order for accessibility */}
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
            <h3>Friends</h3> {/* Adjust heading for sequential order */}
            <div className="d-flex gap-3">
              {friends.length > 0 ? (
                friends.map((friend, index) => (
                  <div key={index} className="text-center">
                    <button onClick={() => navigate(`/chat/${friend.chatId}`)}>
                      <picture>
                        <source srcSet={friend.gender === 'male' ? avatarMaleWebP : avatarFemaleWebP} type="image/webp" />
                        <img
                          src={friend.gender === 'male' ? avatarMaleImage : avatarFemaleImage}
                          alt={`${friend.name}'s Avatar`}
                          className="img-fluid rounded-circle"
                          style={{ width: '50px', height: '50px' }} // Explicit dimensions to prevent layout shifts
                        />
                      </picture>
                    </button>
                    <p>{friend.name}</p>
                  </div>
                ))
              ) : (
                <p>No friends found.</p>
              )}
            </div>
          </div>
        </div>
      </div>
    </>
  );
}

export default UserProfile;
