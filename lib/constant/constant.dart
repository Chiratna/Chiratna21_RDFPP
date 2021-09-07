import 'package:flutter/material.dart';

roomDetails(int i) {
  List<Map<String, dynamic>> rooms = [
    {
      'pic': 'assets/images/bed.svg',
      'title': 'Bed Room',
      'lights': '4 lights',
    },
    {
      'pic': 'assets/images/room.svg',
      'title': 'Living Room',
      'lights': '2 lights',
    },
    {
      'pic': 'assets/images/kitchen.svg',
      'title': 'Kitchen',
      'lights': '5 lights',
    },
    {
      'pic': 'assets/images/bathtube.svg',
      'title': 'Bathroom',
      'lights': '1 lights',
    },
    {
      'pic': 'assets/images/house.svg',
      'title': 'Outdoor',
      'lights': '5 lights',
    },
    {
      'pic': 'assets/images/balcony.svg',
      'title': 'Balcony',
      'lights': '2 lights',
    },
  ];

  return rooms[i];
}

List<Color> colors = [
  Colors.pink[200]!,
  Colors.greenAccent,
  Colors.cyan[300]!,
  Colors.purpleAccent[700]!,
  Colors.purple[200]!,
  Colors.amberAccent[400]!,
];

List<Map<String, dynamic>> scenceGradients = [
  {
    'gradient': LinearGradient(
      colors: [
        Colors.amber[600]!,
        Colors.deepOrange[400]!,
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
    'title': 'Birthday',
  },
  {
    'gradient': LinearGradient(
      colors: [
        Colors.purple[100]!,
        Colors.purple[400]!,
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
    'title': 'Party'
  },
  {
    'gradient': LinearGradient(
      colors: [
        Colors.blue[100]!,
        Colors.blue[400]!,
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
    'title': 'Relax',
  },
  {
    'gradient': LinearGradient(
      colors: [
        Colors.green[100]!,
        Colors.green[300]!,
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
    'title': 'Fun'
  }
];
