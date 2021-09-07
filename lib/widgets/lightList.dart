import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LightList extends StatelessWidget {
  const LightList({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: kBottomNavigationBarHeight * 1.2,
      //color: Colors.white,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            width: size.width * 0.3,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  'assets/images/mainLight.svg',
                  color: Colors.indigo[900],
                ),
                Text(
                  'Main Light',
                  style: TextStyle(
                      color: Colors.indigo[900], fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            width: size.width * 0.3,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.indigo[900],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  'assets/images/desk.svg',
                  color: Colors.white,
                ),
                Text(
                  'Desk Light',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            width: size.width * 0.3,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  'assets/images/bedlight.svg',
                  color: Colors.indigo[900],
                ),
                Text(
                  'Bed Light',
                  style: TextStyle(
                      color: Colors.indigo[900], fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
