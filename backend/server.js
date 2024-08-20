const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const db = require('./firebase');

const app = express();
app.use(bodyParser.json());
app.use(cors());

// Endpoint to register a user
app.post('/api/users', async (req, res) => {
  const newUser = req.body;
  const userRef = db.collection('users').doc();
  await userRef.set(newUser);
  res.send({ id: userRef.id, ...newUser });
});

// Matching function
function calculateMatchScore(user1, user2) {
  let score = 0;

  const ageDifference = Math.abs(user1.age - user2.age);
  if (ageDifference <= 5) {
    score += 5;
  } else if (ageDifference <= 10) {
    score += 3;
  } else {
    score += 1;
  }

  const commonInterests = user1.interests.filter(interest =>
    user2.interests.includes(interest)
  );
  score += commonInterests.length * 2;

  const commonLanguages = user1.languages.filter(language =>
    user2.languages.includes(language)
  );
  score += commonLanguages.length * 3;

  return score;
}

// Endpoint to get matched users
app.post('/api/match', async (req, res) => {
  const usersSnapshot = await db.collection('users').get();
  const users = usersSnapshot.docs.map(doc => doc.data());
  const currentUser = req.body;

  const matches = users.map(user => ({
    user,
    score: calculateMatchScore(currentUser, user),
  }));

  matches.sort((a, b) => b.score - a.score);

  res.send(matches);
});

const port = 5000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
