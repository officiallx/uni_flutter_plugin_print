import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:uni_flutter_plugin/fps/sensor_response.dart';
import 'package:uni_flutter_plugin/printer/printer_constants.dart';

import 'fps/fps_constants.dart';
import 'fps/fps_device_info.dart';
import 'fps/sensor_verify_image_response.dart';
import 'fps/sensor_verify_response.dart';
import 'fps/template_data.dart';
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

  //***********************************PRINTER APIS********************************************
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

//*************************FPS APIS**************************************************************

  Future<int> initFPS() {
    throw UnimplementedError("initFPS() has not been implemented.");
  }

  Future<int> closeFPS() {
    throw UnimplementedError("closeFPS() has not been implemented.");
  }

  Future<SensorResponse> captureFPS() {
    throw UnimplementedError("captureFPS() has not been implemented.");
  }

  Future<int> setTemplate(TemplateType templateType) {
    throw UnimplementedError("setTemplate() has not been implemented.");
  }

  Future<int> getTemplate() {
    throw UnimplementedError("getTemplate() has not been implemented.");
  }

  Future<int> setImgCompressionAlgo(ImageCompressionType imageCompressionType) {
    throw UnimplementedError(
        "setImgCompressionAlgo() has not been implemented.");
  }

  Future<int> getImageCompressionAlgo() {
    throw UnimplementedError(
        "getImageCompressionAlgo() has not been implemented.");
  }

  Future<int> setTimeout(int timeout) {
    throw UnimplementedError("setTimeout() has not been implemented.");
  }

  Future<int> getTimeout() {
    throw UnimplementedError("getTimeout() has not been implemented.");
  }

  Future<int> getImageQuality() {
    throw UnimplementedError("getImageQuality() has not been implemented.");
  }

  Future<int> setFFDSecurityLevel(SecurityLevel securityLevel) {
    throw UnimplementedError("setFFDSecurityLevel() has not been implemented.");
  }

  Future<SensorVerifyResponse> verifyFPSMatch(
      List<int> fingerData1, List<int> fingerData2) {
    throw UnimplementedError("verifyFPSMatch() has not been implemented.");
  }

  Future<SensorVerifyImageResponse> verifyFPS(
      List<int> fingerData1, bool fingerDataEnabled) {
    throw UnimplementedError("verifyFPS() has not been implemented.");
  }

  Future<FPSDeviceInfo> getFPSDeviceInfo() {
    throw UnimplementedError("FPSDeviceInfo() has not been implemented.");
  }

  Future<SensorVerifyImageResponse> verifyFPSWithTemplate(
      List<TemplateData> templateData, bool fingerDataEnabled) {
    throw UnimplementedError(
        "verifyFPSWithTemplate() has not been implemented.");
  }

  Future<int> enableFingerPositionUpdates() async {
    throw UnimplementedError(
        "enableFingerPositionUpdates() has not been implemented.");
  }

  Future<int> disableFingerPositionUpdates() async {
    throw UnimplementedError(
        "disableFingerPositionUpdates() has not been implemented.");
  }

  Stream<FingerPosition> get fingerPositionUpdates {
    throw UnimplementedError(
        'fingerPositionUpdates() has not been implemented.');
  }
}
