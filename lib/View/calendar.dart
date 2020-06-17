import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
import '../main.dart';
import 'package:PersonalAssistantApp/Global.dart';
import 'package:PersonalAssistantApp/Models/Event.dart' as Quinoa;


class CalendarPage extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final"

  @override
  _CalendarPageState createState() => new _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _currentDate = DateTime(2020, 6, 9);
  DateTime _currentDate2 = DateTime(2020, 6, 12);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2020, 6, 7));
  DateTime _targetDateTime = DateTime(2020, 6, 14);
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];




  CalendarCarousel _calendarCarouselNoHeader;
  EventList<Event> _markedDateMap;
  List<Event> _displayEvents = new List<Event>();
  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    super.initState();
    Global.printEvents();


  }

  @override
  Widget build(BuildContext context) {
    _markedDateMap = new EventList<Event>();
    for(Quinoa.Event e in Global.events) {
      _markedDateMap.add(
          e.startTime,
          new Event(title: e.action, date: e.startTime,icon: _eventIcon)
      );
    }

    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      selectedDayButtonColor: Colors.white,
      dayPadding: 5,
      todayBorderColor: Colors.teal,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => {
          _currentDate2 = date,
          _displayEvents = events

        });
        events.forEach((event) => print(event.title));
      },
      daysHaveCircularBorder: true,
      dayButtonColor: Colors.grey[800],
      
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.white70,
      ),
      thisMonthDayBorderColor: Colors.grey[800],
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      // selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder: CircleBorder(
        side: BorderSide(color: Colors.white)
      ),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.black,
      ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: Colors.white,
      selectedDayTextStyle: TextStyle(
        color: Colors.black,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      daysTextStyle: TextStyle(
        color: Colors.white
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return new Scaffold(
      backgroundColor: Colors.grey[900],
        appBar: new AppBar(
          title: new Text('Calendar'),
          actions: [
            IconButton(color: Colors.white, icon: Icon(Icons.add), onPressed: () {},)
          ],
        ),
        body: Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                margin: EdgeInsets.only(
                  top: 30.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: new Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      _currentMonth,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        color: Colors.white
                      ),
                    )),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: FlatButton(
                      color: Colors.white,
                      child: Text('PREV', style: TextStyle(color: Colors.black),),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month -1);
                          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    ),
                    ),
                    FlatButton(
                      color: Colors.white,
                      child: Text('NEXT', style: TextStyle(color: Colors.black),),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month +1);
                          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: _calendarCarouselNoHeader,
              ), 
                  ],
                );
              } else if (index == 1) {
                return _generateDayHeader(_currentDate2.month.toString() + "-" + _currentDate2.day.toString() + "-" + _currentDate2.year .toString());
              }
//              else if (index == 2) {
//                return generateEventsCard(
//                'Hackathon Planning Meeting',
//                '4:00 PM',
//                'Discussing what we need to do for Hack the North and planning some epic project ideas',
//                ['Aaditya Chaudhary', "Desgroup Whatley", 'Lunarcoffee Gao'], sequence[1], '2 hours');
//
//              } else if (index == 3) {
//                return generateEventsCard(
//                'Hackathon Planning Meeting',
//                '4:00 PM',
//                'Discussing what we need to do for Hack the North and planning some epic project ideas',
//                ['Aaditya Chaudhary', "Desgroup Whatley", 'Lunarcoffee Gao'], sequence[1], '2 hours');
//
//              }
            else {
                  if(index - 2 < _displayEvents.length) {
                    var time = _displayEvents[index-2].date;
                    return _generateEventsCard(
                        _displayEvents[index-2].title,
                        "${time.hour < 13 ? time.hour : time.hour % 12}:${time.minute < 10 ? 0 : ''}${time.minute} ${time.hour < 13 ? 'AM' : 'PM'}",
                        sequence[index%4],

                    );
                  }
              }
            }
         

              

          ),
        ));
  }
  Widget _generateEventsCard(String title, String time, Color color) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
        height: 180,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  width: 2,
                  height: 70,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                ),
                Text(
                  time,
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  width: 2,
                  height: 70,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: color),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(

                      child: Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),

                      padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: Colors.grey[200],
                      ),
                      padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                      child: Text('Reschedule'),
                    ),

//                    Spacer(),

                  ],
                ),
              ),
            )
          ],
        ));
  }

  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  _generateDayHeader(String day) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Text(
        'Schedule for $day',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

}