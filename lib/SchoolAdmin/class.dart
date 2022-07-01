import 'package:adminpannel/Agora/agora.dart';
import 'package:adminpannel/Attendancepages/StudentAttendance.dart';
import 'package:adminpannel/SchoolAdmin/Connector/getData.dart';
import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/AddResult.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Manage.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/SignUp_Staff.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/SignUp_student.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'Pages.dart/asignment.dart';

class Academics extends StatefulWidget {
  final class_;
  final section;

  const Academics({Key? key, this.class_, this.section}) : super(key: key);

  @override
  State<Academics> createState() => _AcademicsState();
}

class _AcademicsState extends State<Academics> {
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Academics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Container(
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  if (Provider.of<SchoolProvider>(context, listen: false)
                      .permissions
                      .contains('Homework Management'))
                    StreamBuilder(
                        stream: firestore
                            .collection(Provider.of<SchoolProvider>(context,
                                    listen: false)
                                .info
                                .name)
                            .doc('Academics')
                            .collection(widget.class_ + widget.section)
                            .doc('HomeWorks')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<
                                    DocumentSnapshot<Map<String, dynamic>>>
                                snapshot) {
                          return AdministrativeCard(
                            color: snapshot.hasData
                                ? snapshot.data!.data() != null
                                    ? snapshot.data!['Seen']
                                        ? Colors.green.shade100
                                        : Colors.white
                                    : Colors.white
                                : Colors.white,
                            icon: Icon(
                              Icons.task_alt,
                              color: Colors.white,
                            ),
                            title: 'Homework',
                            onTap: () {
                              print(snapshot.data!.data() == null);
                              if (snapshot.data!.data() != null) {
                                snapshot.data!.reference.set({'Seen': false});
                              }

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return HomeWork(
                                  section: widget.section,
                                  class_: widget.class_,
                                );
                              }));
                            },
                          );
                        }),
                  if (Provider.of<SchoolProvider>(context, listen: false)
                      .permissions
                      .contains('StudyMaterial Management'))
                    AdministrativeCard(
                      icon: Icon(
                        Icons.task_alt,
                        color: Colors.white,
                      ),
                      title: 'Study material',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => StudyMaterial(
                                      section: widget.section,
                                      class_: widget.class_,
                                    ))));
                      },
                    ),
                  if (Provider.of<SchoolProvider>(context, listen: false)
                      .permissions
                      .contains('Attendance Management'))
                    AdministrativeCard(
                      icon: Icon(
                        Icons.task_alt,
                        color: Colors.white,
                      ),
                      title: 'Attendance',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => StudentAttendance(
                                      section: widget.section,
                                      class_: widget.class_,
                                    ))));
                      },
                    ),
                  if (Provider.of<SchoolProvider>(context, listen: false)
                      .permissions
                      .contains('Routine Management'))
                    AdministrativeCard(
                      icon: Icon(
                        Icons.task_alt,
                        color: Colors.white,
                      ),
                      title: 'Routine',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Routine(
                              class_: widget.class_, section: widget.section);
                        }));
                      },
                    ),
                  if (Provider.of<SchoolProvider>(context, listen: false)
                      .permissions
                      .contains('Live Class Management'))
                    AdministrativeCard(
                      icon: Icon(
                        Icons.task_alt,
                        color: Colors.white,
                      ),
                      title: 'Live Classes',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => LiveClass(
                                    class_: widget.class_,
                                    section: widget.section))));
                      },
                    ),
                  if (Provider.of<SchoolProvider>(context, listen: false)
                      .permissions
                      .contains('Exam Management'))
                    AdministrativeCard(
                      icon: Icon(
                        Icons.task_alt,
                        color: Colors.white,
                      ),
                      title: 'Exam',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Exam(
                              class_: widget.class_, section: widget.section);
                        }));
                      },
                    ),
                  if (Provider.of<SchoolProvider>(context, listen: false)
                      .permissions
                      .contains('Result Management'))
                    AdministrativeCard(
                      icon: Icon(
                        Icons.task_alt,
                        color: Colors.white,
                      ),
                      title: 'Result',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Result(
                              class_: widget.class_, section: widget.section);
                        }));
                      },
                    ),
                  if (Provider.of<SchoolProvider>(context, listen: false)
                      .permissions
                      .contains('LeaveRequest Management'))
                    AdministrativeCard(
                      icon: Icon(
                        Icons.message_outlined,
                        color: Colors.white,
                      ),
                      title: 'Leave Requests',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LeaveRequests(
                              class_: widget.class_, section: widget.section);
                        }));
                      },
                    ),
                  if (Provider.of<SchoolProvider>(context, listen: false)
                      .permissions
                      .contains('Student Management'))
                    AdministrativeCard(
                        icon: Icon(
                          Icons.task_alt,
                          color: Colors.white,
                        ),
                        title: 'Students',
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return StudentRecords(
                                class_: widget.class_, section: widget.section);
                          }));
                        }),
                  if (Provider.of<SchoolProvider>(context, listen: false)
                      .permissions
                      .contains('Notice Management'))
                    AdministrativeCard(
                        icon: Icon(
                          Icons.task_alt,
                          color: Colors.white,
                        ),
                        title: 'Notice',
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Notices(
                                class_: widget.class_, section: widget.section);
                          }));
                        }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AdministrativeCard extends StatelessWidget {
  final title;
  final icon;
  final onTap;
  final color;
  const AdministrativeCard({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Card(
              color: color == null ? Color(0xffFFFFFF) : color,
              elevation: 5.0,
              child: Container(
                height: 150,
                width: 150,
                child: Center(
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xff59DBD3),
                      child: icon),
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class StudentRecords extends StatefulWidget {
  final class_;
  final section;
  const StudentRecords({Key? key, this.class_, this.section}) : super(key: key);

  @override
  State<StudentRecords> createState() => _StudentRecordsState();
}

class _StudentRecordsState extends State<StudentRecords> {
  Widget comp = Container();

  getOptions() async {
    Widget a = await GetData().getClassRecords(
        context: context, class_: widget.class_, section: widget.section);
    setState(() {
      comp = a;
    });
  }

  @override
  void initState() {
    getOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.class_ + ' ' + widget.section),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return UserStudent(
                        section: widget.section, class_: widget.class_);
                  }));
                },
                child: Text('Add New',
                    style: TextStyle(
                      color: Colors.white,
                    ))),
          )
        ],
      ),
      body: comp,
    );
  }
}

class Notices extends StatefulWidget {
  final class_;
  final section;
  const Notices({Key? key, this.class_, this.section}) : super(key: key);

  @override
  State<Notices> createState() => _NoticesState();
}

class _NoticesState extends State<Notices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.class_ + ' ' + widget.section),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AssignNotice(
                          class_: widget.class_,
                          section: widget.section,
                        );
                      },
                    ),
                  );
                },
                // onPressed: () {

                //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                //     return UserStudent(
                //         section: widget.section, class_: widget.class_);
                //   }));
                // },
                child: Text('Add New',
                    style: TextStyle(
                      color: Colors.white,
                    ))),
          )
        ],
      ),
      body: GetData().getNotices(context, widget.class_, widget.section),
    );
  }
}

class StaffRecords extends StatefulWidget {
  final class_;
  final section;
  const StaffRecords({Key? key, this.class_, this.section}) : super(key: key);

  @override
  State<StaffRecords> createState() => _StaffRecordsState();
}

class _StaffRecordsState extends State<StaffRecords> {
  Widget comp = Container();

  getOptions() async {
    Widget a = await GetData().getStaffRecords(
        context: context, class_: widget.class_, section: widget.section);
    setState(() {
      comp = a;
    });
  }

  @override
  void initState() {
    getOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Management'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignupStaff(
                          class_: widget.class_,
                          section: widget.section,
                        );
                      },
                    ),
                  );
                },
                child: Text('Add New',
                    style: TextStyle(
                      color: Colors.white,
                    ))),
          )
        ],
      ),
      body: comp,
    );
  }
}

class HomeWork extends StatefulWidget {
  final class_;
  final section;

  const HomeWork({Key? key, this.class_, this.section}) : super(key: key);

  @override
  State<HomeWork> createState() => _HomeWorkState();
}

class _HomeWorkState extends State<HomeWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeWork'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Assigns(
                                class_: widget.class_,
                                section: widget.section,
                              )));
                  // await Upload().addHomework(
                  //     context: context,
                  //     data: {'title': 'test', 'description': 'testing'},
                  //     class_: class_,
                  //     section: section);
                },
                child: Text(
                  'Add New',
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
      body: GetData().getHomework(context, widget.class_, widget.section),
    );
  }
}

class StudyMaterial extends StatelessWidget {
  final class_;
  final section;
  const StudyMaterial({Key? key, this.class_, this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StudyMaterial'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssignStudyMaterial(
                        class_: class_,
                        section: section,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Add New',
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
      body: GetData().getStudyMaterial(context, class_, section),
    );
  }
}

class StudentAttendance extends StatefulWidget {
  final class_;
  final section;
  const StudentAttendance({Key? key, this.class_, this.section})
      : super(key: key);

  @override
  State<StudentAttendance> createState() => _StudentAttendanceState();
}

class _StudentAttendanceState extends State<StudentAttendance> {
  bool status = false;
  List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thrusday',
    'Friday',
    'Saturday'
  ];
  var _selectedDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(_selectedDate),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        _selectedDate = '${DateFormat('yyyy-MM-dd').format(picked)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.class_ + ' ' + widget.section),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text(
                    'Change Date  $_selectedDate',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
        body: StreamBuilder(
            stream: GetData().getStudentsForAttendance(
                context: context,
                class_: widget.class_,
                section: widget.section),
            builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
              if (snap.hasData)
                for (var v in snap.data!.docs) {
                  Upload().addAttendance(
                      data: {
                        'Rollno': v['Information']['Rollno'],
                        'Name': v['Information']['Name'],
                        'Date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        'Day': DateFormat('EEEE').format(DateTime.now()),
                        'Status': 'A',
                        'Grade': v['Information']['Class'],
                      },
                      class_: widget.class_,
                      section: widget.section,
                      context: context);
                }
              return snap.hasData
                  ? GetData().getAttendances(
                      context, widget.class_, widget.section, _selectedDate)
                  : Container();
            }));
  }
}

class StaffAttendance extends StatefulWidget {
  final class_;
  final section;
  const StaffAttendance({Key? key, this.class_, this.section})
      : super(key: key);

  @override
  State<StaffAttendance> createState() => _StaffAttendanceState();
}

class _StaffAttendanceState extends State<StaffAttendance> {
  bool status = false;
  List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thrusday',
    'Friday',
    'Saturday'
  ];

  var _selectedDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(_selectedDate),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        _selectedDate = '${DateFormat('yyyy-MM-dd').format(picked)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Staff Attendance'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text(
                    'Change Date  $_selectedDate',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
        body: StreamBuilder(
            stream: GetData().getStaffForAttendance(
                context: context,
                class_: widget.class_,
                section: widget.section),
            builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
              if (snap.hasData)
                for (var v in snap.data!.docs) {
                  Upload().addStaffAttendance(
                      data: {
                        'DOB': v['Information']['DOB'],
                        'Name': v['Information']['Name'],
                        'Date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        'Per_Address': v['Information']['Per_Address'],
                        'Day': DateFormat('EEEE').format(DateTime.now()),
                        'Status': 'A',
                        'Phone_No': v['Information']['Phone_No'],
                      },
                      class_: widget.class_,
                      section: widget.section,
                      context: context);
                }
              return snap.hasData
                  ? GetData().getStaffAttendances(
                      context, widget.class_, widget.section, _selectedDate)
                  : Container();
            }));
  }
}

class Exam extends StatelessWidget {
  final class_;
  final section;
  const Exam({Key? key, this.class_, this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AssignExam(class_: class_, section: section)));
                },
                child: Text(
                  'Add New',
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
      body: GetData().getExam(context, class_, section),
    );
  }
}

class Result extends StatelessWidget {
  final class_;
  final section;
  const Result({Key? key, this.class_, this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Addresult(
                                class_: class_,
                                section: section,
                              )
                          //  AssignResult(class_: class_, section: section)

                          ));
                },
                child: Text(
                  'Add New',
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
      body: GetData().getResult(context, class_, section),
    );
  }
}

class LeaveRequests extends StatelessWidget {
  final class_;
  final section;
  const LeaveRequests({Key? key, this.class_, this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application'),
      ),
      body: GetData().getLeaveRequests(context, class_, section),
    );
  }
}

class Routine extends StatelessWidget {
  final class_;
  final section;
  const Routine({Key? key, this.class_, this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Routine'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AssignRoutine(class_: class_, section: section)));
                },
                child: Text(
                  'Add New',
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
      body: GetData().getRoutine(context, class_, section),
    );
  }
}

class LiveClass extends StatelessWidget {
  final class_;
  final section;
  const LiveClass({Key? key, this.class_, this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Class'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AssignLiveClass(class_: class_, section: section);
                  }));
                },
                child: Text(
                  'Add New',
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
      body: GetData().getLiveClass(context, class_, section),
    );
  }
}

class HomeWorkSubmission extends StatelessWidget {
  final snapshot;
  const HomeWorkSubmission({Key? key, required this.snapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submissions'),
      ),
      body: GetData().getSubmission(snapshot),
    );
  }
}
