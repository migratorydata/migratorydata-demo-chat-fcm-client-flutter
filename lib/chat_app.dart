
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:migratorydata_client_dart_v6/client.dart';

class ChatApp implements MigratoryDataListener, MigratoryDataLogListener {
  // TODO: to be configured
  String PUBLISH_PASSWORD = "some-token";
  String SERVER_ADDRESS = "192.168.1.223:8800";
  bool USE_ENCRYPTION = false;

  AppStatus appStatus = AppStatus.LOG_IN;
  String LOGOUT_SUBJECT = "/_migratorydata_/presence/logout";

  var roomMessages = SplayTreeMap<int, String>();

  MigratoryDataClient migratoryDataClient = MigratoryDataClient();

  // used for ui update
  List<String> chatMessages;
  List<String> appInfo;
  String fcmToken;
  String roomName;
  State myApp;

  ChatApp(this.chatMessages, this.appInfo, this.fcmToken, this.roomName, this.myApp);

  void init() {
    migratoryDataClient.setLogListener(this, MigratoryDataLogLevel.DEBUG);

    migratoryDataClient.setEntitlementToken(PUBLISH_PASSWORD);
    migratoryDataClient.setExternalToken(fcmToken, null);
    migratoryDataClient.setListener(this);

    migratoryDataClient.setEncryption(USE_ENCRYPTION);
    migratoryDataClient.setServers([SERVER_ADDRESS]);

    migratoryDataClient.subscribeWithHistory(["/rooms/$roomName"], 20);

    migratoryDataClient.connect();

    appInfo.add("Subscribing to room=/rooms/$roomName");
  }

  void pause() {
    migratoryDataClient.pause();
    }

  void resume() {
    migratoryDataClient.resume();
    }

  void disconnect() {
    migratoryDataClient.disconnect();
    }

  void chat(String userName, String message) {
    Map<String, dynamic> jsonMessage = {};
    jsonMessage['userName'] = userName;
    jsonMessage['timestamp'] = DateTime.now().millisecondsSinceEpoch;
    jsonMessage['message'] = message;

    migratoryDataClient.publish(
        MigratoryDataMessage("/rooms/$roomName", utf8.encode(jsonEncode(jsonMessage))));
    }

  AppStatus getAppStatus() {
    return appStatus;
  }

  void updateAppStatus(AppStatus newStatus) {
    appStatus = newStatus;
  }

  void logout() {
    migratoryDataClient.pause();

      migratoryDataClient.unsubscribe(migratoryDataClient.getSubjects());

    migratoryDataClient.subscribe([LOGOUT_SUBJECT]);

    updateAppStatus(AppStatus.PERFORMING_LOG_OUT);

    migratoryDataClient.resume();
  }

  void login() {
    if (appStatus == AppStatus.LOG_OUT) {
      migratoryDataClient.pause();

      migratoryDataClient.unsubscribe(migratoryDataClient.getSubjects());

      migratoryDataClient.subscribe(["/rooms/$roomName"]);

      updateAppStatus(AppStatus.LOG_IN);

      migratoryDataClient.resume();
    }
  }

  String formatChatMessage(Map<String, dynamic> decodeChatMessage) {
    String username = decodeChatMessage['userName'];
    String message = decodeChatMessage['message'];
    int timestamp = decodeChatMessage['timestamp'];

    final f = new DateFormat('hh:mm:ss');

    String date = f.format(DateTime.fromMillisecondsSinceEpoch(timestamp));

    String chatMessage = "[$date][${username != null ? username : "nobody"}] $message";
    return chatMessage;
  }

  @override
  onMessage(MigratoryDataMessage message) {
    print(message);
    if (message.messageType == MessageType.SNAPSHOT) {
      return;
    }

    final decodeChatMessage = jsonDecode(utf8.decode(message.getContent())) as Map<String, dynamic>;
    String chatMessage = formatChatMessage(decodeChatMessage);

    roomMessages[decodeChatMessage['timestamp']] = chatMessage;

    chatMessages.clear();
    chatMessages.addAll(roomMessages.values);

    myApp.setState(() {});
  }


  @override
  onStatus(String status, String info) {
    if (kDebugMode) {
      print("$status - $info");
    }

    appInfo.add("$status - $info");

    if (MigratoryDataClient.NOTIFY_SERVER_UP == status) {
      if (appStatus == AppStatus.PERFORMING_LOG_OUT && migratoryDataClient.getSubjects().contains(LOGOUT_SUBJECT)) {
        updateAppStatus(AppStatus.LOG_OUT);
      }
    }

    myApp.setState(() {});
  }

  @override
  onLog(String log, MigratoryDataLogLevel level) {
    if (kDebugMode) {
      print(log);
    }
  }

}

enum AppStatus {
  LOG_IN, PERFORMING_LOG_OUT, LOG_OUT
}
