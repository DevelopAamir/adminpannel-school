import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: AssetImage('images/bird0.png'),
                      ),
                    ),
                    height: 50,
                    width: 130,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '9811006844',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '9826370489',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'school@gmail.com',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Contact us',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '9811006844',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '9826370489',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'school@gmail.com',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Contact us',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '9811006844',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '9826370489',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'school@gmail.com',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Contact us',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '9811006844',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '9826370489',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'school@gmail.com',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
      color: Color(0xffD2FBFF),
      width: double.infinity,
      height: 200,
    );
  }
}
