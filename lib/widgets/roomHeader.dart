import 'package:flutter/material.dart';

class RoomHeader extends StatelessWidget {
  const RoomHeader({
    Key? key,
    required this.size,
    required this.s,
  }) : super(key: key);

  final Size size;
  final String s;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 8),
            child: Icon(
              Icons.arrow_back,
              size: 24,
              color: Colors.white,
            ),
          ),
          Text(
            '$s',
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          )
        ],
      ),
      width: 100,
    );
  }
}
