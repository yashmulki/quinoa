import 'package:flutter/material.dart';

class Event {
  String action;
  String tags;
  DateTime startTime;
  int length;
  String repeats;

  List<String> getTagsList() {
    List<String> taglist = new List<String>();
    taglist.add(this.tags);
    return taglist;
  }

  Event({this.action,this.tags,this.startTime,this.length,this.repeats});
  factory Event.fromJson(Map<String, dynamic> json) {

    var startTime = DateTime.tryParse(json['start_date']);
    if(startTime == null) {
      print("date NULL");
      return null;
    }
//    print("date: " + startTime.toString());
//    print(json["length"]);
//    print(json["repeats"]);
//    print(json["action"]);
//    print(json["tag"]);

    return Event(
      action: json["action"],
      tags: json["tag"],
      startTime: startTime,
      length: json["length"],
      repeats: json["repeats"]
    );

  }
}