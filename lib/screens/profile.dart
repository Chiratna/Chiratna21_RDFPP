import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touchstoneassignment/screens/bedPage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/images/user.svg', // There is some problem in the user SVG image
                      fit: BoxFit.cover,
                    )
                  ],
                ),
                radius: 40,
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Center(
            child: Container(
              child: TextHeader(header: 'Developed By'),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Center(
            child: Container(
              child: Text(
                'Chiratna Chakraborty',
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
