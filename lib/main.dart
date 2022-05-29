import 'package:adminpannel/Attendancepages/AllAttendance.dart';
import 'package:adminpannel/Attendancepages/takeSatt.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Calender.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/HomePage.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/LeaveHistory.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Login.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Media.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Notice.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Profilepage.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/SignUp_student.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:adminpannel/StaffUI/Teacher/homepage.dart';
import 'package:adminpannel/Storage/storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_strategy/url_strategy.dart';
import 'SchoolAdmin/Pages.dart/AddResult.dart';
import 'SchoolAdmin/Pages.dart/Landingpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setPathUrlStrategy();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SchoolProvider>(
          create: (_) => SchoolProvider(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        theme: ThemeData(
          primaryColor: Color(0xff02242C),
          primarySwatch: Palette.kToDark,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const Landingpage(),
          '/Login': (context) => const Login(),
          '/HomePage': (context) => const HomePage(),
          '/HomePage/ProfilePage': (context) => const Profilepage(),
          '/Attendance': (context) => const AllAttendance(),
          '/Notice': (context) => const Notice(),
          '/Leavehistory': (context) => const Leavehistory(),
          '/AddUser': (context) => const UserStudent(),
          '/Staffs': (context) => const Staffs(),
          '/Calender': (context) => const Calender(),
          '/Attendance/Takeattendance': (context) => const TakeSatt(),
          '/HomePage/Media': (context) => Medias(),
          '/Addresult': (context) => Addresult(),
        },
      ),
    ),
  );
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class LandPage extends StatelessWidget {
  const LandPage({Key? key}) : super(key: key);
  // getToken(context) async {
  //   var token = await Store().getData('id');
  //   Provider.of<SchoolProvider>(context, listen: false).getId(token.toString());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: 220,
                  child: Image(
                    image: AssetImage("images/Logo21.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                // Text(
                //   'School',
                //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                // ),
                Buttons(texts: 'Login your account'),
                Buttons(
                  texts: 'Request for forget password',
                ),
                Buttons(
                  texts: 'Request for New subscription',
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffC4C4C4),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.facebook,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.web_stories,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.link_outlined,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.facebook,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  // final Widget ontap;
  final String texts;
  const Buttons({
    Key? key,
    required this.texts,
  }) : super(key: key);
  getToken(context) async {
    var token = await Store().getData('id');
    Provider.of<SchoolProvider>(context, listen: false).getId(token.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        await getToken(context);
        Navigator.pushNamed(context, '/Login');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffC4C4C4),
            borderRadius: BorderRadius.circular(5),
          ),
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Text(
                texts,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Deside extends StatefulWidget {
  final Widget child;
  Deside({Key? key, required this.child}) : super(key: key);

  @override
  State<Deside> createState() => _DesideState();
}

class _DesideState extends State<Deside> {
  var accessToken = '';
  ConnectivityResult? _connectivityResult;

  Future<void> _checkConnectivityState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.wifi) {
      print('Connected to a Wi-Fi network');
    } else if (result == ConnectivityResult.mobile) {
      print('Connected to a mobile network');
    } else {
      print(result.toString());
    }

    setState(() {
      _connectivityResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<SchoolProvider>(context, listen: false).accessToken !=
            null.toString()
        ? widget.child
        : Container(
            child: Center(
              child: CircularProgressIndicator(color: Colors.indigo),
            ),
          );
  }
}

class Palette {
  static const MaterialColor kToDark = const MaterialColor(
    0xff59DBD3,
    const <int, Color>{
      50: const Color(
        0xff59DBD3,
      ), //10%
      100: const Color(
        0xff59DBD3,
      ), //20%
      200: const Color(
        0xff59DBD3,
      ), //30%
      300: const Color(
        0xff59DBD3,
      ), //40%
      400: const Color(
        0xff59DBD3,
      ), //50%
      500: const Color(
        0xff59DBD3,
      ), //60%
      600: const Color(
        0xff59DBD3,
      ), //70%
      700: const Color(
        0xff59DBD3,
      ), //80%
      800: const Color(
        0xff59DBD3,
      ), //90%
      900: const Color(
        0xff59DBD3,
      ), //100%
    },
  );
}
