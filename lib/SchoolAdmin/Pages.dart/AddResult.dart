import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/dropdown.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Resultcomponent.dart';
import 'package:adminpannel/SchoolAdmin/ProgressIndicators.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Addresult extends StatefulWidget {
  final class_, section;
  Addresult({Key? key, this.class_, this.section}) : super(key: key);

  @override
  State<Addresult> createState() => _AddresultState();
}

class _AddresultState extends State<Addresult> {
  List<ResultSubjectObject> data = [];
  StudentDetailForResult info = StudentDetailForResult('', '', '', '');
  num totalGpa = 0;
  var namOfExam;
  @override
  void initState() {
    getFeeCatogary();
    super.initState();
  }

  getGrade(gpa) {
    Map grade = {
      4.0: 'A+',
      3.6: 'A',
      3.2: 'B+',
      2.8: 'B',
      2.4: 'C+',
      2.0: 'C',
      1.6: 'D+',
      1.2: 'D',
      0.8: 'E',
    };
    if (gpa >= 4.0) {
      return grade[4.0];
    } else if (gpa >= 3.6 && gpa < 4.0) {
      return grade[3.6];
    } else if (gpa >= 3.2 && gpa < 3.6) {
      return grade[3.2];
    } else if (gpa >= 2.8 && gpa < 3.2) {
      return grade[2.8];
    } else if (gpa >= 2.4 && gpa < 2.8) {
      return grade[2.4];
    } else if (gpa >= 2.0 && gpa < 2.4) {
      return grade[2.0];
    } else if (gpa >= 1.6 && gpa < 2.0) {
      return grade[1.6];
    } else if (gpa >= 1.2 && gpa < 1.6) {
      return grade[1.2];
    } else if (gpa <= 0.8) {
      return grade[0.8];
    }
  }

  getRemarks(g) {
    Map grade = {
      'A+': 'Outstanding',
      'A': 'Excelent',
      'B+': 'very good',
      'B': 'good',
      'C+': 'Satisfactory',
      'C': 'Acceptable',
      'D+': 'Partially Acceptable',
      'D': 'Insufficient',
      'E': 'Very Insufficient',
    };

    return grade[g];
  }

  getFeeCatogary() async {
    final firestore = FirebaseFirestore.instance;
    try {
      final response = firestore
          .collection(
              Provider.of<SchoolProvider>(context, listen: false).info.name)
          .doc('ExamSettings')
          .collection(DateTime.now().year.toString())
          .get()
          .then((value) {
        for (var v in value.docs) {
          Provider.of<SchoolProvider>(context, listen: false)
              .getExamNames(v['key']);
          print(v['key'].toString());
        }
      });
    } catch (e) {
      print(e);
    }
  }

  var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var class_teacher;
  var stamp;
  var principal;
  bool spin = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    AppBar(
                      title: Text('Add Result'),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 1.5, color: Colors.white),
                                  ),
                                  width: 900,
                                  height: 400,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              CircleAvatar(
                                                  backgroundColor: Colors.grey,
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      Provider.of<SchoolProvider>(
                                                              context)
                                                          .info
                                                          .logo)),
                                              SizedBox(
                                                width: 150,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  Provider.of<SchoolProvider>(
                                                          context,
                                                          listen: false)
                                                      .info
                                                      .name,
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        AddMarksField(
                                          value: (a) {
                                            if (a.creditHour != '' &&
                                                a.finalGrade != '' &&
                                                a.gradePoint != '' &&
                                                a.practical != '' &&
                                                a.theory != '') {
                                              setState(() {
                                                data.add(a);
                                              });
                                              setState(() {
                                                num total_gp_obtained = 0;
                                                num total_credit = 0;
                                                for (var v in data) {
                                                  total_gp_obtained +=
                                                      num.parse(v.gradePoint
                                                          .toString());
                                                  print(total_gp_obtained);
                                                  total_credit +=
                                                      num.parse(v.creditHour);
                                                  print(total_credit);
                                                }

                                                setState(() {
                                                  totalGpa = total_gp_obtained *
                                                      4 /
                                                      total_credit;
                                                });
                                              });
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: 'Please Fill All Field');
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Signaturefield(
                                                txtss: 'Date',
                                                url: date,
                                                image: true),
                                            InkWell(
                                              onTap: () async {
                                                await Upload()
                                                    .uploadFile(context)
                                                    .then((value) async {
                                                  await Upload()
                                                      .getMediaLink(value)
                                                      .then((v) {
                                                    setState(() {
                                                      class_teacher = v;
                                                    });
                                                  });
                                                });
                                              },
                                              child: Signaturefield(
                                                  txtss: 'Class Teacher',
                                                  url: class_teacher),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                await Upload()
                                                    .uploadFile(context)
                                                    .then((value) async {
                                                  await Upload()
                                                      .getMediaLink(value)
                                                      .then((v) {
                                                    setState(() {
                                                      stamp = v;
                                                    });
                                                  });
                                                });
                                              },
                                              child: Signaturefield(
                                                  txtss: 'Stamp', url: stamp),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                await Upload()
                                                    .uploadFile(context)
                                                    .then((value) async {
                                                  await Upload()
                                                      .getMediaLink(value)
                                                      .then((v) {
                                                    setState(() {
                                                      principal = v;
                                                    });
                                                  });
                                                });
                                              },
                                              child: Signaturefield(
                                                  txtss: 'Principal',
                                                  url: principal),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1.5, color: Colors.black),
                                ),
                                width: 900,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            radius: 25,
                                            backgroundImage: NetworkImage(
                                                Provider.of<SchoolProvider>(
                                                        context)
                                                    .info
                                                    .logo)),
                                        SizedBox(
                                          width: 200,
                                        ),
                                        Expanded(
                                          child: Text(
                                            Provider.of<SchoolProvider>(context,
                                                    listen: false)
                                                .info
                                                .name,
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Name:',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Class:',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Roll No:',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                info.name,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                info.class_,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                info.roll_no,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Section:',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                info.section,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 140,
                                          child: VerticalDivider(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Result',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Exam:',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                        width: 300,
                                                        height: 70,
                                                        child: DropDown(
                                                          items: Provider.of<
                                                                      SchoolProvider>(
                                                                  context)
                                                              .examNames,
                                                          onchange: (a) {
                                                            setState(() {
                                                              namOfExam = a;
                                                            });
                                                          },
                                                        ))),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'SN',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          child: VerticalDivider(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Subjects Name',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          child: VerticalDivider(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Cradit Hour',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          child: VerticalDivider(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Obtained Grade',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        'Th',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Container(
                                                        width: 50,
                                                        height: 20,
                                                        child: VerticalDivider(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Pr',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          child: VerticalDivider(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Final Grade',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          child: VerticalDivider(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Grade Point',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Column(
                                      children: data
                                          .map((e) => Stack(
                                                children: [
                                                  Resultcard(
                                                      data: e,
                                                      index:
                                                          '${data.indexOf(e) + 1}'),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            data.remove(e);
                                                          });
                                                          setState(() {
                                                            num total_gp_obtained =
                                                                0;
                                                            num total_credit =
                                                                0;
                                                            for (var v
                                                                in data) {
                                                              total_gp_obtained +=
                                                                  num.parse(v
                                                                      .gradePoint
                                                                      .toString());
                                                              print(
                                                                  total_gp_obtained);
                                                              total_credit +=
                                                                  num.parse(v
                                                                      .creditHour);
                                                              print(
                                                                  total_credit);
                                                            }

                                                            setState(() {
                                                              totalGpa =
                                                                  total_gp_obtained *
                                                                      4 /
                                                                      total_credit;
                                                            });
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.close_rounded,
                                                          color: Colors.red,
                                                        )),
                                                  )
                                                ],
                                              ))
                                          .toList(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'GPA : ${totalGpa.toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Grade : ${getGrade(totalGpa)}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          'Remarks : ${getRemarks(getGrade(totalGpa))}'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          'Position : Position will be calculated after submitting'),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: CupertinoButton.filled(
                                    child: Text('Submit'),
                                    onPressed: () {
                                      final firestore =
                                          FirebaseFirestore.instance;
                                      Map<String, dynamic> map = {
                                        'Info': {
                                          'name': info.name,
                                          'class': info.class_,
                                          'rollno': info.roll_no,
                                          'section': info.section,
                                          'ExamName': namOfExam,
                                          'gpa': '$totalGpa',
                                          'Grade': getGrade(totalGpa),
                                          'Remarks':
                                              getRemarks(getGrade(totalGpa))
                                                  .toString(),
                                          'date': date.toString(),
                                          'class_teacher': class_teacher,
                                          'stamp': stamp,
                                          'principal': principal,
                                        },
                                        'Marks': [],
                                      };
                                      for (var s in data) {
                                        map['Marks'].add({
                                          'subject': s.subject,
                                          'creditHour': s.creditHour,
                                          'theory': s.theory,
                                          'practical': s.practical,
                                          'final_grade': s.finalGrade,
                                          'gpa': s.gradePoint,
                                        });
                                      }

                                      if (namOfExam != null &&
                                          info.name != '') {
                                        setState(() {
                                          spin = true;
                                        });
                                        Upload().addResult(
                                          data: map,
                                          context: context,
                                          class_: widget.class_,
                                          section: widget.section,
                                        );
                                        setState(() {
                                          spin = false;
                                        });
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Please Select Student and Name of Exam');
                                      }
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: SearchBar(
                      class_: widget.class_,
                      section: widget.section,
                      value: (a) {
                        setState(() {
                          info = a;
                        });
                      },
                    )),
              ],
            ),
          ),
        ),
        Center(
          child: indicator(spin),
        )
      ],
    );
  }
}

class SearchBar extends StatefulWidget {
  final class_, section;
  final Function(StudentDetailForResult)? value;
  const SearchBar({Key? key, this.class_, this.section, this.value})
      : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final controller = TextEditingController();
  List<StudentDetailForResult> student = [];

  bool textFeildFocus = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: AnimatedContainer(
        width: 290,
        height: textFeildFocus ? 300 : 50,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  offset: Offset(0, 0),
                  spreadRadius: 0.2,
                  blurRadius: 0.7)
            ],
            border: Border.all(
              color: Colors.green,
            ),
            borderRadius: BorderRadius.circular(10)),
        duration: Duration(milliseconds: 500),
        child: Column(children: [
          Container(
            child: TextField(
                onSubmitted: (a) {
                  setState(() {
                    textFeildFocus = false;
                  });
                },
                onTap: () {
                  setState(() {
                    textFeildFocus = true;
                  });
                },
                decoration: InputDecoration(
                    hintText: 'Search Student',
                    hintStyle: TextStyle(fontSize: 12),
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none),
                controller: controller,
                onChanged: (a) async {
                  final firestore = FirebaseFirestore.instance;
                  try {
                    final response = await firestore
                        .collection(
                            Provider.of<SchoolProvider>(context, listen: false)
                                .info
                                .name)
                        .doc('Academics')
                        .collection(widget.class_ + widget.section)
                        .doc('Students')
                        .collection(DateTime.now().year.toString())
                        .get();
                    List<StudentDetailForResult> data = [];
                    response.docs.forEach((element) {
                      var v = element['Information'];

                      if (v.toString().contains(a)) {
                        print(v['Name']);
                        data.add(StudentDetailForResult(
                            v['Name'], v['Rollno'], v['Class'], v['Section']));
                      } else {
                        print('wrng');
                      }
                    });
                    setState(() {
                      student = data;
                    });
                  } catch (e) {
                    print(e);
                  }
                  print(student.length);
                }),
          ),
          Expanded(
              child: ListView(
            children: student.map((e) {
              return ListTile(
                title: Text('Name : ' + e.name),
                subtitle: Text('Roll No : ' + e.roll_no),
                onTap: () {
                  widget.value!(e);
                  textFeildFocus = false;
                  setState(() {
                    controller.text = e.name;
                  });
                },
              );
            }).toList(),
          ))
        ]),
      ),
    );
  }
}

class StudentDetailForResult {
  final name;
  final roll_no;
  final class_;
  final section;

  StudentDetailForResult(this.name, this.roll_no, this.class_, this.section);
}

class AddMarksField extends StatefulWidget {
  final Function(ResultSubjectObject)? value;
  AddMarksField({
    Key? key,
    this.value,
  }) : super(key: key);

  @override
  State<AddMarksField> createState() => _AddMarksFieldState();
}

class _AddMarksFieldState extends State<AddMarksField> {
  final subjectController = TextEditingController();

  final credit_hour = TextEditingController();

  final obtained_theory = TextEditingController();

  final obtained_practical = TextEditingController();

  final g_p_a = TextEditingController();

  final finalGarde = TextEditingController();

  final theory = TextEditingController();
  final practical = TextEditingController();
  getGrade(gpa) {
    Map grade = {
      4.0: 'A+',
      3.6: 'A',
      3.2: 'B+',
      2.8: 'B',
      2.4: 'C+',
      2.0: 'C',
      1.6: 'D+',
      1.2: 'D',
      0.8: 'E',
    };
    if (gpa >= 4.0) {
      return grade[4.0];
    } else if (gpa >= 3.6 && gpa < 4.0) {
      return grade[3.6];
    } else if (gpa >= 3.2 && gpa < 3.6) {
      return grade[3.2];
    } else if (gpa >= 2.8 && gpa < 3.2) {
      return grade[2.8];
    } else if (gpa >= 2.4 && gpa < 2.8) {
      return grade[2.4];
    } else if (gpa >= 2.0 && gpa < 2.4) {
      return grade[2.0];
    } else if (gpa >= 1.6 && gpa < 2.0) {
      return grade[1.6];
    } else if (gpa >= 1.2 && gpa < 1.6) {
      return grade[1.2];
    } else if (gpa <= 0.8) {
      return grade[0.8];
    }
  }

  getGPA(grads) {
    Map grade = {
      'A+': 4.0,
      'A': 3.6,
      'B+': 3.2,
      'B': 2.8,
      'C+': 2.4,
      'C': 2.0,
      'D+': 1.6,
      'D': 1.2,
      'E': 0.8,
    };

    return grade[grads];
  }

  percentToGpa(percent) {
    print(percent);
    if (percent > 90)
      return 4;
    else if (percent > 80 && percent <= 90)
      return 3.6;
    else if (percent > 70 && percent <= 80)
      return 3.2;
    else if (percent > 60 && percent <= 70)
      return 2.8;
    else if (percent > 50 && percent <= 60)
      return 2.4;
    else if (percent > 40 && percent <= 50)
      return 2.0;
    else if (percent > 30 && percent <= 40)
      return 1.6;
    else if (percent > 20 && percent <= 30)
      return 1.2;
    else if (percent > 0 && percent <= 20) return 0.8;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Resultifeld(
          txts: 'Subjects',
          controllers: subjectController,
        ),
        Resultifeld(
          txts: 'Cradit Hour',
          controllers: credit_hour,
        ),
        Resultifeld(
          txts: 'Theory Max',
          controllers: theory,
        ),
        Resultifeld(
          txts: 'Practical Max',
          controllers: practical,
        ),
        Resultifeld(
          txts: 'Theory',
          controllers: obtained_theory,
        ),
        Resultifeld(
          txts: 'Practical',
          controllers: obtained_practical,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              var total = num.parse(obtained_theory.text) +
                  num.parse(obtained_practical.text);
              var pract = num.parse(obtained_practical.text) *
                  100 /
                  num.parse(practical.text);
              var theo = num.parse(obtained_theory.text) *
                  100 /
                  num.parse(theory.text);
              var totalMarks =
                  num.parse(theory.text) + num.parse(practical.text);
              var percent = '${total * 100 / totalMarks}';

              widget.value!(
                ResultSubjectObject(
                  subjectController.text,
                  credit_hour.text,
                  getGrade(percentToGpa(theo)),
                  getGrade(percentToGpa(pract)),
                  getGrade(percentToGpa(num.parse(percent))),
                  getGPA(
                    getGrade(
                      percentToGpa(num.parse(percent)),
                    ),
                  ).toString(),
                ),
              );
            },
            child: CircleAvatar(
              backgroundColor: Color(0xff02242C),
              radius: 17,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 15,
                child: Icon(
                  Icons.done,
                  color: Color(0xff02242C),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class Signaturefield extends StatelessWidget {
  final String txtss;
  final url;
  final image;
  const Signaturefield({
    Key? key,
    required this.txtss,
    this.url,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 110,
      width: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          image == null
              ? url != null
                  ? Container(
                      width: 75,
                      height: 75,
                      child: Image.network(url, width: 50, height: 50))
                  : Container()
              : url != null
                  ? Text(url)
                  : Container(),
          Divider(
            color: Colors.black,
          ),
          Text(
            txtss,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class Resultifeld extends StatelessWidget {
  final String txts;
  final controllers;
  const Resultifeld({
    Key? key,
    required this.txts,
    required this.controllers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: TextField(
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            controller: controllers,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: txts,
            ),
          ),
        ),
      ),
      width: 125,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 2,
          color: Color(0xff7AF37F),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class ResultSubjectObject {
  final subject;
  final creditHour;
  final theory;
  final practical;
  final finalGrade;
  final gradePoint;

  ResultSubjectObject(
    this.subject,
    this.creditHour,
    this.theory,
    this.practical,
    this.finalGrade,
    this.gradePoint,
  );
}
