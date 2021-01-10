import 'package:flutter/material.dart';

import 'GhanaMobileMoneytActivity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GhanaMobileMoney',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GhanaMobileMoneyActivity(),
    );
  }
}
/*
//Navigator.push(context, MaterialPageRoute(builder: (context) => GhanaMobileMoneyActivity(labmaintotalamount.toString(),DatabaseHelper.tablelab,Constant.SERVICE_TITLE_LAB)));
                  showDialog(context: context, barrierDismissible: false,builder: (context) => GhanaMobileMoneyActivity(_scaffoldKeyitemdetail,labmaintotalamount.toString(),DatabaseHelper.tablelab,Constant.SERVICE_TITLE_LAB));
 */
