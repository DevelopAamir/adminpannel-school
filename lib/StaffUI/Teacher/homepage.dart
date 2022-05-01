import 'package:flutter/material.dart';
import 'Assisment.dart';
import 'Class.dart';
import 'Drawer.dart';
import 'Message.dart';
import 'Takeattendance.dart';
import 'Takeexmdart.dart';
import 'leave.dart';
import 'stfcard.dart';

class Staffs extends StatelessWidget {
  const Staffs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff9CCDDB),
        title: Text('Home'),
      ),
      drawer: MainDrawerstf(),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff9CCDDB),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  width: double.infinity,
                  height: 80,
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('tapped');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Classes();
                              },
                            ),
                          );
                        },
                        child: Stfcard(
                          icons: Icons.desktop_mac,
                          clr: Color(0xff072D44),
                          txts: Text('Take class'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('tapped');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Stfmsg();
                              },
                            ),
                          );
                        },
                        child: Stfcard(
                          icons: Icons.message,
                          clr: Color(0xff064469),
                          txts: Text(
                            'Message',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('tapped');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Leave();
                              },
                            ),
                          );
                        },
                        child: Stfcard(
                          icons: Icons.sick,
                          clr: Color(0xff5790AB),
                          txts: Text('Leave'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('tapped');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Assisment();
                              },
                            ),
                          );
                        },
                        child: Stfcard(
                          icons: Icons.book_online_outlined,
                          clr: Color(0xff932E56),
                          txts: Text('Assign'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('tapped');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return AttendanceST();
                              },
                            ),
                          );
                        },
                        child: Stfcard(
                          icons: Icons.person_search_rounded,
                          clr: Color(0xff422E53),
                          txts: Text('Attendance'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('tapped');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Examtake();
                              },
                            ),
                          );
                        },
                        child: Stfcard(
                          icons: Icons.ac_unit_outlined,
                          clr: Color(0xff212040),
                          txts: Text('Take Exam'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
