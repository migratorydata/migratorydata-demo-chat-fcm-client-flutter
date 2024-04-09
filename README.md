### migratorydata-demo-chat-fcm-client-flutter

Building a Real-time Chat App with Flutter, MigratoryData, and Firebase Cloud Messaging (FCM)

Welcome to the documentation on building a real-time chat application using Flutter, MigratoryData for real-time messaging, and Firebase Cloud Messaging (FCM) for notifications. In this guide, we'll walk you through the process of setting up Flutter, integrating Firebase Messaging, and utilizing MigratoryData Dart API for seamless real-time communication.

### Prerequisites

Before we begin, ensure you have the following prerequisites installed and set up:

- MigratoryData Server with Presence extension. see repo [migratorydata-demo-chat-fcm-plugin](https://github.com/migratorydata/migratorydata-demo-chat-fcm-plugin) for more details.
- Flutter SDK: Install Flutter by following the official installation guide for your platform: [Flutter Installation Guide](https://firebase.google.com/codelabs/firebase-fcm-flutter#1)
- Firebase Account: Create a Firebase account and set up a new project in the Firebase Console: [Firebase Console](https://console.firebase.google.com/)

## Getting Started

1. Clone this project to your machine.

2. Configuring Firebase Messaging.

- Install the FlutterFire plugin using the command: `flutter pub add firebase_core`
- Install the FCM plugin: `flutter pub add firebase_messaging`
- Set up the FlutterFire CLI: `dart pub global activate flutterfire_cli`
- Configure the Firebase project on Flutter: `flutterfire configure --project=your_project`. Use arrow keys and space to select the platforms or press Enter to use the default platforms.
This project is a starting point for a Flutter application.

More info on how to configure flutter project with firebase can be found at this [link](https://firebase.google.com/codelabs/firebase-fcm-flutter#2)

3. Configure MigratoryData server address in file `chat_app.dart`
4. Run the application on emulator or device.

### Dart API documentation

For further details, please refer the documentation at:

https://migratorydata.com/docs/client-api/dart/getting_started/