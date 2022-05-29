import 'package:adminpannel/SchoolAdmin/Maps/Map.dart';
import 'package:adminpannel/SchoolAdmin/objects/schoolInfo.dart';
import 'package:adminpannel/Storage/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class SchoolProvider with ChangeNotifier {
  var accessToken;
  getId(ids) {
    accessToken = ids;
    notifyListeners();
  }

  List<String> feeCatogaries = ['Select'];
  List<String> examNames = ['Select'];
  var role;
  List permissions = [];
  Map student = Maps().student;
  Map<String, dynamic> staff = Maps().staff;
  Map admin = Maps().admin;
  Map<String, dynamic> attendanceRegister = Maps().attendance;
  Map<String, Object?> attendanceToBeSend = {};

  getFeesTypes(response) {
    if (!feeCatogaries.contains(response)) {
      feeCatogaries.add(response);
      notifyListeners();
    }
  }

  getExamNames(response) {
    if (!examNames.contains(response)) {
      examNames.add(response);
      notifyListeners();
    }
  }

  addStudentInformation({required String key, required value}) {
    student['Information'].update(key.toString(), (a) => value.toString());
    print(student['Information']);
    notifyListeners();
  }

  addStaffInformation({required String key, required value}) {
    staff['Information'].update(key.toString(), (a) => value.toString());
    print(staff['Information']);
    notifyListeners();
  }

  getAdminAllData(responce) {
    admin = responce;
    notifyListeners();
  }

  getAdminProfile(response) {
    admin.update('Information', (value) => response);
    notifyListeners();
  }

  getAdminAttendance(response, type) {
    admin.update('${type}_Attendance', (value) => response);
    notifyListeners();
  }

  getregisteredStudent(response) {
    attendanceRegister = response;
    notifyListeners();
  }

  setStudentRegister(response) {
    attendanceToBeSend.addAll(response);
    notifyListeners();
  }

  setPermission(permission) {
    permissions = permission;
    notifyListeners();
  }

  getRole(permission) {
    role = permission;
    notifyListeners();
  }

  registerStudent(data, type) {
    final index = attendanceRegister.length;
    if (type == 'Staff') {
      attendanceRegister.addEntries([
        MapEntry('${index - 1 + 1}', {
          'Date': '',
          'Status': 'true',
          'Name': data['Name'],
          'Day': '',
          'Type': '$type',
        }),
      ]);
    } else {
      attendanceRegister.addEntries([
        MapEntry('${index - 1 + 1}', {
          'Date': '',
          'Status': 'true',
          'Name': data['Name'],
          'Day': '',
          'Class': data['Class'],
          'Type': '$type',
        }),
      ]);
      notifyListeners();
    }

    // attendanceRegister.addEntries([
    //   MapEntry('Students_Attendance', recent),
    // ]);
  }

  String id = '';
  SchoolInfo info = SchoolInfo(
      enrollment: 'enrollment',
      name: 'name',
      id: 'id',
      userName: 'userName',
      date: 'date',
      logo: 'logo');
  getSchoolInfo(DocumentSnapshot<Map<String, dynamic>> response) {
    final information = SchoolInfo(
      enrollment: response.data()!["Information"]["EnrollmentNumber"],
      name: response.data()!["Information"]["School_Name"],
      id: response.data()!["Information"]["ID"],
      userName: response.data()!["Information"]["UserName"],
      date: response.data()!['Information']['Subscription_Date'],
      logo: response.data()!["Information"]["Profile_Pic"],
    );
    info = information;
    notifyListeners();
  }

  getStaffInfo(DocumentSnapshot<Map<String, dynamic>> response) async {
    var id = await Store().getData('id');
    var schoolName = await Store().getData('schoolName');

    final information = SchoolInfo(
      enrollment: '',
      name: schoolName.toString(),
      id: id.toString(),
      userName: response.data()!["Information"]["Name"],
      date: '',
      logo: response.data()!["Information"]["Profile_Pic"],
    );
    info = information;
    notifyListeners();
  }
}
