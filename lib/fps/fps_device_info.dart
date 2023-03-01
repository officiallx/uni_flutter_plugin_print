class FPSDeviceInfo {
  final String serialNumber;
  final String sensorName;
  final int responseCode;

  FPSDeviceInfo(
      {required this.serialNumber,
      required this.sensorName,
      required this.responseCode});

  factory FPSDeviceInfo.fromJSON(Map<String, dynamic> json) {
    return FPSDeviceInfo(
        serialNumber: json["serialNumber"],
        sensorName: json["sensorName"],
        responseCode: json["responseCode"]);
  }

  @override
  String toString() {
    return "SerialNumber : $serialNumber SensorName : $sensorName ResponseCode : $responseCode";
  }
}
