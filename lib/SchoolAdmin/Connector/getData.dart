import 'package:adminpannel/Agora/agora.dart';
import 'package:adminpannel/Attendancepages/AllAttendance.dart';
import 'package:adminpannel/Attendancepages/takeSatt.dart';
import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/class.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:adminpannel/Storage/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adminpannel/Attendancepages/takeSatt.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class GetData {
  final firestore = FirebaseFirestore.instance;

  void getData(context) async {
    final iD = await Store().getData('id');
    try {
      await firestore.collection('ADMIN').doc(iD).get().then((value) {
        Provider.of<SchoolProvider>(context, listen: false)
            .getAdminAllData(value.data());
        //print(value.data()!['Information']);
      });
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
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ListTile(
                                title: Text('Name : ' +
                                    snapshot.data!.docs[i]['Information']
                                        ['Name'])),
                            ListTile(
                                title: Text('Class : ' +
                                    snapshot.data!.docs[i]['Information']
                                        ['Class'])),
                            ListTile(
                                title: Text('Roll no : ' +
                                    snapshot.data!.docs[i]['Information']
                                        ['Rollno'])),
                            ListTile(
                                title: Text('Section : ' +
                                    snapshot.data!.docs[i]['Information']
                                        ['Section']))
                          ],
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
          .doc('Academics')
          .collection(class_ + section)
          .doc('Teacher')
          .collection(DateTime.now().year.toString())
          .snapshots(),
      builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ListTile(
                                leading: ImageIcon(NetworkImage(snapshot
                                    .data!.docs[i]['Information']['Profile_Pic']
                                    .toString())),
                                title: Text('Name : ' +
                                    snapshot
                                        .data!.docs[i]['Information']['Name']
                                        .toString())),
                            ListTile(
                                title: Text('Phone no : ' +
                                    snapshot.data!
                                        .docs[i]['Information']['Phone_No']
                                        .toString())),
                            ListTile(
                                title: Text('Address : ' +
                                    snapshot.data!
                                        .docs[i]['Information']['Per_Address']
                                        .toString())),
                          ],
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
                              Upload().getMedia(
                                  snapshot.data!.docs[i]['Attachment']);
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
                                          snapshot.data!.docs[i]['title'],
                                        ),
                                        subtitle: Text(snapshot.data!.docs[i]
                                            ['Description']),
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
                                                  .doc(
                                                      snapshot.data!.docs[i].id)
                                                  .delete();
                                              Navigator.pop(context);
                                            },
                                            child: Text('yes')),
                                      ],
                                    );
                                  });
                            },
                            title: Text(
                              snapshot.data!.docs[i]['title'] +
                                  ' (${snapshot.data!.docs[i]['subject']})',
                            ),
                            subtitle:
                                Text(snapshot.data!.docs[i]['Description']),
                            trailing: OutlinedButton(
                              child: Text('View'),
                              onPressed: () {
                                Upload().getMedia(
                                    snapshot.data!.docs[i]['Attachment']);
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
                              sn: snapshot.data!.docs[i]['Rollno'],
                              date: snapshot.data!.docs[i]['Date'],
                              name: snapshot.data!.docs[i]['Name'],
                              status: snapshot.data!.docs[i]['Status'] == 'P',
                              day: snapshot.data!.docs[i]['Day'],
                              getStatus:
                                  snapshot.data!.docs[i]['Status'] == 'P',
                              grade: snapshot.data!.docs[i]['Grade'],
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
                                    .doc(snapshot.data!.docs[i].id)
                                    .update({
                                  'Rollno': snapshot.data!.docs[i]['Rollno'],
                                  'Name': snapshot.data!.docs[i]['Name'],
                                  'Date': snapshot.data!.docs[i]['Date'],
                                  'Day': snapshot.data!.docs[i]['Day'],
                                  'Status':
                                      snapshot.data!.docs[i]['Status'] == 'A'
                                          ? 'P'
                                          : 'A',
                                  'Grade': snapshot.data!.docs[i]['Grade'],
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
            .doc('Academics')
            .collection(class_ + section)
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
                              sn: "${i + 1}",
                              date: snapshot.data!.docs[i]['Date'],
                              name: snapshot.data!.docs[i]['Name'],
                              status: snapshot.data!.docs[i]['Status'] == 'P',
                              day: snapshot.data!.docs[i]['Day'],
                              getStatus:
                                  snapshot.data!.docs[i]['Status'] == 'P',
                              grade: '',
                              type: '',
                              onChanged: (a) async {
                                await firestore
                                    .collection(school)
                                    .doc('Academics')
                                    .collection(class_ + section)
                                    .doc('StaffAttendance')
                                    .collection(DateTime.now().year.toString())
                                    .doc('daily')
                                    .collection(date == null
                                        ? DateFormat('yyyy-MM-dd')
                                            .format(DateTime.now())
                                            .toString()
                                        : date)
                                    .doc(snapshot.data!.docs[i].id)
                                    .update({
                                  'Name': snapshot.data!.docs[i]['Name'],
                                  'Date': snapshot.data!.docs[i]['Date'],
                                  'Day': snapshot.data!.docs[i]['Day'],
                                  'Status':
                                      snapshot.data!.docs[i]['Status'] == 'A'
                                          ? 'P'
                                          : 'A',
                                  'Per_Address': snapshot.data!.docs[i]
                                      ['Per_Address'],
                                  'DOB': snapshot.data!.docs[i]['DOB'],
                                  'Phone_No': snapshot.data!.docs[i]
                                      ['Phone_No'],
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
                              launch(snapshot.data!.docs[i]['url']);
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
                                          snapshot.data!.docs[i]['title'],
                                        ),
                                        subtitle: Text('Subject : ' +
                                            snapshot.data!.docs[i]['subject']),
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
                                                  .doc(
                                                      snapshot.data!.docs[i].id)
                                                  .delete();
                                              Navigator.pop(context);
                                            },
                                            child: Text('yes')),
                                      ],
                                    );
                                  });
                            },
                            title: Text(snapshot.data!.docs[i]['title'] +
                                ' (${snapshot.data!.docs[i]['subject']})'),
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
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              launch(snapshot.data!.docs[i]['url']);
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
                                          snapshot.data!.docs[i]['title'],
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
                                                  .doc('Exams')
                                                  .collection(DateTime.now()
                                                      .year
                                                      .toString())
                                                  .doc(
                                                      snapshot.data!.docs[i].id)
                                                  .delete();
                                              Navigator.pop(context);
                                            },
                                            child: Text('yes')),
                                      ],
                                    );
                                  });
                            },
                            title: Text(snapshot.data!.docs[i]['title']),
                            subtitle: Text('Date_Added'),
                          ),
                        ],
                      ),
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
                                          snapshot.data!.docs[i]['title'],
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
                                                  .doc(
                                                      snapshot.data!.docs[i].id)
                                                  .delete();
                                              Navigator.pop(context);
                                            },
                                            child: Text('yes')),
                                      ],
                                    );
                                  });
                            },
                            onTap: () {
                              Upload().getMedia(snapshot.data!.docs[i]['file']);
                            },
                            title: Text(
                              snapshot.data!.docs[i]['title'],
                            ),
                            subtitle:
                                Text(snapshot.data!.docs[i]['Date_Added']),
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
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () async {
                              final _auth = FirebaseAuth.instance;
                              if (snapshot.data!.docs[i]['Host'] ==
                                      _auth.currentUser!.email ||
                                  snapshot.data!.docs[i]['status'] ==
                                      'Running') {
                                await firestore
                                    .collection(school)
                                    .doc('Academics')
                                    .collection(class_ + section)
                                    .doc('LiveClass')
                                    .collection(DateTime.now().year.toString())
                                    .doc(snapshot.data!.docs[i].id)
                                    .update({
                                  'Date_Added': snapshot.data!.docs[i]
                                      ['Date_Added'],
                                  'status': 'Running',
                                  'date': snapshot.data!.docs[i]['date'],
                                  'title': snapshot.data!.docs[i]['title'],
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AgoraSDK(
                                              class_: class_,
                                              section: section,
                                              channel: class_ + section,
                                            )));
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
                                      title:
                                          Text('Do You Really Want To Delete'),
                                      content: ListTile(
                                        title: Text(
                                          snapshot.data!.docs[i]['title'],
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
                                                  .doc('LiveClass')
                                                  .collection(DateTime.now()
                                                      .year
                                                      .toString())
                                                  .doc(
                                                      snapshot.data!.docs[i].id)
                                                  .delete();
                                              Navigator.pop(context);
                                            },
                                            child: Text('yes')),
                                      ],
                                    );
                                  });
                            },
                            title: Text(
                              snapshot.data!.docs[i]['title'],
                            ),
                            subtitle: Text(snapshot.data!.docs[i]['date']),
                          ),
                        ],
                      ),
                    );
                  })
              : Container();
        });
  }

  Widget getSubmission(snapshot) {
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
                              snapshot.data!.docs[i]['Name'],
                            ),
                            trailing: OutlinedButton(
                              child: Text('View'),
                              onPressed: () {
                                Upload().getMedia(
                                    snapshot.data!.docs[i]['Attachment']);
                              },
                            ),
                          ),
                          Divider()
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
        .doc('Academics')
        .collection(class_ + section)
        .doc('Teacher')
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
                        widget.snapshot.data!.docs[i]['title'],
                      ),
                      subtitle:
                          Text(widget.snapshot.data!.docs[i]['description']),
                    ),
                    actions: [
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Back')),
                      OutlinedButton(
                        onPressed: () async {
                          var id = widget.snapshot.data.docs[i].id;
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
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      widget.snapshot.data!.docs[i]['title'],
                    ),
                    subtitle:
                        Text(widget.snapshot.data!.docs[i]['description']),
                    trailing: widget.snapshot.data!.docs[i]['attachment'] !=
                            null
                        ? OutlinedButton(
                            onPressed: () {
                              setState(() {
                                tileheight = 200;
                              });
                              Upload().getMedia(
                                  widget.snapshot.data!.docs[i]['attachment']);
                            },
                            child: Text('View'))
                        : Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Uploaded by : ' +
                        widget.snapshot.data!.docs[i]['added_by']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Submission date : ' +
                        widget.snapshot.data!.docs[i]['submission_date']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HomeWorkSubmission(
                              snapshot: widget.submissionSnapshot
                                  .doc(widget.snapshot.data!.docs[i].id)
                                  .collection('Submissions')
                                  .snapshots(),
                            );
                          }));
                        },
                        child: Text('Submissions')),
                  )
                ],
              ),
            ),
          );
        });
  }
}
