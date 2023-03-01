class SensorVerifyImageResponse {
  final int responseCode;
  final int similarity;
  final bool isMatched;
  final int matchedTemplate;
  final List<int>? BMPImageData;

  SensorVerifyImageResponse(
      {required this.responseCode,
      required this.similarity,
      required this.isMatched,
      required this.matchedTemplate,
      required this.BMPImageData});

  factory SensorVerifyImageResponse.fromJSON(Map<String, dynamic> json) {
    List<int>? BMPImageData =
        json["BMPImageData"] != null ? List.from(json["BMPImageData"]) : null;
    return SensorVerifyImageResponse(
        responseCode: json["responseCode"],
        similarity: json["similarity"],
        isMatched: json["isMatched"],
        matchedTemplate: json["matchedTemplate"],
        BMPImageData: BMPImageData);
  }

  @override
  String toString() {
    return "Response Code : $responseCode Similarity : $similarity IsMatched : $isMatched MatchedTemplate : $matchedTemplate";
  }
}
