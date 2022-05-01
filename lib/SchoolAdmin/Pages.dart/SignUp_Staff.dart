import 'dart:io';

import 'package:adminpannel/SchoolAdmin/Connector/addStudent.dart';
import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Responsive/sinupresponsive.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignupStaff extends StatefulWidget {
  const SignupStaff({Key? key}) : super(key: key);

  @override
  _SignupStaffState createState() => _SignupStaffState();
}

class _SignupStaffState extends State<SignupStaff> {
  TextEditingController emailController = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmpassword = TextEditingController();
  File? image;

  void imageSelect() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } catch (e) {
      print('Failed to pick image:$e');
    }
  }

  List<TextEditingController> detailscontrollers1 = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  List<TextEditingController> detailscontrollers2 = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff12B081),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: Text(
                  'Add Student',
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
        title: Text('ADD USERS'),
      ),
      body: width >= height
          ? ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Color.fromRGBO(228, 223, 223, 1),
                    radius: 30,
                    child: CupertinoButton(
                      onPressed: () async {
                        imageSelect();
                        final url = await Upload().uploadProfilepic(image);

                        Provider.of<SchoolProvider>(context, listen: false)
                            .addStaffInformation(
                                key: 'Profile_Pic', value: url);
                      },
                      child: image != null
                          ? Image.file(
                              image!,
                              fit: BoxFit.fill,
                            )
                          : Icon(
                              Icons.person,
                              size: 30,
                            ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Details2(
                            confirmpassword: confirmpassword,
                            emailController: emailController,
                            password: password,
                            userType: 'staff',
                            controllers: detailscontrollers2)),
                    Expanded(
                        child: Details(
                      userType: 'staff',
                      controllers: detailscontrollers1,
                      image: image,
                    )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoButton(
                    child: Text('ADD'),
                    onPressed: () async {
                      if (password.text == confirmpassword.text) {
                        await AddStudent().addStudent(
                            email: emailController.text,
                            password: password.text,
                            schoolName: Provider.of<SchoolProvider>(context,
                                    listen: false)
                                .info
                                .name,
                            grade: 'Staff',
                            data: Provider.of<SchoolProvider>(context,
                                    listen: false)
                                .staff,
                            type: 'Staff',
                            context: context);
                        for (var i = 0; i < detailscontrollers1.length; i++) {
                          detailscontrollers1[i].clear();
                          emailController.clear();
                          password.clear();
                          confirmpassword.clear();
                        }
                        for (var i = 0; i < detailscontrollers2.length; i++) {
                          detailscontrollers2[i].clear();
                        }
                        setState(() {
                          image = null;
                        });
                      }
                    },
                    color: Colors.indigo,
                  ),
                )
              ],
            )
          : ListView(
              children: [
                CupertinoButton(
                  onPressed: () async {
                    imageSelect();
                    final url = await Upload().uploadProfilepic(image);

                    Provider.of<SchoolProvider>(context, listen: false)
                        .addStaffInformation(key: 'Profile_Pic', value: url);
                  },
                  child: image != null
                      ? Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(50)),
                          child: Image.file(
                            image!,
                            fit: BoxFit.fill,
                          ),
                        )
                      : FlutterLogo(
                          size: 30,
                        ),
                ),
                Details2(
                  confirmpassword: confirmpassword,
                  emailController: emailController,
                  password: password,
                  userType: 'staff',
                  controllers: detailscontrollers2,
                ),
                Details(
                  userType: 'staff',
                  controllers: detailscontrollers1,
                  image: image,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoButton(
                    child: Text('ADD'),
                    onPressed: () async {
                      if (password.text == confirmpassword.text) {
                        await AddStudent().addStudent(
                            email: emailController.text,
                            password: password.text,
                            schoolName: Provider.of<SchoolProvider>(context,
                                    listen: false)
                                .info
                                .name,
                            grade: 'Staff',
                            data: Provider.of<SchoolProvider>(context,
                                    listen: false)
                                .staff,
                            type: 'Staff',
                            context: context);
                        for (var i = 0; i < detailscontrollers1.length; i++) {
                          detailscontrollers1[i].clear();
                          emailController.clear();
                          password.clear();
                          confirmpassword.clear();
                        }
                        for (var i = 0; i < detailscontrollers2.length; i++) {
                          detailscontrollers2[i].clear();
                        }
                      }
                    },
                    color: Colors.indigo,
                  ),
                )
              ],
            ),
    );
  }
}
