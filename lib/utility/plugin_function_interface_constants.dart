class PluginFunctionInterfaceConstants {
  //main Channel Name
  static const String MAIN_CHANNEL_NAME = "uni_flutter_plugin";

  //Event Channel names
  static const String FINGER_POSITION_CALLBACK_EVENT_CHANNEL =
      "finger_position_callback_event_channel";

//Printer functions
  static const String PRINTER_PRINT_TEXT = "printer_print_text";
  static const String PRINTER_INIT_PRINTER = "printer_init_printer";
  static const String PRINTER_CLOSE_PRINTER = "printer_close_printer";
  static const String PRINTER_PRINT_IMG = "printer_print_img";
  static const String PRINTER_PRINT_LINE = "printer_print_line";
  static const String PRINTER_CHECK_PAPER = "printer_check_paper";
  static const String PRINTER_I_FLUSH_BUFFER = "printer_i_flush_buffer";
  static const String PRINTER_I_START_PRINTING = "printer_i_start_printing";
  static const String PRINTER_I_GET_PRINTER_STATUS =
      "printer_i_get_printer_status";
  static const String PRINTER_GET_VERSION = "printer_get_version";
  static const String PRINTER_I_SET_PRINTER_PROPERTIES =
      "printer_i_set_printer_properties";
  static const String PRINTER_I_UPDATE_BUFFER_STRING =
      "printer_i_update_buffer_string";
  static const String PRINTER_I_UPDATE_BUFFER_FONT_SIZE =
      "printer_i_update_buffer_font_size";
  static const String PRINTER_I_UPDATE_BUFFER_BYTE_ARRAY =
      "printer_i_update_buffer_byte_array";
  static const String PRINTER_I_UPDATE_BUFFER_TEXT_ALIGNMENT =
      "printer_i_update_buffer_text_alignment";
  static const String PRINTER_PRINT_QR_CODE = "printer_print_qr_code";
  static const String PRINTER_PRINT_QR_CODE_WIDTH =
      "printer_print_qr_code_width";
  static const String PRINTER_PRINT_QR_CODE_WIDTH_IMAGE_ALIGNMENT =
      "printer_print_qr_code_width_image_alignment";
  static const String PRINTER_SEND_RAW_DATA = "printer_send_raw_data";
  static const String PRINTER_I_PRINT_EAN_BARCODE =
      "printer_i_print_ean_barcode";
  static const String PRINTER_SET_LOG_ENABLE = "printer_set_log_enable";

  //FPS Functions
  static const String FPS_INIT_FPS = "fps_init_fps";
  static const String FPS_CLOSE_FPS = "fps_close_fps";
  static const String FPS_CAPTURE_FPS = "fps_capture_fps";
  static const String FPS_SET_TEMPLATE = "fps_set_template";
  static const String FPS_GET_TEMPLATE = "fps_get_template";
  static const String FPS_SET_IMG_COMPRESSION_ALGO =
      "fps_set_img_compression_algo";
  static const String FPS_GET_IMG_COMPRESSION_ALGO =
      "fps_get_img_compression_algo";
  static const String FPS_GET_IMAGE_QUALITY = "fps_get_image_quality";
  static const String FPS_SET_TIMEOUT = "fps_set_timeout";
  static const String FPS_GET_TIMEOUT = "fps_get_timeout";
  static const String FPS_SET_FFD_SECURITY_LEVEL = "fps_set_ffd_security_level";
  static const String FPS_VERIFY_FPS_MATCH = "fps_verify_fps_match";
  static const String FPS_VERIFY_FPS = "fps_verify_fps";
  static const String FPS_GET_FPS_DEVICE_INFO = "fps_get_fps_device_info";
  static const String FPS_VERIFY_FPS_WITH_TEMPLATE =
      "fps_verify_fps_with_template";
  static const String FPS_ENABLE_FINGER_POSITION_UPDATES =
      "fps_enable_finger_position_updates";
  static const String FPS_DISABLE_FINGER_POSITION_UPDATES =
      "fps_disable_finger_position_updates";
}
