import 'dart:io';

import 'package:adminpannel/SchoolAdmin/Connector/addStudent.dart';
import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Responsive/sinupresponsive.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignupStaff extends StatefulWidget {
  final section;
  final class_;
  const SignupStaff({Key? key, this.section, this.class_}) : super(key: key);

  @override
  _SignupStaffState createState() => _SignupStaffState();
}

class _SignupStaffState extends State<SignupStaff> {
  TextEditingController emailController = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmpassword = TextEditingController();
  var image;
  var imageurl = '';

  Future<void> imageSelect() async {
    try {
      final selectedimage = await FilePicker.platform
          .pickFiles(allowMultiple: false, type: FileType.image);
      if (selectedimage == null) return;
      final imageTemporary = selectedimage.files[0].bytes;
      setState(() {
        image = imageTemporary;
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
  bool spin = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff12B081),
        title: Text('ADD Staff'),
      ),
      body: width >= height
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Color.fromRGBO(228, 223, 223, 1),
                    radius: 30,
                    child: CupertinoButton(
                      onPressed: () async {
                        await imageSelect();
                        setState(() {
                          spin = true;
                        });
                        final url = await Upload()
                            .uploadProfilepic(image)
                            .then((value) {
                          setState(() {
                            imageurl = value;
                            spin = false;
                          });
                          print(spin.toString());
                          Provider.of<SchoolProvider>(context, listen: false)
                              .addStaffInformation(
                                  key: 'Profile_Pic', value: value);
                        });
                      },
                      child: imageurl != ''
                          ? Image.network(
                              imageurl,
                              fit: BoxFit.fill,
                            )
                          : Icon(
                              Icons.person,
                              size: 30,
                            ),
                    ),
                  ),
                ),
                Stack(
                  children: [
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
                    spin
                        ? Center(
                            child: Visibility(
                                visible: spin,
                                child: CircularProgressIndicator(
                                    color: Colors.blue)),
                          )
                        : Container()
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoButton(
                    child: Text('ADD'),
                    onPressed: () async {
                      Provider.of<SchoolProvider>(context, listen: false)
                          .addStaffInformation(
                        key: 'Section',
                        value: widget.section,
                      );
                      setState(() {
                        spin = true;
                      });
                      if (password.text == confirmpassword.text) {
                        await AddStudent().addStaff(
                            email: emailController.text,
                            password: password.text,
                            schoolName: Provider.of<SchoolProvider>(context,
                                    listen: false)
                                .info
                                .name,
                            grade: widget.class_,
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
                      setState(() {
                        spin = false;
                      });
                    },
                    color: Colors.indigo,
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                ListView(
                  children: [
                    CupertinoButton(
                      onPressed: () async {
                        await imageSelect();
                        setState(() {
                          spin = true;
                        });
                        final url = await Upload()
                            .uploadProfilepic(image)
                            .then((value) {
                          setState(() {
                            spin = false;

                            imageurl = value;
                          });
                          Provider.of<SchoolProvider>(context, listen: false)
                              .addStaffInformation(
                                  key: 'Profile_Pic', value: value);
                        });
                      },
                      child: imageurl != ''
                          ? Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Image.network(
                                imageurl,
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
                          setState(() {
                            spin = true;
                          });
                          if (password.text == confirmpassword.text) {
                            await AddStudent().addStaff(
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
                            for (var i = 0;
                                i < detailscontrollers1.length;
                                i++) {
                              detailscontrollers1[i].clear();
                              emailController.clear();
                              password.clear();
                              confirmpassword.clear();
                            }
                            for (var i = 0;
                                i < detailscontrollers2.length;
                                i++) {
                              detailscontrollers2[i].clear();
                            }
                          }
                          setState(() {
                            spin = false;
                          });
                        },
                        color: Colors.indigo,
                      ),
                    )
                  ],
                ),
                spin
                    ? Center(
                        child: Visibility(
                            visible: spin,
                            child:
                                CircularProgressIndicator(color: Colors.green)),
                      )
                    : Container()
              ],
            ),
    );
  }
}
