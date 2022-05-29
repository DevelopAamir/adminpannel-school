import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Drawerbutton.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Landingpage.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Media.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Profilepage.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Settings.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/SignUp_Staff.dart';
import 'package:adminpannel/SchoolAdmin/class.dart';
import 'package:adminpannel/Storage/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/dataProvider.dart';

class Drawer1 extends StatelessWidget {
  Drawer1({
    Key? key,
  }) : super(key: key);
  final _firestore = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color(0xff296A79),
      width: 200,
      height: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage('images/bird0.png'),
                ),
              ),
              height: 55,
              width: 130,
            ),
            Card(
              elevation: 0.5,
              color: Color(0xff59DBD3),
              child: ListTile(
                title: Text(
                  'Admin Pannel',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Settings();
                    }));
                  },
                ),
              ),
            ),
            DrawerButton(
              texts: 'Profile',
              page: Profilepage(),
              icon: Icons.home,
            ),
            DrawerButton(
              texts: 'Media',
              page: Medias(),
              icon: Icons.perm_media,
            ),
            if (Provider.of<SchoolProvider>(context, listen: false)
                .permissions
                .contains('Staff Management'))
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignupStaff()));
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
                            color: Color(0xff02242C),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Add Staff',
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
            if (Provider.of<SchoolProvider>(context, listen: false)
                .permissions
                .contains('Staff Management'))
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StaffRecords()));
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
                            color: Color(0xff02242C),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Staffs',
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
            if (Provider.of<SchoolProvider>(context, listen: false)
                .permissions
                .contains('Staff Management'))
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StaffAttendance()));
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
                            color: Color(0xff02242C),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Staff Attendance',
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
                          color: Color(0xff02242C),
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
            Center(
              child: GestureDetector(
                onTap: () async {
                  await Store().logOut().then((value) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (ontext) => Landingpage()));
                  });
                },
                child: Card(
                  elevation: 0.5,
                  color: Color(0xffE1EFF0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout_outlined,
                          size: 20,
                          color: Color(0xff02242C),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Sign Out',
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
