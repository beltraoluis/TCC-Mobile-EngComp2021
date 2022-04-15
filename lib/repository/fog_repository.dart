
abstract class FogRepository {
  void connect(Function() onConnect );
  void disconnect(Function() onDisconnect);
  void onMessageReceived(Function(String) onMessage);
  void send(String message);
}