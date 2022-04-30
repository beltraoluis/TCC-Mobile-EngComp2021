import 'dart:developer';

import "package:dart_amqp/dart_amqp.dart";
import 'package:tcc_eng_comp/repository/fog_repository.dart';
import 'package:tcc_eng_comp/repository/preference_repository.dart';

class AMQPRepository extends FogRepository {
  late Client _client;
  late ConnectionSettings _settings;
  final _queueName = "tcc-amqp";

  void init() async{
    _settings = ConnectionSettings(
        host: await PreferenceRepository.getBrokerHost(),
        port: 5672,
        virtualHost: '/',//await PreferenceRepository.getUser(),
        authProvider: AmqPlainAuthenticator(
            await PreferenceRepository.getUser(),
            await PreferenceRepository.getPassword())
    );
    _client = Client(settings: _settings);
  }

  AMQPRepository() {
    init();
  }

  Future<FogRepository> connect(Function(String) onMessage ) async {
    var channel = await _client.channel();
    var queue = await channel.queue(_queueName);
    log('AMQP connected');
    Consumer consumer = await queue.consume();
    consumer.listen((AmqpMessage message) {
      onMessage.call(message.payloadAsString);
    });
    consumer.listen((AmqpMessage message) => onMessage.call(message.payloadAsString));
    return this;
  }

  void send(String message) async {
    var client = Client(settings: _settings);
    var channel = await client.channel();
    var queue = await channel.queue(_queueName);
    queue.publish(message);
    client.close();
  }

  void disconnect(Function() onDisconnect) {
    _client.close().then((value) => onDisconnect.call());
  }
}