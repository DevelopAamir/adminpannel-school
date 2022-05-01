// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class Profilepic extends StatefulWidget {
//   const Profilepic({Key? key}) : super(key: key);

//   @override
//   _ProfilepicState createState() => _ProfilepicState();
// }

// class _ProfilepicState extends State<Profilepic> {
  

 

//   // Future pickImage() async {
//   //   try {
//   //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//   //     if (image == null) return;
//   //     final imageTemporary = File(image.path);
//   //     setState(() {
//   //       this.image = imageTemporary;
//   //     });
//   //   } on PlatformException catch (e) {
//   //     print('Failed to pick image:$e');
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: CupertinoButton(
//           onPressed: () {
//             imageSelect();
//           },
//           child: image != null
//               ? Container(
//                   height: 50,
//                   width: 50,
//                   decoration: BoxDecoration(
//                       color: Colors.pink,
//                       borderRadius: BorderRadius.circular(50)),
//                   child: Image.file(
//                     image!,
//                     fit: BoxFit.fill,
//                   ),
//                 )
//               : FlutterLogo(
//                   size: 30,
//                 ),
//         ),
//       ),
//     );
//   }
// }
