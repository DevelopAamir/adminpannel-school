import 'package:adminpannel/Attendancepages/takeSatt.dart';
import 'package:adminpannel/SchoolAdmin/Connector/getData.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:adminpannel/Storage/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllAttendance extends StatefulWidget {
  const AllAttendance({Key? key}) : super(key: key);

  @override
  _AllAttendanceState createState() => _AllAttendanceState();
}

class _AllAttendanceState extends State<AllAttendance> {
  var label = 'Staff';
  var _class = 10;
  Future getToken(context) async {
    var token = await Store().getData('id');
    Provider.of<SchoolProvider>(context, listen: false).getId(token);
    return token;
  }

  @override
  void initState() {
    getToken(context).then((v) {
      if (v == null) {
        Navigator.pushNamed(context, '/Login');
      } else {
        GetData().getAttendance(context, label.toString());
      }
    });

    super.initState();
  }

  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Text('Attendance'),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                        items: <String>[
                          'Staff',
                          'Students',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                            ),
                          );
                        }).toList(),
                        onChanged: (_) async {
                          setState(() {
                            label = _.toString();
                          });
                          // await GetData().getAttendance(context, label);
                        },
                        hint: Text(
                          label,
                          style: TextStyle(color: Colors.black),
                        ),
                        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(
                        context, '/Attendance/Takeattendance');
                  },
                  child: Container(
                    height: 35,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Take Att',
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(Icons.person, color: Colors.black)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            TopBar(),
            Expanded(
              child: Container(
                child: StreamBuilder(
                    stream: GetData()
                        .getAttendance(context, label.toString())
                        .asStream(),
                    builder: (BuildContext context, AsyncSnapshot snapShort) {
                      return snapShort.data == null
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Colors.green,
                            ))
                          : RefreshIndicator(
                              onRefresh: () {
                                setState(() {});
                                return GetData()
                                    .getAttendance(context, label.toString());
                              },
                              child: ListView.builder(
                                  itemCount: snapShort.data!.length,
                                  itemBuilder: (context, index) {
                                    return Cards(
                                        sn: '${index + 1}',
                                        date: snapShort.data['${index + 1}']
                                                ['Date']
                                            .toString(),
                                        name: snapShort.data['${index + 1}']
                                                ['Name']
                                            .toString(),
                                        status: snapShort.data['${index + 1}']
                                                ['Status']
                                            .toString(),
                                        day: snapShort.data['${index + 1}']
                                                ['Day']
                                            .toString());
                                  }),
                            );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Cards extends StatelessWidget {
  final sn;
  final date;
  final name;
  final status;
  final day;
  const Cards({
    Key? key,
    required this.sn,
    required this.date,
    required this.name,
    required this.status,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    sn,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    day,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    date,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    status,
                    style: TextStyle(color: Colors.black),
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
          padding: const EdgeInsets.only(left: 10, right: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Container(
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'SN',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Name',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Day',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Date',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Status',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ]),
        ),
        color: Colors.white,
        width: double.infinity,
        height: 55,
      ),
    );
  }
}
