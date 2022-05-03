import 'dart:async';
import 'dart:convert';
//import 'package:stomp_dart_client/stomp.dart';
//import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:tcc_eng_comp/repository/fog_repository.dart';
import 'package:tcc_eng_comp/repository/preference_repository.dart';
import 'package:stomp/stomp.dart';
import "package:stomp/vm.dart" as StompAdapter;

class StompRepository extends FogRepository  {
  static final StompRepository _singleton = StompRepository._internal();
  Function(String) _onMessage = (value) => null;

  factory StompRepository() {
    return _singleton;
  }

  StompRepository._internal();
  
  late StompClient client;

  void onReciveMessage(var headers, var message) {
    print("<<received: message");
    print("Recieve $message");
    _onMessage.call(message);
  }

  Future<FogRepository> connect(Function(String) onMessage) async {
    // TODO: Tratar conexão anterior
    _onMessage = onMessage;
    StompAdapter.connect(await PreferenceRepository.getBrokerHost(), port: 5692, login: await PreferenceRepository.getUser(), passcode: await PreferenceRepository.getPassword())
    .then((StompClient client) {
      this.client = client;
        client.subscribeString("TCC STOMP", 'STOMP.Rx', this.onReciveMessage, ack: AUTO, matcher: all);
        //client.unsubscribe("project.STOMPExchange");
        //client.disconnect();
      });
    return this;
  }
  
  void send(String message) {
    client.sendString("/exchange/project.STOMPExchange/STOMP.RxKey", message);
  }
  
  void disconnect(Function() onDisconnect) {
    client.disconnect();
  }
}