### migratorydata-demo-chat-fcm-client-flutter

Building a Real-time Chat App with Flutter, MigratoryData, and Firebase Cloud Messaging (FCM)

Welcome to the documentation on building a real-time chat application using Flutter, MigratoryData for real-time messaging, and Firebase Cloud Messaging (FCM) for notifications. In this guide, we'll walk you through the process of setting up Flutter, integrating Firebase Messaging, and utilizing MigratoryData Dart API for seamless real-time communication.

### Prerequisites

Before we begin, ensure you have the following prerequisites installed and set up:

- MigratoryData Server with Presence extension. see repo [migratorydata-demo-chat-fcm-plugin](https://github.com/migratorydata/migratorydata-demo-chat-fcm-plugin) for more details.
- Flutter SDK: Install Flutter by following the official installation guide for your platform: [Flutter Installation Guide](https://firebase.google.com/codelabs/firebase-fcm-flutter#1).
- Firebase Account: Set up a new project in the [Firebase Console](https://console.firebase.google.com/) or use the existing project associated with the [fcm-plugin](https://github.com/migratorydata/migratorydata-demo-chat-fcm-plugin).

### Getting Started

1. Install [fcm-plugin]((https://github.com/migratorydata/migratorydata-demo-chat-fcm-plugin)) and run the Migratorydata server with presence extension. See the [migratorydata-demo-chat-fcm-plugin](https://github.com/migratorydata/migratorydata-demo-chat-fcm-plugin) for more details.

2. Clone this repository to your local machine.

3. Configuring Firebase Messaging.

- Install the FlutterFire plugin using the command: `flutter pub add firebase_core`.
- Install the FCM plugin: `flutter pub add firebase_messaging`.
- Set up the FlutterFire CLI: `dart pub global activate flutterfire_cli`.
- Configure the Firebase project on Flutter: `flutterfire configure --project=your_project`. Use arrow keys and space to select the platforms or press Enter to use the default platforms.

> This project is a starting point for a Flutter application.
> More info on how to configure flutter project with firebase can be found at this [link](https://firebase.google.com/codelabs/firebase-fcm-flutter#2).

4. Configure MigratoryData server address in file `chat_app.dart`.
5. Launch the application on emulator or device.

### Dart API documentation

For further details, please refer the documentation at:

https://migratorydata.com/docs/client-api/dart/getting_started/