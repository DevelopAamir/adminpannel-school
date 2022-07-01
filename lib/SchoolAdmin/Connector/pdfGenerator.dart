import 'dart:typed_data';

import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/objects/resultObj.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as fil;
import 'package:lottie/lottie.dart';

generatePdf(ResultObj data, context) async {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
              width: 200,
              height: 250,
              child: Column(
                children: [
                  Lottie.asset('images/build.json'),
                  Text('Generating....')
                ],
              )),
        );
      });
  final storage = FirebaseStorage.instance;
  final pdf = pw.Document();
  Uint8List? image;
  Uint8List? prince;
  Uint8List? class_tea;
  Uint8List? exam_coo;

  try {
    image = await storage.refFromURL(data.logo).getData();
    prince = await storage.refFromURL(data.prncipal).getData();
    class_tea = await storage.refFromURL(data.class_teacher).getData();
    exam_coo = await storage.refFromURL(data.exam_coordinator).getData();
    print(data.logo);
    print(data.class_teacher);
    print(data.exam_coordinator);
    print(data.prncipal);
  } catch (e) {
    print(e);
  }

  pdf.addPage(
    pw.Page(build: (pw.Context context) {
      return pw.Center(
        child: pw.Stack(children: [
          pw.Container(
            decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColor.fromHex('000000'))),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.SizedBox(height: 10),
                pw.SizedBox(
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Column(
                            children: [
                              pw.Text(
                                data.schoolName,
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
                pw.Text(
                  data.schoolAddress,
                  style: pw.TextStyle(
                      fontSize: 10, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Text('Grade Sheet',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text(data.examDetails),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.Padding(
                  padding: pw.EdgeInsets.all(8),
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text('Name : ${data.studentInfo['name']}',
                                style: pw.TextStyle(
                                  height: 2.0,
                                  fontSize: 10,
                                )),
                            pw.Text('Class : ${data.studentInfo['class']}',
                                style: pw.TextStyle(height: 2.0, fontSize: 10)),
                          ],
                        ),
                      ),
                      pw.Expanded(child: pw.Container()),
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text('Roll No : ${data.studentInfo['rollno']}',
                                style: pw.TextStyle(height: 2.0, fontSize: 10)),
                            pw.Text('section : ${data.studentInfo['section']}',
                                style: pw.TextStyle(height: 2.0, fontSize: 10))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Table.fromTextArray(
                  headerStyle: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 10),
                  headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
                  cellHeight: 20,
                  cellStyle: pw.TextStyle(fontSize: 8),
                  headerAlignment: pw.Alignment.center,
                  columnWidths: {
                    0: pw.FlexColumnWidth(1),
                    1: pw.FlexColumnWidth(4),
                    2: pw.FlexColumnWidth(3),
                    3: pw.FlexColumnWidth(2),
                    4: pw.FlexColumnWidth(2),
                    5: pw.FlexColumnWidth(3),
                    6: pw.FlexColumnWidth(2),
                  },
                  cellAlignments: {
                    0: pw.Alignment.center,
                    1: pw.Alignment.centerLeft,
                    2: pw.Alignment.center,
                    3: pw.Alignment.center,
                    4: pw.Alignment.center,
                    5: pw.Alignment.center,
                    6: pw.Alignment.center,
                  },
                  headers: [
                    'Sn',
                    'Subject',
                    'Credit Hour',
                    'Th',
                    'Pr',
                    'Final Grade',
                    'GP',
                  ],
                  data: data.marks.map((e) {
                    return [
                      data.marks.indexOf(e) + 1,
                      e['subject'],
                      e['creditHour'],
                      e['theory'],
                      e['practical'],
                      e['final_grade'],
                      e['gpa'],
                    ];
                  }).toList(),
                ),
                pw.SizedBox(height: 5),
                pw.Align(
                    alignment: pw.Alignment.bottomLeft,
                    child: pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child:
                            pw.Text('Grade Point Average (GPA) : ' + data.gpa,
                                style: pw.TextStyle(
                                  height: 2.0,
                                  fontSize: 8,
                                )))),
                pw.Align(
                    alignment: pw.Alignment.bottomLeft,
                    child: pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text('Remarks : ' + data.remarks,
                            style: pw.TextStyle(
                              height: 2.0,
                              fontSize: 8,
                            )))),
                pw.Align(
                    alignment: pw.Alignment.centerLeft,
                    child: pw.SizedBox(
                      width: 300,
                      child: pw.Table.fromTextArray(
                          headerStyle:
                              pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          cellHeight: 10,
                          headerAlignment: pw.Alignment.center,
                          cellAlignment: pw.Alignment.centerLeft,
                          headerCount: 1,
                          headers: [
                            'Grading System',
                          ],
                          data: []),
                    )),
                pw.Align(
                    alignment: pw.Alignment.centerLeft,
                    child: pw.SizedBox(
                      width: 300,
                      child: pw.Table.fromTextArray(
                          headerStyle: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 8),
                          cellHeight: 8,
                          cellPadding: pw.EdgeInsets.all(3),
                          cellStyle: pw.TextStyle(fontSize: 6),
                          headerAlignment: pw.Alignment.centerLeft,
                          cellAlignment: pw.Alignment.centerLeft,
                          headerCount: 1,
                          headers: [
                            'Interval',
                            'Grade Point',
                            'Grade',
                            'Remarks',
                          ],
                          data: [
                            [
                              '90% to 100%',
                              '4.0',
                              'A+',
                              'Outstanding',
                            ],
                            [
                              '80% to Below Below 90%',
                              '3.6',
                              'A',
                              'Excellent',
                            ],
                            [
                              '70% to Below 80%',
                              '3.2',
                              'B+',
                              'Very Good',
                            ],
                            [
                              '60% to Below 70%',
                              '2.8',
                              'B',
                              'Good',
                            ],
                            [
                              '50% to Below 60%',
                              '2.4',
                              'C+',
                              'Satisfactory',
                            ],
                            [
                              '40% to Below 50%',
                              '4.0',
                              'C',
                              'Acceptable',
                            ],
                            [
                              '30% to Below 40%',
                              '1.6',
                              'D+',
                              'Partially Acceptable',
                            ],
                            [
                              '20% to Below 30%',
                              '1.2',
                              'D',
                              'Insufficient',
                            ],
                            [
                              '0% to Below 20%',
                              '0.8',
                              'E',
                              'Very Insufficient',
                            ],
                          ]),
                    )),
                pw.Padding(
                    padding: pw.EdgeInsets.all(8),
                    child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text('Teacher Suggestion : ',
                            style: pw.TextStyle(
                              height: 2.0,
                              fontSize: 10,
                            )))),
                pw.Spacer(),
                pw.Padding(
                    padding: pw.EdgeInsets.all(8),
                    child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Padding(
                                    padding: pw.EdgeInsets.all(5),
                                    child: pw.Container(
                                      height: 50,
                                      width: 50,
                                      child:
                                          pw.Image(pw.MemoryImage(class_tea!)),
                                    )),
                                pw.Container(
                                    width: 80,
                                    height: 0.5,
                                    color: PdfColors.black),
                                pw.Text(
                                  'class Teacher',
                                  style: pw.TextStyle(height: 2.0, fontSize: 8),
                                )
                              ]),
                          pw.Spacer(),
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Padding(
                                    padding: pw.EdgeInsets.all(5),
                                    child: pw.Container(
                                      height: 50,
                                      width: 50,
                                      child:
                                          pw.Image(pw.MemoryImage(exam_coo!)),
                                    )),
                                pw.Container(
                                    width: 80,
                                    height: 0.5,
                                    color: PdfColors.black),
                                pw.Text('Exam Coordinator',
                                    style:
                                        pw.TextStyle(height: 2.0, fontSize: 8))
                              ]),
                          pw.Spacer(),
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Padding(
                                    padding: pw.EdgeInsets.all(5),
                                    child: pw.Container(
                                      height: 20,
                                      child: pw.Text(data.exam_date,
                                          style: pw.TextStyle(
                                              height: 2.0, fontSize: 10)),
                                    )),
                                pw.Container(
                                    width: 80,
                                    height: 0.5,
                                    color: PdfColors.black),
                                pw.Text('Date of Issue',
                                    style:
                                        pw.TextStyle(height: 2.0, fontSize: 8))
                              ]),
                          pw.Spacer(),
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Padding(
                                    padding: pw.EdgeInsets.all(5),
                                    child: pw.Container(
                                      height: 50,
                                      width: 50,
                                      child: pw.Image(pw.MemoryImage(prince!)),
                                    )),
                                pw.Container(
                                    width: 80,
                                    height: 0.5,
                                    color: PdfColors.black),
                                pw.Text('Principal',
                                    style:
                                        pw.TextStyle(height: 2.0, fontSize: 8))
                              ])
                        ]))
              ],
            ),
          ),
          pw.Padding(
              padding: pw.EdgeInsets.all(15),
              child: pw.Container(
                height: 50,
                width: 50,
                child: pw.Image(pw.MemoryImage(image!)),
              )),
        ]),
      ); // Center
    }),
  ); // Page

  var file = await pdf.save();

  await storage
      .ref('sfs.pdf')
      .putData(file, SettableMetadata(contentType: 'application/pdf'))
      .then((p0) async {
    Upload().getMedia(p0.ref.fullPath);
  });
  print('Done');
  Navigator.pop(context);
}
