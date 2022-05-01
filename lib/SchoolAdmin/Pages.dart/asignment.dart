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
  var file;
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
                            'Attachment',
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
                        },
                        class_: widget.class_,
                        section: widget.section);
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Please Fill All Filled',
                        backgroundColor: Colors.red);
                  }
                },
                child: Container(
                  child: Center(
                    child: Text(
                      'Send',
                      style: TextStyle(color: Colors.white),
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
