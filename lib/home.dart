import 'dart:async';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String hour = DateTime.now().hour.toString();
  String minute = DateTime.now().minute.toString();
  String second = DateTime.now().second.toString();

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
  }

  void _updateTime() {
    final DateTime now = DateTime.now();
    setState(() {
      hour = now.hour.toString();
      minute = now.minute.toString();
      second = now.second.toString();

      if (hour.length == 1) {
        hour = "0$hour";
      }
      if (minute.length == 1) {
        minute = "0$minute";
      }
      if (second.length == 1) {
        second = "0$second";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final clockStyle = theme.textTheme.displayLarge;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            hour,
            style: clockStyle,
          ),
          Text(
            minute,
            style: clockStyle,
          ),
          Text(
            second,
            style: clockStyle,
          ),
        ],
      ),
    );
  }
}
