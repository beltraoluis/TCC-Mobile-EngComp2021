import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_eng_comp/repository/preference_repository.dart';
import 'package:tcc_eng_comp/util/fog_protocol.dart';

class MenuBusinessModel {
  final _backendToken = 'IzJUQ0MwSm9zZTJMdWlzMg==';

  setBackendUrl(String value) {
    PreferenceRepository.setBackendUrl(value);
  }

  Future<String> getBackendUrl() async {
    return PreferenceRepository.getBackendUrl();
  }

  setBrokerUrl(String value) {
    PreferenceRepository.setBrokerUrl(value);
  }

  Future<String> getBrokerUrl() async {
    return PreferenceRepository.getBrokerUrl();
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
    PreferenceRepository.setMessageSize(int.parse(value));
  }

  Future<String> getMessageSize() async {
    return (await PreferenceRepository.getMessageSize()).toString();
  }

  setMessageDelta(String value) {
    PreferenceRepository.setMessageDelta(int.parse(value));
  }

  Future<String> getMessageDelta() async {
    return (await PreferenceRepository.getMessageDelta()).toString();

  }

  setMessageQty(String value) {
    PreferenceRepository.setMessageQty(int.parse(value));
  }

  Future<String> getMessageQty() async {
    return (await PreferenceRepository.getMessageQty()).toString();
  }

  setProtocol(FogProtocol value) {
    PreferenceRepository.setProtocol(value.name);
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