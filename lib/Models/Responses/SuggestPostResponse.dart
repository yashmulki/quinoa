class SuggestPostResponse {
  bool ok;

  SuggestPostResponse({this.ok});
  factory SuggestPostResponse.fromJson(Map<String, dynamic> json) {
    return SuggestPostResponse(
      ok: json["OK"]
    );
  }
}