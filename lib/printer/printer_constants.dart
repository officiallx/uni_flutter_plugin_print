class PrinterConstants {
  static const int PRINTER_SUCCESS = 0;
  static const int PRINTER_PAPER_OUT = -51;
  static const int PRINTER_LOW_POWER = -52;
  static const int PRINTER_BUSY = -53;
  static const int PRINTER_FAILURE = -54;
  static const int PRINTER_LIMIT_EXCEED = -55;
  static const int PRINTER_NO_RESPONSE = -56;
  static const int PRINTER_IMAGE_SIZE_NOT_SUPPORTED = -57;
}

enum FontSize {
  Width_x_Height_1x1,
  Width_x_Height_1x2,
  Width_x_Height_1x3,
  Width_x_Height_1x4,
  Width_x_Height_2x1,
  Width_x_Height_2x2,
  Width_x_Height_2x3,
  Width_x_Height_2x4,
  Width_x_Height_3x1,
  Width_x_Height_3x2,
  Width_x_Height_3x3,
  Width_x_Height_3x4,
  Width_x_Height_4x1,
  Width_x_Height_4x2,
  Width_x_Height_4x3,
  Width_x_Height_4x4
}

enum TextAlignment { Left, Center, Right }

enum ImageAlignment { Left, Center, Right }

enum ImageWidth { Inch_1, Inch_2 }
