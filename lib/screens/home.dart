import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touchstoneassignment/constant/constant.dart';
import 'package:touchstoneassignment/screens/bedPage.dart';
import 'package:touchstoneassignment/widgets/bottomNavBar.dart';
import 'dart:math' as math;

import 'package:touchstoneassignment/widgets/gridItem.dart';
import 'package:touchstoneassignment/widgets/homeHeader.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool isHome = true;
  AnimationController? _controller;
  Animation? sizeAnimation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    //sizeAnimation = Tween<double>()

    _controller!.addListener(() {
      print(_controller!.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue[900],
      bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: [
          Positioned(
            left: -size.width * 0.25,
            top: -size.height * 0.25,
            child: Transform.rotate(
              angle: -math.pi / 18,
              child: SvgPicture.asset('assets/images/Circles.svg'),
            ),
          ),
          Positioned(top: 24, left: 16, child: HomeHeader(size: size)),
          Positioned(
              top: 32,
              right: 24,
              child: CircleAvatar(
                radius: 32,
                backgroundColor: Colors.white,
                child: SvgPicture.asset('assets/images/bathtube.svg'),
              )),
          Positioned(
            bottom: 0,
            child: Container(
              height: size.height * 0.8 - kBottomNavigationBarHeight,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextHeader(
                    header: 'All Rooms',
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 8,
                        mainAxisExtent: size.height * 0.2,
                      ),
                      itemCount: 6,
                      itemBuilder: (_, i) {
                        Map<String, dynamic> room = roomDetails(i);
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                  pageBuilder: (context, animation, _) {
                                    return Room(
                                      animation: animation,
                                      title: room['title'],
                                      lights: room['lights'],
                                    );
                                  },
                                  transitionsBuilder:
                                      (context, animation, _, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                  transitionDuration:
                                      const Duration(milliseconds: 500)),
                            );
                          },
                          child: GridItem(room: room),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}
