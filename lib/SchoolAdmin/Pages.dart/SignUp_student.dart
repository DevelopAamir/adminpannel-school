import 'dart:io';

import 'package:adminpannel/SchoolAdmin/Connector/addStudent.dart';
import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Responsive/sinupresponsive.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/SignUp_Staff.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:adminpannel/Storage/storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserStudent extends StatefulWidget {
  final section;
  final class_;
  const UserStudent({Key? key, this.section, this.class_}) : super(key: key);

  @override
  _UserStudentState createState() => _UserStudentState();
}

class _UserStudentState extends State<UserStudent> {
  bool visibility = false;
  Future getToken(context) async {
    var token = await Store().getData('id');
    Provider.of<SchoolProvider>(context, listen: false).getId(token);
    return token;
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  var image;
  var imageurl = '';
  void imageSelect() async {
    try {
      setState(() {
        visibility = true;
      });
      final currentimage = await FilePicker.platform
          .pickFiles(allowMultiple: false, type: FileType.image);
      if (currentimage == null) return;
      final imageTemporary = currentimage.files[0];
      setState(() {
        image = imageTemporary;
      });
      final url = await Upload().uploadProfilepic(imageTemporary);
      setState(() {
        imageurl = url;
        visibility = false;
      });
      Provider.of<SchoolProvider>(context, listen: false)
          .addStudentInformation(key: 'Profile_Pic', value: url);
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
    TextEditingController(),
  ];
  @override
  void initState() {
    getToken(context).then((value) {
      if (value == null) {
        Navigator.pushNamed(context, '/Login');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('ADD Student'),
      ),
      body: width >= height
          ? Stack(
              children: [
                ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(228, 223, 223, 1),
                        radius: 30,
                        child: CupertinoButton(
                          onPressed: () {
                            imageSelect();
                          },
                          child: imageurl != ''
                              ? Image.network(
                                  imageurl,
                                  fit: BoxFit.fill,
                                )
                              : Icon(Icons.person),
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
                          userType: 'student',
                          controllers: detailscontrollers2,
                        )),
                        Expanded(
                            child: Details(
                          userType: 'student',
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
                          setState(() {
                            visibility = true;
                          });
                          Provider.of<SchoolProvider>(context, listen: false)
                              .addStudentInformation(
                            key: 'Section',
                            value: widget.section,
                          );
                          Provider.of<SchoolProvider>(context, listen: false)
                              .addStudentInformation(
                            key: 'Class',
                            value: widget.class_,
                          );
                          if (password.text == confirmpassword.text) {
                            await AddStudent().addStudent(
                                email: emailController.text,
                                password: password.text,
                                schoolName: Provider.of<SchoolProvider>(context,
                                        listen: false)
                                    .info
                                    .name,
                                grade: Provider.of<SchoolProvider>(context,
                                        listen: false)
                                    .student['Information']['Class'],
                                data: Provider.of<SchoolProvider>(context,
                                        listen: false)
                                    .student,
                                type: 'Students',
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
                            visibility = false;
                          });
                        },
                        color: Color(0xff02242C),
                      ),
                    )
                  ],
                ),
                Visibility(
                    visible: visibility,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    ))
              ],
            )
          : Stack(
              children: [
                ListView(
                  children: [
                    CupertinoButton(
                        onPressed: () async {
                          imageSelect();
                        },
                        child: image != null
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                height: 80,
                                width: 80,
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Icon(
                                Icons.person,
                                size: 30,
                              )),
                    Details2(
                      confirmpassword: confirmpassword,
                      emailController: emailController,
                      password: password,
                      userType: 'student',
                      controllers: detailscontrollers2,
                    ),
                    Details(
                      userType: 'student',
                      controllers: detailscontrollers1,
                      image: image,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoButton(
                        child: Text(
                          'ADD',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          setState(() {
                            visibility = true;
                          });
                          Provider.of<SchoolProvider>(context, listen: false)
                              .addStudentInformation(
                            key: 'Section',
                            value: widget.section,
                          );
                          Provider.of<SchoolProvider>(context, listen: false)
                              .addStudentInformation(
                            key: 'Class',
                            value: widget.class_,
                          );
                          if (password.text == confirmpassword.text) {
                            await AddStudent().addStudent(
                                email: emailController.text,
                                password: password.text,
                                schoolName: Provider.of<SchoolProvider>(context,
                                        listen: false)
                                    .info
                                    .name,
                                grade: Provider.of<SchoolProvider>(context,
                                        listen: false)
                                    .student['Information']['Class'],
                                data: Provider.of<SchoolProvider>(context,
                                        listen: false)
                                    .student,
                                type: 'Students',
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
                            setState(() {
                              image = null;
                            });
                          }
                          setState(() {
                            visibility = false;
                          });
                        },
                        color: Color(0xff02242C),
                      ),
                    )
                  ],
                ),
                Visibility(
                    visible: visibility,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff02242C),
                      ),
                    ))
              ],
            ),
    );
  }
}

//      Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//       ),
//       body: Center(
//         child: GestureDetector(
//           onTap: () {
//             AddStudent().addStudent(
//               'mr@gmail.com',
//               '123456',
//               Provider.of<SchoolProvider>(context, listen: false).info.name,
//               '10',
//             );
//           },
//           child: Card(
//             color: Colors.red,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'SignUp Student',
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// SignupButton(),
// SizedBox(
//   height: 10,
// ),
// GestureDetector(
//   onTap: () {
//     // print('tapped');
//     // Navigator.push(
//     //   context,
//     //   MaterialPageRoute(
//     //     builder: (context) {
//     //       return Login();
//     //     },
//     //   ),
//     // );
//   },
//   child: Container(
//     margin: EdgeInsets.only(left: 4, right: 4),
//     child: Center(
//       child: Text(
//         'Login',
//         style: TextStyle(color: Colors.white),
//       ),
//     ),
//     width: double.infinity,
//     height: 50,
//     decoration: BoxDecoration(
//       color: Color(0xff005b96),
//       borderRadius: BorderRadius.circular(5),
//     ),
//   ),
// ),
