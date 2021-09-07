import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LampWidget extends StatelessWidget {
  const LampWidget({
    Key? key,
    required this.size,
    required this.bright,
  }) : super(key: key);

  final Size size;
  final Color bright;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.height * 0.22,
      height: size.height * 0.22,
      margin: EdgeInsets.only(right: 16),
      //key: UniqueKey(),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: SvgPicture.asset(
              'assets/images/lightbulb.svg',
              color: bright,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            top: 0,
            child: SvgPicture.asset('assets/images/lightbulboutline.svg'),
          ),
        ],
      ),
    );
  }
}
