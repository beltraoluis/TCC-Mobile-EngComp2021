import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttRepository {
  late MqttServerClient client;
  String topic = 'test/btl';

  Future<void> connect() async {
    client = MqttServerClient('192.168.1.150:1883', '');
    client.logging(on: false);
    client.keepAlivePeriod = 20;
    client.onConnected = onConnected;
    final connMess = MqttConnectMessage()
        .withClientIdentifier('MqttClientUniqueId');
    print('connecting...');
    client.connectionMessage = connMess;
    try {
      await client.connect('admin','admin123456');
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
      print(
          '<${mqttMessage[0].topic}>: $payload');
      print('');
    });
  }

  Future<void> send(String message) async {
    final builder = MqttClientPayloadBuilder();
    builder.addString('Hello MQTT!');
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
    await MqttUtilities.asyncSleep(60);
  }

  Future<void> disconnect() async {
    client.unsubscribe(topic);
    await MqttUtilities.asyncSleep(2);
    print('disconnecting...');
    client.disconnect();
    print('disconnected');
  }

  void onConnected() {
    print('connected');
  }
}



