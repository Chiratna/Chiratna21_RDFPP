import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LampWidget extends StatelessWidget {
  const LampWidget({
    Key? key,
    required this.bright,
  }) : super(key: key);

  final Color bright;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 170,
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
