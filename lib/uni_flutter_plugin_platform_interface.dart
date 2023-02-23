import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'uni_flutter_plugin_method_channel.dart';

abstract class UniFlutterPluginPlatform extends PlatformInterface {
  /// Constructs a UniFlutterPluginPlatform.
  UniFlutterPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static UniFlutterPluginPlatform _instance = MethodChannelUniFlutterPlugin();

  /// The default instance of [UniFlutterPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelUniFlutterPlugin].
  static UniFlutterPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UniFlutterPluginPlatform] when
  /// they register themselves.
  static set instance(UniFlutterPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<int> initPrinter() {
    throw UnimplementedError('initPrinter() has not been implemented.');
  }

  Future<int> closePrinter() {
    throw UnimplementedError('closePrinter() has not been implemented.');
  }

  Future<int> printText(String data) {
    throw UnimplementedError('printText() has not been implemented.');
  }

  Future<int> printImage(Uint8List data) {
    throw UnimplementedError('printImage() has not been implemented.');
  }
}
