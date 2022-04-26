import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:tcc_eng_comp/repository/preference_repository.dart';

import '../fog_repository.dart';

class MqttRepository extends FogRepository {
  late MqttServerClient client;
  String topic = 'tcc/mqtt';

  Future<FogRepository> connect(Function(String) onMessage) async {
    var identifier = 'mqtt-${await PreferenceRepository.getUser()}';
    var user = await PreferenceRepository.getUser();
    user = '$user:$user';
    client = MqttServerClient(await PreferenceRepository.getBrokerHost(), '#');
    client.logging(on: true);
    client.port = 1883;
    client.keepAlivePeriod = 20;
    client.onConnected = onConnected;
    final connMess = MqttConnectMessage()
        .withClientIdentifier(identifier);
    print('connecting...');
    client.connectionMessage = connMess;
    try {
      await client.connect(user,await PreferenceRepository.getPassword());
    } on NoConnectionException catch (e) {
      print('exception: $e');
      client.disconnect();
    } on SocketException catch (e) {
      print('socket_exception: $e');
      client.disconnect();
    }
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('connected');
    } else {
      print('status is ${client.connectionStatus}');
      client.disconnect();
      exit(-1);
    }
    client.subscribe(topic, MqttQos.exactlyOnce);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? mqttMessage) {
      final receivedMessage = mqttMessage![0].payload as MqttPublishMessage;
      final payload = MqttPublishPayload.bytesToStringAsString(receivedMessage.payload.message);
      onMessage.call(payload);
    });
    return this;
  }

  Future<void> send(String message) async {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
    await MqttUtilities.asyncSleep(60);
  }

  void disconnect(Function() onDisconnect) async {
    client.unsubscribe(topic);
    await MqttUtilities.asyncSleep(2);
    print('disconnecting...');
    client.disconnect();
    print('disconnected');
  }

  void onConnected() {
    print('MQTT connected');
  }
}



