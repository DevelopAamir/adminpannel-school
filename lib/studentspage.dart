import 'package:adminpannel/SchoolAdmin/Pages.dart/Notice.dart';
import 'package:adminpannel/StaffUI/Teacher/Takeattendance.dart';
import 'package:flutter/material.dart';

class Studentspage extends StatelessWidget {
  const Studentspage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class 1'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Classcard(
              txt: 'Take Attendance',
              button: Notice(),
            ),
            Classcard(
              txt: 'Take Class',
              button: Notice(),
            ),
            Classcard(
              txt: 'Add Notice',
              button: Notice(),
            ),
            Classcard(
              txt: 'Add homework',
              button: Notice(),
            ),
            Classcard(
              txt: 'Leave History',
              button: Notice(),
            ),
            Classcard(
              txt: 'Suspend',
              button: Notice(),
            ),
          ],
        ),
      ),
    );
  }
}

class Classcard extends StatelessWidget {
  final String txt;
  final Widget button;
  const Classcard({
    Key? key,
    required this.txt,
    required this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => button));
        },
        child: Card(
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                txt,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
