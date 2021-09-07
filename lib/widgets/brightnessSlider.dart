import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BrightnessSlider extends StatelessWidget {
  const BrightnessSlider(
      {Key? key,
      required this.color,
      required this.size,
      required this.value,
      required this.child})
      : super(key: key);
  final Size size;
  final Widget child;
  final Color color;
  final double value;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        width: size.width,
        child: Row(children: [
          SvgPicture.asset(
            'assets/images/solution2.svg',
            color: Colors.grey,
          ),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                activeTrackColor: Colors.amber,
                inactiveTrackColor: Colors.grey[400],
                trackHeight: 2,
                thumbColor: Colors.white,
              ),
              child: child,
            ),
          ),
          Container(
              // height: 35,
              // width: 35,
              child: Stack(
            children: [
              SvgPicture.asset(
                'assets/images/solution1.svg',
                color: Colors.grey,
              ),
              SvgPicture.asset(
                'assets/images/solution1.svg',
                color: Colors.amber.withOpacity(value),
              ),
            ],
          ))
        ]));
  }
}
