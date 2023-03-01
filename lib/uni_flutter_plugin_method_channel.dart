import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:uni_flutter_plugin/fps/sensor_response.dart';
import 'package:uni_flutter_plugin/utility/extensions.dart';
import 'package:uni_flutter_plugin/utility/helper_functions.dart';
import 'package:uni_flutter_plugin/utility/plugin_function_interface_constants.dart';

import 'fps/fps_constants.dart';
import 'fps/fps_device_info.dart';
import 'fps/sensor_verify_image_response.dart';
import 'fps/sensor_verify_response.dart';
import 'fps/template_data.dart';
import 'printer/printer_constants.dart';
import 'uni_flutter_plugin_platform_interface.dart';

class MethodChannelUniFlutterPlugin extends UniFlutterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel =
      const MethodChannel(PluginFunctionInterfaceConstants.MAIN_CHANNEL_NAME);

  final EventChannel fingerPositionCallbackChannel = const EventChannel(
      PluginFunctionInterfaceConstants.FINGER_POSITION_CALLBACK_EVENT_CHANNEL);
  Stream<FingerPosition>? _onFingerPositionUpdated;

  //***************************************************PRINTER APIS********************************************8
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
        PluginFunctionInterfaceConstants.PRINTER_PRINT_TEXT, data);
    return ret;
  }

  @override
  Future<int> printImage(List<int> data) async {
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.PRINTER_PRINT_IMG, data);
    return ret;
  }

  @override
  Future<int> printLine(int line) async {
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.PRINTER_PRINT_LINE, line);
    return ret;
  }

  @override
  Future<bool> checkPaper() async {
    final ret = await methodChannel
        .invokeMethod(PluginFunctionInterfaceConstants.PRINTER_CHECK_PAPER);
    return ret == 1;
  }

  @override
  Future<int> iStartPrinting() async {
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.PRINTER_I_START_PRINTING);
    return ret;
  }

  @override
  Future<int> iFlushBuffer() async {
    final ret = await methodChannel
        .invokeMethod(PluginFunctionInterfaceConstants.PRINTER_I_FLUSH_BUFFER);
    return ret;
  }

  @override
  Future<int> iGetPrinterStatus() async {
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.PRINTER_I_GET_PRINTER_STATUS);
    return ret;
  }

  @override
  Future<String> getVersion() async {
    final ret = await methodChannel
        .invokeMethod(PluginFunctionInterfaceConstants.PRINTER_GET_VERSION);
    return ret;
  }

  @override
  Future<int> iSetPrinterProperties(
      FontSize fontSize, TextAlignment textAlignment) async {
    int fontSizeValue = fontSize.id;
    int textAlignmentValue = textAlignment.id;
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.PRINTER_I_SET_PRINTER_PROPERTIES,
        {"font_size": fontSizeValue, "text_alignment": textAlignmentValue});
    return ret;
  }

  @override
  Future<int> iUpdateBufferFontSize(FontSize fontSize) async {
    int fontSizeValue = fontSize.id;
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.PRINTER_I_UPDATE_BUFFER_FONT_SIZE,
        fontSizeValue);
    return ret;
  }

  @override
  Future<int> iUpdateBufferString(String data) async {
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.PRINTER_I_UPDATE_BUFFER_STRING, data);
    return ret;
  }

  @override
  Future<int> iUpdateBufferListInteger(List<int> data) async {
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.PRINTER_I_UPDATE_BUFFER_BYTE_ARRAY,
        data);
    return ret;
  }

  @override
  Future<int> iUpdateBufferTextAlignment(TextAlignment textAlignment) async {
    int textAlignmentValue = textAlignment.id;
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.PRINTER_I_UPDATE_BUFFER_TEXT_ALIGNMENT,
        textAlignmentValue);
    return ret;
  }

  @override
  Future<int> printQRCode(String data,
      {ImageWidth? width, ImageAlignment? imageAlignment}) async {
    if (width == null && imageAlignment == null) {
      final ret = await methodChannel.invokeMethod(
          PluginFunctionInterfaceConstants.PRINTER_PRINT_QR_CODE, data);
      return ret;
    } else if (width != null && imageAlignment == null) {
      int widthValue = width.id;
      final ret = await methodChannel.invokeMethod(
          PluginFunctionInterfaceConstants.PRINTER_PRINT_QR_CODE_WIDTH,
          {"data": data, "width": widthValue});
      return ret;
    } else if (width == null && imageAlignment != null) {
      final ret = await methodChannel.invokeMethod(
          PluginFunctionInterfaceConstants.PRINTER_PRINT_QR_CODE, data);
      return ret;
    } else {
      int imageAlignmentValue = imageAlignment!.id;
      int widthValue = width!.id;
      final ret = await methodChannel.invokeMethod(
          PluginFunctionInterfaceConstants
              .PRINTER_PRINT_QR_CODE_WIDTH_IMAGE_ALIGNMENT,
          {
            "data": data,
            "width": widthValue,
            "image_alignment": imageAlignmentValue
          });
      return ret;
    }
  }

  @override
  Future<int> sendRawData(List<int> data) async {
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.PRINTER_SEND_RAW_DATA, data);
    return ret;
  }

  @override
  Future<int> iPrintEANBarcode(String data, int height) async {
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.PRINTER_I_PRINT_EAN_BARCODE,
        {"data": data, "height": height});
    return ret;
  }

  @override
  Future<int> setLogEnable(bool status) async {
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.PRINTER_SET_LOG_ENABLE, status);
    return ret;
  }

//*****************************************************FPS APIS*************************************************************************

  @override
  Future<int> initFPS() async {
    final ret = await methodChannel
        .invokeMethod(PluginFunctionInterfaceConstants.FPS_INIT_FPS);
    return ret;
  }

  @override
  Future<int> closeFPS() async {
    final ret = await methodChannel
        .invokeMethod(PluginFunctionInterfaceConstants.FPS_CLOSE_FPS);
    return ret;
  }

  @override
  Future<SensorResponse> captureFPS() async {
    final ret = await methodChannel
        .invokeMethod(PluginFunctionInterfaceConstants.FPS_CAPTURE_FPS);
    return SensorResponse.fromJson(json.decode(ret));
  }

  @override
  Future<int> setTemplate(TemplateType templateType) async {
    int templateValue = templateType.id;
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.FPS_SET_TEMPLATE, templateValue);
    return ret;
  }

  @override
  Future<int> getTemplate() async {
    final ret = await methodChannel
        .invokeMethod(PluginFunctionInterfaceConstants.FPS_GET_TEMPLATE);
    return ret;
  }

  @override
  Future<int> setImgCompressionAlgo(
      ImageCompressionType imageCompressionType) async {
    int imageCompression = imageCompressionType.id;
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.FPS_SET_IMG_COMPRESSION_ALGO,
        imageCompression);
    return ret;
  }

  @override
  Future<int> getImageCompressionAlgo() async {
    final ret = await methodChannel.invokeMethod(
      PluginFunctionInterfaceConstants.FPS_GET_IMG_COMPRESSION_ALGO,
    );
    return ret;
  }

  @override
  Future<int> setTimeout(int timeout) async {
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.FPS_SET_TIMEOUT, timeout);
    return ret;
  }

  @override
  Future<int> getTimeout() async {
    final ret = await methodChannel
        .invokeMethod(PluginFunctionInterfaceConstants.FPS_GET_TIMEOUT);
    return ret;
  }

  @override
  Future<int> setFFDSecurityLevel(SecurityLevel securityLevel) async {
    int ffd = securityLevel.id;
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.FPS_SET_FFD_SECURITY_LEVEL, ffd);
    return ret;
  }

  @override
  Future<int> getImageQuality() async {
    final ret = await methodChannel
        .invokeMethod(PluginFunctionInterfaceConstants.FPS_GET_IMAGE_QUALITY);
    return ret;
  }

  @override
  Future<FPSDeviceInfo> getFPSDeviceInfo() async {
    final ret = await methodChannel
        .invokeMethod(PluginFunctionInterfaceConstants.FPS_GET_FPS_DEVICE_INFO);
    return FPSDeviceInfo.fromJSON(json.decode(ret));
  }

  @override
  Future<SensorVerifyImageResponse> verifyFPS(
      List<int> fingerData1, bool fingerDataEnabled) async {
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.FPS_VERIFY_FPS, {
      "finger_data_1": fingerData1,
      "finger_data_enabled": fingerDataEnabled
    });
    return SensorVerifyImageResponse.fromJSON(json.decode(ret));
  }

  @override
  Future<SensorVerifyResponse> verifyFPSMatch(
      List<int> fingerData1, List<int> fingerData2) async {
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.FPS_VERIFY_FPS_MATCH,
        {"finger_data_1": fingerData1, "finger_data_2": fingerData2});
    return SensorVerifyResponse.fromJSON(json.decode(ret));
  }

  @override
  Future<SensorVerifyImageResponse> verifyFPSWithTemplate(
      List<TemplateData> templateData, bool fingerDataEnabled) async {
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.FPS_VERIFY_FPS_WITH_TEMPLATE, {
      "template_data_list":
          List<dynamic>.from(templateData.map((x) => x.toJson())),
      "finger_data_enabled": fingerDataEnabled
    });
    return SensorVerifyImageResponse.fromJSON(json.decode(ret));
  }

  @override
  Future<int> enableFingerPositionUpdates() async {
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.FPS_ENABLE_FINGER_POSITION_UPDATES);
    return ret;
  }

  @override
  Future<int> disableFingerPositionUpdates() async {
    final ret = await methodChannel.invokeMethod(
        PluginFunctionInterfaceConstants.FPS_DISABLE_FINGER_POSITION_UPDATES);
    return ret;
  }

  @override
  Stream<FingerPosition> get fingerPositionUpdates {
    _onFingerPositionUpdated ??= fingerPositionCallbackChannel
        .receiveBroadcastStream()
        .map((event) => HelperFunctions.getValueOfFingerPosition(
            int.parse(event.toString())));
    return _onFingerPositionUpdated!;
  }
}
