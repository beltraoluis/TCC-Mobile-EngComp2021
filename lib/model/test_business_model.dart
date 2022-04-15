import 'package:tcc_eng_comp/data/fog_protocol.dart';
import 'package:tcc_eng_comp/repository/preference_repository.dart';

class TestBusinessModel {
  Future<int> getMessageSize() async {
  return PreferenceRepository.getMessageSize();
  }

  Future<int> getMessageDelta() async {
    return PreferenceRepository.getMessageDelta();

  }

  Future<int> getMessageQty() async {
    return PreferenceRepository.getMessageQty();
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