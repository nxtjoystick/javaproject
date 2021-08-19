import 'package:flutter/material.dart';
import 'package:tap_game/main.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  void nextPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Home(
                  player1: _controller1.text,
                  player2: _controller2.text,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.amber,
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity * 0.7,
                  child: TextField(
                    controller: _controller1,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Player 1 name'),
                  ),
                ),
                TextField(
                    controller: _controller2,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Player 2 name')),
                RaisedButton(
                  onPressed: () {
                    nextPage();
                  },
                  child: Text("Go to game"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
