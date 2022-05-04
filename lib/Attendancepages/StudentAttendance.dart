import 'package:adminpannel/Attendancepages/takeSatt.dart';
import 'package:adminpannel/SchoolAdmin/Connector/getData.dart';
import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/SignUp_student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


// class TopBar extends StatelessWidget {
//   const TopBar({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: Container(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 15, right: 15),
//           child:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Text(
//               'SN',
//               style: TextStyle(color: Colors.white),
//             ),
//             Text(
//               'Name',
//               style: TextStyle(color: Colors.white),
//             ),
//             Text(
//               'Day',
//               style: TextStyle(color: Colors.white),
//             ),
//             Text(
//               'Date',
//               style: TextStyle(color: Colors.white),
//             ),
//             Text(
//               'Status',
//               style: TextStyle(color: Colors.white),
//             ),
//           ]),
//         ),
//         color: Color(0xff9DFCA7),
//         width: double.infinity,
//         height: 55,
//       ),
//     );
//   }
// }

