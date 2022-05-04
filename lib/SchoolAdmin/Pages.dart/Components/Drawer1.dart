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
            Center(
              child: GestureDetector(
                onTap: () {
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101));
                },
                child: Card(
                  elevation: 0.5,
                  color: Color(0xffE1EFF0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 20,
                          color: Color(0xff1DB691),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Calender',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
