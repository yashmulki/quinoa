
import 'package:PersonalAssistantApp/Models/Event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/classes/event.dart' as Calender;

import 'Models/GetRequests.dart';
import 'Models/Responses/ScheduleGetResponse.dart';

class Global {
  static Future<ScheduleGetResponse> schedule;
  static List<Event> events = new List<Event>();



  static void getEvents() {
    schedule = GetRequests.schedule();
//    schedule.whenComplete(() => {
//      events = schedule.
//      generateMap(),
//      print("all good in the hood")
//    });

  }

  static void printEvents() {
    for(Event e in events) {
      print(e.action);
    }
  }






}