import 'package:adminpannel/StaffUI/Teacher/homepage.dart';
import 'package:flutter/material.dart';

import 'Settings.dart';
import 'Takeattendance.dart';

class MainDrawerstf extends StatelessWidget {
  const MainDrawerstf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 167,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xff9CCDDB),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      // backgroundImage: AssetImage(
                      //   'images/Aamir.jpg',
                      // ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'MD Aamir',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  Column(
                    children: [
                      Button(
                        widget: Staffs(),
                        text: 'Gallery',
                        icons: Icons.photo,
                        color: Color(0xff4ABC9A),
                      ),
                      Button(
                        widget: AttendanceST(),
                        text: 'Take Attendance',
                        icons: Icons.format_align_center,
                        color: Color(0xffE75480),
                      ),
                      Button(
                        widget: Staffs(),
                        text: 'Today Classes',
                        icons: Icons.book,
                        color: Color(0xffB5651D),
                      ),
                      Button(
                        widget: Staffs(),
                        text: 'Calendar',
                        icons: Icons.calendar_today,
                        color: Colors.pink,
                      ),
                      Button(
                        widget: Settingss(),
                        text: 'Settings',
                        icons: Icons.settings,
                        color: Color(0xff676767),
                      ),
                      Button(
                        widget: Staffs(),
                        text: 'Help and feedback',
                        icons: Icons.question_answer,
                        color: Color(0xff355c7d),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.widget,
    required this.text,
    required this.icons,
    required this.color,
  }) : super(key: key);
  final Widget widget;
  final String text;
  final IconData? icons;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('tapped');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return widget;
            },
          ),
        );
      },
      child: ListTile(
        leading: Icon(
          icons,
          color: color,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Color(0xff666758),
          ),
        ),
      ),
    );
  }
}
