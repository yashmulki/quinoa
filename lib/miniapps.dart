import 'package:flutter/material.dart';
import 'package:quinoa/QExcercise.dart';

class MiniApps extends StatelessWidget {

  final List<String> appNames = ["QWeather", "QExcercise", "Shopping List", "QJournal", "QLearn", "QuinoaBank", "Rideshare", "QCasts", "Expedia", "Password Manager", "QFinance", "EV Chargers", "Videos", "CryptoBuy"];
  final List<IconData> appIcons = [Icons.cloud, Icons.directions_run, Icons.shopping_cart, Icons.book, Icons.school, Icons.attach_money, Icons.directions_car, Icons.rss_feed, Icons.flight_takeoff, Icons.vpn_key, Icons.trending_up, Icons.offline_bolt, Icons.ondemand_video, Icons.enhanced_encryption];
  final List<Color> appColors = [Colors.blueAccent, Colors.white, Colors.grey, Colors.lime, Colors.white, Colors.green, Colors.red, Colors.orange, Colors.white, Colors.teal, Colors.blue, Colors.yellow, Colors.red, Colors.teal];

  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Mini Apps'),
      ),
      body: ListView.builder(
        itemCount: appNames.length * 2,
        itemBuilder: (context, index) {
          if (index % 2 == 1) {
            return Divider(color: Colors.white,);
          }

          int mappedIndex = index~/2;

          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => QExcercise()));
            },
            child: Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Icon(appIcons[mappedIndex], color: appColors[mappedIndex],),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(appNames[mappedIndex], style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
          );

        })
    );
  }

}