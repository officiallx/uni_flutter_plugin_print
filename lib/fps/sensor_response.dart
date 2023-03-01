class SensorResponse {
  final int responseCode;
  final List<int>? responseData;
  final List<int>? templateData;
  final List<int>? ISOImageData;
  final List<int>? BMPImageData;
  final List<int>? WSQImageData;

  SensorResponse(
      {required this.responseCode,
      required this.responseData,
      required this.templateData,
      required this.ISOImageData,
      required this.BMPImageData,
      required this.WSQImageData});

  factory SensorResponse.fromJson(Map<String, dynamic> json) {
    List<int>? BMPImageData =
        json["BMPImageData"] != null ? List.from(json["BMPImageData"]) : null;
    List<int>? WSQImageData =
        json["WSQImageData"] != null ? List.from(json["WSQImageData"]) : null;
    List<int>? ISOImageData =
        json["ISOImageData"] != null ? List.from(json["ISOImageData"]) : null;
    List<int>? templateData =
        json["templateData"] != null ? List.from(json["templateData"]) : null;
    List<int>? responseData =
        json["responseData"] != null ? List.from(json["responseData"]) : null;

    return SensorResponse(
      BMPImageData: BMPImageData,
      responseCode: json["responseCode"],
      responseData: responseData,
      templateData: templateData,
      ISOImageData: ISOImageData,
      WSQImageData: WSQImageData,
    );
  }
}
