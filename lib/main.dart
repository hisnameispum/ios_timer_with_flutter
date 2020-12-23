import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _seconds = 90;
  int _minutes = 0;
  Timer _timer;
  var f = NumberFormat("00", "en_US");
  void _startTimer() {
    _minutes = (_seconds / 60).floor();
    _seconds = 90 - (_minutes * 60);

    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 1) {
          _seconds--;
        }
        else if (_seconds == 1 && _minutes > 0 ){
          _minutes-=1;
          _seconds = 60;

        }
        else if (_seconds == 0 && _minutes < 0){
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${f.format(_minutes)} :${f.format(_seconds)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: (){
                    if (_timer != null) {
                      setState(() {
                        _timer.cancel();
                        _minutes = 0;
                        _seconds = 0;
                      });
                    }
                  },
                  color: Colors.black,
                  shape: CircleBorder(
                      side: BorderSide(color: Colors.orange[300]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text(
                        "Stop",
                        style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: (){
                    _startTimer();
                  },
                  color: Colors.orange[300],
                  shape: CircleBorder(
                    side: BorderSide(color: Colors.orange[300]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text(
                      "Start",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
      ),
    );
  }
}