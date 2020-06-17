import 'dart:convert';

import '../Event.dart';

class ScheduleGetResponse {
  List<Event> events;

  ScheduleGetResponse({this.events});
  factory ScheduleGetResponse.fromJson(Map<String, dynamic> json) {
    List<Event> events = new List<Event>();
//    int y = 0;
//    print("bruh moment +2 ");
//    print(json["events"].length);
//    print("bruh moment -2 ");
    for(Map<String,dynamic> e in json["events"]) {
      //print(y++);
      //print("length: " + events.length.toString());
      Event x = Event.fromJson(e);
      if(x == null) {
        print("stuff is null");

      } else {
//        print("else");
        events.add(x);
      }
      //print("after if-statement");

    }
//    print("returning");
    return ScheduleGetResponse(
      events: events
    );
  }

}
