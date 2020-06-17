import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:fl_chart/fl_chart.dart';

class QuinoaBank extends StatelessWidget {
  LineChartData graphData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'APR';
              case 7:
                return 'MAY';
              case 12:
                return 'JUNE';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '25K';
              case 2:
                return '27K';
              case 3:
                return '29K';
              case 4:
                return '31K';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 14,
      maxY: 4,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
      isCurved: true,
      colors: [
        const Color(0xffaa4cfc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
    ];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.cancel), onPressed: () {
          Navigator.pop(context);
        },),
        backgroundColor: Colors.green,
        title: Text('QuinoaBank'),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 4),
        children: [
          Column(
            children: [
              Center(
                child: Text(
                  'Total Balance',
                  style: TextStyle(fontSize: 32)
                )
              ),
              Center(
                child: Text(
                  '\$53987',
                  // RobotoMono isn't added to pubspec and I'm not about to figure that out
                  style: TextStyle(fontSize: 48, fontFamily: 'RobotoMono')
                )
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: LineChart(
                    graphData()
                ),
              ),
              Center(
                child: Text(
                  'Recent Charges',
                  style: TextStyle(fontSize: 32)
                )
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  children: [
                    Table(
                      children: [
                        TableRow(
                          children: [
                            Text('Snowglobe'),
                            Text('\$35.99', textAlign: TextAlign.right)
                          ]
                        ),
                        TableRow(
                          children: [
                            Text('Paramount, Inc.'),
                            Text('\$153.65', textAlign: TextAlign.right)
                          ]
                        ),
                        TableRow(
                          children: [
                            Text('Google Cloud Platform'),
                            Text('\$1.13', textAlign: TextAlign.right)
                          ]
                        ),
                        TableRow(
                          children: [
                            Text('Amazon Web Services'),
                            Text('\$1.15', textAlign: TextAlign.right)
                          ]
                        ),
                        TableRow(
                          children: [
                            Text('Butter Chicken - Tasty'),
                            Text('\$12.03', textAlign: TextAlign.right)
                          ]
                        ),
                        TableRow(
                          children: [
                            Text('Seven Ten - Bottle O\' Milk'),
                            Text('\$4.15', textAlign: TextAlign.right)
                          ]
                        ),
                        TableRow(
                          children: [
                            Text('Manga Cafe'),
                            Text('\$10.01', textAlign: TextAlign.right)
                          ]
                        ),
                        TableRow(
                          children: [
                            Text('What the Heck by Y.T.'),
                            Text('\$99.99', textAlign: TextAlign.right)
                          ]
                        )
                      ]
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FlatButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text('Next Page'),
                        onPressed: (){ }
                      )
                    )
                  ]
                )
              ),
            ],
          )
        ],
      ),
    );
  }
}