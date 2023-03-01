import 'package:uni_flutter_plugin/fps/fps_constants.dart';

class HelperFunctions {
  static TemplateType? getValueOfTemplateType(int id) {
    switch (id) {
      case 0:
        return TemplateType.Template_Type_PK_COMP;
      case 1:
        return TemplateType.Template_Type_PK_MAT_NORM;
      case 2:
        return TemplateType.Template_Type_PK_COMP_NORM;
      case 4:
        return TemplateType.Template_Type_PK_ANSI_378;
      case 5:
        return TemplateType.Template_Type_PK_MINEX_A;
      case 6:
        return TemplateType.Template_Type_PK_ISO_FMR;
      case 7:
        return TemplateType.Template_Type_PK_ISO_FMC_NS;
      case 8:
        return TemplateType.Template_Type_PK_ISO_FMC_CS;
      case 13:
        return TemplateType.Template_Type_PK_DIN_V66400_CS;
      case 14:
        return TemplateType.Template_Type_PK_DIN_V66400_CS_AA;
      case 15:
        return TemplateType.Template_Type_PK_ISO_FMC_CS_AA;
      case 19:
        return TemplateType.Template_Type_PK_ANSI_378_2009;
      case 20:
        return TemplateType.Template_Type_PK_ISO_FMR_2011;
      default:
        return null;
    }
  }

  static ImageCompressionType? getValueOfImageCompressionType(int id) {
    switch (id) {
      case 0:
        return ImageCompressionType.Uncompressed_No_Bit_Packing;
      case 1:
        return ImageCompressionType.Uncompressed_Bit_Packed;
      case 2:
        return ImageCompressionType.Compressed_WSQ;
      case 3:
        return ImageCompressionType.Compressed_JPEG;
      case 4:
        return ImageCompressionType.PNG;
      case 5:
        return ImageCompressionType.Compress_V1;
      case 6:
        return ImageCompressionType.Compressed_JPEG2000;
      default:
        return null;
    }
  }

  static FingerPosition getValueOfFingerPosition(int id) {
    switch (id) {
      case 0:
        return FingerPosition.Move_No_Finger;
      case 1:
        return FingerPosition.Move_Finger_Up;
      case 2:
        return FingerPosition.Move_Finger_Down;
      case 3:
        return FingerPosition.Move_Finger_Left;
      case 4:
        return FingerPosition.Move_Finger_Right;
      case 5:
        return FingerPosition.Press_Harder;
      case 6:
        return FingerPosition.Move_Latent;
      case 7:
        return FingerPosition.Remove_Finger;
      case 8:
        return FingerPosition.Finger_Ok;
      default:
        return FingerPosition.Move_No_Finger;
    }
  }
}
