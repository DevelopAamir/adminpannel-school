import 'package:adminpannel/SchoolAdmin/Pages.dart/HomePage.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:adminpannel/Storage/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LogIn {
  Future<void> login(String email, String password, context) async {
    final auth = FirebaseAuth.instance;
    if (email != "" || password != "") {
      try {
        final response = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        print(response.user.toString());
        final id = response.user!.uid.toString();
        await Store().storeData('id', id);
        await Store().storeData('role', response.user!.photoURL.toString());
        if (response.user!.photoURL.toString() == 'Staff') {
          await Store()
              .storeData('schoolName', response.user!.displayName.toString());
        }
        getData(context).then((value) {
          Fluttertoast.showToast(
              msg: 'Sucessfully Logged In', backgroundColor: Colors.green);
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => HomePage())));
        });
      } on FirebaseAuthException catch (e) {
        print(e.message);
        Fluttertoast.showToast(
          msg: e.message.toString(),
          webBgColor: "linear-gradient(to right,#FF0000,#FF6347)",
          webShowClose: true,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Fill All Feilds',
        webBgColor: "linear-gradient(to right,#FF0000,#FF6347)",
        webShowClose: true,
      );
    }
  }

  Future<void> getData(context) async {
    final iD = await Store().getData('id');
    final role = await Store().getData('role');
    final school = await Store().getData('schoolName');
    try {
      final fireStore = FirebaseFirestore.instance;
      final response = role == 'Staff'
          ? await fireStore
              .collection(school.toString())
              .doc('Staff')
              .collection(DateTime.now().year.toString())
              .doc(iD)
              .get()
          : await fireStore.collection('ADMIN').doc(iD).get();
      print(response.data()!.toString());
      if (role != 'Staff') {
        Provider.of<SchoolProvider>(context, listen: false)
            .getSchoolInfo(response);
        Provider.of<SchoolProvider>(context, listen: false)
            .setPermission(response.data()!['permissions']);
      } else {
        Provider.of<SchoolProvider>(context, listen: false)
            .getStaffInfo(response);
        Provider.of<SchoolProvider>(context, listen: false)
            .setPermission(response.data()!['permission']);
        Provider.of<SchoolProvider>(context, listen: false).getRole(iD);
      }
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
