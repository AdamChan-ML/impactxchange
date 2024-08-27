import React, { useEffect, useState, useContext, useCallback } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap-icons/font/bootstrap-icons.css';
import avatarFemaleImage from '../assets/images/avatar-f.jpg';
import avatarMaleImage from '../assets/images/avatar-m.jpg';
import { UserContext } from '../components/UserContext';

const UserProfile = React.memo(() => {
  const [profile, setProfile] = useState(null);
  const [friends, setFriends] = useState([]);
  const navigate = useNavigate();
  const { userId } = useParams();
  const { setUserId } = useContext(UserContext);

  useEffect(() => {
    setUserId(userId);

    const fetchUserData = async () => {
      try {
        const profileResponse = await fetch(`https://impactxchange-433008.de.r.appspot.com/user/${userId}`);
        const profileData = await profileResponse.json();
        setProfile(profileData);

        const friendsResponse = await fetch(`http://localhost:3001/user/${userId}/friends`);
        const friendsData = await friendsResponse.json();
        setFriends(friendsData);
      } catch (error) {
        console.error('Error fetching user data:', error);
      }
    };

    fetchUserData();
  }, [userId, setUserId]);

  const handleNavigate = useCallback((path) => {
    navigate(path);
  }, [navigate]);

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
            loading="lazy"
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
              onClick={() => handleNavigate('/edit-profile')}
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
              onClick={() => handleNavigate('/levels')}
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
            {friends.length > 0 ? (
              friends.map((friend, index) => (
                <div key={index} className="text-center">
                  <button onClick={() => handleNavigate(`/chat/${friend.chatId}`)}>
                    <img
                      src={friend.gender === 'male' ? avatarMaleImage : avatarFemaleImage}
                      alt={`${friend.name}'s Avatar`}
                      className="img-fluid rounded-circle"
                      style={{ width: '50px', height: '50px' }}
                      loading="lazy"
                    />
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
  );
});

export default UserProfile;
