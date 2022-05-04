import 'dart:io';

import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Upload {
  final firestore = FirebaseFirestore.instance;

  Future<void> addStudent(
      {schoolName,
      school,
      id,
      grade,
      required data,
      required type,
      required context}) async {
    try {
      await firestore
          .collection(schoolName)
          .doc('Academics')
          .collection(
              grade.toString() + data['Information']['Section'].toString())
          .doc('Students')
          .collection(DateTime.now().year.toString())
          .doc(id)
          .set(data);
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<void> addStaff(
      {schoolName,
      school,
      id,
      grade,
      required data,
      required type,
      required context}) async {
    try {
      await firestore
          .collection(schoolName)
          .doc('Academics')
          .collection(
              grade.toString() + data['Information']['Section'].toString())
          .doc('Teacher')
          .collection(DateTime.now().year.toString())
          .doc(id)
          .set(data);
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future uploadAttendanceSheet(Map<String, Object?> data, context) async {
    print('object');
    final firestore = FirebaseFirestore.instance;
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    try {
      await firestore.collection(school).doc('AttendanceHistory').update(data);
      print('kamaal ho gaya');
    } catch (e) {
      print(e);
    }
  }

  Future<String> uploadProfilepic(image) async {
    var imageUrl = '';
    try {
      UploadTask uploadTask =
          FirebaseStorage.instance.ref("profilepictures").putData(image!);
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
    } catch (e) {
      print(e.toString());
    }
    return imageUrl.toString();
  }

  Future uploadFile(context) async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['Pdf', 'jpg', 'docx', 'mp4']);
    var downloadUrl;
    if (file != null) {
      var contentType;
      if (file.files.first.extension!.toLowerCase() == 'pdf') {
        contentType = 'application/pdf';
      } else if (file.files.first.extension!.toLowerCase() == 'jpg') {
        contentType = 'image/jpeg';
      } else if (file.files.first.extension!.toLowerCase() == 'mp4') {
        contentType = 'video/mp4';
      } else if (file.files.first.extension!.toLowerCase() == 'docx') {
        contentType =
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      }
      final data = file.files.first.bytes;
      final path = DateTime.now().year;

      try {
        final storage = FirebaseStorage.instance;

        showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.height / 2,
                  height: MediaQuery.of(context).size.height / 2,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Card(
                      child: StreamBuilder<TaskSnapshot>(
                          stream: storage
                              .ref('$path/${file.names.first}')
                              .putData(data!,
                                  SettableMetadata(contentType: contentType))
                              .snapshotEvents,
                          builder: (context, snapshort) {
                            return Builder(builder: (context) {
                              snapshort.data!.bytesTransferred ==
                                      snapshort.data!.totalBytes
                                  ? Navigator.pop(context)
                                  : print('');
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: LinearPercentIndicator(
                                          onAnimationEnd: () {
                                            Navigator.pop(context);
                                          },
                                          width: 200.0,
                                          lineHeight: 14.0,
                                          percent:
                                              snapshort.data!.bytesTransferred /
                                                  snapshort.data!.totalBytes,
                                          backgroundColor: Colors.grey,
                                          progressColor: Colors.green,
                                          barRadius: Radius.circular(2),
                                        ),
                                      ),
                                    ),
                                    Text(
                                        '${snapshort.data!.bytesTransferred * 100 / snapshort.data!.totalBytes}'
                                            .toString()
                                            .split('.')
                                            .first),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Please Wait for a while'),
                                    )
                                  ],
                                ),
                              );
                            });
                          }),
                    ),
                  ),
                ),
              );
            });

        var p0 = await storage.ref('$path/${file.names.first}');

        downloadUrl = p0.fullPath.toString();
        print(p0.fullPath.toString() + "zdxfghuijkosdfghjkasdfghj");

        await firestore
            .collection(
                Provider.of<SchoolProvider>(context, listen: false).info.name)
            .doc('Attachments')
            .collection('Attachments')
            .add({
          'name': file.names.first,
          'url': p0.fullPath.toString(),
          'date': DateTime.now()
        });
      } on FirebaseException catch (e) {
        print(e.toString() + 'kkkk');
      }
    }

    return downloadUrl;
  }

  Future getMedia(path) async {
    final storage = FirebaseStorage.instance;

    try {
      final link = await storage.ref(path).getDownloadURL().then((value) {
        // file = File.fromRawPath(value!);
        launch(value, forceWebView: true);
      });
    } catch (e) {
      print(e);
    }
  }

  addNewClass(context, className, sectionName) async {
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;

    await firestore
        .collection(school)
        .doc('Classes')
        .collection('RegisteredClasses')
        .add({
      'class': className,
      'section': sectionName,
    });
  }

  addHomework({required data, context, class_, section}) async {
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    await firestore
        .collection(school)
        .doc('Academics')
        .collection(class_ + section)
        .doc('HomeWorks')
        .collection(DateTime.now().year.toString())
        .add(data);
  }

  addStudyMaterial({required data, context, class_, section}) async {
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    await firestore
        .collection(school)
        .doc('Academics')
        .collection(class_ + section)
        .doc('StudyMaterials')
        .collection(DateTime.now().year.toString())
        .add(data);
  }

  addExam({required data, context, class_, section}) async {
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    await firestore
        .collection(school)
        .doc('Academics')
        .collection(class_ + section)
        .doc('Exams')
        .collection(DateTime.now().year.toString())
        .add(data);
  }

  addResult({required data, context, class_, section}) async {
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    await firestore
        .collection(school)
        .doc('Academics')
        .collection(class_ + section)
        .doc('Results')
        .collection(DateTime.now().year.toString())
        .add(data);
  }

  addRoutine({required data, context, class_, section}) async {
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    firestore
        .collection(school)
        .doc('Academics')
        .collection(class_ + section)
        .doc('Routine')
        .collection(DateTime.now().year.toString())
        .add(data);
  }

  addAttendance({required data, context, class_, section}) async {
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    firestore
        .collection(school)
        .doc('Academics')
        .collection(class_ + section)
        .doc('Attendance')
        .collection(DateTime.now().year.toString())
        .doc('daily')
        .collection(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        firestore
            .collection(school)
            .doc('Academics')
            .collection(class_ + section)
            .doc('Attendance')
            .collection(DateTime.now().year.toString())
            .doc('daily')
            .collection(
                DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
            .doc(data['Rollno'] + data['Name'])
            .set(data);
      }
    });
  }

  addStaffAttendance({required data, context, class_, section}) async {
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    firestore
        .collection(school)
        .doc('Academics')
        .collection(class_ + section)
        .doc('StaffAttendance')
        .collection(DateTime.now().year.toString())
        .doc('daily')
        .collection(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        firestore
            .collection(school)
            .doc('Academics')
            .collection(class_ + section)
            .doc('StaffAttendance')
            .collection(DateTime.now().year.toString())
            .doc('daily')
            .collection(
                DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
            .doc(data['Name'] + data['Per_Address'])
            .set(data);
      }
    });
  }

  addLiveClass({required data, context, class_, section}) async {
    final school =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    firestore
        .collection(school)
        .doc('Academics')
        .collection(class_ + section)
        .doc('LiveClass')
        .collection(DateTime.now().year.toString())
        .add(data);
  }
}
