import 'dart:io';

import 'package:PersonalAssistantApp/Models/Responses/ScheduleGetResponse.dart';
import 'package:PersonalAssistantApp/Models/Responses/SuggestGetResponse.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Constants.dart';

class GetRequests {
  static Future<SuggestGetResponse> suggest(String action) async {
    final res = await http.get(Constants.API_SUGGEST + "?action=" + action);

    if(res.statusCode == 200) {
      print(res.body);
      return SuggestGetResponse.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("failed to load json");
    }
  }

  static Future<ScheduleGetResponse> schedule() async {
    final res = await http.get(Constants.API_SCHEDULE);
//    print("bruh moment ");
    if(res.statusCode == 200) {

//      print(res.body);
//      print("bruh moment 1");
      return ScheduleGetResponse.fromJson(json.decode(res.body));
    } else {
      throw Exception("failed to load json");
    }
  }
}