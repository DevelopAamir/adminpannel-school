import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Store {
  final auth = FirebaseAuth.instance;
  final storage = FlutterSecureStorage();
  Future<void> storeData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<void> logOut() async {
    try {
      await storage.deleteAll();
      auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<String?> getData(String key) async {
    return await storage.read(key: key);
  }
}
