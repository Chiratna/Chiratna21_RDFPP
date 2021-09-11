import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:touchstoneassignment/constant/constant.dart';
import 'package:touchstoneassignment/screens/profile.dart';
import 'package:touchstoneassignment/widgets/bottomNavBar.dart';
import 'package:touchstoneassignment/widgets/gridItem.dart';
import 'package:touchstoneassignment/widgets/homeHeader.dart';
import 'dart:math' as math;

import 'bedPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(),
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: false,
              stretch: true,
              onStretchTrigger: () async {
                print('Hello');
              },
              bottom: PreferredSize(
                child: Container(),
                preferredSize: Size(0, 20),
              ),
              backgroundColor: Colors.blue[900],
              expandedHeight: 200,
              flexibleSpace: Stack(
                children: [
                  Positioned(
                    left: -size.width * 0.25,
                    top: -size.height * 0.25,
                    child: Transform.rotate(
                      angle: -math.pi / 18,
                      child: SvgPicture.asset('assets/images/Circles.svg'),
                    ),
                  ),
                  Positioned(
                      bottom: 72, left: 16, child: HomeHeader(size: size)),
                  Positioned(
                      bottom: 80,
                      right: 24,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                                pageBuilder: (context, animation, _) {
                                  return ProfilePage();
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
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.white,
                          child: SvgPicture.asset('assets/images/bathtube.svg'),
                        ),
                      )),
                  Positioned(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(50),
                        ),
                      ),
                    ),
                    bottom: -1,
                    left: 0,
                    right: 0,
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                  margin: EdgeInsets.only(
                    left: 32,
                    bottom: 16,
                  ),
                  child: Text(
                    'All Rooms',
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate((_, i) {
                i = i % 6;
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
                          transitionsBuilder: (context, animation, _, child) {
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
              }, childCount: 6),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
                mainAxisExtent: 200,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 32,
              ),
            )
          ],
        ),
      ),
    );
  }
}
