class SensorVerifyResponse {
  final int responseCode;
  final int similarity;
  final bool isMatched;
  final int matchedTemplate;

  SensorVerifyResponse(
      {required this.responseCode,
      required this.similarity,
      required this.isMatched,
      required this.matchedTemplate});

  factory SensorVerifyResponse.fromJSON(Map<String, dynamic> json) {
    return SensorVerifyResponse(
        responseCode: json["responseCode"],
        similarity: json["similarity"],
        isMatched: json["isMatched"],
        matchedTemplate: json["matchedTemplate"]);
  }

  @override
  String toString() {
    return "Response Code : $responseCode Similarity : $similarity IsMatched : $isMatched MatchedTemplate : $matchedTemplate";
  }
}
