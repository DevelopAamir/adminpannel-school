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
        Fluttertoast.showToast(
            msg: 'Sucessfully Logged In', backgroundColor: Colors.green);
        final id = response.user!.uid.toString();
        await Store().storeData('id', id);
        getData(context).then((value) {
          Navigator.popAndPushNamed(context, '/HomePage');
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
    try {
      final fireStore = FirebaseFirestore.instance;
      final response = await fireStore.collection('ADMIN').doc(iD).get();

      Provider.of<SchoolProvider>(context, listen: false)
          .getSchoolInfo(response);
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
