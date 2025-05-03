const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendChatNotification = functions.firestore
    .document("messages/{messageId}")
    .onCreate(async (snap, context) => {
        const message = snap.data();

        const payload = {
            notification: {
                title: "رسالة جديدة م ${message.id}",
                body: message.message,
            },
            topic: "community_chat"
        };

        try {
            const response = await admin.messaging().send(payload);
            console.log("Successfully sent message:", response);
        } catch (error) {
            console.log("Error sending message:", error);
        }
    });
