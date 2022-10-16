const functions = require("firebase-functions");

exports.receiveCallBack = functions.https.onRequest(async (req, res)=> {
    const original = req.body.body;
    console.log(original);
    res.json({result: 'Completed transaction process'});
  });
  // exports.addMessage = functions.https.onRequest(async (req, res) => {
  //   // Grab the text parameter.
  //   const original = req.query.text;
  //   // Push the new message into Firestore using the Firebase Admin SDK.
  //   const writeResult = await admin.firestore().collection('messages').add({original: original});
  //   // Send back a message that we've successfully written the message
  //   res.json({result: `Message with ID: ${writeResult.id} added.`});
  // });