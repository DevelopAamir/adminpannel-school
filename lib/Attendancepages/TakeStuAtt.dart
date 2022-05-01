import 'package:flutter/material.dart';

class StuAtt extends StatelessWidget {
  const StuAtt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff9DFCA7),
        title: Row(
          children: [
            Text('Student Attendance'),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 35,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Color(0xff56F653),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Filter'),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.filter_tilt_shift,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 35,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Color(0xff56F653),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Take Att'),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.person,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              TopBar(),
              Card(
                color: Color(0xffB2EAFF),
                child: Padding(
                  padding: const EdgeInsets.all(
                    10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '1',
                        style: TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                        ),
                        child: Text(
                          'Ahmad',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Text(
                        'Sunday',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        '2022/01/10',
                        style: TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 15.0,
                        ),
                        child: Text(
                          'P',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              children: [
                Text(
                  'Create',
                  style: TextStyle(color: Colors.white),
                ),
                Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 5, bottom: 5),
                    child: Text(
                      'Date',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 18.0, right: 18.0, top: 5, bottom: 5),
                child: Text(
                  'Day',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 18.0, right: 18.0, top: 5, bottom: 5),
                child: Text(
                  'Class',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Card(
              color: Color(0xff9DFCA7),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ]),
        ),
        color: Color(0xff13CC5D),
        width: double.infinity,
        height: 60,
      ),
    );
  }
}
