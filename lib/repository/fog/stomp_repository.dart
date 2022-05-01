import 'dart:async';
import 'dart:convert';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:tcc_eng_comp/repository/fog_repository.dart';
import 'package:tcc_eng_comp/repository/preference_repository.dart';

class StompRepository extends FogRepository {
  late Function(String) _onMessage;
  late StompClient client;
  var _isConnected = false;

  void onConnect(StompFrame frame) {
    _isConnected = true;
    client.subscribe(
      destination: 'STOMP.Tx',
      callback: (frame) {
        _onMessage.call(frame.body ?? 'message: null');
      },
    );
  }

  void onDisconnect(StompFrame frame) {
    print(frame.toString());
  }

  Future<FogRepository> connect(Function(String) onMessage) async {
    // TODO: Tratar conexão anterior
    _onMessage = onMessage;
    client = StompClient(
      config: StompConfig(
        url: 'ws://${await PreferenceRepository.getBrokerHost()}:5692',
        onConnect: onConnect,
        onDisconnect: onDisconnect,
        onUnhandledFrame: onDisconnect,
        onUnhandledMessage: onDisconnect,
        onUnhandledReceipt: onDisconnect,
        onDebugMessage: (String message) => print(message),
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
    await Future.delayed(Duration(milliseconds: 200));
    return this;
  }
  
  void send(String message) {
    client.send(
        destination: '/exchange/project.STOMPExchange/STOMP.RxKey',
        body: message,
        headers: {}
    );
  }

  void disconnect(Function() onDisconnect) {
    client.deactivate();
  }
}