import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'sdk_constants.dart';
import 'uni_flutter_plugin_platform_interface.dart';

/// An implementation of [UniFlutterPluginPlatform] that uses method channels.
class MethodChannelUniFlutterPlugin extends UniFlutterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel =
      const MethodChannel(PluginFunctionInterfaceConstants.MAIN_CHANNEL_NAME);

  @override
  Future<int> initPrinter() async {
    final ret = await methodChannel
        .invokeMethod(PluginFunctionInterfaceConstants.PRINTER_INIT_PRINTER);
    return ret;
  }

  @override
  Future<int> closePrinter() async {
    final ret = await methodChannel
        .invokeMethod(PluginFunctionInterfaceConstants.PRINTER_CLOSE_PRINTER);
    return ret;
  }

  @override
  Future<int> printText(String data) async {
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.PRINTER_PRINT_TEXT, {"data": data});
    return ret;
  }

  @override
  Future<int> printImage(Uint8List data) async {
    String stringData = data.toString();
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.PRINTER_PRINT_IMG,
        {"data": stringData});
    return ret;
  }
}
