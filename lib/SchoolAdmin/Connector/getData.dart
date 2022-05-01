import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:adminpannel/Storage/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              snapshot.data!.docs[i]['title'],
                            ),
                            subtitle: snapshot.data!.docs[i]['description'],
                            trailing: snapshot.data!.docs[i]['url'] != null
                                ? OutlinedButton(
                                    onPressed: () {
                                      launch(snapshot.data!.docs[i]['url']);
                                    },
                                    child: Text('View'))
                                : Container(),
                          ),
                        ],
                      ),
                    );
                  })
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
            .doc('StudyMaterial')
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
                              title: Text(
                            snapshot.data!.docs[i]['title'],
                          )),
                          Divider()
                        ],
                      ),
                    );
                  })
              : Container();
        });
  }

  Widget getAttendances(context, class_, section) {
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
            .collection(
                DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
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
                              title: Text(
                            snapshot.data!.docs[i]['title'],
                          )),
                          Divider()
                        ],
                      ),
                    );
                  })
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
            .doc('Exam')
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
                              title: Text(
                            snapshot.data!.docs[i]['title'],
                          )),
                          Divider()
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
                              title: Text(
                            snapshot.data!.docs[i]['title'],
                          )),
                          Divider()
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
                              title: Text(
                            snapshot.data!.docs[i]['title'],
                          )),
                          Divider()
                        ],
                      ),
                    );
                  })
              : Container();
        });
  }
}
