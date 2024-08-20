const admin = require('firebase-admin');
const serviceAccount = require('./impactxchange-4fc6d-firebase-adminsdk-82u10-a7f6a40be0.json'); // Download this from Firebase Console

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

module.exports = db;
