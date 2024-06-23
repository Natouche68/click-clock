import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Timer? timer;
  String hour = DateTime.now().hour.toString();
  String minute = DateTime.now().minute.toString();
  String second = DateTime.now().second.toString();

  @override
  void initState() {
    super.initState();

    _updateTime();
    timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
  }

  @override
  void dispose() {
    super.dispose();

    if (timer!.isActive) {
      timer!.cancel();
    }
  }

  void _updateTime() {
    final DateTime now = DateTime.now();
    setState(() {
      hour = now.hour.toString().padLeft(2, "0");
      minute = now.minute.toString().padLeft(2, "0");
      second = now.second.toString().padLeft(2, "0");
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final clockStyle = theme.textTheme.displayLarge!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                "assets/${hour[0]}.svg",
                semanticsLabel: hour[0],
                height: clockStyle.fontSize,
                colorFilter:
                    ColorFilter.mode(clockStyle.color!, BlendMode.srcIn),
              ),
              SvgPicture.asset(
                "assets/${hour[1]}.svg",
                semanticsLabel: hour[1],
                height: clockStyle.fontSize,
                colorFilter:
                    ColorFilter.mode(clockStyle.color!, BlendMode.srcIn),
              ),
            ],
          ),
          SizedBox(
            height: clockStyle.fontSize! / 2,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                "assets/${minute[0]}.svg",
                semanticsLabel: minute[0],
                height: clockStyle.fontSize,
                colorFilter:
                    ColorFilter.mode(clockStyle.color!, BlendMode.srcIn),
              ),
              SvgPicture.asset(
                "assets/${minute[1]}.svg",
                semanticsLabel: minute[1],
                height: clockStyle.fontSize,
                colorFilter:
                    ColorFilter.mode(clockStyle.color!, BlendMode.srcIn),
              ),
            ],
          ),
          SizedBox(
            height: clockStyle.fontSize! / 2,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                "assets/${second[0]}.svg",
                semanticsLabel: second[0],
                height: clockStyle.fontSize,
                colorFilter:
                    ColorFilter.mode(clockStyle.color!, BlendMode.srcIn),
              ),
              SvgPicture.asset(
                "assets/${second[1]}.svg",
                semanticsLabel: second[1],
                height: clockStyle.fontSize,
                colorFilter:
                    ColorFilter.mode(clockStyle.color!, BlendMode.srcIn),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
