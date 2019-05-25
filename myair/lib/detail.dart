import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class DetailPage extends StatefulWidget {
  final myAirID;
  DetailPage({Key key, @required this.myAirID}) : super(key: key);
  @override
  DetailPageState createState() => DetailPageState();
}
var myDatas = [];
bool _progressBarActive = true;
class DetailPageState extends State<DetailPage> {
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _getDatas());
    super.initState();
  }
  _getDatas () async{
    await http.post(Uri.encodeFull('http://arifaslan.tech/projects/design_project/getWithQrApi.php'),
    body: {'qrcode': widget.myAirID}).then((UriResponse) {
      setState((){
        myDatas = [];
        myDatas = json.decode(UriResponse.body);
      });    
    });
    _progressBarActive = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _progressBarActive == true ? circularProgress:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "MQ135: ",
                  style: TextStyle(
                    fontSize: 30,

                  ),
                ),
                Text(
                  ""+myDatas[0]['mq'],
                  style: TextStyle(
                    fontSize: 30,

                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Grove 1: ",
                  style: TextStyle(
                    fontSize: 30,

                  ),
                ),
                Text(
                  ""+myDatas[0]['gr1'],
                  style: TextStyle(
                    fontSize: 30,

                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Grove 2: ",
                  style: TextStyle(
                    fontSize: 30,

                  ),
                ),
                Text(
                  ""+myDatas[0]['gr2'],
                  style: TextStyle(
                    fontSize: 30,

                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Nem: ",
                  style: TextStyle(
                    fontSize: 30,

                  ),
                ),
                Text(
                  ""+myDatas[0]['hum']+"%",
                  style: TextStyle(
                    fontSize: 30,

                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Sıcaklık: ",
                    style: TextStyle(
                      fontSize: 30,

                    ),
                  ),
                  Text(
                    ""+myDatas[0]['tmp']+"°C",
                    style: TextStyle(
                      fontSize: 30,

                    ),
                  ),
                  
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Genel Hava Kalitesi: ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  ""+myDatas[0]['qbb'],
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget circularProgress = Container(
    alignment: Alignment.center,
    child: CircularProgressIndicator(),
  );
}