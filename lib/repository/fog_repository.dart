
abstract class FogRepository {
  Future<FogRepository> connect(Function(String) onMessage);
  void disconnect(Function() onDisconnect);
  void send(String message);
}