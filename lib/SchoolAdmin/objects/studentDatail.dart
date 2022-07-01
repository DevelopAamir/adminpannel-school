import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentDetail {
  final String name,
      class_,
      rollno,
      section,
      fathername,
      mothername,
      fathernumber,
      mothernumber,
      parentsname,
      parentsnumber,
      temporaryaddress,
      permanentadderss,
      dob,
      phonenumber,
      profilephoto,
      totalfee,
      remainingfee,
      password;
  final String? email;
  final CollectionReference<Map<String, dynamic>> payments;

  StudentDetail(
    this.name,
    this.class_,
    this.rollno,
    this.section,
    this.fathername,
    this.mothername,
    this.fathernumber,
    this.mothernumber,
    this.parentsname,
    this.parentsnumber,
    this.temporaryaddress,
    this.permanentadderss,
    this.dob,
    this.phonenumber,
    this.profilephoto,
    this.totalfee,
    this.remainingfee,
    this.password,
    this.email,
    this.payments,
  );
}
