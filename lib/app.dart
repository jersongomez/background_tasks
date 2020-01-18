import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 3));
    _controller.repeat();
  }

  static int delayMessage(int seconds) {
    print("************************************");
    print("delayed on -> ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}");
    sleep(Duration(seconds: seconds));
    print("delayed off -> ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}");
    return seconds;
  }

  Future<int> spawnSeconds(int seconds) async {
    var delayedSeconds = await compute(delayMessage, seconds);
    return delayedSeconds;
  }

  void printTimer() async {
    print(await spawnSeconds(2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // please check one after the other
          printTimer();
//          print(delayMessage(2));
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
