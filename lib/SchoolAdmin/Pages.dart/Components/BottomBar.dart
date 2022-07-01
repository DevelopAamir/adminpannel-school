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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Us',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                          fontWeight: FontWeight.w100),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Biratnagar-6',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w100),
                    ),
                    Text(
                      '9811006844',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w100),
                    ),
                    Text(
                      '9826370489',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w100),
                    ),
                    Text(
                      'school@gmail.com',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w100),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Social Networks',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        color: Colors.grey,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.facebook,
                          color: Colors.white,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.link,
                          color: Colors.white,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.info,
                          color: Colors.white,
                          size: 15,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Help?',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        color: Colors.grey,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Support',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w100),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Help centre',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w100),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Terms and condition',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      color: Color(0xff021205),
      width: double.infinity,
      height: 160,
    );
  }
}
