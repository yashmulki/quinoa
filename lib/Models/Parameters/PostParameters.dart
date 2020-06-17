
class PostParameters {
    String action;
    String tag;
    DateTime startTime;
    int length;
    String repeats;
    bool accepted;

    PostParameters({this.action,this.tag,this.startTime,this.length,this.accepted,this.repeats});



    Map<String, dynamic> toJson() {
      return {
          "tag": tag,
          "start_time": startTime.toIso8601String(),
          "length": length,
          "accepted": accepted,
          "repeats": repeats
      };
    }
}