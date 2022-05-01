import 'package:flutter/material.dart';

class AttendanceST extends StatefulWidget {
  const AttendanceST({Key? key}) : super(key: key);

  @override
  _AttendanceSTState createState() => _AttendanceSTState();
}

class _AttendanceSTState extends State<AttendanceST> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Open shopping cart',
            onPressed: () {},
          ),
        ],
        backgroundColor: Color(0xff9CCDDB),
        title: Text('Take Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Atcard(
              texts: 'osama',
            ),
            Atcard(
              texts: 'Zishan',
            ),
            Atcard(
              texts: 'Majid',
            ),
            Atcard(
              texts: 'Abuzer',
            ),
          ],
        ),
      ),
    );
  }
}

class Atcard extends StatefulWidget {
  const Atcard({
    Key? key,
    required this.texts,
  }) : super(key: key);
  final String texts;

  @override
  _AtcardState createState() => _AtcardState();
}

class _AtcardState extends State<Atcard> {
  bool eye = true;

  @override
  Widget build(BuildContext context) {
    hide() {
      if (eye == true) {
        setState(() {
          eye = false;
        });
      } else {
        setState(() {
          eye = true;
        });
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.texts),
            IconButton(
              icon: Icon(eye == true ? Icons.done : Icons.close),
              onPressed: () {
                setState(() {});
                hide();
              },
            )
          ],
        ),
      ),
      height: 40,
      width: double.infinity,
    );
  }
}
