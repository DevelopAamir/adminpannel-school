import 'package:flutter/material.dart';

import 'homescreen.dart';

class Features extends StatelessWidget {
  const Features({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Stack(
              children: [
                Divider(
                  height: 8,
                  color: Color(0xff179F76),
                ),
                Image.asset('images/picture.png'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 80.0, left: 80),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Features',
                                    style: TextStyle(
                                        fontSize: 32, color: Color(0xff004E36)),
                                  ),
                                  Text(
                                    'School app support all devices both Computers and Mobiles (iOs and Android) minimum device specifications requirement.',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 3, 3, 3),
                                        fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(29),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, left: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height / 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'DIGITAL WORLD',
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      fontSize: 40,
                                      color: Color(0xff4AA393)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Learn more things from our one and only educaton website, ',
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 30,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(29),
                            ),
                          ),

                          // Expanded(
                          //   child: Container(
                          //       width: MediaQuery.of(context).size.width / 6,
                          //       child: Image(
                          //           image: AssetImage('images/soon.png'))),
                          // ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        _Featurecard(
                          text: 'Online Class',
                          icns: Icons.video_call,
                        ),
                        _Featurecard(
                          icns: Icons.person,
                          text: 'Attendance',
                        ),
                        _Featurecard(
                          icns: Icons.notifications,
                          text: 'Notice',
                        ),
                        _Featurecard(
                          icns: Icons.perm_media,
                          text: 'Media',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _Featurecard(
                          icns: Icons.calendar_month,
                          text: 'Calender',
                        ),
                        _Featurecard(
                          icns: Icons.work,
                          text: 'Assignment',
                        ),
                        _Featurecard(
                          icns: Icons.leave_bags_at_home,
                          text: 'Leave Application',
                        ),
                        _Featurecard(
                          icns: Icons.chat,
                          text: 'Chat',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Stack(
                      children: [
                        Image(
                          fit: BoxFit.fitWidth,
                          image: AssetImage('images/bottomgradient.png'),
                        ),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1,
                              child: Padding(
                                padding: const EdgeInsets.all(60.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Contacts',
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Color(0xff4AA393),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Details(
                                          maintxt: '9811006844:9812345678',
                                        ),
                                        Details(
                                          maintxt: 'school@gmail.com',
                                        ),
                                        Details(
                                          maintxt: 'Location:Map',
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Social Network',
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Color(0xff4AA393),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.facebook,
                                              size: 25,
                                              color: Color(0xff8C8C8C),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Facebook',
                                              style: TextStyle(
                                                color: Color(0xff535353),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.message_rounded,
                                              size: 25,
                                              color: Color(0xff8C8C8C),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Message',
                                              style: TextStyle(
                                                color: Color(0xff535353),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.telegram_outlined,
                                              size: 25,
                                              color: Color(0xff8C8C8C),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Telegram',
                                              style: TextStyle(
                                                color: Color(0xff535353),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Help?',
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Color(0xff4AA393),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Help center',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff5CEE8D),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Support',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff5CEE8D),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Terms and condition',
                                          style: TextStyle(
                                            fontSize: 14,
                                            // fontWeight: FontWeight.w100,
                                            color: Color(0xff5CEE8D),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Quick response',
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 17,
                                            color: Color(0xff4AA393),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(14.0),
                                            child: Center(
                                              child: TextField(
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'Contact Number and address'),
                                              ),
                                            ),
                                          ),
                                          height: 50,
                                          width: 288,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(14.0),
                                            child: Center(
                                              child: TextField(
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Institute Name'),
                                              ),
                                            ),
                                          ),
                                          height: 50,
                                          width: 288,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: Center(
                                            child: Text(
                                              'Submite',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          height: 47,
                                          width: 288,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                // stops: [
                                                //   0.9,
                                                //   0.9,
                                                //   0.9,
                                                //   0.9,
                                                // ],
                                                colors: [
                                                  Color(0xff04C899),
                                                  Color(0xff5709FB),
                                                  Color(0xffFE0000),
                                                  Color(0xffFA1C94)
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.copyright,
                                              size: 25,
                                              color: Color(0xff8C8C8C),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Details(
                                              maintxt: '2022 school Pvt.Ltd',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              height: 400,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Featurecard extends StatelessWidget {
  final String text;
  final IconData icns;
  const _Featurecard({
    Key? key,
    required this.text,
    required this.icns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.17,
          height: MediaQuery.of(context).size.width * 0.17,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 35, bottom: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icns,
                    size: 60,
                    color: Color.fromARGB(255, 91, 240, 240),
                  ),
                  Text(
                    text,
                    style: TextStyle(color: Colors.black, letterSpacing: 1),
                  ),
                ],
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xffFEFFFF),
            boxShadow: [
              BoxShadow(
                color: Color(0xffDCEDF0).withOpacity(0.50),
                spreadRadius: 10,
                blurRadius: 19,
                offset: Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
        ),
      ),
    );
  }
}
