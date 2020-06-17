class SchedulePostResponse {
  bool ok;

  SchedulePostResponse({this.ok});
  factory SchedulePostResponse.fromJson(Map<String, dynamic> json) {
    return SchedulePostResponse(
        ok: json["ok"]
    );
  }
}