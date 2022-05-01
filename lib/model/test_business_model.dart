import 'package:tcc_eng_comp/data/fog_protocol.dart';
import 'package:tcc_eng_comp/repository/fog/mqtt_repository.dart';
import 'package:tcc_eng_comp/repository/fog/stomp_repository.dart';
import 'package:tcc_eng_comp/repository/fog_repository.dart';
import 'package:tcc_eng_comp/repository/preference_repository.dart';
import 'package:tcc_eng_comp/repository/fog/amqp_repository.dart';

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

  Future<FogProtocol> _getProtocol() async {
    var protocolName = await PreferenceRepository.getProtocol();
    switch (protocolName) {
      case PreferenceRepository.mqtt: return FogProtocol.MQTT;
      case PreferenceRepository.stomp: return FogProtocol.STOMP;
      default: return FogProtocol.AMQP;
    }
  }


  Future<FogRepository> fogRepository() async {
    FogProtocol _protocol = await _getProtocol();
    var result;
    switch(_protocol) {
      case FogProtocol.MQTT: {
        result = MqttRepository();
        break;
      }
      case FogProtocol.STOMP: {
        result = StompRepository();
        break;
      }
      case FogProtocol.AMQP: {
        result = AMQPRepository();
      }
    }
    return Future.delayed(Duration(milliseconds: 500), () => result);
  }
}