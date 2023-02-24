import 'dart:typed_data';

import '../uni_flutter_plugin_platform_interface.dart';
import 'printer_constants.dart';

class UniPrinterPlugin {
  Future<int> initPrinter() async {
    return UniFlutterPluginPlatform.instance.initPrinter();
  }

  Future<int> printText(String data) async {
    return UniFlutterPluginPlatform.instance.printText(data);
  }

  Future<int> closePrinter() async {
    return UniFlutterPluginPlatform.instance.closePrinter();
  }

  Future<int> printLine(int line) async {
    return UniFlutterPluginPlatform.instance.printLine(line);
  }

  Future<int> printImage(List<int> data) async {
    return UniFlutterPluginPlatform.instance.printImage(data);
  }

  Future<bool> checkPaper() async {
    return UniFlutterPluginPlatform.instance.checkPaper();
  }

  Future<int> iGetPrinterStatus() async {
    return UniFlutterPluginPlatform.instance.iGetPrinterStatus();
  }

  Future<int> iSetPrinterProperties(
      FontSize fontSize, TextAlignment textAlignment) async {
    return UniFlutterPluginPlatform.instance
        .iSetPrinterProperties(fontSize, textAlignment);
  }

  Future<int> iFlushBuffer() {
    return UniFlutterPluginPlatform.instance.iFlushBuffer();
  }

  Future<int> iUpdateBufferString(String data) {
    return UniFlutterPluginPlatform.instance.iUpdateBufferString(data);
  }

  Future<int> iUpdateBufferFontSize(FontSize fontSize) {
    return UniFlutterPluginPlatform.instance.iUpdateBufferFontSize(fontSize);
  }

  Future<int> iUpdateBufferListInteger(List<int> data) {
    return UniFlutterPluginPlatform.instance.iUpdateBufferListInteger(data);
  }

  Future<int> iUpdateBufferTextAlignment(TextAlignment textAlignment) {
    return UniFlutterPluginPlatform.instance
        .iUpdateBufferTextAlignment(textAlignment);
  }

  Future<int> iStartPrinting() {
    return UniFlutterPluginPlatform.instance.iStartPrinting();
  }

  Future<String> getVersion() {
    return UniFlutterPluginPlatform.instance.getVersion();
  }

  Future<int> printQRCode(String data,
      {ImageWidth? width, ImageAlignment? imageAlignment}) {
    return UniFlutterPluginPlatform.instance
        .printQRCode(data, width: width, imageAlignment: imageAlignment);
  }

  Future<int> sendRawData(List<int> data) {
    return UniFlutterPluginPlatform.instance.sendRawData(data);
  }

  Future<int> setLogEnable(bool status) {
    return UniFlutterPluginPlatform.instance.setLogEnable(status);
  }
}
