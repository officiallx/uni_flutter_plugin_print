import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:uni_flutter_plugin/printer/printer_constants.dart';

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

  Future<int> printImage(List<int> data) {
    throw UnimplementedError('printImage() has not been implemented.');
  }

  Future<int> printLine(int line) {
    throw UnimplementedError('printLine() has not been implemented.');
  }

  Future<int> iFlushBuffer() {
    throw UnimplementedError('iFlushBuffer() has not been implemented.');
  }

  Future<bool> checkPaper() {
    throw UnimplementedError("checkPaper() has not been implemented.");
  }

  Future<int> iStartPrinting() {
    throw UnimplementedError("iStartPrinting() has not been implemented.");
  }

  Future<int> iGetPrinterStatus() {
    throw UnimplementedError("iGetPrinterStatus() has not been implemented.");
  }

  Future<String> getVersion() {
    throw UnimplementedError("getVersion() has not been implemented.");
  }

  Future<int> iSetPrinterProperties(
      FontSize fontSize, TextAlignment textAlignment) {
    throw UnimplementedError(
        "iSetPrinterProperties() has not been implemented.");
  }

  Future<int> iUpdateBufferString(String data) {
    throw UnimplementedError("iUpdateBufferString() has not been implemented.");
  }

  Future<int> iUpdateBufferFontSize(FontSize fontSize) {
    throw UnimplementedError(
        "iUpdateBufferFontSize() has not been implemented.");
  }

  Future<int> iUpdateBufferListInteger(List<int> data) {
    throw UnimplementedError(
        "iUpdateBufferListInteger() has not been implemented.");
  }

  Future<int> iUpdateBufferTextAlignment(TextAlignment textAlignment) {
    throw UnimplementedError(
        "iUpdateBufferTextAlignment() has not been implemented.");
  }

  Future<int> printQRCode(String data,
      {ImageWidth? width, ImageAlignment? imageAlignment}) {
    throw UnimplementedError("printQRCode() has not been implemented.");
  }

  Future<int> sendRawData(List<int> data) {
    throw UnimplementedError("sendRawData() has not been implemented.");
  }

  Future<int> iPrintEANBarcode(String data, int height) {
    throw UnimplementedError("iPrintEANBarcode() has not been implemented.");
  }

  Future<int> setLogEnable(bool status) {
    throw UnimplementedError("setLogEnable() has not been implemented.");
  }
}
