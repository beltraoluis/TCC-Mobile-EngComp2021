import 'package:tcc_eng_comp/repository/preference_repository.dart';
import 'package:tcc_eng_comp/data/fog_protocol.dart';

class MenuBusinessModel {
  final _backendToken = 'IzJUQ0MwSm9zZTJMdWlzMg==';

  setBackendUrl(String value) {
    PreferenceRepository.setBackendUrl(value);
  }

  Future<String> getBackendUrl() async {
    return PreferenceRepository.getBackendUrl();
  }

  setBrokerUrl(String value) {
    PreferenceRepository.setBrokerHost(value);
  }

  Future<String> getBrokerHost() async {
    return PreferenceRepository.getBrokerHost();
  }

  setUser(String value) {
    PreferenceRepository.setUser(value);
  }

  Future<String> getUser() async {
    return PreferenceRepository.getUser();
  }

  setPassword(String value) {
    PreferenceRepository.setPassword(value);
  }

  Future<String> getPassword() async {
    return PreferenceRepository.getPassword();
  }

  setMessageSize(String value) {
    if(value.isEmpty) {
      PreferenceRepository.setMessageSize(0);
    }
    else {
      PreferenceRepository.setMessageSize(int.parse(value));
    }
  }

  Future<String> getMessageSize() async {
    return (await PreferenceRepository.getMessageSize()).toString();
  }

  setMessageDelta(String value) {
    if(value.isEmpty) {
      PreferenceRepository.setMessageDelta(0);
    }
    else {
      PreferenceRepository.setMessageDelta(int.parse(value));
    }
  }

  Future<String> getMessageDelta() async {
    return (await PreferenceRepository.getMessageDelta()).toString();

  }

  setMessageQty(String value) {
    if(value.isEmpty) {
      PreferenceRepository.setMessageQty(0);
    }
    else {
      PreferenceRepository.setMessageQty(int.parse(value));
    }
  }

  Future<String> getMessageQty() async {
    return (await PreferenceRepository.getMessageQty()).toString();
  }

  setProtocol(FogProtocol? value) {
    var protocol;
    switch(value) {
      case null:
      case FogProtocol.AMQP:
        protocol = PreferenceRepository.amqp;
        break;
      case FogProtocol.STOMP:
        protocol = PreferenceRepository.stomp;
        break;
      case FogProtocol.MQTT:
        protocol = PreferenceRepository.mqtt;
        break;
    }
    PreferenceRepository.setProtocol(protocol);
  }

  Future<FogProtocol> getProtocol() async {
    var protocolName = await PreferenceRepository.getProtocol();
    switch (protocolName) {
      case PreferenceRepository.mqtt: return FogProtocol.MQTT;
      case PreferenceRepository.stomp: return FogProtocol.STOMP;
      default: return FogProtocol.AMQP;
    }
  }
}