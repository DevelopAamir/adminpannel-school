import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddStudent {
  Future<void> addStudent(
      {email,
      password,
      schoolName,
      grade,
      data,
      required type,
      required context}) async {
    var app = await Firebase.initializeApp(
        name: '$email',
        options: FirebaseOptions(
            apiKey: 'AIzaSyDMqxPs3T-9tfUNK0mweo3qcXUCg5YecUU',
            appId: '1:557268782813:web:db7492cc11dabdcb515534',
            messagingSenderId: '557268782813',
            projectId: 'school-b69d0'));
    final auth = FirebaseAuth.instanceFor(
      app: app,
    );
    try {
      final response = await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        print(value.user.toString());

        await auth.currentUser!.updateDisplayName(
            Provider.of<SchoolProvider>(context, listen: false).info.name +
                ',' +
                grade.toString() +
                data['Information']['Section'].toString());

        await Upload()
            .addStudent(
                schoolName: schoolName,
                id: auth.currentUser!.uid,
                grade: grade,
                data: data,
                type: type,
                context: context)
            .onError((error, stackTrace) {
          auth.currentUser!.delete();
        });
        print(auth.currentUser!.displayName.toString());
        await auth.signOut();
        await auth.app.delete();
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> addStaff(
      {email,
      password,
      schoolName,
      grade,
      data,
      required type,
      required context}) async {
    var app = await Firebase.initializeApp(
        name: '$email',
        options: FirebaseOptions(
            apiKey: 'AIzaSyDMqxPs3T-9tfUNK0mweo3qcXUCg5YecUU',
            appId: '1:557268782813:web:db7492cc11dabdcb515534',
            messagingSenderId: '557268782813',
            projectId: 'school-b69d0'));
    final auth = FirebaseAuth.instanceFor(
      app: app,
    );
    List permissions = [];
    try {
      final response = await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        print(value.user.toString());
        await auth.currentUser!.updateDisplayName(
            Provider.of<SchoolProvider>(context, listen: false).info.name);
        await auth.currentUser!.updatePhotoURL('Staff');
        await showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: ListView(
                  children: [
                    Text('Give Permission To Staff',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold)),
                    if (Provider.of<SchoolProvider>(context, listen: false)
                        .permissions
                        .contains('Homework Management'))
                      Chaecker(
                          title: Text('Homework Management'),
                          // value: permissions.contains('Homework Management'),
                          onChanged: (a) {
                            print(a);
                            if (a = true) {
                              permissions.add('Homework Management');
                            } else {
                              permissions.remove('Homework Management');
                            }
                          }),
                    if (Provider.of<SchoolProvider>(context, listen: false)
                        .permissions
                        .contains('StudyMaterial Management'))
                      Chaecker(
                          title: Text('StudyMaterial Management'),
                          // value: permissions.contains('StudyMaterial Management'),
                          onChanged: (a) {
                            if (!permissions
                                .contains('StudyMaterial Management')) {
                              permissions.add('StudyMaterial Management');
                            } else {
                              permissions.remove('StudyMaterial Management');
                            }
                          }),
                    if (Provider.of<SchoolProvider>(context, listen: false)
                        .permissions
                        .contains('Attendance Management'))
                      Chaecker(
                          title: Text('Attendance Management'),
                          // value: permissions.contains('Attendance Management'),
                          onChanged: (a) {
                            if (!permissions
                                .contains('Attendance Management')) {
                              permissions.add('Attendance Management');
                            } else {
                              permissions.remove('Attendance Management');
                            }
                          }),
                    if (Provider.of<SchoolProvider>(context, listen: false)
                        .permissions
                        .contains('Routine Management'))
                      Chaecker(
                          title: Text('Routine Management'),
                          // value: permissions.contains('Routine Management'),
                          onChanged: (a) {
                            if (!permissions.contains('Routine Management')) {
                              permissions.add('Routine Management');
                            } else {
                              permissions.remove('Routine Management');
                            }
                          }),
                    if (Provider.of<SchoolProvider>(context, listen: false)
                        .permissions
                        .contains('Live Class Management'))
                      Chaecker(
                          title: Text('Live Class Management'),
                          // value: permissions.contains('Live Class Management'),
                          onChanged: (a) {
                            if (!permissions
                                .contains('Live Class Management')) {
                              permissions.add('Live Class Management');
                            } else {
                              permissions.remove('Live Class Management');
                            }
                          }),
                    if (Provider.of<SchoolProvider>(context, listen: false)
                        .permissions
                        .contains('Exam Management'))
                      Chaecker(
                          title: Text('Exam Management'),
                          // value: permissions.contains('Exam Management'),
                          onChanged: (a) {
                            if (!permissions.contains('Exam Management')) {
                              permissions.add('Exam Management');
                            } else {
                              permissions.remove('Exam Management');
                            }
                          }),
                    if (Provider.of<SchoolProvider>(context, listen: false)
                        .permissions
                        .contains('Result Management'))
                      Chaecker(
                          title: Text('Result Management'),
                          // value: permissions.contains('Result Management'),
                          onChanged: (a) {
                            if (!permissions.contains('Result Management')) {
                              permissions.add('Result Management');
                            } else {
                              permissions.remove('Result Management');
                            }
                          }),
                    if (Provider.of<SchoolProvider>(context, listen: false)
                        .permissions
                        .contains('LeaveRequest Management'))
                      Chaecker(
                          title: Text('LeaveRequest Management'),
                          // value: permissions.contains('LeaveRequest Management'),
                          onChanged: (a) {
                            if (!permissions
                                .contains('LeaveRequest Management')) {
                              permissions.add('LeaveRequest Management');
                            } else {
                              permissions.remove('LeaveRequest Management');
                            }
                          }),
                    if (Provider.of<SchoolProvider>(context, listen: false)
                        .permissions
                        .contains('StaffAttendance Management'))
                      Chaecker(
                          title: Text('StaffAttendance Management'),
                          // value:
                          // permissions.contains('StaffAttendance Management'),
                          onChanged: (a) {
                            if (!permissions
                                .contains('StaffAttendance Management')) {
                              permissions.add('StaffAttendance Management');
                            } else {
                              permissions.remove('StaffAttendance Management');
                            }
                          }),
                    if (Provider.of<SchoolProvider>(context, listen: false)
                        .permissions
                        .contains('Student Management'))
                      Chaecker(
                          title: Text('Student Management'),
                          // value:
                          // permissions.contains('StaffAttendance Management'),
                          onChanged: (a) {
                            if (!permissions.contains('Student Management')) {
                              permissions.add('Student Management');
                            } else {
                              permissions.remove('Student Management');
                            }
                          }),
                    if (Provider.of<SchoolProvider>(context, listen: false)
                        .permissions
                        .contains('Notice Management'))
                      Chaecker(
                          title: Text('Notice Management'),
                          // value: permissions.contains('Notice Management'),
                          onChanged: (a) {
                            if (!permissions.contains('Notice Management')) {
                              permissions.add('Notice Management');
                            } else {
                              permissions.remove('Notice Management');
                            }
                          }),
                    CupertinoButton(
                        child: Text('Submit'),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              );
            });
        data['permission'] = permissions;
        await Upload()
            .addStaff(
                schoolName: schoolName,
                id: auth.currentUser!.uid,
                grade: grade,
                data: data,
                type: type,
                context: context)
            .onError((error, stackTrace) {
          auth.currentUser!.delete();
        });
        print(auth.currentUser!.displayName.toString());
        await auth.signOut();
        await auth.app.delete();
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

class Chaecker extends StatefulWidget {
  final title;
  final Function(bool?)? onChanged;
  const Chaecker({Key? key, this.onChanged, this.title}) : super(key: key);

  @override
  State<Chaecker> createState() => _ChaeckerState();
}

class _ChaeckerState extends State<Chaecker> {
  bool? v = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      onChanged: (bool? value) {
        setState(() {
          v = value;
        });
        widget.onChanged!(value);
      },
      value: v,
      title: widget.title,
    );
  }
}
