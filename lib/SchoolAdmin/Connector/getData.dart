import 'dart:developer';

import 'package:adminpannel/Agora/agora.dart';
import 'package:adminpannel/Attendancepages/AllAttendance.dart';
import 'package:adminpannel/Attendancepages/takeSatt.dart';
import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/ApplicationCard.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Textfiel.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/dropdown.dart';
import 'package:adminpannel/SchoolAdmin/class.dart';
import 'package:adminpannel/SchoolAdmin/objects/studentDatail.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:adminpannel/SchoolAdmin/showResult.dart';
import 'package:adminpannel/Storage/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adminpannel/Attendancepages/takeSatt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Maps/Map.dart';
import '../Pages.dart/document.dart';

class GetData {
  final firestore = FirebaseFirestore.instance;

  Future getData(context) async {
    final iD = await Store().getData('id');
    final role = await Store().getData('role');
    try {
      if (role != 'Staff') {
        await firestore.collection('ADMIN').doc(iD).get().then((value) {
          Provider.of<SchoolProvider>(context, listen: false)
              .getAdminAllData(value.data());
          //print(value.data()!['Information']);
        });
      } else {
        await firestore
            .collection(
                Provider.of<SchoolProvider>(context, listen: false).info.name)
            .doc('Staff')
            .collection(DateTime.now().year.toString())
            .doc(iD)
            .get()
            .then((value) {
          Provider.of<SchoolProvider>(context, listen: false)
              .getAdminAllData(value.data());
        });
      }
    } catch (e) {}
  }

  Future getPofile(context) async {
    final iD = await Store().getData('id');
    try {
      await firestore.collection('ADMIN').doc(iD).get().then((value) {
        var data = value.data()!['Information'];
        Provider.of<SchoolProvider>(context, listen: false)
            .getAdminProfile(data);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<int> getTotalStudent(context) async {
    final firestore = FirebaseFirestore.instance;
    var u = 0;

    await firestore
        .collection(
            Provider.of<SchoolProvider>(context, listen: false).info.name)
        .doc('Classes')
        .collection('RegisteredClasses')
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        var class_ = element.data()['class'].toString() +
            element.data()['section'].toString();
        int use = 0;

        await firestore
            .collection(
                Provider.of<SchoolProvider>(context, listen: false).info.name)
            .doc('Academics')
            .collection(class_)
            .doc('Students')
            .collection(DateTime.now().year.toString())
            .get()
            .then((val) {
          use = 80;
        });
        u = u + use;
      });
    });
    print(u);
    return u;
  }

  Future<int> getTotalStaff(context) async {
    final firestore = FirebaseFirestore.instance;
    int user = 0;
    await firestore
        .collection(
            Provider.of<SchoolProvider>(context, listen: false).info.name)
        .doc('Staff')
        .collection(DateTime.now().year.toString())
        .get()
        .then((value) {
      print(value.docs[0].toString());
      value.docs.forEach((element) {
        user++;
      });
    });

    return user;
  }

  Future<int> getClasses(context) async {
    final firestore = FirebaseFirestore.instance;
    int user = 0;
    await firestore
        .collection(
            Provider.of<SchoolProvider>(context, listen: false).info.name)
        .doc('Classes')
        .collection('RegisteredClasses')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        user++;
      });
    });
    return user;
  }

  Future<Map> getAttendance(context, type) async {
    final firestore = FirebaseFirestore.instance;
    var schoolName =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    var map;
    try {
      var amap =
          await firestore.collection(schoolName).doc('AttendanceHistory').get();

      map = amap.data();

      print(amap.data());
    } catch (e) {}
    return map;
  }

  Future getUsersByClassAndType(
      {required grade, required BuildContext context, required type}) async {
    if (type == 'Staff') {
      try {
        var schoolName =
            Provider.of<SchoolProvider>(context, listen: false).info.name;
        var response =
            await firestore.collection(schoolName).doc('Attendance').get();
        var data = {};
        for (var i = 0; i < response.data()!.length; i++) {
          if (response.data()![i.toString()]['Type'] == type) {
            data.addAll({'${data.length + 1}': response.data()![i.toString()]});
          }
        }
        Provider.of<SchoolProvider>(context, listen: false)
            .getAdminAttendance(data, type);
        print(data.toString());
      } catch (e) {
        print(e);
      }
    } else {
      try {
        var schoolName =
            Provider.of<SchoolProvider>(context, listen: false).info.name;
        var response =
            await firestore.collection(schoolName).doc('Attendance').get();
        var data = {};
        for (var i = 0; i < response.data()!.length; i++) {
          if (response.data()![i.toString()]['Class'] == grade) {
            data.addAll({'${data.length + 1}': response.data()![i.toString()]});
          }
        }
        Provider.of<SchoolProvider>(context, listen: false)
            .getAdminAttendance(data, type);
        print(Provider.of<SchoolProvider>(context, listen: false)
            .admin['${type}_Attendance']);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<Widget> getClassRecords(
      {required context, required class_, required section}) async {
    var schoolName =
        Provider.of<SchoolProvider>(context, listen: false).info.name;

    return StreamBuilder(
      stream: firestore
          .collection(schoolName)
          .doc('Academics')
          .collection(class_ + section)
          .doc('Students')
          .collection(DateTime.now().year.toString())
          .snapshots(),
      builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Alert'),
                                content: Text(snapshot.data!.docs.reversed
                                    .toList()[i]['Information']['Name']),
                                actions: [
                                  OutlinedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Back')),
                                  OutlinedButton(
                                      onPressed: () {
                                        snapshot.data!.docs.reversed
                                            .toList()[i]
                                            .reference
                                            .delete();

                                        Navigator.pop(context);
                                      },
                                      child: Text('Delete'))
                                ],
                              );
                            });
                      },
                      onTap: () {
                        QueryDocumentSnapshot<Object?> value =
                            snapshot.data!.docs.reversed.toList()[i];
                        final data = StudentDetail(
                            value['Information']['Name'],
                            value['Information']['Class'],
                            value['Information']['Rollno'],
                            value['Information']['Section'],
                            value['Information']['Father_Name'],
                            value['Information']['Mother_Name'],
                            value['Information']['Father_No'],
                            value['Information']['Mother_No'],
                            value['Information']['Parents_Name'],
                            value['Information']['Parents_No'],
                            value['Information']['Temp_Address'],
                            value['Information']['Per_Address'],
                            value['Information']['DOB'],
                            value['Information']['Phone_No'],
                            value['Information']['Profile_Pic'],
                            value['Information']['Fee'],
                            '',
                            value['Information']['password'],
                            'Test@ahna Just Use The Right', //TODO: just pass right parameter here
                            value.reference.collection('Submission'));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentDetails(
                                      data: data,
                                      studentPath: value,
                                    )));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                    height: 150,
                                    child: Image.network(
                                        snapshot.data!.docs.reversed.toList()[i]
                                            ['Information']['Profile_Pic'])),
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ListTile(
                                        title: Text('Name : ' +
                                            snapshot.data!.docs.reversed
                                                    .toList()[i]['Information']
                                                ['Name'])),
                                    ListTile(
                                        title: Text('Class : ' +
                                            snapshot.data!.docs.reversed
                                                    .toList()[i]['Information']
                                                ['Class'])),
                                    ListTile(
                                        title: Text('Roll no : ' +
                                            snapshot.data!.docs.reversed
                                                    .toList()[i]['Information']
                                                ['Rollno'])),
                                    ListTile(
                                        title: Text('Section : ' +
                                            snapshot.data!.docs.reversed
                                                    .toList()[i]['Information']
                                                ['Section']))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })
            : Container();
      }),
    );
  }

  Future<Widget> getStaffRecords(
      {required context, required class_, required section}) async {
    var schoolName =
        Provider.of<SchoolProvider>(context, listen: false).info.name;

    return StreamBuilder(
      stream: firestore
          .collection(schoolName)
          .doc('Staff')
          .collection(DateTime.now().year.toString())
          .snapshots(),
      builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return StaffDetail(
                            path: snapshot.data!.docs.reversed.toList()[i],
                          );
                        }));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ListTile(
                                  leading: Image.network(snapshot
                                      .data!.docs.reversed
                                      .toList()[i]['Information']['Profile_Pic']
                                      .toString()),
                                  title: Text('Name : ' +
                                      snapshot.data!.docs.reversed
                                          .toList()[i]['Information']['Name']
                                          .toString())),
                              ListTile(
                                  title: Text('Phone no : ' +
                                      snapshot.data!.docs.reversed
                                          .toList()[i]['Information']
                                              ['Phone_No']
                                          .toString())),
                              ListTile(
                                  title: Text('Address : ' +
                                      snapshot.data!.docs.reversed
                                          .toList()[i]['Information']
                                              ['Per_Address']
                                          .toString())),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })
            : Container();
      }),
    );
  }

  Widget getHomework(context, class_, section) {
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;

    return StreamBuilder(
        stream: firestore
            .collection(school)
            .doc('Academics')
            .collection(class_ + section)
            .doc('HomeWorks')
            .collection(DateTime.now().year.toString())
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? HomeWorkBuilder(
                  snapshot: snapshot,
                  submissionSnapshot: firestore
                      .collection(school)
                      .doc('Academics')
                      .collection(class_ + section)
                      .doc('HomeWorks')
                      .collection(DateTime.now().year.toString()),
                )
              : Container();
        });
  }

  Widget getStudyMaterial(context, class_, section) {
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    return StreamBuilder(
        stream: firestore
            .collection(school)
            .doc('Academics')
            .collection(class_ + section)
            .doc('StudyMaterials')
            .collection(DateTime.now().year.toString())
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Upload().getMedia(snapshot.data!.docs.reversed
                                  .toList()[i]['Attachment']);
                            },
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title:
                                          Text('Do You Really Want To Delete'),
                                      content: ListTile(
                                        title: Text(
                                          snapshot.data!.docs.reversed
                                              .toList()[i]['title'],
                                        ),
                                        subtitle: Text(snapshot
                                            .data!.docs.reversed
                                            .toList()[i]['Description']),
                                      ),
                                      actions: [
                                        OutlinedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Back')),
                                        OutlinedButton(
                                            onPressed: () async {
                                              await firestore
                                                  .collection(school)
                                                  .doc('Academics')
                                                  .collection(class_ + section)
                                                  .doc('StudyMaterials')
                                                  .collection(DateTime.now()
                                                      .year
                                                      .toString())
                                                  .doc(snapshot
                                                      .data!.docs.reversed
                                                      .toList()[i]
                                                      .id)
                                                  .delete();
                                              Navigator.pop(context);
                                            },
                                            child: Text('yes')),
                                      ],
                                    );
                                  });
                            },
                            title: Text(
                              snapshot.data!.docs.reversed.toList()[i]
                                      ['title'] +
                                  ' (${snapshot.data!.docs.reversed.toList()[i]['subject']})',
                            ),
                            subtitle: Text(snapshot.data!.docs.reversed
                                .toList()[i]['Description']),
                            trailing: OutlinedButton(
                              child: Text('View'),
                              onPressed: () {
                                Upload().getMedia(snapshot.data!.docs.reversed
                                    .toList()[i]['Attachment']);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  })
              : Container();
        });
  }

  Widget getNotices(context, class_, section) {
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    return StreamBuilder(
        stream: firestore
            .collection(school)
            .doc('Academics')
            .collection(class_ + section)
            .doc('Notices')
            .collection(DateTime.now().year.toString())
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Upload().getMedia(snapshot.data!.docs.reversed
                                  .toList()[i]['Attachment']);
                            },
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title:
                                          Text('Do You Really Want To Delete'),
                                      content: ListTile(
                                        title: Text(
                                          snapshot.data!.docs.reversed
                                              .toList()[i]['title'],
                                        ),
                                        subtitle: Text(snapshot
                                            .data!.docs.reversed
                                            .toList()[i]['Description']),
                                      ),
                                      actions: [
                                        OutlinedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Back')),
                                        OutlinedButton(
                                            onPressed: () async {
                                              await firestore
                                                  .collection(school)
                                                  .doc('Academics')
                                                  .collection(class_ + section)
                                                  .doc('Notices')
                                                  .collection(DateTime.now()
                                                      .year
                                                      .toString())
                                                  .doc(snapshot
                                                      .data!.docs.reversed
                                                      .toList()[i]
                                                      .id)
                                                  .delete();
                                              Navigator.pop(context);
                                            },
                                            child: Text('yes')),
                                      ],
                                    );
                                  });
                            },
                            title: Text(snapshot.data!.docs.reversed.toList()[i]
                                ['title']),
                            subtitle: Text(snapshot.data!.docs.reversed
                                .toList()[i]['Description']),
                            trailing: OutlinedButton(
                              child: Text('View'),
                              onPressed: () {
                                Upload().getMedia(snapshot.data!.docs.reversed
                                    .toList()[i]['Attachment']);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  })
              : Container();
        });
  }

  Widget getAttendances(context, class_, section, date) {
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    return StreamBuilder(
        stream: firestore
            .collection(school)
            .doc('Academics')
            .collection(class_ + section)
            .doc('Attendance')
            .collection(DateTime.now().year.toString())
            .doc('daily')
            .collection(date)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? Column(
                  children: [
                    Card(
                      color: Color.fromARGB(255, 35, 89, 109),
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
                                  'Roll No',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 2.0, height: 12, color: Colors.white),
                            ),
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20.0,
                                  ),
                                  child: Text(
                                    'Name',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 2.0, height: 12, color: Colors.white),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  'Day',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 2.0, height: 12, color: Colors.white),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  'Date',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 2.0, height: 12, color: Colors.white),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  'Status',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, i) {
                            return Cards1(
                              sn: snapshot.data!.docs.reversed.toList()[i]
                                  ['Rollno'],
                              date: snapshot.data!.docs.reversed.toList()[i]
                                  ['Date'],
                              name: snapshot.data!.docs.reversed.toList()[i]
                                  ['Name'],
                              status: snapshot.data!.docs.reversed.toList()[i]
                                      ['Status'] ==
                                  'P',
                              day: snapshot.data!.docs.reversed.toList()[i]
                                  ['Day'],
                              getStatus: snapshot.data!.docs.reversed
                                      .toList()[i]['Status'] ==
                                  'P',
                              grade: snapshot.data!.docs.reversed.toList()[i]
                                  ['Grade'],
                              type: '',
                              onChanged: (a) async {
                                await firestore
                                    .collection(school)
                                    .doc('Academics')
                                    .collection(class_ + section)
                                    .doc('Attendance')
                                    .collection(DateTime.now().year.toString())
                                    .doc('daily')
                                    .collection(date == null
                                        ? DateFormat('yyyy-MM-dd')
                                            .format(DateTime.now())
                                            .toString()
                                        : date)
                                    .doc(snapshot.data!.docs.reversed
                                        .toList()[i]
                                        .id)
                                    .update({
                                  'Rollno': snapshot.data!.docs.reversed
                                      .toList()[i]['Rollno'],
                                  'Name': snapshot.data!.docs.reversed
                                      .toList()[i]['Name'],
                                  'Date': snapshot.data!.docs.reversed
                                      .toList()[i]['Date'],
                                  'Day': snapshot.data!.docs.reversed
                                      .toList()[i]['Day'],
                                  'Status': snapshot.data!.docs.reversed
                                              .toList()[i]['Status'] ==
                                          'A'
                                      ? 'P'
                                      : 'A',
                                  'Grade': snapshot.data!.docs.reversed
                                      .toList()[i]['Grade'],
                                });
                              },
                            );
                          }),
                    ),
                  ],
                )
              : Container();
        });
  }

  Widget getStaffAttendances(context, class_, section, date) {
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    return StreamBuilder(
        stream: firestore
            .collection(school)
            // .doc('Academics')
            // .collection(class_ + section)
            .doc('StaffAttendance')
            .collection(DateTime.now().year.toString())
            .doc('daily')
            .collection(date)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? Column(
                  children: [
                    Card(
                      color: Color.fromARGB(255, 35, 89, 109),
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
                                  'S.N',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 2.0, height: 12, color: Colors.white),
                            ),
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20.0,
                                  ),
                                  child: Text(
                                    'Name',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 2.0, height: 12, color: Colors.white),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  'Day',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 2.0, height: 12, color: Colors.white),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  'DateTime',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 2.0, height: 12, color: Colors.white),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  'Status',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, i) {
                            return Cards1(
                              sn: "${i + 1}",
                              date: snapshot.data!.docs.reversed.toList()[i]
                                  ['Date'],
                              name: snapshot.data!.docs.reversed.toList()[i]
                                  ['Name'],
                              status: snapshot.data!.docs.reversed.toList()[i]
                                      ['Status'] ==
                                  'P',
                              day: snapshot.data!.docs.reversed.toList()[i]
                                  ['Day'],
                              getStatus: snapshot.data!.docs.reversed
                                      .toList()[i]['Status'] ==
                                  'P',
                              grade: '',
                              type: '',
                              onChanged: (a) async {
                                await firestore
                                    .collection(school)
                                    // .doc('Academics')
                                    // .collection(class_ + section)
                                    .doc('StaffAttendance')
                                    .collection(DateTime.now().year.toString())
                                    .doc('daily')
                                    .collection(date == null
                                        ? DateFormat('yyyy-MM-dd')
                                            .format(DateTime.now())
                                            .toString()
                                        : date)
                                    .doc(snapshot.data!.docs.reversed
                                        .toList()[i]
                                        .id)
                                    .update({
                                  'Name': snapshot.data!.docs.reversed
                                      .toList()[i]['Name'],
                                  'Date': snapshot.data!.docs.reversed
                                          .toList()[i]['Date']
                                          .toString()
                                          .contains(' ')
                                      ? snapshot.data!.docs.reversed
                                              .toList()[i]['Date']
                                              .toString()
                                              .split(' ')
                                              .first +
                                          ' ' +
                                          DateFormat('hh:mm')
                                              .format(DateTime.now())
                                              .toString()
                                      : snapshot.data!.docs.reversed.toList()[i]
                                              ['Date'] +
                                          ' ' +
                                          DateFormat('hh:mm')
                                              .format(DateTime.now())
                                              .toString(),
                                  'Day': snapshot.data!.docs.reversed
                                      .toList()[i]['Day'],
                                  'Status': snapshot.data!.docs.reversed
                                              .toList()[i]['Status'] ==
                                          'A'
                                      ? 'P'
                                      : 'A',
                                  'Per_Address': snapshot.data!.docs.reversed
                                      .toList()[i]['Per_Address'],
                                  'DOB': snapshot.data!.docs.reversed
                                      .toList()[i]['DOB'],
                                  'Phone_No': snapshot.data!.docs.reversed
                                      .toList()[i]['Phone_No'],
                                });
                              },
                            );
                          }),
                    ),
                  ],
                )
              : Container();
        });
  }

  Widget getExam(context, class_, section) {
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    return StreamBuilder(
        stream: firestore
            .collection(school)
            .doc('Academics')
            .collection(class_ + section)
            .doc('Exams')
            .collection(DateTime.now().year.toString())
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              launch(snapshot.data!.docs.reversed.toList()[i]
                                  ['url']);
                            },
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title:
                                          Text('Do You Really Want To Delete'),
                                      content: ListTile(
                                        title: Text(
                                          snapshot.data!.docs.reversed
                                              .toList()[i]['title'],
                                        ),
                                        subtitle: Text('Subject : ' +
                                            snapshot.data!.docs.reversed
                                                .toList()[i]['subject']),
                                      ),
                                      actions: [
                                        OutlinedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Back')),
                                        OutlinedButton(
                                            onPressed: () async {
                                              await firestore
                                                  .collection(school)
                                                  .doc('Academics')
                                                  .collection(class_ + section)
                                                  .doc('Exams')
                                                  .collection(DateTime.now()
                                                      .year
                                                      .toString())
                                                  .doc(snapshot
                                                      .data!.docs.reversed
                                                      .toList()[i]
                                                      .id)
                                                  .delete();
                                              Navigator.pop(context);
                                            },
                                            child: Text('yes')),
                                      ],
                                    );
                                  });
                            },
                            title: Text(snapshot.data!.docs.reversed.toList()[i]
                                    ['title'] +
                                ' (${snapshot.data!.docs.reversed.toList()[i]['subject']})'),
                            subtitle: Text('exam_date'),
                          ),
                        ],
                      ),
                    );
                  })
              : Container();
        });
  }

  Widget getResult(context, class_, section) {
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    return StreamBuilder(
        stream: firestore
            .collection(school)
            .doc('Academics')
            .collection(class_ + section)
            .doc('Results')
            .collection(DateTime.now().year.toString())
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  //
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    return snapshot.data!.docs.reversed
                            .toList()[i]
                            .id
                            .contains('Positions')
                        ? Container()
                        : Card(
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ShowResult(
                                                class_: class_,
                                                section: section,
                                                data: snapshot
                                                    .data!.docs.reversed
                                                    .toList()[i])));
                                  },
                                  trailing: StreamBuilder(
                                      stream: snapshot.data!.docs.reversed
                                          .toList()[i]
                                          .reference
                                          .collection('hidden')
                                          .doc('hidden')
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<
                                                  DocumentSnapshot<
                                                      Map<String, dynamic>>>
                                              sna) {
                                        return IconButton(
                                            onPressed: () {
                                              sna.data!.data()!['hidden']
                                                  ? snapshot.data!.docs.reversed
                                                      .toList()[i]
                                                      .reference
                                                      .collection('hidden')
                                                      .doc('hidden')
                                                      .update({'hidden': false})
                                                  : snapshot.data!.docs.reversed
                                                      .toList()[i]
                                                      .reference
                                                      .collection('hidden')
                                                      .doc('hidden')
                                                      .update({'hidden': true});
                                            },
                                            icon: sna.hasData &&
                                                    sna.data!.data()!['hidden']
                                                ? Icon(Icons.visibility_off)
                                                : Icon(Icons.visibility));
                                      }),
                                  onLongPress: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                                'Do You Really Want To Delete'),
                                            content: ListTile(
                                              title: Text(
                                                snapshot.data!.docs.reversed
                                                        .toList()[i]['Info']
                                                    ['name'],
                                              ),
                                            ),
                                            actions: [
                                              OutlinedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Back')),
                                              OutlinedButton(
                                                  onPressed: () async {
                                                    await firestore
                                                        .collection(school)
                                                        .doc('Academics')
                                                        .collection(
                                                            class_ + section)
                                                        .doc('Results')
                                                        .collection(
                                                            DateTime.now()
                                                                .year
                                                                .toString())
                                                        .doc(snapshot.data!.docs
                                                                        .reversed
                                                                        .toList()[
                                                                    i]['Info']
                                                                ['ExamName'] +
                                                            'Positions')
                                                        .get()
                                                        .then((value) {
                                                      List pd = value
                                                          .data()!['Positions'];
                                                      print(value
                                                          .data()
                                                          .toString());
                                                      pd.removeWhere(
                                                          (element) =>
                                                              element[
                                                                  'roll_no'] ==
                                                              snapshot.data!
                                                                          .docs[
                                                                      i]['Info']
                                                                  ['rollno']);
                                                      value.reference.update(
                                                          {'Positions': pd});
                                                    });

                                                    await firestore
                                                        .collection(school)
                                                        .doc('Academics')
                                                        .collection(
                                                            class_ + section)
                                                        .doc('Results')
                                                        .collection(
                                                            DateTime.now()
                                                                .year
                                                                .toString())
                                                        .doc(snapshot
                                                            .data!.docs.reversed
                                                            .toList()[i]
                                                            .id)
                                                        .delete();

                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('yes')),
                                            ],
                                          );
                                        });
                                  },
                                  title: Text(snapshot.data!.docs.reversed
                                      .toList()[i]['Info']['name']),
                                  subtitle: Text(snapshot.data!.docs.reversed
                                      .toList()[i]['Info']['ExamName']),
                                ),
                              ],
                            ),
                          );
                  })
              : Container();
        });
  }

  Widget getLeaveRequests(context, class_, section) {
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    return StreamBuilder(
        stream: firestore
            .collection(school)
            .doc('Academics')
            .collection(class_ + section)
            .doc('Application')
            .collection(DateTime.now().year.toString())
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    return ApplicationCard(
                      onApprove: () {
                        print('Approved');
                        snapshot.data!.docs[i].reference.update({
                          'Date': snapshot.data!.docs[i]['Date'],
                          'Status': 'Approved',
                          'describe': snapshot.data!.docs[i]['describe'],
                          'endDate': snapshot.data!.docs[i]['endDate'],
                          'name': snapshot.data!.docs[i]['name'],
                          'roll_no': snapshot.data!.docs[i]['roll_no'],
                          'startDate': snapshot.data!.docs[i]['startDate'],
                          'text': snapshot.data!.docs[i]['text'],
                          'message': Provider.of<SchoolProvider>(context,
                                  listen: false)
                              .message
                        });
                      },
                      onUnApprove: () {
                        print('Unapproved');
                        snapshot.data!.docs[i].reference.update({
                          'Date': snapshot.data!.docs[i]['Date'],
                          'Status': 'Rejected',
                          'describe': snapshot.data!.docs[i]['describe'],
                          'endDate': snapshot.data!.docs[i]['endDate'],
                          'name': snapshot.data!.docs[i]['name'],
                          'roll_no': snapshot.data!.docs[i]['roll_no'],
                          'startDate': snapshot.data!.docs[i]['startDate'],
                          'text': snapshot.data!.docs[i]['text'],
                          'message': Provider.of<SchoolProvider>(context,
                                  listen: false)
                              .message
                        });
                      },
                      data: snapshot.data!.docs[i],
                    );
                  })
              : Container();
        });
  }

  Widget getRoutine(context, class_, section) {
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    return StreamBuilder(
        stream: firestore
            .collection(school)
            .doc('Academics')
            .collection(class_ + section)
            .doc('Routine')
            .collection(DateTime.now().year.toString())
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            onLongPress: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title:
                                          Text('Do You Really Want To Delete'),
                                      content: ListTile(
                                        title: Text(
                                          snapshot.data!.docs.reversed
                                              .toList()[i]['title'],
                                        ),
                                      ),
                                      actions: [
                                        OutlinedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Back')),
                                        OutlinedButton(
                                            onPressed: () async {
                                              await firestore
                                                  .collection(school)
                                                  .doc('Academics')
                                                  .collection(class_ + section)
                                                  .doc('Routine')
                                                  .collection(DateTime.now()
                                                      .year
                                                      .toString())
                                                  .doc(snapshot
                                                      .data!.docs.reversed
                                                      .toList()[i]
                                                      .id)
                                                  .delete();
                                              Navigator.pop(context);
                                            },
                                            child: Text('yes')),
                                      ],
                                    );
                                  });
                            },
                            onTap: () {
                              Upload().getMedia(snapshot.data!.docs.reversed
                                  .toList()[i]['file']);
                            },
                            title: Text(
                              snapshot.data!.docs.reversed.toList()[i]['title'],
                            ),
                            subtitle: Text(snapshot.data!.docs.reversed
                                .toList()[i]['Date_Added']),
                          ),
                        ],
                      ),
                    );
                  })
              : Container();
        });
  }

  Widget getLiveClass(context, class_, section) {
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    return StreamBuilder(
        stream: firestore
            .collection(school)
            .doc('Academics')
            .collection(class_ + section)
            .doc('LiveClass')
            .collection(DateTime.now().year.toString())
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? Builder(builder: (context) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, i) {
                        return Card(
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () async {
                                  final _auth = FirebaseAuth.instance;
                                  if (snapshot.data!.docs.reversed.toList()[i]
                                              ['Host'] ==
                                          _auth.currentUser!.email ||
                                      snapshot.data!.docs.reversed.toList()[i]
                                              ['status'] ==
                                          'Running') {
                                    await firestore
                                        .collection(school)
                                        .doc('Academics')
                                        .collection(class_ + section)
                                        .doc('LiveClass')
                                        .collection(
                                            DateTime.now().year.toString())
                                        .doc(snapshot.data!.docs.reversed
                                            .toList()[i]
                                            .id)
                                        .update({
                                      'Date_Added': snapshot.data!.docs.reversed
                                          .toList()[i]['Date_Added'],
                                      'status': 'Running',
                                      'date': snapshot.data!.docs.reversed
                                          .toList()[i]['date'],
                                      'title': snapshot.data!.docs.reversed
                                          .toList()[i]['title'],
                                    });
                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder: (context) {
                                    //   return AgoraSDK(
                                    //     channel: '15',
                                    //     class_: class_,
                                    //     section: section,
                                    //   );
                                    // }));
                                    launch(
                                        'https://e-conference.000webhostapp.com/8-2?url=${snapshot.data!.docs.reversed.toList()[i]['channelid']}');
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'No Class Are Currently Running');
                                  }
                                },
                                onLongPress: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Do You Really Want To Delete'),
                                          content: ListTile(
                                            title: Text(
                                              snapshot.data!.docs.reversed
                                                  .toList()[i]['title'],
                                            ),
                                          ),
                                          actions: [
                                            OutlinedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Back')),
                                            OutlinedButton(
                                                onPressed: () {
                                                  firestore
                                                      .collection(school)
                                                      .doc('Academics')
                                                      .collection(
                                                          class_ + section)
                                                      .doc('LiveClass')
                                                      .collection(DateTime.now()
                                                          .year
                                                          .toString())
                                                      .doc(snapshot
                                                          .data!.docs.reversed
                                                          .toList()[i]
                                                          .id)
                                                      .delete();
                                                  Navigator.pop(context);
                                                },
                                                child: Text('yes')),
                                          ],
                                        );
                                      });
                                },
                                title: Text(
                                  snapshot.data!.docs.reversed.toList()[i]
                                      ['title'],
                                ),
                                subtitle: Text(snapshot.data!.docs.reversed
                                    .toList()[i]['date']),
                              ),
                            ],
                          ),
                        );
                      });
                })
              : Container();
        });
  }

  Widget getSubmission(snapshot) {
    List review = [];

    return StreamBuilder(
        stream: snapshot,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                              title: Text(
                                'Name : ' +
                                    snapshot.data!.docs.reversed.toList()[i]
                                        ['name'],
                              ),
                              contentPadding: EdgeInsets.all(2),
                              subtitle: Text(
                                'Roll no : ' +
                                    snapshot.data!.docs.reversed.toList()[i]
                                        ['roll_no'],
                                style: TextStyle(height: 2),
                              ),
                              trailing: Container(
                                  width: 200,
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            snapshot.data!.docs.reversed
                                                .toList()[i]
                                                .reference
                                                .update({
                                              'name': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['name'],
                                              'Date_submitted': snapshot
                                                      .data!.docs.reversed
                                                      .toList()[i]
                                                  ['Date_submitted'],
                                              'attachments': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['attachments'],
                                              'status': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['status'],
                                              'roll_no': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['roll_no'],
                                              'Remarks': [
                                                true,
                                                false,
                                                false,
                                                false,
                                                false,
                                              ],
                                              'Seen': false,
                                            });
                                          },
                                          child: Icon(snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['Remarks'][0]
                                              ? Icons.star
                                              : Icons.star_outline)),
                                      InkWell(
                                          onTap: () {
                                            snapshot.data!.docs.reversed
                                                .toList()[i]
                                                .reference
                                                .update({
                                              'name': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['name'],
                                              'Date_submitted': snapshot
                                                      .data!.docs.reversed
                                                      .toList()[i]
                                                  ['Date_submitted'],
                                              'attachments': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['attachments'],
                                              'status': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['status'],
                                              'roll_no': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['roll_no'],
                                              'Remarks': [
                                                true,
                                                true,
                                                false,
                                                false,
                                                false,
                                              ]
                                            });
                                          },
                                          child: Icon(snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['Remarks'][1]
                                              ? Icons.star
                                              : Icons.star_outline)),
                                      InkWell(
                                          onTap: () {
                                            snapshot.data!.docs.reversed
                                                .toList()[i]
                                                .reference
                                                .update({
                                              'name': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['name'],
                                              'Date_submitted': snapshot
                                                      .data!.docs.reversed
                                                      .toList()[i]
                                                  ['Date_submitted'],
                                              'attachments': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['attachments'],
                                              'status': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['status'],
                                              'roll_no': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['roll_no'],
                                              'Remarks': [
                                                true,
                                                true,
                                                true,
                                                false,
                                                false,
                                              ]
                                            });
                                          },
                                          child: Icon(snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['Remarks'][2]
                                              ? Icons.star
                                              : Icons.star_outline)),
                                      InkWell(
                                          onTap: () {
                                            snapshot.data!.docs.reversed
                                                .toList()[i]
                                                .reference
                                                .update({
                                              'name': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['name'],
                                              'Date_submitted': snapshot
                                                      .data!.docs.reversed
                                                      .toList()[i]
                                                  ['Date_submitted'],
                                              'attachments': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['attachments'],
                                              'status': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['status'],
                                              'roll_no': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['roll_no'],
                                              'Remarks': [
                                                true,
                                                true,
                                                true,
                                                true,
                                                false,
                                              ]
                                            });
                                          },
                                          child: Icon(snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['Remarks'][3]
                                              ? Icons.star
                                              : Icons.star_outline)),
                                      InkWell(
                                          onTap: () {
                                            snapshot.data!.docs.reversed
                                                .toList()[i]
                                                .reference
                                                .update({
                                              'name': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['name'],
                                              'Date_submitted': snapshot
                                                      .data!.docs.reversed
                                                      .toList()[i]
                                                  ['Date_submitted'],
                                              'attachments': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['attachments'],
                                              'status': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['status'],
                                              'roll_no': snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['roll_no'],
                                              'Remarks': [
                                                true,
                                                true,
                                                true,
                                                true,
                                                true,
                                              ]
                                            });
                                          },
                                          child: Icon(snapshot
                                                  .data!.docs.reversed
                                                  .toList()[i]['Remarks'][4]
                                              ? Icons.star
                                              : Icons.star_outline)),
                                    ],
                                  ))),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 8),
                            child: Divider(),
                          ),
                          Container(
                            height: 100,
                            width: double.infinity,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.reversed
                                    .toList()[i]['attachments']
                                    .length,
                                itemBuilder: (context, u) {
                                  return InkWell(
                                    onTap: () async {
                                      await Upload().getMedia(snapshot
                                          .data!.docs.reversed
                                          .toList()[i]['attachments'][u]);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                                color: Colors.green)),
                                        child: Card(
                                          elevation: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25, vertical: 8),
                                            child: Center(
                                                child: Icon(Icons.perm_media)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                      'Submitted Date : ${snapshot.data!.docs.reversed.toList()[i]['Date_submitted']}'),
                                  Container(
                                    width: 250,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: MaterialButton(
                                            color: snapshot.data!.docs.reversed
                                                            .toList()[i]
                                                        ['status'] ==
                                                    'Re_Do'
                                                ? Colors.red
                                                : Colors.green.shade100,
                                            child: Text('Re_Do'),
                                            onPressed: () async {
                                              await snapshot.data!.docs.reversed
                                                  .toList()[i]
                                                  .reference
                                                  .update({
                                                'name': snapshot
                                                    .data!.docs.reversed
                                                    .toList()[i]['name'],
                                                'Date_submitted': snapshot
                                                        .data!.docs.reversed
                                                        .toList()[i]
                                                    ['Date_submitted'],
                                                'attachments': snapshot
                                                    .data!.docs.reversed
                                                    .toList()[i]['attachments'],
                                                'status': 'Re_Do',
                                                'roll_no': snapshot
                                                    .data!.docs.reversed
                                                    .toList()[i]['roll_no'],
                                                'Remarks': snapshot
                                                    .data!.docs.reversed
                                                    .toList()[i]['Remarks']
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: MaterialButton(
                                            color: snapshot.data!.docs.reversed
                                                            .toList()[i]
                                                        ['status'] ==
                                                    'Approved'
                                                ? Colors.green
                                                : Colors.green.shade100,
                                            child: Text('Approve'),
                                            onPressed: () async {
                                              await snapshot.data!.docs.reversed
                                                  .toList()[i]
                                                  .reference
                                                  .update({
                                                'name': snapshot
                                                    .data!.docs.reversed
                                                    .toList()[i]['name'],
                                                'Date_submitted': snapshot
                                                        .data!.docs.reversed
                                                        .toList()[i]
                                                    ['Date_submitted'],
                                                'attachments': snapshot
                                                    .data!.docs.reversed
                                                    .toList()[i]['attachments'],
                                                'status': 'Approved',
                                                'roll_no': snapshot
                                                    .data!.docs.reversed
                                                    .toList()[i]['roll_no'],
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  })
              : Container();
        });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStudentsForAttendance(
      {required context, required class_, required section}) {
    var schoolName =
        Provider.of<SchoolProvider>(context, listen: false).info.name;

    return firestore
        .collection(schoolName)
        .doc('Academics')
        .collection(class_ + section)
        .doc('Students')
        .collection(DateTime.now().year.toString())
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStaffForAttendance(
      {required context, required class_, required section}) {
    var schoolName =
        Provider.of<SchoolProvider>(context, listen: false).info.name;

    return firestore
        .collection(schoolName)
        .doc('Staff')
        .collection(DateTime.now().year.toString())
        .snapshots();
  }
}

class HomeWorkBuilder extends StatefulWidget {
  final CollectionReference<Map<String, dynamic>> submissionSnapshot;
  final snapshot;
  const HomeWorkBuilder({
    Key? key,
    required this.snapshot,
    required this.submissionSnapshot,
  }) : super(key: key);

  @override
  State<HomeWorkBuilder> createState() => _HomeWorkBuilderState();
}

class _HomeWorkBuilderState extends State<HomeWorkBuilder> {
  @override
  Widget build(BuildContext context) {
    double tileheight = 70.0;
    return ListView.builder(
        itemCount: widget.snapshot.data!.docs.length,
        itemBuilder: (context, i) {
          return InkWell(
            onLongPress: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Do You Really Want To Delete'),
                    content: ListTile(
                      title: Text(
                        widget.snapshot.data!.docs.reversed.toList()[i]
                            ['title'],
                      ),
                      subtitle: Text(widget.snapshot.data!.docs.reversed
                          .toList()[i]['description']),
                    ),
                    actions: [
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Back')),
                      OutlinedButton(
                        onPressed: () async {
                          var id =
                              widget.snapshot.data.docs.reversed.toList()[i].id;
                          await widget.submissionSnapshot.doc(id).delete();
                          Fluttertoast.showToast(msg: 'Sucessfully Deleted');
                          Navigator.pop(context);
                        },
                        child: Text('yes'),
                      ),
                    ],
                  );
                },
              );
            },
            child: StreamBuilder(
                stream: widget.submissionSnapshot
                    .doc(widget.snapshot.data!.docs.reversed.toList()[i].id)
                    .collection('Submissions')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  bool seen = false;
                  if (snapshot.hasData) {
                    for (var snap in snapshot.data!.docs) {
                      if (snap.data() != null) {
                        seen = snap['Seen'];
                      }
                    }
                  }

                  return Card(
                    color: seen
                        ? Color.fromARGB(255, 163, 250, 160)
                        : Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            widget.snapshot.data!.docs.reversed.toList()[i]
                                ['title'],
                          ),
                          subtitle: Text(widget.snapshot.data!.docs.reversed
                              .toList()[i]['description']),
                          trailing: widget.snapshot.data!.docs.reversed
                                      .toList()[i]['attachment'] !=
                                  "null"
                              ? OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      tileheight = 200;
                                    });
                                    Upload().getMedia(widget
                                        .snapshot.data!.docs.reversed
                                        .toList()[i]['attachment']);
                                  },
                                  child: Text('View'))
                              : null,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Uploaded by : ' +
                              widget.snapshot.data!.docs.reversed.toList()[i]
                                  ['added_by']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Submission date : ' +
                              widget.snapshot.data!.docs.reversed.toList()[i]
                                  ['submission_date']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                              onPressed: () {
                                if (snapshot.hasData) {
                                  for (QueryDocumentSnapshot<Object?> snap
                                      in snapshot.data!.docs) {
                                    snap.reference.update({
                                      'Date_submitted': snap['Date_submitted'],
                                      'Seen': false,
                                      'attachments': snap['attachments'],
                                      'name': snap['name'],
                                      'roll_no': snap['roll_no'],
                                      'status': snap['status'],
                                    });
                                  }
                                }
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomeWorkSubmission(
                                    snapshot: widget.submissionSnapshot
                                        .doc(widget.snapshot.data!.docs.reversed
                                            .toList()[i]
                                            .id)
                                        .collection('Submissions')
                                        .snapshots(),
                                  );
                                }));
                              },
                              child: Text('Submissions')),
                        )
                      ],
                    ),
                  );
                }),
          );
        });
  }
}

class StudentDetails extends StatefulWidget {
  final StudentDetail data;
  final QueryDocumentSnapshot<Object?> studentPath;
  StudentDetails({Key? key, required this.data, required this.studentPath})
      : super(key: key);

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  String dropdownValue = '';
  var amount;

  var reason;

  bool spin = false;
  var submitter;

  @override
  void initState() {
    getFeeCatogary();
    getTotalAttendance();
    getOld();
    super.initState();
  }

  int totalPresents = 0;
  int totalClasses = 0;
  getTotalAttendance() {
    firestore
        .collection(
            Provider.of<SchoolProvider>(context, listen: false).info.name)
        .doc('Academics')
        .collection(widget.data.class_ + widget.data.section)
        .doc('Attendance')
        .collection(DateFormat('yyyy').format(DateTime.now()).toString())
        .doc('attendanceDates')
        .get()
        .then((value) {
      setState(() {
        totalClasses = value['Dates'].length;
      });
      for (var a in value['Dates']) {
        print(a);
        firestore
            .collection(
                Provider.of<SchoolProvider>(context, listen: false).info.name)
            .doc('Academics')
            .collection(widget.data.class_ + widget.data.section)
            .doc('Attendance')
            .collection(DateFormat('yyyy').format(DateTime.now()).toString())
            .doc('daily')
            .collection(a)
            .get()
            .then((value) {
          print(value.docs[0].data().toString());
          int k = value.docs
              .where((element) =>
                  element['Rollno'] == widget.data.rollno &&
                  element['Status'] == 'P')
              .length;

          setState(() {
            totalPresents = totalPresents + k;
          });
        });
      }
    });
  }

  getFeeCatogary() async {
    final firestore = FirebaseFirestore.instance;
    try {
      final response = firestore
          .collection(
              Provider.of<SchoolProvider>(context, listen: false).info.name)
          .doc('FeeSetting')
          .collection(DateTime.now().year.toString())
          .get()
          .then((value) {
        for (var v in value.docs) {
          Provider.of<SchoolProvider>(context, listen: false)
              .getFeesTypes(v['type']);
        }
      });
    } catch (e) {}
  }

  var selectedDate;

  final startController = TextEditingController();
  final endController = TextEditingController();

  Future<void> _selectDate(BuildContext context, vari) async {
    final DateTime? picked =
        Provider.of<SchoolProvider>(context, listen: false).date == 'nepali'
            ? await picker.showMaterialDatePicker(
                context: context,
                initialDate: NepaliDateTime.now(),
                firstDate: NepaliDateTime(1970),
                lastDate: NepaliDateTime(2100),
              )
            : await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2015, 8),
                lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        vari.text = '${DateFormat('yyyy-MM-dd').format(picked)}';
      });
    }
  }

  final firestore = FirebaseFirestore.instance;
  var bookName;
  Map<String, dynamic> user = {};

  getOld() {
    user = {
      'Information': {
        'Profile_Pic': widget.data.profilephoto,
        'Name': widget.data.name,
        'Class': widget.data.class_,
        'Rollno': widget.data.rollno,
        'Section': widget.data.section,
        'Temp_Address': widget.data.temporaryaddress,
        'Per_Address': widget.data.permanentadderss,
        'DOB': widget.data.dob,
        'Phone_No': widget.data.phonenumber,
        'Parents_Name': widget.data.parentsname,
        'Parents_No': widget.data.parentsnumber,
        'Father_Name': widget.data.fathername,
        'Father_No': widget.data.fathernumber,
        'Mother_Name': widget.data.mothername,
        'Mother_No': widget.data.mothernumber,
        'Fee': widget.data.totalfee,
        'password': widget.data.password,
        'email': widget.data.profilephoto,
      },
    };
  }

  var title = '';
  final file = TextEditingController();

  bool edit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Add Payment'),
                          content: Container(
                            height: 300,
                            child: Column(
                              children: [
                                DropDown(
                                  items: Provider.of<SchoolProvider>(context,
                                          listen: false)
                                      .feeCatogaries,
                                  onchange: (a) {
                                    setState(() {
                                      dropdownValue = a.toString();
                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                      onChanged: (a) {
                                        reason = a;
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'Enstallment Number',
                                          hintText:
                                              'Enter the Enstallment Number',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    onChanged: (a) {
                                      submitter = a;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Submitter Name',
                                      hintText: 'Enter the Submitter Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    onChanged: (a) {
                                      amount = a;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'amount',
                                      hintText: 'Enter the amount',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            OutlinedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  setState(() {
                                    spin = true;
                                  });
                                  if (amount != 0 &&
                                      reason != null &&
                                      submitter != null) {
                                    await widget.data.payments
                                        .doc(DateTime.now().toString())
                                        .set({
                                      'date': DateFormat('yyyy-MM-dd')
                                          .format(DateTime.now()),
                                      'Added_by': submitter,
                                      'amount': amount,
                                      'catogary': dropdownValue,
                                      'reason': reason
                                    });

                                    setState(() {
                                      spin = false;
                                    });
                                    Fluttertoast.showToast(
                                        msg: 'Payment Added Succesfully');
                                  } else {
                                    setState(() {
                                      spin = false;
                                    });
                                    Fluttertoast.showToast(msg: 'Fill fields');
                                  }
                                },
                                child: Text('Add',
                                    style: TextStyle(color: Colors.black)))
                          ],
                        );
                      });
                },
                child: Text('Payment', style: TextStyle(color: Colors.black))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return StudentDocuments(
                          data: widget.studentPath.reference
                              .collection('document'));
                    }),
                  );
                },
                child:
                    Text('Documents', style: TextStyle(color: Colors.black))),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 40,
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Card(
                        elevation: edit ? 15 : 2,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Profile',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor:
                                          Color.fromARGB(255, 230, 229, 229),
                                      backgroundImage: NetworkImage(
                                          widget.data.profilephoto),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            edit = true;
                                          });
                                        },
                                        child: Icon(Icons.edit))
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Name: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Class:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Roll No: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Section: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Father Name:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Father Number:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Mother Name: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Mother Number: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Parents Name: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Parents Number: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Temporary Address:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Permanent Address: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'DOB:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Phone Number: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          edit
                                              ? Container(
                                                  height: 20,
                                                  width: 100,
                                                  child: TextField(
                                                    onChanged: (a) {
                                                      setState(() {
                                                        user['Information']
                                                            ['Name'] = a;
                                                      });
                                                      print(user['Information']
                                                          ['Name']);
                                                    },
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            widget.data.name),
                                                  ),
                                                )
                                              : Text(
                                                  '${widget.data.name}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            '${widget.data.class_}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            '${widget.data.rollno}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            '${widget.data.section}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          edit
                                              ? Container(
                                                  height: 20,
                                                  width: 100,
                                                  child: TextField(
                                                    onChanged: (a) {
                                                      setState(() {
                                                        user['Information']
                                                            ['Father_Name'] = a;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                        hintText: widget
                                                            .data.fathername),
                                                  ),
                                                )
                                              : Text(
                                                  '${widget.data.fathername}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          edit
                                              ? Container(
                                                  height: 20,
                                                  width: 100,
                                                  child: TextField(
                                                    onChanged: (a) {
                                                      setState(() {
                                                        user['Information']
                                                            ['Father_No'] = a;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                        hintText: widget
                                                            .data.fathernumber),
                                                  ),
                                                )
                                              : Text(
                                                  '${widget.data.fathernumber}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          edit
                                              ? Container(
                                                  height: 20,
                                                  width: 100,
                                                  child: TextField(
                                                    onChanged: (a) {
                                                      setState(() {
                                                        user['Information']
                                                            ['Mother_Name'] = a;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                        hintText: widget
                                                            .data.mothername),
                                                  ),
                                                )
                                              : Text(
                                                  '${widget.data.mothername}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          edit
                                              ? Container(
                                                  height: 20,
                                                  width: 100,
                                                  child: TextField(
                                                    onChanged: (a) {
                                                      setState(() {
                                                        user['Information']
                                                            ['Mother_No'] = a;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                        hintText: widget
                                                            .data.mothernumber),
                                                  ),
                                                )
                                              : Text(
                                                  '${widget.data.mothernumber}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          edit
                                              ? Container(
                                                  height: 20,
                                                  width: 100,
                                                  child: TextField(
                                                    onChanged: (a) {
                                                      setState(() {
                                                        user['Information'][
                                                            'Parents_Name'] = a;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                        hintText: widget
                                                            .data.parentsname),
                                                  ),
                                                )
                                              : Text(
                                                  '${widget.data.parentsname}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          edit
                                              ? Container(
                                                  height: 20,
                                                  width: 100,
                                                  child: TextField(
                                                    onChanged: (a) {
                                                      setState(() {
                                                        user['Information']
                                                            ['Parents_No'] = a;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                        hintText: widget.data
                                                            .parentsnumber),
                                                  ),
                                                )
                                              : Text(
                                                  '${widget.data.parentsnumber}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          edit
                                              ? Container(
                                                  height: 20,
                                                  width: 100,
                                                  child: TextField(
                                                      onChanged: (a) {
                                                        setState(() {
                                                          user['Information'][
                                                              'Temp_Address'] = a;
                                                        });
                                                      },
                                                      decoration: InputDecoration(
                                                          hintText: widget.data
                                                              .temporaryaddress)),
                                                )
                                              : Text(
                                                  '${widget.data.temporaryaddress}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          edit
                                              ? Container(
                                                  height: 20,
                                                  width: 100,
                                                  child: TextField(
                                                      onChanged: (a) {
                                                        setState(() {
                                                          user['Information'][
                                                              'Per_Address'] = a;
                                                        });
                                                      },
                                                      decoration: InputDecoration(
                                                          hintText: widget.data
                                                              .permanentadderss)),
                                                )
                                              : Text(
                                                  '${widget.data.permanentadderss}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          edit
                                              ? Container(
                                                  height: 20,
                                                  width: 100,
                                                  child: TextField(
                                                      onChanged: (a) {
                                                        setState(() {
                                                          user['Information']
                                                              ['DOB'] = a;
                                                        });
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                              hintText: widget
                                                                  .data.dob)),
                                                )
                                              : Text(
                                                  '${widget.data.dob}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          edit
                                              ? Container(
                                                  height: 20,
                                                  width: 100,
                                                  child: TextField(
                                                      onChanged: (a) {
                                                        setState(() {
                                                          user['Information']
                                                              ['Phone_No'] = a;
                                                        });
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                              hintText: widget
                                                                  .data
                                                                  .phonenumber)),
                                                )
                                              : Text(
                                                  '${widget.data.phonenumber}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                        ]),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: edit
                            ? Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: FloatingActionButton(
                                    onPressed: () async {
                                      setState(() {
                                        edit = false;
                                      });
                                      try {
                                        await widget.studentPath.reference
                                            .update(user);
                                      } catch (e) {
                                        print(e);
                                      }

                                      Navigator.pop(context);

                                      Fluttertoast.showToast(
                                          msg: 'Profile Updated');
                                    },
                                    child: Icon(Icons.check)),
                              )
                            : null,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Card(
                    elevation: 2,
                    child: Container(
                      height: MediaQuery.of(context).size.height - 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Attendance',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Out of: $totalPresents / $totalClasses',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Present days: $totalPresents',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Class conducted: $totalClasses',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Library',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Add Book'),
                                          content: Container(
                                            height: 300,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                      onChanged: (a) {
                                                        bookName = a;
                                                      },
                                                      decoration: InputDecoration(
                                                          labelText:
                                                              'Book Name',
                                                          hintText:
                                                              'Enter The Book Name',
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)))),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    onTap: () {
                                                      _selectDate(context,
                                                          startController);
                                                    },
                                                    onChanged: (a) {},
                                                    controller: startController,
                                                    decoration: InputDecoration(
                                                      labelText: 'Issue Date',
                                                      hintText:
                                                          'Select Date Issued',
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    controller: endController,
                                                    onTap: () {
                                                      _selectDate(context,
                                                          endController);
                                                    },
                                                    onChanged: (a) {},
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Submission Date',
                                                      hintText:
                                                          'Enter Submssion Date',
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            OutlinedButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    spin = true;
                                                  });
                                                  if (bookName != null) {
                                                    widget.studentPath.reference
                                                        .collection('Books')
                                                        .doc(DateTime.now()
                                                            .toString())
                                                        .set({
                                                      'issueDate':
                                                          startController.text,
                                                      'submissionDate':
                                                          endController.text,
                                                      'book': bookName,
                                                      'Status': 'Not Submitted'
                                                    });
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg: 'Fill The Fields');
                                                  }

                                                  setState(() {
                                                    spin = false;
                                                  });
                                                },
                                                child: Text('Add',
                                                    style: TextStyle(
                                                        color: Colors.black)))
                                          ],
                                        );
                                      });
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Add Books',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Subject',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  VerticalDivider(
                                      width: 2, color: Colors.black),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Date',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  VerticalDivider(
                                      width: 2, color: Colors.black),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Status',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: StreamBuilder(
                              stream: widget.studentPath.reference
                                  .collection('Books')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                return !snapshot.hasData
                                    ? Container()
                                    : ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, i) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onLongPress: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Want To Delete ? '),
                                                      actions: [
                                                        OutlinedButton(
                                                          onPressed: () {
                                                            snapshot.data!.docs
                                                                .reversed
                                                                .toList()[i]
                                                                .reference
                                                                .delete();
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    'Deleted Sucessfully');
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text('Yes'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Want To Update Status'),
                                                      actions: [
                                                        OutlinedButton(
                                                          onPressed: () {
                                                            if (snapshot
                                                                        .data!
                                                                        .docs
                                                                        .reversed
                                                                        .toList()[i]
                                                                    [
                                                                    'Status'] ==
                                                                'Submitted') {
                                                              snapshot.data!
                                                                  .docs.reversed
                                                                  .toList()[i]
                                                                  .reference
                                                                  .update({
                                                                'book': snapshot
                                                                        .data!
                                                                        .docs
                                                                        .reversed
                                                                        .toList()[
                                                                    i]['book'],
                                                                'issueDate': snapshot
                                                                        .data!
                                                                        .docs
                                                                        .reversed
                                                                        .toList()[i]
                                                                    [
                                                                    'issueDate'],
                                                                'submissionDate': snapshot
                                                                        .data!
                                                                        .docs
                                                                        .reversed
                                                                        .toList()[i]
                                                                    [
                                                                    'submissionDate'],
                                                                'Status':
                                                                    'Not Submitted'
                                                              });
                                                            } else {
                                                              snapshot.data!
                                                                  .docs.reversed
                                                                  .toList()[i]
                                                                  .reference
                                                                  .update({
                                                                'book': snapshot
                                                                        .data!
                                                                        .docs
                                                                        .reversed
                                                                        .toList()[
                                                                    i]['book'],
                                                                'issueDate': snapshot
                                                                        .data!
                                                                        .docs
                                                                        .reversed
                                                                        .toList()[i]
                                                                    [
                                                                    'issueDate'],
                                                                'submissionDate': snapshot
                                                                        .data!
                                                                        .docs
                                                                        .reversed
                                                                        .toList()[i]
                                                                    [
                                                                    'submissionDate'],
                                                                'Status':
                                                                    'Submitted'
                                                              });
                                                            }

                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    'Updated Sucessfully');
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text('Yes'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Card(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          snapshot.data!.docs
                                                                  .reversed
                                                                  .toList()[i]
                                                              ['book'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ),
                                                    VerticalDivider(
                                                        width: 2,
                                                        color: Colors.black),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          snapshot.data!.docs
                                                                      .reversed
                                                                      .toList()[i]
                                                                  [
                                                                  'issueDate'] +
                                                              ' ' +
                                                              snapshot.data!.docs
                                                                      .reversed
                                                                      .toList()[i]
                                                                  [
                                                                  'submissionDate'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ),
                                                    VerticalDivider(
                                                      width: 2,
                                                      color: Colors.black,
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          snapshot.data!.docs
                                                                  .reversed
                                                                  .toList()[i]
                                                              ['Status'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Text(
                                'Payment Details',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.17,
                                // height: MediaQuery.of(context).size.width * 0.17,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 35, bottom: 35),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Total fee: ${widget.data.totalfee}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'Paid fees: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 400,
                                child: StreamBuilder(
                                    stream: widget.data.payments.snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      return snapshot.hasData
                                          ? ListView.builder(
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              itemBuilder: (context, i) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    padding: EdgeInsets.all(20),
                                                    width: 300,
                                                    height: 150,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Paid fee:',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 12,
                                                            ),
                                                            Text(
                                                              snapshot.data!.docs
                                                                      .reversed
                                                                      .toList()[
                                                                  i]['amount'],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Paid by:',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            SizedBox(
                                                              width: 12,
                                                            ),
                                                            Text(
                                                              snapshot.data!.docs
                                                                      .reversed
                                                                      .toList()[
                                                                  i]['Added_by'],
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Catogary:',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            SizedBox(
                                                              width: 12,
                                                            ),
                                                            Text(
                                                              snapshot.data!.docs
                                                                      .reversed
                                                                      .toList()[
                                                                  i]['catogary'],
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacer(),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Date:',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            SizedBox(
                                                              width: 12,
                                                            ),
                                                            Text(
                                                              snapshot.data!.docs
                                                                      .reversed
                                                                      .toList()[
                                                                  i]['date'],
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Color(0xffFEFFFF),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  180,
                                                                  185,
                                                                  185)
                                                              .withOpacity(
                                                                  0.50),
                                                          spreadRadius: 0,
                                                          blurRadius: 4,
                                                          offset: Offset(0,
                                                              0), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              })
                                          : Container();
                                    }),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'Documents',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            SizedBox(height: 15),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, right: 18),
                              child: Text(
                                'Upload documents here such as Birth certificate, Citizenship certificate and others documents',
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 11, color: Colors.grey),
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              height: MediaQuery.of(context).size.height / 1.7,
                              child: StreamBuilder(
                                  stream: widget.studentPath.reference
                                      .collection('document')
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    return !snapshot.hasData
                                        ? Container()
                                        : ListView.builder(
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            itemBuilder: (context, i) {
                                              return InkWell(
                                                onTap: () {
                                                  Upload().getMedia(snapshot
                                                      .data!
                                                      .docs[i]['attachment']);
                                                },
                                                child: Card(
                                                    elevation: 5,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(30.0),
                                                        child: Text(snapshot
                                                                .data!.docs[i]
                                                            ['title']))),
                                              );
                                            },
                                          );
                                  }),
                            ),
                            SizedBox(height: 15),
                            CupertinoButton.filled(
                              child: Text('Add'),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          title: Text('Add Document'),
                                          content: SizedBox(
                                              height: 300,
                                              child: Column(
                                                children: [
                                                  Textfield(
                                                      text: 'Enter Title',
                                                      obsecuewtext: false,
                                                      icon: Icons.title,
                                                      controller: null,
                                                      onChange: (a) {
                                                        setState(() {
                                                          title = a;
                                                        });
                                                      }),
                                                  Textfield(
                                                    text: 'Attachment',
                                                    obsecuewtext: false,
                                                    icon: Icons.attachment,
                                                    controller: file,
                                                    onChange: (a) {},
                                                    onTap: () async {
                                                      setState(() {
                                                        spin = true;
                                                      });
                                                      await Upload()
                                                          .uploadFile(context)
                                                          .then((value) {
                                                        setState(() {
                                                          file.text = value;
                                                        });
                                                      });
                                                      setState(() {
                                                        spin = false;
                                                      });
                                                    },
                                                  )
                                                ],
                                              )),
                                          actions: [
                                            OutlinedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Back')),
                                            OutlinedButton(
                                                onPressed: () {
                                                  widget.studentPath.reference
                                                      .collection('document')
                                                      .add({
                                                    'title': title,
                                                    'attachment': file.text,
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Yes'))
                                          ]);
                                    });
                              },
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
          Visibility(
              visible: spin,
              child:
                  Center(child: CircularProgressIndicator(color: Colors.black)))
        ],
      ),
    );
  }
}

class StaffDetail extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> path;
  StaffDetail({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  State<StaffDetail> createState() => _StaffDetailState();
}

class _StaffDetailState extends State<StaffDetail> {
  String dropdownValue = '';
  var amount;
  var install;
  var reason;

  bool spin = false;
  var submitter;
  final firestore = FirebaseFirestore.instance;
  int totalPresents = 0;
  int totalClasses = 0;

  getTotalAttendance() {
    firestore
        .collection(
            Provider.of<SchoolProvider>(context, listen: false).info.name)
        .doc('StaffAttendance')
        .collection(DateFormat('yyyy').format(DateTime.now()).toString())
        .doc('attendanceDates')
        .get()
        .then((value) {
      setState(() {
        totalClasses = value['Dates'].length;
      });
      for (var a in value['Dates']) {
        print(a);
        firestore
            .collection(
                Provider.of<SchoolProvider>(context, listen: false).info.name)
            .doc('StaffAttendance')
            .collection(DateFormat('yyyy').format(DateTime.now()).toString())
            .doc('daily')
            .collection(a)
            .get()
            .then((value) {
          print(value.docs.isEmpty);
          int k = value.docs
              .where((element) =>
                  element['Name'] == widget.path['Information']['Name'] &&
                  element['Status'] == 'P')
              .length;

          setState(() {
            totalPresents = totalPresents + k;
          });
        });
      }
    });
  }

  @override
  void initState() {
    getTotalAttendance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Add Payment'),
                          content: Container(
                            height: 300,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                      onChanged: (a) {
                                        install = a;
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Enstallment Number',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                      onChanged: (a) {
                                        reason = a;
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Catogary',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                      onChanged: (a) {
                                        amount = a;
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'amount',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)))),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            OutlinedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  setState(() {
                                    spin = true;
                                  });
                                  if (amount != 0 && reason != null) {
                                    await widget.path.reference
                                        .collection('Submission')
                                        .doc(DateTime.now().toString())
                                        .set({
                                      'date': DateFormat('yyyy-MM-dd')
                                          .format(DateTime.now()),
                                      'Added_by': Provider.of<SchoolProvider>(
                                              context,
                                              listen: false)
                                          .info
                                          .userName,
                                      'amount': amount,
                                      'install': install,
                                      'reason': reason,
                                    });

                                    setState(() {
                                      spin = false;
                                    });
                                    Fluttertoast.showToast(
                                        msg: 'Payment Added Succesfully');
                                  } else {
                                    setState(() {
                                      spin = false;
                                    });
                                    Fluttertoast.showToast(msg: 'Fill fields');
                                  }
                                },
                                child: Text('Add',
                                    style: TextStyle(color: Colors.black)))
                          ],
                        );
                      });
                },
                child: Text('Payment', style: TextStyle(color: Colors.black))),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Profile',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor:
                                      Color.fromARGB(255, 230, 229, 229),
                                  backgroundImage: NetworkImage(widget
                                      .path['Information']['Profile_Pic']),
                                ),
                                Icon(Icons.edit),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Temporary Address:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Permanent Address: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'DOB:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Phone Number: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ]),
                                Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${widget.path['Information']['Name']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '${widget.path['Information']['Temp_Address']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '${widget.path['Information']['Per_Address']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '${widget.path['Information']['DOB']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '${widget.path['Information']['Phone_No']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Attendance',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Out of: $totalPresents /$totalClasses',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Present: $totalPresents',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Class conducted: $totalClasses',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
                  ),
                )),
                Expanded(
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Text(
                                'Payment Details',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.17,
                                // height: MediaQuery.of(context).size.width * 0.17,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 35, bottom: 35),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Monthly Salary : ${widget.path['Information']['Salary']}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 400,
                                child: StreamBuilder(
                                    stream: widget.path.reference
                                        .collection('Submission')
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      return snapshot.hasData
                                          ? ListView.builder(
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              itemBuilder: (context, i) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    padding: EdgeInsets.all(20),
                                                    width: 300,
                                                    height: 150,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Paid Salary:',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 12,
                                                            ),
                                                            Text(
                                                              snapshot.data!.docs
                                                                      .reversed
                                                                      .toList()[
                                                                  i]['amount'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Paid by:',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            SizedBox(
                                                              width: 12,
                                                            ),
                                                            Text(
                                                              snapshot.data!.docs
                                                                      .reversed
                                                                      .toList()[
                                                                  i]['Added_by'],
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Catogary:',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            SizedBox(
                                                              width: 12,
                                                            ),
                                                            Text(
                                                              snapshot.data!.docs
                                                                      .reversed
                                                                      .toList()[
                                                                  i]['reason'],
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Spacer(),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Date:',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            SizedBox(
                                                              width: 12,
                                                            ),
                                                            Text(
                                                              snapshot.data!.docs
                                                                      .reversed
                                                                      .toList()[
                                                                  i]['date'],
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Color(0xffFEFFFF),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  180,
                                                                  185,
                                                                  185)
                                                              .withOpacity(
                                                                  0.50),
                                                          spreadRadius: 0,
                                                          blurRadius: 4,
                                                          offset: Offset(0,
                                                              0), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              })
                                          : Container();
                                    }),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
              visible: spin,
              child:
                  Center(child: CircularProgressIndicator(color: Colors.black)))
        ],
      ),
    );
  }
}
