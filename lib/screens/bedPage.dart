import 'package:flutter/material.dart';
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
  double value = 1;
  Color lampColor = Colors.amber;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    translateTween =
        CurvedAnimation(parent: _controller!, curve: Curves.easeIn);

    widget.animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) _controller!.forward();
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
                  setState(() {
                    lampColor = colors[index].withOpacity(value);
                  });
                },
                child: CircleAvatar(backgroundColor: colors[index])),
      );
    });
    return stackLayers;
  }

  List<Widget> scenePicker(double factor, Size size) {
    double top = 1;
    double right = size.width - 120 - 64;
    List<Widget> stackLayers =
        List<Widget>.generate(scenceGradients.length, (index) {
      if (index % 2 == 0) {
        if (index == 0)
          top = 0;
        else
          top += kBottomNavigationBarHeight + 16;
        right = size.width - 120 - 64;
      } else {
        right = (1 - factor) * right;
      }

      return Positioned(
        top: top,
        right: right,
        child: Container(
          decoration: BoxDecoration(
            gradient: scenceGradients[index]['gradient'],
            borderRadius: BorderRadius.circular(8),
          ),
          width: 120,
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
      );
    });

    return stackLayers;
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
          Positioned(
            bottom: 0,
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 600),
              tween: Tween<double>(begin: 0.8, end: 0.65),
              builder: (_, height, child) {
                return Container(
                  height: size.height * height - kBottomNavigationBarHeight,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      )),
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHeader(header: 'Intensity'),
                      BrightnessSlider(
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
                      TextHeader(
                        header: 'Colors',
                      ),
                      AnimatedBuilder(
                          animation: translateTween!,
                          builder: (_, child) {
                            return Container(
                              margin: EdgeInsets.only(left: 32),
                              width: size.width,
                              child: Stack(
                                children:
                                    colorPicker(translateTween!.value * 2.5),
                              ),
                            );
                          }),
                      TextHeader(header: 'Scenes'),
                      Expanded(
                        child: Container(
                          width: size.width,
                          child: Center(
                            child: AnimatedBuilder(
                                animation: translateTween!,
                                builder: (_, child) {
                                  return Container(
                                    margin:
                                        EdgeInsets.only(left: 32, right: 32),
                                    width: size.width,
                                    child: Stack(
                                      children: scenePicker(
                                          translateTween!.value, size),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
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
              child:
                  LampWidget(size: size, bright: lampColor.withOpacity(value)),
            ),
          ),
          Positioned(
            top: 24,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: size.height * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RoomHeader(size: size, s: '${widget.title}'),
                    AnimatedBuilder(
                      animation: translateTween!,
                      builder: (_, child) {
                        return Transform.translate(
                          offset: Offset(0, 16 * translateTween!.value),
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
            top: size.height * 0.24,
            left: 32,
            child: AnimatedBuilder(
                animation: translateTween!,
                builder: (_, child) {
                  return Transform.translate(
                    offset: Offset(
                        size.width * 0.3 * (1 - translateTween!.value), 0),
                    child: Opacity(
                      opacity: translateTween!.value,
                      child: child,
                    ),
                  );
                },
                child: LightList(size: size)),
          ),
          Positioned(
            top: size.height * 0.33,
            right: 40,
            child: AnimatedBuilder(
              animation: translateTween!,
              builder: (_, child) {
                return Opacity(
                  opacity: translateTween!.value,
                  child: child,
                );
              },
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: SvgPicture.asset(
                    'assets/images/iconawesomepoweroff.svg',
                    color: Colors.red,
                  )),
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
