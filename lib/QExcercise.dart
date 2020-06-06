
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class QExcercise extends StatelessWidget {
  Widget build(context) {
    return Scaffold( 
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.cancel), onPressed: () {
          Navigator.pop(context);
        },),
        backgroundColor: Colors.orange,
        title: Text('QExcercise'),
      ),
      body: ListView(
        children: [
          Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  'Calories Burned',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
        Container(
           padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
           child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: BarChart(
                        mainBarData(),
                        swapAnimationDuration: const Duration(milliseconds: 250),
                      ),
                  ),
                ),
         ),
          Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  'Hey Yash T! Looks like you haven\'t been hitting your calorie goals for the past few days. Perhaps you\'d like to take a quick jog, or perhaps a swim? If you want, I can find you a nearby pool!',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
              ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: FlatButton(
                onPressed: () {},
                child: Text('Find me a pool!')
              )
            ),
            Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  'Suggested Excercises',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius:  BorderRadius.all(Radius.circular(15))
                ),
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Row(
                  children: [
                    Icon(Icons.directions_walk),
              
                   Container(child:  Text('Take a walk'), margin: EdgeInsets.fromLTRB(10, 0, 0, 0),)
                  
                  ]
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius:  BorderRadius.all(Radius.circular(15))
                ),
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Row(
                  children: [
                    Icon(Icons.directions_bike),
              
                   Container(child:  Text('Bike Ride'), margin: EdgeInsets.fromLTRB(10, 0, 0, 0),)
                  
                  ]
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius:  BorderRadius.all(Radius.circular(15))
                ),
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Row(
                  children: [
                    Icon(Icons.accessibility),
                   Container(child:  Text('Calesthenics'), margin: EdgeInsets.fromLTRB(10, 0, 0, 0),)
                  
                  ]
                ),
              )
        ],
      ),
    );
  }

BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Monday';
                  break;
                case 1:
                  weekDay = 'Tuesday';
                  break;
                case 2:
                  weekDay = 'Wednesday';
                  break;
                case 3:
                  weekDay = 'Thursday';
                  break;
                case 4:
                  weekDay = 'Friday';
                  break;
                case 5:
                  weekDay = 'Saturday';
                  break;
                case 6:
                  weekDay = 'Sunday';
                  break;
              }
              return BarTooltipItem(
                  weekDay + '\n' + (rod.y - 1).toString(), TextStyle(color: Colors.yellow));
            }),
        touchCallback: (barTouchResponse) {
         
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

    List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 250, isTouched: i == 6);
          case 1:
            return makeGroupData(1, 225, isTouched: i == 6);
          case 2:
            return makeGroupData(2, 300, isTouched: i == 6);
          case 3:
            return makeGroupData(3, 325, isTouched: i == 6);
          case 4:
            return makeGroupData(4, 225, isTouched: i == 6);
          case 5:
            return makeGroupData(5, 200, isTouched: i == 6);
          case 6:
            return makeGroupData(6, 100, isTouched: i == 6);
          default:
            return null;
        }
      });


  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.black,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          color: isTouched ? Colors.orange : barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            color: Colors.grey[800],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }


}