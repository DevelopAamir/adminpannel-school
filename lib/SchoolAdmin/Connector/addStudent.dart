import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddStudent {
  Future<void> addStudent(
      {email,
      password,
      schoolName,
      grade,
      data,
      required type,
      required context}) async {
    var app = await Firebase.initializeApp(
        name: '$email',
        options: FirebaseOptions(
            apiKey: 'AIzaSyDMqxPs3T-9tfUNK0mweo3qcXUCg5YecUU',
            appId: '1:557268782813:web:db7492cc11dabdcb515534',
            messagingSenderId: '557268782813',
            projectId: 'school-b69d0'));
    final auth = FirebaseAuth.instanceFor(
      app: app,
    );
    try {
      final response = await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        print(value.user.toString());
        await auth.currentUser!.updateDisplayName(
            Provider.of<SchoolProvider>(context, listen: false).info.name);

        await Upload()
            .addStudent(
                schoolName: schoolName,
                id: auth.currentUser!.uid,
                grade: grade,
                data: data,
                type: type,
                context: context)
            .onError((error, stackTrace) {
          auth.currentUser!.delete();
        });
        print(auth.currentUser!.displayName.toString());
        await auth.signOut();
        await auth.app.delete();
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> addStaff(
      {email,
      password,
      schoolName,
      grade,
      data,
      required type,
      required context}) async {
    var app = await Firebase.initializeApp(
        name: '$email',
        options: FirebaseOptions(
            apiKey: 'AIzaSyDMqxPs3T-9tfUNK0mweo3qcXUCg5YecUU',
            appId: '1:557268782813:web:db7492cc11dabdcb515534',
            messagingSenderId: '557268782813',
            projectId: 'school-b69d0'));
    final auth = FirebaseAuth.instanceFor(
      app: app,
    );
    try {
      final response = await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        print(value.user.toString());
        await auth.currentUser!.updateDisplayName(
            Provider.of<SchoolProvider>(context, listen: false).info.name);

        await Upload()
            .addStaff(
                schoolName: schoolName,
                id: auth.currentUser!.uid,
                grade: grade,
                data: data,
                type: type,
                context: context)
            .onError((error, stackTrace) {
          auth.currentUser!.delete();
        });
        print(auth.currentUser!.displayName.toString());
        await auth.signOut();
        await auth.app.delete();
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
