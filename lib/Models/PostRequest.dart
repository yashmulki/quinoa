import 'package:PersonalAssistantApp/Models/Constants.dart';
import 'package:PersonalAssistantApp/Models/Parameters/PostParameters.dart';
import 'package:PersonalAssistantApp/Models/Responses/SchedulePostResponse.dart';
import 'package:PersonalAssistantApp/Models/Responses/SuggestPostResponse.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
class PostRequest {

  static Future<SchedulePostResponse> schedule(PostParameters params) async {
    var res = await http.post(
        (Constants.API_SCHEDULE + "?tag=" + params.tag
            + "&start_date=" + params.startTime.toIso8601String()
            + "&length=" + params.length.toString()
            + "&repeats=none"
            + "&action=" + params.action
        ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

    );

    if(res.statusCode == 200) {
      print(res.body + " -> schedule");
      return SchedulePostResponse(ok: res.body == "OK");


    } else {
      throw Exception("failed to load json");
    }
  }

  static Future<SuggestPostResponse> suggest(PostParameters params) async {
    var res = await http.post(
        (Constants.API_SUGGEST + "?tag=" + params.tag
            + "&start_date=" + params.startTime.toIso8601String()
            + "&length=" + params.length.toString()
            + "&accepted=" + params.repeats.toString()
            + "&repeats=none"
            + "&action=" + params.action
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },

    );

    if(res.statusCode == 200) {
      print(res.body + " -> suggestion");
      return SuggestPostResponse(ok: res.body == "OK");


    } else {
      throw Exception("failed to load json");
    }
  }

}