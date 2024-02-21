// const {OAuth2Client} = require('google-auth-library');
// const client = new OAuth2Client('YOUR_CLIENT_ID');

// async function verify(token) {
//   const ticket = await client.verifyIdToken({
//       idToken: token,
//       audience: 'YOUR_CLIENT_ID',  // Specify the CLIENT_ID of the app that accesses the backend
//   });
//   const payload = ticket.getPayload();
//   const userid = payload['sub'];
//   // If request specified a G Suite domain:
//   // const domain = payload['hd'];
// }

// app.post('/api/auth/googleSignIn', async (req, res) => {
//   try {
//     const { token } = req.body;
//     await verify(token);
//     // Verified successfully
//     // Here, you might want to check if the user already exists in your database
//     // If not, create a new user document in MongoDB using Mongoose
//     res.status(200).send({ message: 'Token verified successfully' });
//   } catch (error) {
//     res.status(400).send({ message: 'Invalid ID token' });
//   }
// });



// const User = require('./models/user'); // Assuming you have a User model

// async function createUserIfNotExist(payload) {
//   const { email, name, sub: googleId } = payload;
//   let user = await User.findOne({ googleId });
//   if (!user) {
//     user = new User({
//       name,
//       email,
//       googleId,
//     });
//     await user.save();
//   }
//   return user;
// }

// npm install google-auth-library
// npm install express nodemailer mongoose dotenv;
// // verifyEmail.js
// app.post('/register', async (req, res) => {
//   const { email } = req.body;
//   const verificationCode = Math.random().toString().substr(2, 6); // Generate a 6-digit code

//   // Save or update the user with the generated code
//   const newUser = await User.findOneAndUpdate(
//     { email },
//     { verificationCode, isVerified: false },
//     { upsert: true, new: true }
//   );

//   // Send email with the code
//   const mailOptions = {
//     from: process.env.EMAIL_USERNAME,
//     to: email,
//     subject: 'Your Verification Code',
//     text: `Your verification code is: ${verificationCode}`,
//   };

//   transporter.sendMail(mailOptions, (error) => {
//     if (error) {
//       console.log(error);
//       return res.status(500).json({ message: 'Error sending verification code' });
//     }
//     res.status(200).json({ message: 'Verification code sent successfully' });
//   });
// });
// app.post('/verify-code', async (req, res) => {
//   const { email, code } = req.body;
//   const user = await User.findOne({ email });

//   if (user && user.verificationCode == code) {
//     user.isVerified = true;
//     await user.save();
//     res.json({ message: 'Email verified successfully' });
//   } else {
//     res.status(400).json({ message: 'Invalid or expired code' });
//   }
// });
// Assuming Express setup and other imports are already defined

// Endpoint to resend the verification code
// app.post('/resend-code', async (req, res) => {
//   const { email } = req.body;
//   const user = await User.findOne({ email });

//   if (!user) {
//     return res.status(404).json({ message: 'User not found' });
//   }

//   const verificationCode = Math.random().toString().substr(2, 6); // Generate a new 6-digit code
//   user.verificationCode = verificationCode;
//   await user.save();

//   // Send email with the new code
//   const mailOptions = {
//     from: process.env.EMAIL_USERNAME,
//     to: email,
//     subject: 'Your New Verification Code',
//     text: `Your new verification code is: ${verificationCode}`,
//   };

//   transporter.sendMail(mailOptions, (error) => {
//     if (error) {
//       console.log(error);
//       return res.status(500).json({ message: 'Error sending verification code' });
//     }
//     res.status(200).json({ message: 'New verification code sent successfully' });
//   });
// });


