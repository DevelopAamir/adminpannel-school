import 'package:adminpannel/Agora/agora.dart';
import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Assigns extends StatefulWidget {
  final class_;
  final section;
  const Assigns({Key? key, this.class_, this.section}) : super(key: key);

  @override
  State<Assigns> createState() => _AssignsState();
}

class _AssignsState extends State<Assigns> {
  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _chapter = TextEditingController();
  TextEditingController _discription = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TextEditingController _submissionDate = TextEditingController();
  TextEditingController _subjectcontroller = TextEditingController();
  var file;
  bool progress = false;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _submissionDate.text = '${DateFormat('yyyy-MM-dd').format(picked)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5FFFD),
      appBar: AppBar(
        backgroundColor: Color(0xff12B081),
        title: Text('Assign'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Textfilds(
              controllers: _titlecontroller,
              titles: 'Title',
            ),
            Textfilds(
              controllers: _chapter,
              titles: 'Chapter',
            ),
            Textfilds(
              controllers: _discription,
              titles: 'Discription',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 400,
                child: Center(
                  child: TextField(
                    onTap: () async {
                      await _selectDate(context);
                    },
                    textAlign: TextAlign.start,
                    controller: _submissionDate,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Icon(Icons.calendar_month),
                      ),

                      fillColor: Color.fromARGB(255, 223, 219, 219),
                      filled: true,
                      hintText: 'Submission Date',
                      // labelText: "Fill Details",
                      labelStyle:
                          TextStyle(color: Colors.black54, fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    await Upload().uploadFile(context).then((value) => setState(
                          () => file = value,
                        ));
                  },
                  child: Container(
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            file == null
                                ? 'Attachments'
                                : file.toString().split('/').last,
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.attachment,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                    height: 40,
                    width: 400,
                    color: Color.fromARGB(255, 223, 219, 219),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  if (_titlecontroller.text.isNotEmpty &&
                      file != null &&
                      _submissionDate.text.isNotEmpty) {
                    setState(() {
                      progress = true;
                    });
                    await Upload().addHomework(
                        context: context,
                        data: {
                          'title': _titlecontroller.text.trim(),
                          'description': _discription.text.trim(),
                          'attachment': file.toString(),
                          'chapter': _chapter.text.trim(),
                          'submission_date': _submissionDate.text.trim(),
                          'added_by': Provider.of<SchoolProvider>(context,
                                  listen: false)
                              .admin['Information']['UserName']
                              .toString(),
                          'Date_Added':
                              DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          'subject': _subjectcontroller.text
                        },
                        class_: widget.class_,
                        section: widget.section);
                    Fluttertoast.showToast(
                        msg: 'Homework Added Sucessfully',
                        timeInSecForIosWeb: 3,
                        webShowClose: true);
                    _titlecontroller.clear();
                    _discription.clear();
                    _submissionDate.clear();
                    _chapter.clear();

                    setState(() {
                      progress = false;
                      file = null;
                    });
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Please Fill All Filled',
                      webBgColor: "linear-gradient(to right,#FF0000,#FF6347)",
                    );
                  }
                },
                child: Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Send',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if (progress)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            )),
                          )
                      ],
                    ),
                  ),
                  height: 40,
                  width: 400,
                  color: Color(0xff78F5DF),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Textfilds extends StatelessWidget {
  final String titles;
  final TextEditingController controllers;

  const Textfilds({Key? key, required this.titles, required this.controllers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.transparent,
        height: 50,
        width: 400,
        child: Center(
          child: TextField(
            textAlign: TextAlign.start,
            controller: controllers,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              fillColor: Color.fromARGB(255, 231, 229, 229),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
              hintText: titles,
              // labelText: "Fill Details",
              labelStyle: TextStyle(color: Colors.black54, fontSize: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AssignStudyMaterial extends StatefulWidget {
  final class_;
  final section;
  const AssignStudyMaterial({Key? key, this.class_, this.section})
      : super(key: key);

  @override
  State<AssignStudyMaterial> createState() => _AssignStudyMaterialState();
}

class _AssignStudyMaterialState extends State<AssignStudyMaterial> {
  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _chapter = TextEditingController();
  TextEditingController _discription = TextEditingController();
  TextEditingController _subjectcontroller = TextEditingController();

  var file;
  bool progress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5FFFD),
      appBar: AppBar(
        backgroundColor: Color(0xff12B081),
        title: Text('Assign'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Textfilds(
              controllers: _titlecontroller,
              titles: 'Title',
            ),
            Textfilds(
              controllers: _subjectcontroller,
              titles: 'Subject',
            ),
            Textfilds(
              controllers: _chapter,
              titles: 'Chapter',
            ),
            Textfilds(
              controllers: _discription,
              titles: 'Discription',
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     height: 50,
            //     width: 400,
            //     child: Center(
            //       child: TextField(
            //         onTap: () async {
            //           await _selectDate(context);
            //         },
            //         textAlign: TextAlign.start,
            //         controller: _submissionDate,
            //         decoration: InputDecoration(
            //           enabledBorder: InputBorder.none,
            //           focusedBorder: OutlineInputBorder(
            //             borderSide:
            //                 const BorderSide(color: Colors.white, width: 2.0),
            //             borderRadius: BorderRadius.circular(25.0),
            //           ),
            //           suffixIcon: Padding(
            //             padding: const EdgeInsets.only(right: 10.0),
            //             child: Icon(Icons.calendar_month),
            //           ),

            //           fillColor: Color.fromARGB(255, 223, 219, 219),
            //           filled: true,
            //           hintText: 'Submission Date',
            //           // labelText: "Fill Details",
            //           labelStyle:
            //               TextStyle(color: Colors.black54, fontSize: 15),
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(20.0),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    await Upload().uploadFile(context).then((value) => setState(
                          () => file = value,
                        ));
                  },
                  child: Container(
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            file == null
                                ? 'Attachments'
                                : file.toString().split('/').last,
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.attachment,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                    height: 40,
                    width: 400,
                    color: Color.fromARGB(255, 223, 219, 219),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  if (_titlecontroller.text.isNotEmpty && file != null) {
                    setState(() {
                      progress = true;
                    });
                    await Upload().addStudyMaterial(
                        context: context,
                        data: {
                          'title': _titlecontroller.text,
                          'Description': _discription.text,
                          'Attachment': file,
                          'subject': _subjectcontroller.text,
                          'Date_Added':
                              DateFormat('yyyy-MM-dd').format(DateTime.now())
                        },
                        class_: widget.class_,
                        section: widget.section);
                    Fluttertoast.showToast(
                        msg: 'StudyMaterial Added Sucessfully',
                        timeInSecForIosWeb: 3,
                        webShowClose: true);
                    _titlecontroller.clear();
                    _discription.clear();
                    _subjectcontroller.clear();
                    _chapter.clear();

                    setState(() {
                      progress = false;
                      file = null;
                    });
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Please Fill All Filled',
                      webBgColor: "linear-gradient(to right,#FF0000,#FF6347)",
                    );
                  }
                },
                child: Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Send',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if (progress)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            )),
                          )
                      ],
                    ),
                  ),
                  height: 40,
                  width: 400,
                  color: Color(0xff78F5DF),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AssignExam extends StatefulWidget {
  final class_;
  final section;
  const AssignExam({Key? key, this.class_, this.section}) : super(key: key);

  @override
  State<AssignExam> createState() => _AssignExamState();
}

class _AssignExamState extends State<AssignExam> {
  TextEditingController _titlecontroller = TextEditingController();

  TextEditingController _examUrl = TextEditingController();
  TextEditingController _subjectcontroller = TextEditingController();
  TextEditingController _examDate = TextEditingController();
  var selectedDate = DateTime.now();

  var file;
  bool progress = false;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _examDate.text = '${DateFormat('yyyy-MM-dd').format(picked)}';
      });
    }
    final timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timePicked != null) {
      setState(() {
        _examDate.text =
            _examDate.text + '  ' + timePicked.format(context).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5FFFD),
      appBar: AppBar(
        backgroundColor: Color(0xff12B081),
        title: Text('Assign'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Textfilds(
              controllers: _titlecontroller,
              titles: 'Title',
            ),
            Textfilds(
              controllers: _subjectcontroller,
              titles: 'Subject',
            ),
            Textfilds(
              controllers: _examUrl,
              titles: 'Enter Url',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 400,
                child: Center(
                  child: TextField(
                    onTap: () async {
                      await _selectDate(context);
                    },
                    textAlign: TextAlign.start,
                    controller: _examDate,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Icon(Icons.calendar_month),
                      ),

                      fillColor: Color.fromARGB(255, 223, 219, 219),
                      filled: true,
                      hintText: 'Exam Date ',
                      // labelText: "Fill Details",
                      labelStyle:
                          TextStyle(color: Colors.black54, fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  if (_titlecontroller.text.isNotEmpty &&
                      _examUrl.text.isNotEmpty) {
                    setState(() {
                      progress = true;
                    });
                    await Upload().addExam(
                        context: context,
                        data: {
                          'title': _titlecontroller.text,
                          'url': _examUrl.text,
                          'subject': _subjectcontroller.text,
                          'Date_Added':
                              DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          'exam_date': _examDate.text
                        },
                        class_: widget.class_,
                        section: widget.section);
                    Fluttertoast.showToast(
                        msg: 'Exam Added Sucessfully',
                        timeInSecForIosWeb: 3,
                        webShowClose: true);
                    _titlecontroller.clear();

                    _subjectcontroller.clear();

                    setState(() {
                      progress = false;
                      file = null;
                    });
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Please Fill All Filled',
                      webBgColor: "linear-gradient(to right,#FF0000,#FF6347)",
                    );
                  }
                },
                child: Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Send',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if (progress)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            )),
                          )
                      ],
                    ),
                  ),
                  height: 40,
                  width: 400,
                  color: Color(0xff78F5DF),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AssignResult extends StatefulWidget {
  final class_;
  final section;
  const AssignResult({Key? key, this.class_, this.section}) : super(key: key);

  @override
  State<AssignResult> createState() => _AssignResultState();
}

class _AssignResultState extends State<AssignResult> {
  TextEditingController _titlecontroller = TextEditingController();

  TextEditingController _examUrl = TextEditingController();
  TextEditingController _subjectcontroller = TextEditingController();
  TextEditingController _examDate = TextEditingController();
  var selectedDate = DateTime.now();

  var file;
  bool progress = false;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _examDate.text = '${DateFormat('yyyy-MM-dd').format(picked)}';
      });
    }
    final timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timePicked != null) {
      setState(() {
        _examDate.text =
            _examDate.text + '  ' + timePicked.format(context).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5FFFD),
      appBar: AppBar(
        backgroundColor: Color(0xff12B081),
        title: Text('Assign'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Textfilds(
              controllers: _titlecontroller,
              titles: 'Title',
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    await Upload().uploadFile(context).then((value) => setState(
                          () => file = value,
                        ));
                  },
                  child: Container(
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            file == null
                                ? 'Attachments'
                                : file.toString().split('/').last,
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.attachment,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                    height: 40,
                    width: 400,
                    color: Color.fromARGB(255, 223, 219, 219),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  if (_titlecontroller.text.isNotEmpty && file != null) {
                    setState(() {
                      progress = true;
                    });
                    await Upload().addResult(
                        context: context,
                        data: {
                          'title': _titlecontroller.text,
                          'url': file,
                          'Date_Added':
                              DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        },
                        class_: widget.class_,
                        section: widget.section);
                    Fluttertoast.showToast(
                        msg: 'Result Added Sucessfully',
                        timeInSecForIosWeb: 3,
                        webShowClose: true);
                    _titlecontroller.clear();

                    _subjectcontroller.clear();

                    setState(() {
                      progress = false;
                      file = null;
                    });
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Please Fill All Filled',
                      webBgColor: "linear-gradient(to right,#FF0000,#FF6347)",
                    );
                  }
                },
                child: Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Send',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if (progress)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            )),
                          )
                      ],
                    ),
                  ),
                  height: 40,
                  width: 400,
                  color: Color(0xff78F5DF),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AssignRoutine extends StatefulWidget {
  final class_;
  final section;
  const AssignRoutine({Key? key, this.class_, this.section}) : super(key: key);

  @override
  State<AssignRoutine> createState() => _AssignRoutineState();
}

class _AssignRoutineState extends State<AssignRoutine> {
  TextEditingController _titlecontroller = TextEditingController();

  var file;
  bool progress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5FFFD),
      appBar: AppBar(
        backgroundColor: Color(0xff12B081),
        title: Text('Assign'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Textfilds(
              controllers: _titlecontroller,
              titles: 'Title',
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    await Upload().uploadFile(context).then((value) => setState(
                          () => file = value,
                        ));
                  },
                  child: Container(
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            file == null
                                ? 'Attachments'
                                : file.toString().split('/').last,
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.attachment,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                    height: 40,
                    width: 400,
                    color: Color.fromARGB(255, 223, 219, 219),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  if (_titlecontroller.text.isNotEmpty && file != null) {
                    setState(() {
                      progress = true;
                    });
                    await Upload().addRoutine(
                        context: context,
                        data: {
                          'title': _titlecontroller.text,
                          'file': file,
                          'Date_Added':
                              DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        },
                        class_: widget.class_,
                        section: widget.section);
                    Fluttertoast.showToast(
                        msg: 'Routine Added Sucessfully',
                        timeInSecForIosWeb: 3,
                        webShowClose: true);
                    _titlecontroller.clear();

                    setState(() {
                      progress = false;
                      file = null;
                    });
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Please Fill All Filled',
                      webBgColor: "linear-gradient(to right,#FF0000,#FF6347)",
                    );
                  }
                },
                child: Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Send',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if (progress)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            )),
                          )
                      ],
                    ),
                  ),
                  height: 40,
                  width: 400,
                  color: Color(0xff78F5DF),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AssignLiveClass extends StatefulWidget {
  final class_;
  final section;
  const AssignLiveClass({Key? key, this.class_, this.section})
      : super(key: key);

  @override
  State<AssignLiveClass> createState() => _AssignLiveClassState();
}

class _AssignLiveClassState extends State<AssignLiveClass> {
  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _examDate = TextEditingController();
  final _auth = FirebaseAuth.instance;
  var file;
  bool progress = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        _examDate.text = '${DateFormat('yyyy-MM-dd').format(picked)}';
      });
    }
    final timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timePicked != null) {
      setState(() {
        _examDate.text =
            _examDate.text + '  ' + timePicked.format(context).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5FFFD),
      appBar: AppBar(
        backgroundColor: Color(0xff12B081),
        title: Text('Assign'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Textfilds(
              controllers: _titlecontroller,
              titles: 'Title',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 400,
                child: Center(
                  child: TextField(
                    onTap: () async {
                      await _selectDate(context);
                    },
                    textAlign: TextAlign.start,
                    controller: _examDate,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Icon(Icons.calendar_month),
                      ),

                      fillColor: Color.fromARGB(255, 223, 219, 219),
                      filled: true,
                      hintText: 'Exam schedule ',
                      // labelText: "Fill Details",
                      labelStyle:
                          TextStyle(color: Colors.black54, fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  if (_titlecontroller.text.isNotEmpty) {
                    setState(() {
                      progress = true;
                    });

                    await Upload().addLiveClass(
                        context: context,
                        data: {
                          'title': _titlecontroller.text,
                          'date': _examDate.text,
                          'Date_Added':
                              DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          'status': 'pending',
                          'Host': _auth.currentUser!.email,
                        },
                        class_: widget.class_,
                        section: widget.section);
                    AgoraSDK(
                      channel: widget.class_ +
                          widget.section +
                          _titlecontroller.text,
                      class_: widget.class_,
                      section: widget.section,
                    );
                    Fluttertoast.showToast(
                        msg: 'Live Class Added Sucessfully',
                        timeInSecForIosWeb: 3,
                        webShowClose: true);
                    _titlecontroller.clear();

                    setState(() {
                      progress = false;
                      file = null;
                    });
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Please Fill All Filled',
                      webBgColor: "linear-gradient(to right,#FF0000,#FF6347)",
                    );
                  }
                },
                child: Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Send',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if (progress)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            )),
                          )
                      ],
                    ),
                  ),
                  height: 40,
                  width: 400,
                  color: Color(0xff78F5DF),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
