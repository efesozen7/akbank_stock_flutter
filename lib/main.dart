import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:finfree_akbank/AkbankData.dart';
import 'DataService.dart';
import 'PriceEntry.dart';

void main() {
  runApp(MaterialApp(
    title: "Akbank",
    home: new DisplayData(),
  ),
  );
}
class DisplayData extends StatefulWidget{
  @override
  _DisplayDataState createState() => _DisplayDataState();
}
class _DisplayDataState extends State<DisplayData> {
  final Service service = new Service();
  Future<AkbankData> akbankData;
  List<PriceEntry> currentList;
  String currentListName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    akbankData = service.getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Akbank"),
        backgroundColor: Colors.red[600],
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: akbankData,
          builder: (BuildContext context, AsyncSnapshot<AkbankData> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return Center(
                    child: Text('no data')
                );
              } else {
                if(currentList == null){
                  currentList = snapshot.data.d_1g;
                  currentListName = "1G";
                }
                return Container(

                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 10, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(7, 10, 32, 0),
                            child: LineChartW(snapshot.data, currentList)),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  currentList = snapshot.data.d_1g;
                                  currentListName = "1G";
                                });
                              },
                              child: Text('1G',
                                style: TextStyle(
                                    color: Colors.white
                                ),),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.red[600]),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  currentList = snapshot.data.d_1h;
                                  currentListName = "1H";
                                });
                              },
                              child: Text('1H',
                                style: TextStyle(
                                    color: Colors.white
                                ),),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.red[600]),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  currentList = snapshot.data.d_1a;
                                  currentListName = "1A";
                                });
                              },
                              child: Text('1A',
                                style: TextStyle(
                                    color: Colors.white
                                ),),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.red[600]),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  currentList = snapshot.data.d_3a;
                                  currentListName = "3A";
                                });
                              },
                              child: Text('3A',
                                style: TextStyle(
                                    color: Colors.white
                                ),),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.red[600]),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  currentList = snapshot.data.d_1y;
                                  currentListName = "1Y";
                                });
                              },
                              child: Text('1Y',
                                style: TextStyle(
                                    color: Colors.white
                                ),),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.red[600]),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  currentList = snapshot.data.d_5y;
                                  currentListName = "5Y";
                                });
                              },
                              child: Text('5Y',
                                style: TextStyle(
                                    color: Colors.white
                                ),),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.red[600]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Currently displaying: $currentListName',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        )
                      ],


                    ),
                  ),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Center(
                  child: Text('no data')
              ); // error
            } else {
              return Center(child: CircularProgressIndicator()); // loading
            }
          }
      ),
    );

  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class LineChartW extends StatelessWidget {
  LineChartW(this.data, this.currentList);

  final AkbankData data;
  List<PriceEntry> currentList;

  double findMax(){
    double max = -1;
    for(var i = 0; i<currentList.length; i++){
      if(currentList[i].c > max){
        max = currentList[i].c;
      }
    }
    return max;
  }
  double findMin(){
    double min = 1000000;
    for(var i = 0; i<currentList.length; i++){
      if(currentList[i].c < min){
        min = currentList[i].c;
      }
    }
    return min;
  }
  double findRange(){
    return (findMax()-findMin())/3;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: LineChart(
        LineChartData(
          minY: findMin()-findRange(),
          maxY: findMax()+findRange(),
          minX: currentList[0].d.toDouble(),
          maxX: currentList[currentList.length - 1].d.toDouble(),
          lineBarsData: [
            LineChartBarData(
              spots: currentList
                  .map((e) => FlSpot(e.d.toDouble(), e.c))
                  .toList(),
              isCurved: true,
              curveSmoothness: 0.10,
              colors: [Colors.red[600]],
              dotData: FlDotData(
                show: false,
              ),
            ),
          ],
          axisTitleData: FlAxisTitleData(
              leftTitle: AxisTitle(
                  showTitle: true,
                  titleText: "Price (TRY)"
              ),
              bottomTitle: AxisTitle(
                  showTitle: true,
                  titleText: "Time"
              )
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: false,
              reservedSize: 22,
            ),
            topTitles: SideTitles(
              showTitles: false,
              reservedSize: 22,
            ),
          ),
        ),

        swapAnimationDuration: Duration(milliseconds: 150), // Optional
        swapAnimationCurve: Curves.linear,
      ),
    );
  }
}
