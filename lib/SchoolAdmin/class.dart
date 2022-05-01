import 'package:adminpannel/Agora/agora.dart';
import 'package:adminpannel/SchoolAdmin/Connector/getData.dart';
import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Manage.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/SignUp_student.dart';
import 'package:flutter/material.dart';

import 'Pages.dart/asignment.dart';

class Academics extends StatefulWidget {
  final class_;
  final section;

  const Academics({Key? key, this.class_, this.section}) : super(key: key);

  @override
  State<Academics> createState() => _AcademicsState();
}

class _AcademicsState extends State<Academics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff12B081),
        title: Text('Academics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Wrap(
            alignment: WrapAlignment.start,
            children: [
              AdministrativeCard(
                icon: Icon(Icons.task_alt),
                title: 'Homework',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeWork(
                      section: widget.section,
                      class_: widget.class_,
                    );
                  }));
                },
              ),
              AdministrativeCard(
                icon: Icon(Icons.task_alt),
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
              AdministrativeCard(
                icon: Icon(Icons.task_alt),
                title: 'Attendance',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => Attendance(
                                section: widget.section,
                                class_: widget.class_,
                              ))));
                },
              ),
              AdministrativeCard(
                icon: Icon(Icons.task_alt),
                title: 'Routine',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Routine(
                        class_: widget.class_, section: widget.section);
                  }));
                },
              ),
              AdministrativeCard(
                icon: Icon(Icons.task_alt),
                title: 'Live Classes',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => AgoraSDK(
                              class_: widget.class_,
                              section: widget.section))));
                },
              ),
              AdministrativeCard(
                icon: Icon(Icons.task_alt),
                title: 'Exam',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Exam(class_: widget.class_, section: widget.section);
                  }));
                },
              ),
              AdministrativeCard(
                  icon: Icon(Icons.task_alt),
                  title: 'Students',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return StudentRecords(
                          class_: widget.class_, section: widget.section);
                    }));
                  }),
              AdministrativeCard(
                icon: Icon(Icons.task_alt),
                title: 'Staff Attendance',
              ),
              AdministrativeCard(
                icon: Icon(Icons.task_alt),
                title: 'Staff',
              ),
            ],
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
  const AdministrativeCard({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
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
              color: Color(0xFFC4EEE8),
              elevation: 5.0,
              child: Container(
                height: 150,
                width: 150,
                child: icon,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Text(title)
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

class HomeWork extends StatelessWidget {
  final class_;
  final section;

  const HomeWork({Key? key, this.class_, this.section}) : super(key: key);

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
                                class_: class_,
                                section: section,
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
      body: GetData().getHomework(context, class_, section),
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
                  await Upload().addStudyMaterial(
                      context: context,
                      data: {'title': 'test', 'description': 'testing'},
                      class_: class_,
                      section: section);
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

class Attendance extends StatelessWidget {
  final class_;
  final section;
  const Attendance({Key? key, this.class_, this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendace')),
      body: GetData().getAttendances(context, class_, section),
    );
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
                  await Upload().addExam(
                      context: context,
                      data: {'title': 'test', 'description': 'testing'},
                      class_: class_,
                      section: section);
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
                  await Upload().addRoutine(
                      context: context,
                      data: {'title': 'test', 'description': 'testing'},
                      class_: class_,
                      section: section);
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
        title: Text('LIveClass'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                onPressed: () async {
                  await Upload().addLiveClass(
                      context: context,
                      data: {'title': 'test', 'description': 'testing'},
                      class_: class_,
                      section: section);
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
