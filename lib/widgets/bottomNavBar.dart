import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: kBottomNavigationBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: SvgPicture.asset('assets/images/bulb.svg'),
          ),
          Container(
            child: SvgPicture.asset('assets/images/iconfeatherhome.svg'),
          ),
          Container(
            child: SvgPicture.asset('assets/images/iconfeathersettings.svg'),
          ),
        ],
      ),
    );
  }
}
