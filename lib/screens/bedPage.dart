import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:touchstoneassignment/constant/constant.dart';
import 'package:touchstoneassignment/widgets/bottomNavBar.dart';
import 'package:touchstoneassignment/widgets/brightnessSlider.dart';

import 'package:touchstoneassignment/widgets/lampWidget.dart';
import 'package:touchstoneassignment/widgets/lightList.dart';
import 'dart:math' as math;

import 'package:touchstoneassignment/widgets/roomHeader.dart';

class Room extends StatefulWidget {
  const Room({
    Key? key,
    required this.animation,
    required this.title,
    required this.lights,
  }) : super(key: key);
  final Animation animation;
  final String title;
  final String lights;
  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? translateTween;
  ScrollController sc = ScrollController();
  double value = 1, opValue = 1;
  Color lampColor = Colors.amber;
  bool powerOn = true;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    translateTween =
        CurvedAnimation(parent: _controller!, curve: Curves.easeIn);

    widget.animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) _controller!.forward();
    });

    sc.addListener(() {
      setState(() {
        opValue = math.min(1, math.max(0, 1 - sc.offset / 170));
      });
    });

    super.initState();
  }

  List<Widget> colorPicker(double factor) {
    const double overlap = 20;
    List<Widget> stackLayers =
        List<Widget>.generate(colors.length + 1, (index) {
      return Padding(
        padding:
            EdgeInsets.fromLTRB(index.toDouble() * overlap * factor, 0, 0, 0),
        child: index == colors.length
            ? GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  sc.animateTo(0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                  setState(() {
                    lampColor = colors[index].withOpacity(value);
                  });
                },
                child: CircleAvatar(backgroundColor: colors[index])),
      );
    });
    return stackLayers;
  }

  List<Widget> scenePicker() {
    List<Widget> stackLayers =
        List<Widget>.generate(scenceGradients.length, (index) {
      return GestureDetector(
        onTap: () {
          sc.animateTo(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);

          setState(() {
            lampColor = scenceGradients[index]['lampcolor'].withOpacity(value);
          });
        },
        child: Container(
          width: 130,
          height: kBottomNavigationBarHeight,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              gradient: scenceGradients[index]['gradient'],
              borderRadius: BorderRadius.circular(8),
            ),
            height: kBottomNavigationBarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/mainLight.svg',
                  color: Colors.white,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  scenceGradients[index]['title'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });

    return stackLayers;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(),
      body: SafeArea(
          child: CustomScrollView(
        controller: sc,
        //shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        slivers: [
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 150, end: 300),
            duration: const Duration(milliseconds: 500),
            builder: (_, he, child) {
              return SliverAppBar(
                  backgroundColor: Colors.blue[900],
                  automaticallyImplyLeading: false,
                  stretch: true,
                  onStretchTrigger: () async {},
                  expandedHeight: he,
                  flexibleSpace: child);
            },
            child: Stack(
              children: [
                Positioned(
                  left: -size.width * 0.25,
                  top: -size.height * 0.25,
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 500),
                    tween: Tween<double>(begin: 18, end: 3),
                    builder: (_, angle, child) {
                      return Transform.rotate(
                        angle: -math.pi / angle,
                        child: child,
                      );
                    },
                    child: SvgPicture.asset('assets/images/Circles.svg'),
                  ),
                ),
                // Positioned(top: 24, left: 16, child: HomeHeader(size: size)),
                Positioned(
                  right: 0,
                  top: -40,
                  child: AnimatedBuilder(
                    animation: translateTween!,
                    builder: (_, child) {
                      return Transform.translate(
                        offset: Offset(0, 40 * translateTween!.value),
                        child: child,
                      );
                    },
                    child: Opacity(
                        opacity: opValue,
                        child:
                            LampWidget(bright: lampColor.withOpacity(value))),
                  ),
                ),
                Positioned(
                  bottom: 130,
                  left: 16,
                  child: GestureDetector(
                    onTap: () {
                      _controller!.reverse();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RoomHeader(size: size, s: '${widget.title}'),
                          AnimatedBuilder(
                            animation: translateTween!,
                            builder: (_, child) {
                              return Transform.translate(
                                offset: Offset(0, 8 * translateTween!.value),
                                child: Opacity(
                                  opacity: translateTween!.value,
                                  child: child,
                                ),
                              );
                            },
                            child: Text(
                              widget.lights,
                              style: TextStyle(
                                color: Colors.amber[400],
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 56,
                  child: AnimatedBuilder(
                      animation: translateTween!,
                      builder: (_, child) {
                        return Transform.translate(
                          offset: Offset(
                              size.width * 0.3 * (1 - translateTween!.value),
                              0),
                          child: Opacity(
                            opacity: translateTween!.value,
                            child: child,
                          ),
                        );
                      },
                      child: LightList(size: size)),
                ),

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
                Positioned(
                  bottom: 8,
                  right: 32,
                  child: AnimatedBuilder(
                    animation: translateTween!,
                    builder: (_, child) {
                      return Opacity(
                        opacity: translateTween!.value,
                        child: child,
                      );
                    },
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          powerOn = !powerOn;
                          value = powerOn ? 1 : 0;
                        });
                      },
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: SvgPicture.asset(
                            'assets/images/iconawesomepoweroff.svg',
                            color: powerOn ? Colors.red : Colors.grey,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: TextHeader(header: 'Intensity'),
          ),
          SliverToBoxAdapter(
            child: BrightnessSlider(
              color: lampColor,
              size: size,
              value: value,
              child: Slider(
                max: 1,
                min: 0,
                value: value,
                onChanged: (d) {
                  setState(() {
                    value = d;
                  });
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: TextHeader(header: 'Colors'),
          ),
          AnimatedBuilder(
              animation: translateTween!,
              builder: (_, child) {
                return SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(left: 32),
                    width: size.width,
                    child: Wrap(
                      spacing: 16 * translateTween!.value,
                      runSpacing: 16,
                      children: colorPicker(0),
                    ),
                  ),
                );
              }),
          SliverToBoxAdapter(
            child: TextHeader(header: 'Scenes'),
          ),
          AnimatedBuilder(
            animation: translateTween!,
            builder: (_, child) {
              return SliverToBoxAdapter(
                child: Container(
                  width: size.width,
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: (size.width - 48 - 260) * translateTween!.value,
                      runSpacing: 32,
                      children: scenePicker()),
                ),
              );
            },
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 32,
            ),
          )
        ],
      )),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}

class TextHeader extends StatelessWidget {
  const TextHeader({Key? key, required this.header}) : super(key: key);
  final String header;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 24,
      ),
      child: Text(
        header,
        style: TextStyle(
          fontSize: 18,
          color: Colors.blue[900],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
