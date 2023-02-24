import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:uni_flutter_plugin/utility/extensions.dart';
import 'package:uni_flutter_plugin/utility/plugin_function_interface_constants.dart';

import 'printer/printer_constants.dart';
import 'uni_flutter_plugin_platform_interface.dart';

class MethodChannelUniFlutterPlugin extends UniFlutterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel =
      const MethodChannel(PluginFunctionInterfaceConstants.MAIN_CHANNEL_NAME);

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
}
