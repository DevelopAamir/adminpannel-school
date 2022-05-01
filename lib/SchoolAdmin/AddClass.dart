import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddClass extends StatelessWidget {
  AddClass({Key? key}) : super(key: key);
  final classController = TextEditingController();
  final sectionsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff12B081),
        title: Text('Add Class'),
      ),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: classController,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  hintText: 'Enter Class Name',
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
                  hintText: 'Enter Class Name',
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
              color: Color(0xff12B081),
              child: Text('Next'),
              onPressed: () async {
                await Upload().addNewClass(context, classController.text.trim(),
                    sectionsController.text.trim());
              })
        ],
      ),
    );
  }
}
