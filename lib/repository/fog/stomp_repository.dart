import 'dart:async';
import 'dart:convert';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class StompRepository {
  static final StompRepository _singleton = StompRepository._internal();

  factory StompRepository() {
    return _singleton;
  }

  StompRepository._internal();
  
  late StompClient client;

  void onConnect(StompFrame frame) {
    client.subscribe(
      destination: '/topic/test/subscription',
      callback: (frame) {
        List<dynamic>? result = json.decode(frame.body!);
        print(result);
      },
    );
  }

  void connect() {
    // TODO: Tratar conexão anterior
    client = StompClient(
      config: StompConfig(
        url: 'ws://192.168.1.150:61613',
        onConnect: onConnect,
        beforeConnect: () async {
          print('waiting to connect...');
          await Future.delayed(Duration(milliseconds: 200));
          print('connecting...');
        },
        onWebSocketError: (dynamic error) => print(error.toString()),
          stompConnectHeaders: {
            'login': 'admin',
            'passcode': 'admin123456'
          }
      ),
    );
    client.activate();
  }
  
  void send(String message) {
    client.send(
        destination: '/foo/bar',
        body: message,
        headers: {}
    );
  }
  
  void disconnect() {
    client.deactivate();
  }
}