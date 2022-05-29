import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class Classes extends StatelessWidget {
  const Classes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class'),
        backgroundColor: Color(0xff9CCDDB),
      ),
      body: Center(
        child: CircleAvatar(
          radius: 100,
          child: Center(
            child: RiveAnimation.asset(
              'images/animate.riv',
            ),
          ),
        ),
      ),
    );
  }
}
