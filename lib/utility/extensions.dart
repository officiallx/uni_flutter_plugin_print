import 'package:uni_flutter_plugin/fps/fps_constants.dart';

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

extension GetFingerPositionValue on FingerPosition {
  int get id {
    switch (this) {
      case FingerPosition.Move_No_Finger:
        return 0;
      case FingerPosition.Move_Finger_Up:
        return 1;
      case FingerPosition.Move_Finger_Down:
        return 2;
      case FingerPosition.Move_Finger_Left:
        return 3;
      case FingerPosition.Move_Finger_Right:
        return 4;
      case FingerPosition.Press_Harder:
        return 5;
      case FingerPosition.Move_Latent:
        return 6;
      case FingerPosition.Remove_Finger:
        return 7;
      case FingerPosition.Finger_Ok:
        return 8;
    }
  }
}

extension GetSecurityLevelValue on SecurityLevel {
  int get id {
    switch (this) {
      case SecurityLevel.Critical:
        return 5;
      case SecurityLevel.High:
        return 4;
      case SecurityLevel.Medium:
        return 3;
      case SecurityLevel.Low:
        return 2;
      case SecurityLevel.Default:
        return 1;
      case SecurityLevel.None:
        return 0;
    }
  }
}

extension GetImageCompressionTypeValue on ImageCompressionType {
  int get id {
    switch (this) {
      case ImageCompressionType.Uncompressed_No_Bit_Packing:
        return 0;
      case ImageCompressionType.Uncompressed_Bit_Packed:
        return 1;
      case ImageCompressionType.Compressed_WSQ:
        return 2;
      case ImageCompressionType.Compressed_JPEG:
        return 3;
      case ImageCompressionType.PNG:
        return 4;
      case ImageCompressionType.Compress_V1:
        return 5;
      case ImageCompressionType.Compressed_JPEG2000:
        return 6;
    }
  }
}

extension GetTemplateTypeValue on TemplateType {
  int get id {
    switch (this) {
      case TemplateType.Template_Type_PK_COMP:
        return 0;
      case TemplateType.Template_Type_PK_MAT_NORM:
        return 1;
      case TemplateType.Template_Type_PK_COMP_NORM:
        return 2;
      case TemplateType.Template_Type_PK_ANSI_378:
        return 4;
      case TemplateType.Template_Type_PK_MINEX_A:
        return 5;
      case TemplateType.Template_Type_PK_ISO_FMR:
        return 6;
      case TemplateType.Template_Type_PK_ISO_FMC_NS:
        return 7;
      case TemplateType.Template_Type_PK_ISO_FMC_CS:
        return 8;
      case TemplateType.Template_Type_PK_DIN_V66400_CS:
        return 13;
      case TemplateType.Template_Type_PK_DIN_V66400_CS_AA:
        return 14;
      case TemplateType.Template_Type_PK_ISO_FMC_CS_AA:
        return 15;
      case TemplateType.Template_Type_PK_ANSI_378_2009:
        return 19;
      case TemplateType.Template_Type_PK_ISO_FMR_2011:
        return 20;
    }
  }
}
