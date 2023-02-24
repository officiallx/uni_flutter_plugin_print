// import 'package:flutter_test/flutter_test.dart';
// import 'package:uni_flutter_plugin/printer/printer_constants.dart';
// import 'package:uni_flutter_plugin/uni_flutter_plugin_platform_interface.dart';
// import 'package:uni_flutter_plugin/uni_flutter_plugin_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockUniFlutterPluginPlatform
//     with MockPlatformInterfaceMixin
//     implements UniFlutterPluginPlatform {
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
//
//   @override
//   Future<bool> checkPaper() {
//     // TODO: implement checkPaper
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<int> closePrinter() {
//     // TODO: implement closePrinter
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<String> getVersion() {
//     // TODO: implement getVersion
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<int> iFlushBuffer() {
//     // TODO: implement iFlushBuffer
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<int> iGetPrinterStatus() {
//     // TODO: implement iGetPrinterStatus
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<int> iSetPrinterProperties(
//       FontSize fontSize, TextAlignment textAlignment) {
//     // TODO: implement iSetPrinterProperties
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<int> iStartPrinting() {
//     // TODO: implement iStartPrinting
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<int> iUpdateBufferFontSize(FontSize fontSize) {
//     // TODO: implement iUpdateBufferFontSize
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<int> iUpdateBufferListInteger(List<int> data) {
//     // TODO: implement iUpdateBufferListInteger
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<int> iUpdateBufferString(String data) {
//     // TODO: implement iUpdateBufferString
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<int> iUpdateBufferTextAlignment(TextAlignment textAlignment) {
//     // TODO: implement iUpdateBufferTextAlignment
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<int> initPrinter() {
//     // TODO: implement initPrinter
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<int> printImage(List<int> data) {
//     // TODO: implement printImage
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<int> printLine(int line) {
//     // TODO: implement printLine
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<int> printQRCode(String data) {
//     // TODO: implement printQRCode
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<int> printText(String data) {
//     // TODO: implement printText
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<int> iPrintEANBarcode(String data, int height) {
//     // TODO: implement iPrintEANBarcode
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<int> sendRawData(List<int> data) {
//     // TODO: implement sendRawData
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<int> setLogEnable(bool status) {
//     // TODO: implement setLogEnable
//     throw UnimplementedError();
//   }
// }
//
// void main() {
//   final UniFlutterPluginPlatform initialPlatform =
//       UniFlutterPluginPlatform.instance;
//
//   test('$MethodChannelUniFlutterPlugin is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelUniFlutterPlugin>());
//   });
//
//   test('getPlatformVersion', () async {
//     // UniFlutterPlugin uniFlutterPlugin = UniFlutterPlugin();
//     MockUniFlutterPluginPlatform fakePlatform = MockUniFlutterPluginPlatform();
//     UniFlutterPluginPlatform.instance = fakePlatform;
//
//     // expect(await uniFlutterPlugin.getPlatformVersion(), '42');
//   });
// }
