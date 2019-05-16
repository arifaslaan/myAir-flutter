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
    await http.post(Uri.encodeFull('http://arifaslan.tech/projects/graduation_project/getStatusWithTcApi.php'),
    body: {'kimlikno': widget.myAirID}).then((UriResponse) {
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
        child: Text(
          ''+myDatas[0]['name'],
          style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
  Widget circularProgress = Container(
    alignment: Alignment.center,
    child: CircularProgressIndicator(),
  );
}