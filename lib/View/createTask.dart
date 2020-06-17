import 'package:PersonalAssistantApp/Models/GetRequests.dart';
import 'package:PersonalAssistantApp/Models/Parameters/PostParameters.dart';
import 'package:PersonalAssistantApp/Models/PostRequest.dart';
import 'package:PersonalAssistantApp/Models/Responses/SuggestGetResponse.dart';
import 'package:PersonalAssistantApp/classifier.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

import '../Global.dart';
import '../main.dart';


class CreateTaskPage extends StatefulWidget {
   final TextEditingController actionController;

   CreateTaskPage(this.actionController);

  @override
  createState() => CreateTaskPageState();
}

enum tag { task, leisure, school, work }

List<Color> sequence = [Colors.blue, Colors.teal, Colors.orange, Colors.green];



class CreateTaskPageState extends State<CreateTaskPage> {

  tag myTag = tag.task;
    var focusNode = new FocusNode();

  Classifier classifier = Classifier();

  initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () { 
      FocusScope.of(context).requestFocus(focusNode);
      focusNode.requestFocus();
    });
  }

  int time = 0;
  int duration = 5;
  DateTime startDate = DateTime.now();
  SuggestGetResponse lastSuggestion;

  String _getTimeString() {
    var hours = (time / 60).round();
    var minutes = time % 60.round();
    var suffix = "AM";
    if (hours > 12 && hours < 25) {
      suffix = "PM";
      hours = hours % 12;
    }
    var padding = "";
    if (minutes < 10) {
      padding = "0";
    }
    return "$hours:$padding$minutes $suffix";
  }

  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Create New Task'),
        leading: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              Navigator.pop(context, {
               
              });
            }),
      ),
      body: ListView(
        children: [
          Hero(
            tag: 'TXT',
            child: Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  controller: widget.actionController,
                  onEditingComplete: () {
                    // Adi this is where you query the server and the tflite model for recognition
                    // If you set the tag variable it will automatically update if you use setstate
                    // Just update the time and duration variables from here (they're class properties) with a setstate and it'll all work
                    FocusScope.of(context).requestFocus(FocusNode());
                    getSuggestions(widget.actionController.text);
                  },
                  autofocus: true,
                  focusNode: focusNode,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    fillColor: Colors.grey[800],
                    focusColor: Colors.grey[800],
                    border: InputBorder.none,
                    hintText: 'What would you like to schedule?',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                )),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Text(
              'Tags',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              textAlign: TextAlign.start,
            ),
          ),
          _generatePredictedTagList(myTag == null ? [] : [myTag.toString().split('.').last]),
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Text(
              'Date & Time',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: DatePicker(
              startDate,
              initialSelectedDate: DateTime.now(),
              dateTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
              monthTextStyle: TextStyle(color: Colors.white, fontSize: 10),
              dayTextStyle: TextStyle(color: Colors.white, fontSize: 10),
              selectionColor: Colors.teal,
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                // New date selected
                setState(() {
                  // This is where you extract the Date adi
                  startDate = date;
                  print(startDate.toIso8601String());
                });
              },
            ),
          ),
          Container(
              height: 50,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                children: [
                  Text(
                    'Start Time',
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  Slider(
                      max: 288,
                      value: time / 5,
                      onChanged: (val) {
                        setState(() {
                          time = val.round() * 5;
                        });
                      }),
                  Text(
                    '${_getTimeString()}',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )
              // ListView.builder(
              // scrollDirection: Axis.horizontal,
              // itemCount: times.length,
              // itemBuilder: (context, index) {
              //   return _generateTimeCard(index, index == 0);
              // })
              ),

          Container(
              height: 50,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                children: [
                  Text(
                    'Duration',
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  Slider(
                      max: 24,
                      min: 1,
                      value: duration / 5,
                      onChanged: (val) {
                        setState(() {
                          duration = val.round() * 5;
                        });
                      }),
                  Text(
                    '$duration minutes',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
          // Container(
          //   padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          //   child: Text(
          //     'Notes',
          //     style: TextStyle(
          //         color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.start,
          //   ),
          // ),
          Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
              decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: FlatButton(
                  onPressed: () {
                    // Adi this is where you ask for a new time and update all required variables
                    if(lastSuggestion != null) {
                      postSuggestion(lastSuggestion, false);
                    }

                        getSuggestions(widget.actionController.text);
                  },
                  child: Text(
                    'Suggest another time',
                    style: TextStyle(color: Colors.white),
                  ))),

          IgnorePointer(
            child: Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: TextField(
              maxLines: 5,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                fillColor: Colors.grey[800],
                focusColor: Colors.grey[800],
                border: InputBorder.none,
                hintText: 'Notes',
                hintStyle: TextStyle(color: Colors.white70),
              ),
            ),
          )
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          //postSchedule();

          PostParameters params = new PostParameters(
              action: widget.actionController.text,
              accepted: true,
              tag: this.myTag.toString().split('.').last,
              length: this.duration,
              repeats: "none",
              startTime: startDate
          );

          var res = PostRequest.schedule(params);

          res.whenComplete(() => {
            setState(() {
              Global.getEvents();

           }),
              Navigator.pop(context)
          });

        },
      ),

    );
  }

  // List<String> times = ["12 AM", "12:30 AM", "1 AM", "1: 30 AM", "2 AM", "2:30 AM", "3 AM", "3:30 AM", "12 AM", "12:30 AM", "1 AM", "1: 30 AM","12 AM", "12:30 AM", "1 AM", "1: 30 AM"];

  // _generateTimeCard(int index, bool selected) {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         // Use the index here to get the time Adi
  //       });
  //     },

  //     child: Container(
  //     height: 70,
  //     width: 80,
  //     decoration: BoxDecoration(
  //         color: selected? Colors.teal : Colors.grey[200], borderRadius: BorderRadius.all(Radius.circular(10))),
  //     margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
  //     padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Container(
  //           child: Text(
  //             times[index],
  //             style: TextStyle(
  //                 color: selected ? Colors.white : Colors.black,
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 18.0),
  //           ),
  //           padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
  //         ),
  //       ],
  //     ),
  //   ),
  //   );
  // }

  _generatePredictedTagList(List<String> tags) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      height: 45,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tags.length + 1,
          itemBuilder: (context, index) {
            if (index == tags.length) {
              return IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    size: 30,
                  ),
                  color: Colors.white,
                  splashRadius: 0.1,
                  onPressed: () {});
            }

            return generateTagBox(tags[index]);
          }),
    );
  }

  Widget generateTagBox(String name) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.all(Radius.circular(25))),
        padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  name,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.cancel),
                  color: Colors.white,
                  splashRadius: 0.1,
                  onPressed: () {})
            ],
          ),
        ));
  }

  void getSuggestions(String action) async {
    print(action);
    print("bruh");
    SuggestGetResponse res = await GetRequests.suggest(action);

    setState(() {
      lastSuggestion = res;
      time = (res.startTime.hour-1)*60 + res.startTime.minute;
      startDate = res.startTime;
      duration = res.length;

      List pred = classifier.classify(action);
      print(pred);
      double task = pred[0][0];
      double leisure = pred[0][1];
      double school = pred[0][2];
      double work = pred[0][3];

      if (task > leisure && task > school && task > work) {
        myTag = tag.task;
      } else if (leisure > task && leisure > school && leisure > work) {
        myTag = tag.leisure;
      } else if (school > task && school > leisure && school > work) { 
        myTag = tag.school;
      } else {
        myTag = tag.work;
      }
      lastSuggestion.tag = myTag.toString().split(".").last;
    });


  }

  void postSuggestion(SuggestGetResponse lastSuggestion, bool accepted) async {
    PostParameters params = new PostParameters(
      action: widget.actionController.text,
      accepted: accepted,
      tag: lastSuggestion.tag.toString().split('.').last,
      length: lastSuggestion.length,
      repeats: "none",
      startTime: lastSuggestion.startTime
    );

    var res = await PostRequest.suggest(params);

  }

  void postSchedule() async {
    PostParameters params = new PostParameters(
      action: widget.actionController.text,
        accepted: true,
        tag: this.myTag.toString().split('.').last,
        length: this.duration,
        repeats: "none",
        startTime: lastSuggestion.startTime
    );

    var res = await PostRequest.schedule(params);
  }

 

}
