import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  static int _secondsTracker = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 3));
    _controller.repeat();

  }

  static int delayMessage(int seconds) {
    sleep(Duration(seconds: seconds));
  }

  Future<int> spawnSeconds(int seconds) async {
    return await compute(delayMessage, seconds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            'Totally waited for ${_secondsTracker} seconds'
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          spawnSeconds(2);
//          delayMessage(2);
          setState(() {
            _secondsTracker += 2;
          });
        },
        child: AnimatedBuilder(
            animation: _controller,
            child: Icon(
              Icons.thumb_up,
              color: Colors.white,
            ),
            builder: (BuildContext context, Widget _widget) {
              return Transform.rotate(
                angle: _controller.value * 6.3,
                child: _widget,
              );
            }),
      ),
    );
  }
}
