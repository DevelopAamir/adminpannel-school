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
                Image.asset('images/Gradients.png'),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 80.0, left: 100),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Features',
                                      style: TextStyle(
                                          color: Color(0xff179F76),
                                          fontSize: 25),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'School management system',
                                        style: TextStyle(
                                            color: Color(0xff444444),
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              height: 221,
                              decoration: BoxDecoration(
                                color: Color(0xffDEFFF9),
                                borderRadius: BorderRadius.circular(29),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Text(
                              'Education is the most powerful weapon which you can use to change the world',
                              style: TextStyle(
                                letterSpacing: 1,
                                fontSize: 18,
                                color: Color(0xff076D74),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 100.0, left: 100),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                'We are fully focused to provide education in any condition and any where, this application will help to take class, attendance, adding home work , exercise, notice , can also send messages etc. It is fully secure and no one can share link and any other think during online classes',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff076D74),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                          ),
                          Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Image(
                                    image: AssetImage('images/soon.png'))),
                          ),
                          SizedBox(
                            width: 20,
                          ),
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
                    Container(
                      width: MediaQuery.of(context).size.width / 1,
                      child: Padding(
                        padding: const EdgeInsets.all(60.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Contacts',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff535353),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Details(
                                  maintxt: '9811006844:/n 9812345678',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Products',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff535353),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Image(
                                    image: AssetImage(
                                      'images/wings.png',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Social Ntework',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff535353),
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
                                      'Teligram',
                                      style: TextStyle(
                                        color: Color(0xff535353),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      height: 300,
                      // width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffE3FFFD),
                      ),
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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 35, bottom: 35),
              child: Column(
                children: [
                  Icon(
                    icns,
                    size: 60,
                    color: Color(0xff569275),
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
            color: Color(0xffC5F8EE),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
