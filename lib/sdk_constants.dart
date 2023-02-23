class PluginFunctionInterfaceConstants {
  static const String MAIN_CHANNEL_NAME = "uni_flutter_plugin";

  //Printer functions
  static const String PRINTER_PRINT_TEXT = "printer_print_text";
  static const String PRINTER_INIT_PRINTER = "printer_init_printer";
  static const String PRINTER_CLOSE_PRINTER = "printer_close_printer";
  static const String PRINTER_PRINT_IMG = "printer_print_img";
}

class SDKPrinterConstants {
  static const int PRINTER_SUCCESS = 0;
  static const int PRINTER_PAPER_OUT = -51;
  static const int PRINTER_LOW_POWER = -52;
  static const int PRINTER_BUSY = -53;
  static const int PRINTER_FAILURE = -54;
  static const int PRINTER_LIMIT_EXCEED = -55;
  static const int PRINTER_NO_RESPONSE = -56;
  static const int PRINTER_IMAGE_SIZE_NOT_SUPPORTED = -57;
}
