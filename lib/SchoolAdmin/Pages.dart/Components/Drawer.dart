// import 'package:flutter/material.dart';
// import 'package:schoolpannel/SchoolAdmin/Pages.dart/Components/Drawerbutton.dart';
// import 'package:schoolpannel/SchoolAdmin/Pages.dart/SignUp_student.dart';
// import 'package:schoolpannel/SchoolAdmin/providers/dataProvider.dart';
// import 'package:provider/provider.dart';

// class MainDrawer extends StatelessWidget {
//   const MainDrawer({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       elevation: 95,
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: Color(0x99085A6C),
//             ),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(0.0),
//                     child: CircleAvatar(
//                       radius: 55,
//                       backgroundColor: Colors.white,
//                       child: CircleAvatar(
//                         radius: 52,
//                         backgroundColor: Colors.white,
//                         backgroundImage: NetworkImage(
//                             'https://i.ytimg.com/vi/VZgnPcMeLf4/hqdefault.jpg'),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Text(
//                   context.watch<SchoolProvider>().info.name,
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             children: [
//               DrawerButton(
//                 texts: 'Profile',
//                 page: UserStudent(),
//               ),
//               NewWidget(),
//               DrawerButton(
//                 texts: 'Dashboard',
//                 page: UserStudent(),
//               ),
//               NewWidget(),
//               DrawerButton(
//                 texts: 'Add Users',
//                 page: UserStudent(),
//               ),
//               NewWidget(),
//               DrawerButton(
//                 texts: 'Staffs',
//                 page: UserStudent(),
//               ),
//               NewWidget(),
//               DrawerButton(
//                 texts: 'Students',
//                 page: UserStudent(),
//               ),
//               NewWidget(),
//               DrawerButton(
//                 texts: 'Staff Attendance',
//                 page: UserStudent(),
//               ),
//               NewWidget(),
//               DrawerButton(
//                 texts: 'Student Attendance',
//                 page: UserStudent(),
//               ),
//               NewWidget(),
//               DrawerButton(
//                 texts: 'Subscription',
//                 page: UserStudent(),
//               ),
//               NewWidget(),
//               DrawerButton(
//                 texts: 'Class',
//                 page: UserStudent(),
//               ),
//               NewWidget(),
//               DrawerButton(
//                 texts: 'Chat',
//                 page: UserStudent(),
//               ),
//               NewWidget(),
//               DrawerButton(
//                 texts: 'Exam Routine',
//                 page: UserStudent(),
//               ),
//               NewWidget(),
//               DrawerButton(
//                 texts: 'Leave History',
//                 page: UserStudent(),
//               ),
//               NewWidget(),
//               DrawerButton(
//                 texts: 'Leave Requests',
//                 page: UserStudent(),
//               ),
//               NewWidget(),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
