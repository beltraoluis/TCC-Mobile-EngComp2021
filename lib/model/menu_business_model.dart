import 'package:shared_preferences/shared_preferences.dart';

class MenuBusinessModel {
  final _prefs = SharedPreferences.getInstance();
  static final defaultBackendKey = 'backend-key';
  final _backendToken = 'IzJUQ0MwSm9zZTJMdWlzMg==';
  final _defaultBackend = 'https://tcc-jl-backend.herokuapp.com';
  static final defaultBrokerKey = 'broker-key';
  final _defaultBroker = 'https://jackal.rmq.cloudamqp.com';
  static final defaultUserKey = 'user-key';
  final _defaultUser = 'sivnzjfk';
  static final defaultPasswordKey = 'password-key';
  final _defaultPassword = 'nTs2UKTM67C_1VGOOoO7gkRgYNxv2Udb';
  static final defaultMessageSizeKey = 'message-size-key';
  final _defaultMessageSize = 250;
  static final defaultMessageDeltaKey = 'message-delta-key';
  final _defaultMessageDelta = (300000/100).floor();
  static final defaultMessageQtyKey = 'message-qty-key';
  final _defaultMessageQty = 100;

  Future<String> _getPref(String key, String defaultValue) async {
    String? value;
    await _prefs.then((prefs) {
      value = prefs.getString(key);
      if (value != null) {
        return value;
      }
    });
    if (value == null) {
      await _prefs.then((prefs) => prefs.setString(key, defaultValue));
    }
    return defaultValue;
  }

  Future<int> _getPrefInt(String key, int defaultValue) async {
    int? value;
    await _prefs.then((prefs) {
      value = prefs.getInt(key);
      if (value != null) {
        return value;
      }
    });
    if (value == null) {
      await _prefs.then((prefs) => prefs.setInt(key, defaultValue));
    }
    return defaultValue;
  }

  Future<String> getBackendUrl() async {
    String result = "";
    await _getPref(defaultBackendKey, _defaultBackend).then((value) => result = value);
    return result;
  }

  Future<String> getBrokerUrl() async {
    String result = "";
    await _getPref(defaultBrokerKey, _defaultBroker).then((value) => result = value);
          return result;
  }

  Future<String> getUser() async {
    String result = "";
    await _getPref(defaultUserKey, _defaultUser).then((value) => result = value);
    return result;
  }

  Future<String> getPassword() async {
    String result = "";
    await _getPref(defaultPasswordKey, _defaultPassword).then((value) => result = value);
    return result;
  }

  Future<String> getMessageSize() async {
    String result = "";
    await _getPrefInt(defaultMessageSizeKey, _defaultMessageSize).then((value) => result = value.toString());
    return result;
  }

  Future<String> getMessageDelta() async {
    String result = "";
    await _getPrefInt(defaultMessageDeltaKey, _defaultMessageDelta).then((value) => result = value.toString());
    return result;

  }

  Future<String> getMessageQty() async {
    String result = "";
    await _getPrefInt(defaultMessageQtyKey, _defaultMessageQty).then((value) => result = value.toString());
    return result;
  }
}