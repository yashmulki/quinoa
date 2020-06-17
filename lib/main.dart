

import 'package:PersonalAssistantApp/Models/GetRequests.dart';
import 'package:PersonalAssistantApp/Models/Responses/ScheduleGetResponse.dart';
import 'package:flutter/material.dart';
import 'View/calendar.dart';
import 'View/createTask.dart';
import 'View/dashboard.dart';
import 'View/miniapps.dart';
import 'Models/Event.dart';
import 'package:PersonalAssistantApp/Global.dart';

import 'package:toast/toast.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Quinoa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.grey[900]),
      home: CorePage()));
}

class CorePage extends StatefulWidget {
  // This widget is the root of your application.
  createState() => CorePageState();
}

class CorePageState extends State<CorePage> {
  
  int _currentDisplayIndex = 0;
  List<Widget> screens = [MyHomePage(), CalendarPage(), DashboardPage(), MiniApps()];

  void onTapNav(int index) {
    setState(() { _currentDisplayIndex = index; });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap:  (int i) => onTapNav(i),
        type : BottomNavigationBarType.fixed,
        
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[300],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.inbox),
            title: new Text('Now'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.calendar_today),
            title: new Text('Calendar'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), title: Text('Dashboard')),
          BottomNavigationBarItem(
              icon: Icon(Icons.reorder), title: Text('Mini Apps')),
          
        ],
      ),
        body: screens[_currentDisplayIndex]
      );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

 List<Color> sequence = [Colors.blue, Colors.teal, Colors.orange, Colors.green];

class _MyHomePageState extends State<MyHomePage> { 
TextEditingController controller = TextEditingController();
 void initState() {
   super.initState();
//    print("getting events");
    Global.getEvents();
 }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Quinoa'),
        leading: IconButton(
          icon: Icon(
            Icons.account_circle,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_active,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: _loadMainPageScaffold(context, Global.schedule)
      ),
      
    );
  }

  Widget _generateListViewLoading(BuildContext context) {
    return ListView.builder(

        itemBuilder: (context, index) {
          if (index == 0) {
            return _generateWelcomeMessage('Yash T');
          } else if (index == 1) {
            return _generateTextBox();
          } else if (index == 2) {
            return _generateSuggestionsHeader();
          } else if (index == 3) {
            return _generateSuggestionsView();
          } else if (index == 4) {
            return _generateEventsHeader();
          }
          else {
              return CircularProgressIndicator();
          }

        });
  }
  Widget _generateListViewSuccess(BuildContext context, List<Event> events) {
    if(Global.events.length != events.length) {
        Global.events = events;
    }
    var len = events.length;
    if(events.length == 0) {
      len = 1;
    }

    return ListView.builder(
        itemCount: len + 5,
        itemBuilder: (context, index) {

          if (index == 0) {
            return _generateWelcomeMessage('Yash T');
          } else if (index == 1) {
            return _generateTextBox();
          } else if (index == 2) {
            return _generateSuggestionsHeader();
          } else if (index == 3) {
            return _generateSuggestionsView();
          } else if (index == 4) {
            return _generateEventsHeader();
          }
          else {
            if(events.length == 0) {
                return  Text("Seems Like You Haven't Scheduled Anything",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white
                    ));
            } else {
              var time = events[index-5].startTime;
              return generateEventsCard(events[index-5].action,
                  "${time.hour < 13 ? time.hour : time.hour % 12}:${time.minute < 10 ? 0 : ''}${time.minute} ${time.hour < 13 ? 'AM' : 'PM'}",
                  "",
                  events[index-5].getTagsList(),
                  sequence[(index-5)%4],
                  (events[index-5].length.toString() + " minutes")
              );
            }




          }

        });
  }
  Widget _generateListViewFailed(BuildContext context, String err) {
    return ListView.builder(

        itemBuilder: (context, index) {

          if (index == 0) {
            return _generateWelcomeMessage('Yash T');
          } else if (index == 1) {
            return _generateTextBox();
          } else if (index == 2) {
            return _generateSuggestionsHeader();
          } else if (index == 3) {
            return _generateSuggestionsView();
          } else if (index == 4) {
            return _generateEventsHeader();
          }
          else {
            return Text(err);
          }
//            return generateEventsCard(
//                'Hackathon Planning Meeting',
//                '4:00 PM',
//                'Discussing what we need to do for Hack the North and planning some epic project ideas',
//                ['Aaditya Chaudhary', "Desgroup Whatley", 'Lunarcoffee Gao'], sequence[index%4], '2 hours');
//        } else if (index == 6) {
//            return generateEventsCard(
//                'Planning Adi\'s Destruction',
//                '6:30 PM',
//                'Discussing how to destroy Adi\'s entire career before it even started',
//                [ "Desgroup Whatley", 'Lunarcoffee Gao'], sequence[index%4], '1 hour');
//          }
        });
  }
  
  Widget _generateWelcomeMessage(String name) {
    return Container(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Text(
              'Good morning $name!',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Text(
              'Friday, June 7, 2020',
              style: TextStyle(fontSize: 20, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
  bool switched = false;

 void onChanged(String text) {
    if (!switched) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTaskPage(controller)));
    }
 }
  
  Widget _generateTextBox() {
    return Hero(
      tag: 'TXT',
      child: Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.all(Radius.circular(10))),
        child: TextField(
          controller: controller,
          onChanged: (text) => onChanged(text),
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          fillColor: Colors.grey[800],
          focusColor: Colors.grey[800],
          border: InputBorder.none,
          hintText: 'What would you like to schedule?',
          hintStyle: TextStyle(color: Colors.white70),
        ),
      ),
    ),
    );
  }

  Widget _generateSuggestionsHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Text(
        'Suggested Activities',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Widget _generateSuggestionsView() {
    return Container(
      margin: EdgeInsets.only(left: 20),
      height: 170,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _generateSuggestionCard(
                  "Do Some Excercise",
                  "1500/10000 Steps Completed",
                  Colors.blue,
                  Icons.directions_run);
            } else if (index == 1) {
              return _generateSuggestionCard("Practice Guitar",
                  "0/30 Minutes Completed", Colors.teal, Icons.music_note);
            } else if (index == 2) {
              return _generateSuggestionCard(
                  "Book a Vacation",
                  "All inclusive packages from \$300",
                  Colors.orange,
                  Icons.flight_takeoff);
            } else if (index == 3) {
              return _generateSuggestionCard(
                  "Review your budget",
                  "Make sure you stay on track!",
                  Colors.green,
                  Icons.credit_card);
            }
          }),
    );
  }

  Widget _generateSuggestionCard(String title, String info, Color color, IconData icon) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Spacer(),
          Container(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          ),
          Text(
            info,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Widget _generateEventsHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 30, 20, 40),
      child: Text(
        'Upcoming Events',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

 Widget _loadMainPageScaffold(BuildContext context, Future<ScheduleGetResponse> schedule) {
   return FutureBuilder<ScheduleGetResponse>(
     future: schedule,
     builder: (context,snapshot) {
       if (snapshot.hasData ) {
//         print("success");
//         print("data length: " + snapshot.data.events.length.toString());

         return _generateListViewSuccess(context, snapshot.data.events);
       } else if(snapshot.hasError) {
         return _generateListViewFailed(context, snapshot.error.toString());
       } else {
         return _generateListViewLoading(context);
       }
     },
   );
 }

}

Widget generateEventsCard(String title, String time, String note, List<String> participants, Color color, String duration) {
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
                    participants.length == 0
                        ? Text(
                            '',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                            textAlign: TextAlign.start,
                          )
                        : generateParticipantList(participants),
                        Container(
                          padding: EdgeInsets.fromLTRB(2, 10, 0, 10),
                          child: Text(duration, style: TextStyle(color: Colors.white),),
                        ),
                        Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          color: Colors.grey[200],
                        ),
                        padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                        child: Text('Reschedule'),
                      ),
                        
                        Spacer(),
                        Text(note, style: TextStyle(color: Colors.white, fontSize: 14),)
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget generateParticipantList(List<String> participants) {
    return Container(
      margin: EdgeInsets.only(left: 0),
      height: 25,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: participants.length,
          itemBuilder: (context, index) {
            return generateParticipantBox(participants[index]);
          }),
    );
  }

  Widget generateParticipantBox(String name) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.all(Radius.circular(7))
      ),
      padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: Center(child: Text(name, style: TextStyle(color: Colors.white),),)
    );
  }

  Widget generateCardList(BuildContext context, List<Event> events) {

      return ListView.builder(
        shrinkWrap: true,
        itemCount: events.length,
          itemBuilder: (context,index) {
            return generateEventsCard(
                events[index].action,
                events[index].startTime.hour.toString(),
                "",
                events[index].getTagsList(),
                sequence[index%4],
                events[index].length.toString());
          }
      );
  }



