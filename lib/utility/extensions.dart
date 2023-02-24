import '../printer/printer_constants.dart';

extension GetFontSizeValue on FontSize {
  int get id {
    switch (this) {
      case FontSize.Width_x_Height_1x1:
        return 17;
      case FontSize.Width_x_Height_1x2:
        return 18;
      case FontSize.Width_x_Height_1x3:
        return 19;
      case FontSize.Width_x_Height_1x4:
        return 20;
      case FontSize.Width_x_Height_2x1:
        return 33;
      case FontSize.Width_x_Height_2x2:
        return 34;
      case FontSize.Width_x_Height_2x3:
        return 35;
      case FontSize.Width_x_Height_2x4:
        return 36;
      case FontSize.Width_x_Height_3x1:
        return 49;
      case FontSize.Width_x_Height_3x2:
        return 50;
      case FontSize.Width_x_Height_3x3:
        return 51;
      case FontSize.Width_x_Height_3x4:
        return 52;
      case FontSize.Width_x_Height_4x1:
        return 65;
      case FontSize.Width_x_Height_4x2:
        return 66;
      case FontSize.Width_x_Height_4x3:
        return 67;
      case FontSize.Width_x_Height_4x4:
        return 68;
    }
  }
}

extension GetTextAlignmentValue on TextAlignment {
  int get id {
    switch (this) {
      case TextAlignment.Left:
        return 0;
      case TextAlignment.Center:
        return 1;
      case TextAlignment.Right:
        return 2;
    }
  }
}

extension GetImageAlignmentValue on ImageAlignment {
  int get id {
    switch (this) {
      case ImageAlignment.Left:
        return 1;
      case ImageAlignment.Center:
        return 0;
      case ImageAlignment.Right:
        return 2;
    }
  }
}

extension GetImageWidthValue on ImageWidth {
  int get id {
    switch (this) {
      case ImageWidth.Inch_1:
        return 1;
      case ImageWidth.Inch_2:
        return 2;
    }
  }
}
