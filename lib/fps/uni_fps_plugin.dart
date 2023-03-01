import 'package:uni_flutter_plugin/fps/sensor_response.dart';
import 'package:uni_flutter_plugin/fps/sensor_verify_image_response.dart';
import 'package:uni_flutter_plugin/fps/sensor_verify_response.dart';

import '../uni_flutter_plugin_platform_interface.dart';
import 'fps_constants.dart';
import 'fps_device_info.dart';
import 'template_data.dart';

class UniFPSPlugin {
  Future<int> initFPS() {
    return UniFlutterPluginPlatform.instance.initFPS();
  }

  Future<int> closeFPS() {
    return UniFlutterPluginPlatform.instance.closeFPS();
  }

  Future<SensorResponse> captureFPS() {
    return UniFlutterPluginPlatform.instance.captureFPS();
  }

  Future<int> setTemplate(TemplateType templateType) {
    return UniFlutterPluginPlatform.instance.setTemplate(templateType);
  }

  Future<int> getTemplate() {
    return UniFlutterPluginPlatform.instance.getTemplate();
  }

  Future<int> setImgCompressionAlgo(ImageCompressionType imageCompressionType) {
    return UniFlutterPluginPlatform.instance
        .setImgCompressionAlgo(imageCompressionType);
  }

  Future<int> getImageCompressionAlgo() {
    return UniFlutterPluginPlatform.instance.getImageCompressionAlgo();
  }

  Future<int> setTimeout(int timeout) {
    return UniFlutterPluginPlatform.instance.setTimeout(timeout);
  }

  Future<int> getTimeout() {
    return UniFlutterPluginPlatform.instance.getTimeout();
  }

  Future<int> getImageQuality() {
    return UniFlutterPluginPlatform.instance.getImageQuality();
  }

  Future<int> setFFDSecurityLevel(SecurityLevel securityLevel) {
    return UniFlutterPluginPlatform.instance.setFFDSecurityLevel(securityLevel);
  }

  Future<SensorVerifyResponse> verifyFPSMatch(
      List<int> fingerData1, List<int> fingerData2) {
    return UniFlutterPluginPlatform.instance
        .verifyFPSMatch(fingerData1, fingerData2);
  }

  Future<SensorVerifyImageResponse> verifyFPS(
      List<int> fingerData1, bool fingerDataEnabled) {
    return UniFlutterPluginPlatform.instance
        .verifyFPS(fingerData1, fingerDataEnabled);
  }

  Future<FPSDeviceInfo> getFPSDeviceInfo() {
    return UniFlutterPluginPlatform.instance.getFPSDeviceInfo();
  }

  Future<SensorVerifyImageResponse> verifyFPSWithTemplate(
      List<TemplateData> templateData, bool fingerDataEnabled) {
    return UniFlutterPluginPlatform.instance
        .verifyFPSWithTemplate(templateData, fingerDataEnabled);
  }

  Future<int> enableFingerPositionUpdates() {
    return UniFlutterPluginPlatform.instance.enableFingerPositionUpdates();
  }

  Future<int> disableFingerPositionUpdates() async {
    return UniFlutterPluginPlatform.instance.disableFingerPositionUpdates();
  }

  Stream<FingerPosition> get fingerPositionUpdates =>
      UniFlutterPluginPlatform.instance.fingerPositionUpdates;
}
