import 'dart:async';
import 'dart:convert';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:tcc_eng_comp/repository/fog_repository.dart';
import 'package:tcc_eng_comp/repository/preference_repository.dart';

class StompRepository extends FogRepository {
  static final StompRepository _singleton = StompRepository._internal();
  Function(String) _onMessage = (value) => null;

  factory StompRepository() {
    return _singleton;
  }

  StompRepository._internal();
  
  late StompClient client;

  void onConnect(StompFrame frame) {
    client.subscribe(
      destination: '/tcc/stomp',
      callback: (frame) {
        _onMessage.call(frame.body ?? '');
      },
    );
  }

  Future<FogRepository> connect(Function(String) onMessage) async {
    // TODO: Tratar conexão anterior
    _onMessage = onMessage;
    client = StompClient(
      config: StompConfig(
        url: 'ws://${await PreferenceRepository.getBrokerHost()}:5692',
        onConnect: onConnect,
        beforeConnect: () async {
          print('waiting to connect...');
          await Future.delayed(Duration(milliseconds: 200));
          print('connecting...');
        },
        onWebSocketError: (dynamic error) => print(error.toString()),
          stompConnectHeaders: {
            'login': await PreferenceRepository.getUser(),
            'passcode': await PreferenceRepository.getPassword()
          }
      ),
    );
    client.activate();
    return this;
  }
  
  void send(String message) {
    client.send(
        destination: '/tcc/stomp',
        body: message,
        headers: {}
    );
  }

  void disconnect(Function() onDisconnect) {
    client.deactivate();
  }
}