import 'uni_flutter_plugin_platform_interface.dart';

class UniFlutterPlugin {
  Future<int> initPrinter() async {
    return UniFlutterPluginPlatform.instance.initPrinter();
  }

  Future<int> printText(String data) async {
    return UniFlutterPluginPlatform.instance.printText(data);
  }
}
