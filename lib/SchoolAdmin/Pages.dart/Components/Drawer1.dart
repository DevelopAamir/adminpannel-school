import 'package:adminpannel/Attendancepages/AllAttendance.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/AddResult.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Calender.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Drawerbutton.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/LeaveHistory.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Notice.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Profilepage.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/SignUp_student.dart';
import 'package:adminpannel/StaffUI/Teacher/homepage.dart';
import 'package:flutter/material.dart';

class Drawer1 extends StatelessWidget {
  const Drawer1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              elevation: 0.5,
              color: Color(0xff12B081),
              child: ListTile(
                title: Text(
                  'Pannel Setting',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
            ),
            DrawerButton(
              texts: 'Profile',
              page: '/ProfilePage',
              icon: Icons.home,
            ),
            DrawerButton(
              texts: 'Media',
              page: '/Media',
              icon: Icons.perm_media,
            ),
            DrawerButton(
              texts: 'Calender',
              page: 'Calender',
              icon: Icons.calendar_month,
            ),
            DrawerButton(
              texts: 'Add Result',
              page: '/Addresult',
              icon: Icons.person,
            ),
          ],
        ),
      ),
    );
  }
}
