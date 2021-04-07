import 'dart:async';

import 'package:flutter/services.dart';

class KeychainReader {
  static const MethodChannel _channel = const MethodChannel('keychain_reader');

  Future<List<Map<String, String>>> getKeychain() async {
    final List keychain = await _channel.invokeMethod('getKeychain');
    List<Map<String, String>> typedKeychain = [];
    for (Map key in keychain) {
      typedKeychain.add(Map<String, String>.from(key));
    }
    return typedKeychain;
  }
}
