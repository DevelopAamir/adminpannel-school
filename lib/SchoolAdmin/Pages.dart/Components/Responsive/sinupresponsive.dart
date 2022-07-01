import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Textfiel.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  final userType;
  final image;

  final List<TextEditingController> controllers;
  const Details({
    Key? key,
    required this.userType,
    required this.controllers,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (userType == 'student')
              Textfield(
                text: 'Mother Name',
                icon: Icons.password,
                obsecuewtext: false,
                controller: controllers[0],
                onChange: (c) {
                  Provider.of<SchoolProvider>(context, listen: false)
                      .addStudentInformation(key: 'Mother_Name', value: c);
                },
              ),
            if (userType == 'student')
              Textfield(
                text: 'Mother Number',
                icon: Icons.password,
                obsecuewtext: false,
                controller: controllers[1],
                onChange: (c) {
                  Provider.of<SchoolProvider>(context, listen: false)
                      .addStudentInformation(key: 'Mother_No', value: c);
                },
              ),
            if (userType == 'student')
              Textfield(
                text: 'Parents Name',
                icon: Icons.password,
                obsecuewtext: false,
                controller: controllers[2],
                onChange: (c) {
                  Provider.of<SchoolProvider>(context, listen: false)
                      .addStudentInformation(key: 'Parents_Name', value: c);
                },
              ),
            if (userType == 'student')
              Textfield(
                text: 'Parents Number',
                icon: Icons.password,
                obsecuewtext: false,
                onChange: (c) {
                  Provider.of<SchoolProvider>(context, listen: false)
                      .addStudentInformation(key: 'Parents_No', value: c);
                },
                controller: controllers[3],
              ),
            Textfield(
              text: 'Address',
              icon: Icons.password,
              obsecuewtext: false,
              controller: controllers[4],
              onChange: (c) {
                userType == 'student'
                    ? Provider.of<SchoolProvider>(context, listen: false)
                        .addStudentInformation(key: 'Temp_Address', value: c)
                    : Provider.of<SchoolProvider>(context, listen: false)
                        .addStaffInformation(key: 'Temp_Address', value: c);
              },
            ),
            Textfield(
              text: 'Permanent Address',
              icon: Icons.password,
              obsecuewtext: false,
              controller: controllers[5],
              onChange: (c) {
                userType == 'student'
                    ? Provider.of<SchoolProvider>(context, listen: false)
                        .addStudentInformation(key: 'Per_Address', value: c)
                    : Provider.of<SchoolProvider>(context, listen: false)
                        .addStaffInformation(key: 'Per_Address', value: c);
              },
            ),
            Textfield(
              text: 'DOB',
              icon: Icons.password,
              obsecuewtext: false,
              controller: controllers[6],
              onChange: (c) {
                userType == 'student'
                    ? Provider.of<SchoolProvider>(context, listen: false)
                        .addStudentInformation(key: 'DOB', value: c)
                    : Provider.of<SchoolProvider>(context, listen: false)
                        .addStaffInformation(key: 'DOB', value: c);
              },
            ),
            Textfield(
              text: 'Phone Number',
              icon: Icons.password,
              obsecuewtext: false,
              controller: controllers[7],
              onChange: (c) {
                userType == 'student'
                    ? Provider.of<SchoolProvider>(context, listen: false)
                        .addStudentInformation(key: 'Phone_No', value: c)
                    : Provider.of<SchoolProvider>(context, listen: false)
                        .addStaffInformation(key: 'Phone_No', value: c);
              },
            ),
            Textfield(
              text: userType == 'student'
                  ? 'Enter The Fee (Whole Year)'
                  : 'Enter The Salary Per month',
              icon: Icons.password,
              obsecuewtext: false,
              controller: controllers[8],
              onChange: (c) {
                userType == 'student'
                    ? Provider.of<SchoolProvider>(context, listen: false)
                        .addStudentInformation(key: 'Fee', value: c)
                    : Provider.of<SchoolProvider>(context, listen: false)
                        .addStaffInformation(key: 'Salary', value: c);
              },
            ),
            // Textfield(
            //   text: 'Profile Picture',
            //   icon: Icons.password,
            //   obsecuewtext: false,
            //   controller: controllers[8],
            //   onChange: (c) async {
            //     final url = await Upload().uploadProfilepic(image);

            //     userType == 'student'
            //         ? Provider.of<SchoolProvider>(context, listen: false)
            //             .addStudentInformation(key: 'Profile_Pic', value: url)
            //         : Provider.of<SchoolProvider>(context, listen: false)
            //             .addStaffInformation(key: 'Profile_Pic', value: url);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class Details2 extends StatelessWidget {
  final userType;
  final emailController;
  final password;
  final confirmpassword;
  final class_;
  final section;
  final List<TextEditingController> controllers;

  const Details2({
    Key? key,
    required this.emailController,
    required this.password,
    required this.confirmpassword,
    required this.userType,
    required this.controllers,
    this.class_,
    this.section,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Textfield(
            text: 'Email',
            icon: Icons.email,
            obsecuewtext: false,
            controller: emailController,
            onChange: (c) {
              userType == 'student'
                  ? Provider.of<SchoolProvider>(context, listen: false)
                      .addStudentInformation(key: 'email', value: c)
                  : Provider.of<SchoolProvider>(context, listen: false)
                      .addStaffInformation(key: 'email', value: c);
            },
          ),
          Textfield(
            text: 'Password',
            icon: Icons.password,
            obsecuewtext: false,
            controller: password,
            onChange: (c) {
              userType == 'student'
                  ? Provider.of<SchoolProvider>(context, listen: false)
                      .addStudentInformation(key: 'password', value: c)
                  : Provider.of<SchoolProvider>(context, listen: false)
                      .addStaffInformation(key: 'password', value: c);
            },
          ),
          Textfield(
            text: 'Confirm Password',
            icon: Icons.password,
            obsecuewtext: false,
            controller: confirmpassword,
            onChange: (c) {},
          ),
          Textfield(
            text: 'Name',
            icon: Icons.password,
            obsecuewtext: false,
            controller: controllers[0],
            onChange: (c) {
              userType == 'student'
                  ? Provider.of<SchoolProvider>(context, listen: false)
                      .addStudentInformation(key: 'Name', value: c)
                  : Provider.of<SchoolProvider>(context, listen: false)
                      .addStaffInformation(key: 'Name', value: c);
            },
          ),
          if (userType == 'student')
            Textfield(
              text: 'Roll No',
              icon: Icons.password,
              obsecuewtext: false,
              controller: controllers[3],
              onChange: (c) {
                Provider.of<SchoolProvider>(context, listen: false)
                    .addStudentInformation(key: 'Rollno', value: c);
              },
            ),
          if (userType == 'student')
            Textfield(
              text: 'Father Name',
              icon: Icons.password,
              obsecuewtext: false,
              controller: controllers[4],
              onChange: (c) {
                Provider.of<SchoolProvider>(context, listen: false)
                    .addStudentInformation(key: 'Father_Name', value: c);
              },
            ),
          if (userType == 'student')
            Textfield(
              text: 'Father Number',
              icon: Icons.password,
              obsecuewtext: false,
              controller: controllers[5],
              onChange: (c) {
                Provider.of<SchoolProvider>(context, listen: false)
                    .addStudentInformation(key: 'Father_No', value: c);
              },
            ),
        ],
      ),
    );
  }
}
