class FPSConstants {
  static const int CommType_BT = 101;
  static const int CommType_USB = 102;
  static const int CommType_BADPARAMETER = 103;
  static const int PROCESS_SUCCESS = 100;
  static const int PROCESS_FAIL = -100;
  static const int PARAM_ERROR = 10;
  static const int SDK_OK = 0;
  static const int SDK_ERR_INTERNAL = -1;
  static const int SDK_ERR_PROTOCOL = -2;
  static const int SDK_ERR_CONNECT = -3;
  static const int SDK_ERR_CLOSE_COM = -4;
  static const int SDK_ERR_BADPARAMETER = -5;
  static const int SDK_ERR_MEMORY_PC = -6;
  static const int SDK_ERR_MEMORY_DEVICE = -7;
  static const int SDK_ERR_NO_HIT = -8;
  static const int SDK_ERR_STATUS = -9;
  static const int SDK_ERR_DB_FULL = -10;
  static const int SDK_ERR_DB_EMPTY = -11;
  static const int SDK_ERR_ALREADY_ENROLLED = -12;
  static const int SDK_ERR_BASE_NOT_FOUND = -13;
  static const int SDK_ERR_BASE_ALREADY_EXISTS = -14;
  static const int SDK_ERR_NO_ASSOCIATED_DB = -15;
  static const int SDK_ERR_NO_ASSOCIATED_DEVICE = -16;
  static const int SDK_ERR_INVALID_TEMPLATE = -17;
  static const int SDK_ERR_NOT_IMPLEMENTED = -18;
  static const int SDK_ERR_TIMEOUT = -19;
  static const int SDK_ERR_NO_REGISTERED_TEMPLATE = -20;
  static const int SDK_ERR_FIELD_NOT_FOUND = -21;
  static const int SDK_ERR_CORRUPTED_CLASS = -22;
  static const int SDK_ERR_TO_MANY_TEMPLATE = -23;
  static const int SDK_ERR_TO_MANY_FIELD = -24;
  static const int SDK_ERR_MIXED_TEMPLATE = -25;
  static const int SDK_ERR_CMDE_ABORTED = -26;
  static const int SDK_ERR_INVALID_PK_FORMAT = -27;
  static const int SDK_ERR_SAME_FINGER = -28;
  static const int SDK_ERR_OUT_OF_FIELD = -29;
  static const int SDK_ERR_INVALID_USER_ID = -30;
  static const int SDK_ERR_INVALID_USER_DATA = -31;
  static const int SDK_ERR_FIELD_INVALID = -32;
  static const int SDK_ERR_USER_NOT_FOUND = -33;
  static const int SDK_ERR_COM_NOT_OPEN = -34;
  static const int SDK_ERR_ELT_ALREADY_PRESENT = -35;
  static const int SDK_ERR_NOCALLTO_DBQUERRYFIRST = -36;
  static const int SDK_ERR_USER = -37;
  static const int SDK_ERR_BAD_COMPRESSION = -38;
  static const int SDK_ERR_SECU = -39;
  static const int SDK_ERR_CERTIF_UNKNOW = -40;
  static const int SDK_ERR_INVALID_CLASS = -41;
  static const int SDK_ERR_USB_DEVICE_NAME_UNKNOWN = -42;
  static const int SDK_ERR_CERTIF_INVALID = -43;
  static const int SDK_ERR_SIGNER_ID = -44;
  static const int SDK_ERR_SIGNER_ID_INVALID = -45;
  static const int SDK_ERR_FFD = -46;
  static const int SDK_ERR_MOIST_FINGER = -47;
  static const int SDK_ERR_NO_SERVER = -48;
  static const int SDK_ERR_OTP_NOT_INITIALIZED = -49;
  static const int SDK_ERR_OTP_PIN_NEEDED = -50;
  static const int SDK_ERR_OTP_REENROLL_NOT_ALLOWED = -51;
  static const int SDK_ERR_OTP_ENROLL_FAILED = -52;
  static const int SDK_ERR_OTP_IDENT_FAILED = -53;
  static const int SDK_ERR_NO_MORE_OTP = -54;
  static const int SDK_ERR_OTP_NO_HIT = -55;
  static const int SDK_ERR_OTP_ENROLL_NEEDED = -56;
  static const int SDK_ERR_DEVICE_LOCKED = -57;
  static const int SDK_ERR_DEVICE_NOT_LOCK = -58;
  static const int SDK_ERR_OTP_LOCK_GEN_OTP = -59;
  static const int SDK_ERR_OTP_LOCK_SET_PARAM = -60;
  static const int SDK_ERR_OTP_LOCK_ENROLL = -61;
  static const int SDK_ERR_FVP_MINUTIAE_SECURITY_MISMATCH = -62;
  static const int SDK_ERR_FVP_FINGER_MISPLACED_OR_WITHDRAWN = -63;
  static const int SDK_ERR_LICENSE_MISSING = -64;
  static const int SDK_ERR_ADVANCED_SECURITY_LEVEL_MISMATCH = -65;
  static const int SDK_ERR_BAD_const_FINGER_PRINT_QUALITY = -66;
  static const int SDK_ERR_FFD_FINGER_MISPLACED = -68;
  static const int SDK_ERR_KEY_NOT_FOUND = -69;
  static const int SDK_WARNING_WSQ_COMPRESSION_RATIO = -70;
  static const int SDK_ERR_ADVANCED_SECURITY_LEVEL_NOT_AVAILABLE = -71;
  static const int SDK_ERR_UNAVAILABLE = -72;
  static const int SDK_ERR_MOVED_FINGER = -73;
  static const int SDK_ERR_SATURATED_FINGER = -74;
  static const int SDK_ERR_INVALID_FINGER = -75;
  static const int SDK_ERR_FILE_ALREADY_EXISTS = -76;
  static const int SDK_ERR_CAPTURE_FAILED = -78;
  static const int SDK_ERR_SVC_LOST_DEVICE = -110;
  static const int SDK_ERR_CANT_GRAN_PERMISSION_USB = -99;
  static const int CLASS_NOT_INSTANTIATED = -98;
  static const int SDK_ERR_USB_PERMISSION_DENIED = -97;
  static const int SDK_ERR_RESUME_CONNEXION_ALREADY_STARTED = -96;
  static const int SDK_ERR_RESUME_CONNEXION = -95;
  static const int SDK_ERR_INTEGER_INITIALIZATION = -94;
  static const int SDK_ERR_LONG_INITIALIZATION = -93;
  static const int SDK_ERR_NOT_APPLICABLE_TO_THIS_SENSOR = -101;
  static const int SDK_ERR_NO_SUCCESS_CAPTURE_OCCURRED = -102;
}

enum FingerPosition {
  Move_No_Finger,
  Move_Finger_Up,
  Move_Finger_Down,
  Move_Finger_Left,
  Move_Finger_Right,
  Press_Harder,
  Move_Latent,
  Remove_Finger,
  Finger_Ok,
}

enum SecurityLevel { Critical, High, Medium, Low, Default, None }

enum ImageCompressionType {
  Uncompressed_No_Bit_Packing,
  Uncompressed_Bit_Packed,
  Compressed_WSQ,
  Compressed_JPEG,
  PNG,
  Compress_V1,
  Compressed_JPEG2000,
}

enum TemplateType {
  Template_Type_PK_COMP,
  Template_Type_PK_MAT_NORM,
  Template_Type_PK_COMP_NORM,
  Template_Type_PK_ANSI_378,
  Template_Type_PK_MINEX_A,
  Template_Type_PK_ISO_FMR,
  Template_Type_PK_ISO_FMC_NS,
  Template_Type_PK_ISO_FMC_CS,
  Template_Type_PK_DIN_V66400_CS,
  Template_Type_PK_DIN_V66400_CS_AA,
  Template_Type_PK_ISO_FMC_CS_AA,
  Template_Type_PK_ANSI_378_2009,
  Template_Type_PK_ISO_FMR_2011,
}
