const express = require('express');
const admin = require('firebase-admin');
const app = express();

// Load Firebase service account key
const serviceAccount = require('./db-service-account-key.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://kaki-lingua-db-default-rtdb.asia-southeast1.firebasedatabase.app" 
});

const db = admin.database();

app.use(express.json()); // To parse incoming JSON request bodies

app.post('/add-user', (req, res) => {
  const { email, password, name, hobby, language, location } = req.body;

  // Save user data to Firebase Realtime Database
  const userRef = db.ref('users').push();
  userRef.set({
    email,
    password,
    name,
    hobby,
    language,
    location
  })
  .then(() => res.status(200).send('User added successfully'))
  .catch(error => res.status(500).send('Error adding user: ' + error));
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
