import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlockyNumber extends StatelessWidget {
  final String number;
  final double size;
  final Color color;

  const BlockyNumber({
    super.key,
    required this.number,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          "assets/${number[0]}.svg",
          semanticsLabel: number[0],
          height: size,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
        SvgPicture.asset(
          "assets/${number[1]}.svg",
          semanticsLabel: number[1],
          height: size,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ],
    );
  }
}
