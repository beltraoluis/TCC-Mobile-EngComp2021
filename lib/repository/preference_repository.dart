import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

abstract class PreferenceRepository {
  static final _prefs = SharedPreferences.getInstance();
  static final _backendKey = 'backend-key';
  static final _brokerKey = 'broker-key';
  static final _userKey = 'user-key';
  static final _passwordKey = 'password-key';
  static final _messageSizeKey = 'message-size-key';
  static final _messageDeltaKey = 'message-delta-key';
  static final _messageQtyKey = 'message-qty-key';
  static final _protocolKey = 'protocol-key';
  static final _defaultBackend = 'https://tcc-jl-backend.herokuapp.com';
  static final _defaultBroker = '192.168.1.101';
  static final _defaultUser = 'mqttUser';
  static final _defaultPassword = 'mqttUser';
  static final _defaultMessageSize = 250;
  static final _defaultMessageDelta = (300000/100).floor();
  static final _defaultMessageQty = 100;
  static const _defaultProtocol = amqp;
  static const amqp = 'AMQP';
  static const stomp = 'STOMP';
  static const mqtt = 'MQTT';

  static _setStringPref(String key, String value) async {
    await _prefs.then((prefs) => prefs.setString(key, value));
    log('set value "$value" for key "$key"');
  }

  static Future<String> _getStringPref(String key, String defaultValue) async {
    String? value;
    await _prefs.then((prefs) {
      value = prefs.getString(key);
      if (value != null) {
        log('returning value "$value" for key "$key"');
      }
    });
    if (value == null) {
      value = defaultValue;
      await _prefs.then((prefs) => prefs.setString(key, value!));
      log('set default value "$defaultValue" for key "$key"');
      log('returning default value "$defaultValue" for key "$key"');
    }
    return value!;
  }

  static _setIntPref(String key, int value) async {
    await _prefs.then((prefs) => prefs.setInt(key, value));
    log('set value "$value" for key "$key"');
  }

  static Future<int> _getIntPref(String key, int defaultValue) async {
    int? value;
    await _prefs.then((prefs) {
      value = prefs.getInt(key);
      if (value != null) {
        log('returning value "$value" for key "$key"');
      }
    });
    if (value == null) {
      value = defaultValue;
      await _prefs.then((prefs) => prefs.setInt(key, value!));
      log('set default value "$defaultValue" for key "$key"');
      log('returning default value "$defaultValue" for key "$key"');
    }
    return value!;
  }

  static setBackendUrl(String value) {
    if(value.isEmpty) {
      _setStringPref(_backendKey, _defaultBackend);
    } else {
      _setStringPref(_backendKey, value);
    }
  }

  static Future<String> getBackendUrl() async {
    String result = "";
    await _getStringPref(_backendKey, _defaultBackend).then((value) => result = value);
    return result;
  }

  static setBrokerHost(String value) {
    if(value.isEmpty) {
      _setStringPref(_brokerKey, _defaultBroker);
    } else {
      _setStringPref(_brokerKey, value);
    }
  }

  static Future<String> getBrokerHost() async {
    String result = "";
    await _getStringPref(_brokerKey, _defaultBroker).then((value) => result = value);
    return result;
  }

  static setUser(String value) {
    if(value.isEmpty) {
      _setStringPref(_userKey, _defaultUser);
    } else {
      _setStringPref(_userKey, value);
    }
  }

  static Future<String> getUser() async {
    String result = "";
    await _getStringPref(_userKey, _defaultUser).then((value) => result = value);
    return result;
  }

  static setPassword(String value) {
    if(value.isEmpty) {
      _setStringPref(_passwordKey, _defaultPassword);
    } else {
      _setStringPref(_passwordKey, value);
    }
  }

  static Future<String> getPassword() async {
    String result = "";
    await _getStringPref(_passwordKey, _defaultPassword).then((value) => result = value);
    return result;
  }

  static setMessageSize(int value) {
    if(value == 0) {
      _setIntPref(_messageSizeKey, _defaultMessageSize);
    } else {
      _setIntPref(_messageSizeKey, value);
    }
  }

  static Future<int> getMessageSize() async {
    int result = 0;
    await _getIntPref(_messageSizeKey, _defaultMessageSize).then((value) => result = value);
    return result;
  }

  static setMessageDelta(int value) {
    if(value == 0) {
      _setIntPref(_messageDeltaKey, _defaultMessageDelta);
    } else {
      _setIntPref(_messageDeltaKey, value);
    }
  }

  static Future<int> getMessageDelta() async {
    int result = 0;
    await _getIntPref(_messageDeltaKey, _defaultMessageDelta).then((value) => result = value);
    return result;

  }

  static setMessageQty(int value) {
    if(value == 0) {
      _setIntPref(_messageQtyKey, _defaultMessageQty);
    } else {
      _setIntPref(_messageQtyKey, value);
    }
  }

  static Future<int> getMessageQty() async {
    int result = 0;
    await _getIntPref(_messageQtyKey, _defaultMessageQty).then((value) => result = value );
    return result;
  }

  static setProtocol(String value) {
    if(value.isEmpty) {
      _setStringPref(_protocolKey, _defaultProtocol);
    } else {
      _setStringPref(_protocolKey, value);
    }
  }

  static Future<String> getProtocol() async {
    String result = '';
    await _getStringPref(_protocolKey, _defaultProtocol).then((value) => result = value );
    return result;
  }
}