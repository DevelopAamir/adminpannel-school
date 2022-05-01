import 'package:adminpannel/SchoolAdmin/Connector/getData.dart';
import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:adminpannel/Storage/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

class TakeSatt extends StatefulWidget {
  const TakeSatt({Key? key}) : super(key: key);

  @override
  _TakeSattState createState() => _TakeSattState();
}

class _TakeSattState extends State<TakeSatt> {
  Future getToken(context) async {
    var token = await Store().getData('id');
    Provider.of<SchoolProvider>(context, listen: false).getId(token);
    return token;
  }

  @override
  void initState() {
    getToken(context).then((value) {
      if (value == null) {
        Navigator.pushNamed(context, '/Login');
      } else {
        GetData()
            .getUsersByClassAndType(grade: label, context: context, type: type)
            .then((value) {
          setState(() {
            spin = false;
          });
        });
        print(Provider.of<SchoolProvider>(context, listen: false)
            .admin['$type' + '_Attendance']
            .toString());
      }
    });

    super.initState();
  }

  var checkboxValue = false;
  var label = '1';
  var type = 'Students';
  var spin = true;
  @override
  Widget build(BuildContext context) {
    var data = context.watch<SchoolProvider>().admin['$type' + '_Attendance'];
    return spin == true
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color(0xff9DFCA7),
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
                          color: Color(0xff56F653),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Class '),
                            DropdownButton<String>(
                              items: <String>[
                                '1',
                                '2',
                                '3',
                                '4',
                                '5',
                                '6',
                                '7',
                                '8',
                                '9',
                                '10',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                              onChanged: (_) {
                                setState(() {
                                  spin = true;
                                  label = _.toString();
                                });
                                print(label);
                                GetData()
                                    .getUsersByClassAndType(
                                        grade: label,
                                        context: context,
                                        type: type)
                                    .then((value) {
                                  spin = false;
                                });
                              },
                              hint: Text(
                                label,
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Colors.white),
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
                            DropdownButton<String>(
                              items: <String>[
                                'Students',
                                'Staff',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                              onChanged: (_) {
                                setState(() {
                                  spin = true;
                                  type = _.toString();
                                });
                                GetData()
                                    .getUsersByClassAndType(
                                        grade: label,
                                        context: context,
                                        type: type)
                                    .then((value) {
                                  setState(() {
                                    spin = false;
                                  });
                                });
                              },
                              hint: Text(
                                type,
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Colors.white),
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
              child: Column(
                children: [
                  TopBar(),
                  Expanded(
                    child: data.toString() != '{}'
                        ? Container(
                            child: ListView.builder(
                                itemCount: context
                                    .watch<SchoolProvider>()
                                    .admin['${type}_Attendance']
                                    .length,
                                itemBuilder: (context, i) {
                                  int reverseIndex = context
                                          .watch<SchoolProvider>()
                                          .admin['${type}_Attendance']
                                          .length -
                                      1 -
                                      i;
                                  return Cards(
                                    sn: '${i + 1}',
                                    date: DateFormat('yyyy-MM-dd')
                                        .format(DateTime.now())
                                        .toString(),
                                    name: data['${i + 1}']['Name'].toString(),
                                    day: DateFormat('EEEE')
                                        .format(DateTime.now())
                                        .toString(),
                                    getStatus: (a) {
                                      setState(() {
                                        checkboxValue == false
                                            ? checkboxValue = true
                                            : checkboxValue = false;
                                      });
                                    },
                                    type: type,
                                    grade: label,
                                  );
                                }))
                        : Container(
                            child: Center(
                                child: Text('No Registered User Available'))),
                  ),
                  CupertinoButton(
                      color: Colors.green,
                      child: Text('Submit'),
                      onPressed: () {
                        Upload().uploadAttendanceSheet(
                            Provider.of<SchoolProvider>(context, listen: false)
                                .attendanceToBeSend,
                            context);
                      })
                ],
              ),
            ),
          );
  }
}

class Cards extends StatefulWidget {
  final sn;
  final date;
  final name;
  final day;
  final getStatus;
  final type;
  final grade;

  const Cards({
    Key? key,
    required this.sn,
    required this.date,
    required this.name,
    required this.day,
    required this.getStatus,
    required this.type,
    required this.grade,
  }) : super(key: key);

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  var present = false;
  @override
  void initState() {
    GetData().getAttendance(context, widget.type).then((value) {
      Map<String, Object?> dataToBeUploaded = {
        '${value.length + int.parse(widget.sn)}': {
          'Name': widget.name,
          'Class': widget.grade,
          'Day': widget.day,
          'Date': widget.date,
          'Type': widget.type,
          'Status': present
        }
      };
      Provider.of<SchoolProvider>(context, listen: false)
          .setStudentRegister(dataToBeUploaded);
      print(Provider.of<SchoolProvider>(context, listen: false)
          .attendanceToBeSend);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffB2EAFF),
      child: Padding(
        padding: const EdgeInsets.all(
          10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                child: Text(
                  widget.sn,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: Text(
                    widget.name,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  widget.day,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  widget.date,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 15.0,
                  ),
                  child: Checkbox(
                      value: present,
                      onChanged: (v) {
                        setState(() {
                          present == false ? present = true : present = false;
                        });
                        GetData().getAttendance(context, widget.type).then((a) {
                          Map<String, Object?> dataToBeUploaded = {
                            '${a.length + int.parse(widget.sn)}': {
                              'Name': widget.name,
                              'Class': widget.grade,
                              'Day': widget.day,
                              'Date': widget.date,
                              'Type': widget.type,
                              'Status': present
                            }
                          };
                          Provider.of<SchoolProvider>(context, listen: false)
                              .setStudentRegister(dataToBeUploaded);
                          print(Provider.of<SchoolProvider>(context,
                                  listen: false)
                              .attendanceToBeSend);
                        });
                      }),
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
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'S.N',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Name',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Day',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Date',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Status',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ]),
        color: Color(0xff9DFCA7),
        width: double.infinity,
        height: 60,
      ),
    );
  }
}
