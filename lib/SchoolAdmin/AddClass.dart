import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/ProgressIndicators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddClass extends StatefulWidget {
  AddClass({Key? key}) : super(key: key);

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  final classController = TextEditingController();

  final sectionsController = TextEditingController();
  bool spin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Class'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: classController,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      labelText: 'Enter Class',
                      hintText: 'Enter Class',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: sectionsController,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      labelText: 'Enter Section',
                      hintText: 'Enter Section',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CupertinoButton(
                  // color: Color(0xff12B081),
                  child: Text('Next'),
                  onPressed: () async {
                    if (classController.text != '' &&
                        sectionsController.text != '') {
                      setState(() {
                        spin = true;
                      });
                      await Upload().addNewClass(
                          context,
                          classController.text.trim(),
                          sectionsController.text.trim());

                      setState(() {
                        spin = false;
                        classController.clear();
                        sectionsController.clear();
                      });
                    } else {
                      Fluttertoast.showToast(msg: 'Fill The Fields');
                    }
                  })
            ],
          ),
          indicator(spin)
        ],
      ),
    );
  }
}
