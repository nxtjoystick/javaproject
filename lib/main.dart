import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tap_game/page1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tap Game',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Page1(),
    );
  }
}

class Home extends StatefulWidget {
  final String player1, player2;
  Home({this.player1, this.player2});
  @override
  _HomeState createState() => _HomeState(player1, player2);
}

class _HomeState extends State<Home> {
  String player1, player2;
  _HomeState(this.player1, this.player2);
  int factor1 = 15;
  int factor2 = 15;
  bool p1 = false, p2 = false;
  bool over = false;
  bool timerphase = false;
  Timer _timer;
  int _start = 3;
  void startTime() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer _timer) {
      if (_start == 0) {
        setState(() {
          timerphase = false;
          _timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void initState() {
    setState(() {
      timerphase = true;
    });
    startTime();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: factor1,
                child: GestureDetector(
                  onTap: () {
                    if (!timerphase) {
                      setState(() {
                        factor1++;
                        factor2--;
                        if (factor2 == 0) {
                          p2 = true;
                          over = true;
                        }
                      });
                    }
                  },
                  child: Container(
                    child: Center(
                      child: Text(timerphase ? "$player1" : ""),
                    ),
                    decoration: BoxDecoration(color: Colors.red),
                  ),
                ),
              ),
              Flexible(
                flex: factor2,
                child: GestureDetector(
                  onTap: () {
                    if (!timerphase) {
                      setState(() {
                        factor2++;
                        factor1--;
                        if (factor1 == 0) {
                          p1 = true;
                          over = true;
                        }
                      });
                    }
                  },
                  child: Container(
                    child: Center(
                      child: Text(timerphase ? "$player2" : ""),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                  ),
                ),
              )
            ],
          ),
          Center(
            child: !over
                ? Container()
                : Container(
                    child: p1
                        ? Text(
                            player2 == null ? "Player 2 wins" : "$player2 wins",
                            style: TextStyle(fontSize: 35),
                          )
                        : Text(
                            player1 == null ? "Player 1 wins" : "$player1 wins",
                            style: TextStyle(fontSize: 35),
                          ),
                  ),
          ),
          Center(
            child: !timerphase
                ? Text("")
                : Text(
                    "$_start",
                    style: TextStyle(fontSize: 35),
                  ),
          )
        ]),
      ),
      floatingActionButton: Visibility(
        visible: over,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              timerphase = true;
              startTime();
              _start = 3;
              p1 = false;
              p2 = false;
              factor1 = 15;
              factor2 = 15;
              over = false;
            });
          },
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}
