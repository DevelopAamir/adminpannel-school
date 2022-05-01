import 'dart:io';

import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
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
    UploadTask uploadTask =
        FirebaseStorage.instance.ref("profilepictures").putFile(image!);
    TaskSnapshot snapshot = await uploadTask;
    String imageUrl = await snapshot.ref.getDownloadURL();

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
              return SizedBox(
                width: MediaQuery.of(context).size.height / 2,
                height: MediaQuery.of(context).size.height / 2,
                child: Scaffold(
                  body: Card(
                    child: StreamBuilder<TaskSnapshot>(
                        stream: storage
                            .ref('$path/${file.names.first}')
                            .putData(data!,
                                SettableMetadata(contentType: contentType))
                            .snapshotEvents,
                        builder: (context, snapshort) {
                          return Builder(builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 8,
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 8,
                                    width: snapshort.data!.bytesTransferred /
                                        snapshort.data!.totalBytes /
                                        MediaQuery.of(context).size.width /
                                        2.5,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(3)),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                            );
                          });
                        }),
                  ),
                ),
              );
            });

        var p0 = await storage.ref('$path/${file.names.first}');

        downloadUrl = p0.fullPath.toString();
        print(p0.fullPath.toString());

        firestore
            .collection(
                Provider.of<SchoolProvider>(context, listen: false).info.name)
            .doc('Attachments')
            .collection('Attachments')
            .add({
          'name': file.names.first,
          'url': downloadUrl,
          'date': DateTime.now()
        });
      } catch (e) {
        print(e.toString());
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
        .add(data);
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
