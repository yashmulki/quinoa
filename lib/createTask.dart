import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

class CreateTaskPage extends StatefulWidget {
  @override
  createState() => CreateTaskPageState();
}

List<Color> sequence = [Colors.blue, Colors.teal, Colors.orange, Colors.green];

var focusNode = new FocusNode();
var textField = TextField(
  focusNode: focusNode,
  style: TextStyle(color: Colors.white),
  decoration: InputDecoration(
    fillColor: Colors.grey[800],
    focusColor: Colors.grey[800],
    border: InputBorder.none,
    hintText: 'What would you like to schedule?',
    hintStyle: TextStyle(color: Colors.white70),
  ),
);

class CreateTaskPageState extends State<CreateTaskPage> {
  initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

      FocusScope.of(context).requestFocus(focusNode);
//or
      focusNode.requestFocus();
    });
  }

  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Create New Task'),
        leading: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              Navigator.pop(context);
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
                child: textField),
          ),
           Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Text(
        'Tags',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.start,
      ),
    ),
          _generatePredictedTagList(['Work', 'Home']),
          Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Text(
        'Date & Time',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.start,
      ),
    ),
    Container(
      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        dateTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        monthTextStyle: TextStyle(color: Colors.white, fontSize: 10),
        dayTextStyle: TextStyle(color: Colors.white, fontSize: 10),
        selectionColor: Colors.teal,
        selectedTextColor: Colors.white,
        onDateChange: (date) {
          // New date selected
          setState(() {

          });
        },
      ),
    ),
    Container(
      height: 90,
      margin: EdgeInsets.fromLTRB(15, 20, 0, 0),
      child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: times.length,
      itemBuilder: (context, index) {
        return _generateTimeCard(index, index == 0);
      })
    ),
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
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextField(
      maxLines: 5,
  focusNode: focusNode,
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
        ],
      ),
    );
  }

  List<String> times = ["12 AM", "12:30 AM", "1 AM", "1: 30 AM", "12 AM", "12:30 AM", "1 AM", "1: 30 AM", "12 AM", "12:30 AM", "1 AM", "1: 30 AM","12 AM", "12:30 AM", "1 AM", "1: 30 AM"];

  _generateTimeCard(int index, bool selected) {
    return Container(
      height: 70,
      width: 80,
      decoration: BoxDecoration(
          color: selected? Colors.teal : Colors.grey[200], borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              times[index],
              style: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          ),
        ],
      ),
    );
  }

  _generatePredictedTagList(List<String> tags) {
     return Container(
      margin: EdgeInsets.only(left: 20),
      height: 45,
      child: ListView.builder(
        
          scrollDirection: Axis.horizontal,
          itemCount: tags.length + 1,
          itemBuilder: (context, index) {

            if (index == tags.length) {
              return IconButton(icon: Icon(Icons.add_circle_outline, size: 30,), color: Colors.white, splashRadius: 0.1, onPressed: () {});
            }

            return generateTagBox(tags[index]);
          }),
    );
  }

    Widget generateTagBox(String name) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.all(Radius.circular(25))
      ),
      padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: Center(
        child: Row(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(name, style: TextStyle(color: Colors.white),),
          ),
          IconButton(icon: Icon(Icons.cancel), color: Colors.white, splashRadius: 0.1, onPressed: () {
          
        })
      ],),)
    );
  }

}

