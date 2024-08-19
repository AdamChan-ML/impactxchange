const admin = require('firebase-admin');
 const serviceAccount = require('./path/to/serviceAccountKey.json');
 admin.initializeApp({
     credential: admin.credential.cert(serviceAccount),
 }); 
 async function verifyToken(token) {
     try {
         const decodedToken = await admin.auth().verifyIdToken(token);
         return decodedToken;
     } catch (error) {
         throw new Error('Authentication failed');
     }
 }
 module.exports = { verifyToken };