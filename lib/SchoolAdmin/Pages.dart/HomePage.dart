import 'package:adminpannel/SchoolAdmin/Connector/Login.dart';
import 'package:adminpannel/SchoolAdmin/Connector/getData.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/BottomBar.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Drawer1.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Manage.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/animatedscreen.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Login.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Signup.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:adminpannel/Storage/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var role = '';
  final auth = FirebaseAuth.instance;
  Future getToken(context) async {
    var token = await Store().getData('id');
    Provider.of<SchoolProvider>(context, listen: false).getId(token);
    return token;
  }

  getRole() async {
    final a = await Store().getData('role');

    role = a!;
  }

  int totalStudent = 0;
  int tatalStaff = 0;
  int totalClass = 0;
  uploadSchoolInfo() {
    final fire = FirebaseFirestore.instance;
    if (role != 'Staff')
      fire
          .collection(
              Provider.of<SchoolProvider>(context, listen: false).info.name)
          .doc('SchoolInfo')
          .set({
        'SchoolName':
            Provider.of<SchoolProvider>(context, listen: false).info.name,
        'Profile_Pic':
            Provider.of<SchoolProvider>(context, listen: false).info.logo,
        'Address':
            Provider.of<SchoolProvider>(context, listen: false).info.address,
        'Principal':
            Provider.of<SchoolProvider>(context, listen: false).info.userName,
        'Phone No': Provider.of<SchoolProvider>(context, listen: false)
            .info
            .phoneNumber,
        'Gmail': auth.currentUser!.email,
      });
  }

  getTotal() async {
    var totalSt = await GetData().getTotalStudent(context);
    var totalS = await GetData().getTotalStaff(context);
    var totalCl = await GetData().getClasses(context);

    setState(() {
      this.tatalStaff = totalS;
      this.totalStudent = totalSt;
      this.totalClass = totalCl;
    });
  }

  @override
  void initState() {
    getToken(context).then((value) async {
      if (value == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      } else {
        await LogIn().getData(context);
        await GetData().getData(context).then((value) async {
          await getTotal();
        });
        uploadSchoolInfo();
      }
    });
    getRole();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: MainDrawer(),
      backgroundColor: Colors.white,

      drawer:
          MediaQuery.of(context).size.width < MediaQuery.of(context).size.height
              ? Drawer(child: Drawer1())
              : null,
      body: SafeArea(
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (MediaQuery.of(context).size.width >=
                    MediaQuery.of(context).size.height)
                  Drawer1(),
                if (MediaQuery.of(context).size.width >=
                    MediaQuery.of(context).size.height)
                  VerticalDivider(
                    color: Colors.black,
                    thickness: 0.2,
                  ),
                Expanded(
                  child: ListView(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          // height: 55,
                          child: AppBar(
                            automaticallyImplyLeading: false,
                            leading: MediaQuery.of(context).size.width <
                                    MediaQuery.of(context).size.height
                                ? Builder(
                                    builder:
                                        (context) => // Ensure Scaffold is in context
                                            IconButton(
                                                icon: Icon(Icons.menu,
                                                    color: Colors.green),
                                                onPressed: () =>
                                                    Scaffold.of(context)
                                                        .openDrawer()),
                                  )
                                : null,
                            elevation: 0,
                            actions: [
                              GestureDetector(
                                onTap: () {
                                  Store().logOut().then(
                                    (value) {
                                      Navigator.pushAndRemoveUntil(context,
                                          MaterialPageRoute(builder: (context) {
                                        return CreateAccount();
                                      }), (route) => false);
                                    },
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: CircleAvatar(
                                    radius: 22,
                                    backgroundColor: Colors.green[200],
                                    child: InkWell(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Color(
                                          ///flutter run -d chrome --web-renderer html --profile
                                          0xff085A6C,
                                        ),
                                        backgroundImage: NetworkImage(
                                          context
                                              .watch<SchoolProvider>()
                                              .info
                                              .logo,
                                          headers: {
                                            'Access-Control-Allow-Origin': '*'
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                            backgroundColor: Colors.white,
                            title: Text(
                              context.watch<SchoolProvider>().info.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ManageCard(
                            total: [totalStudent, tatalStaff, totalClass],
                          ),
                          AnimatedScreen2(),
                          BottomBar()
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // if (MediaQuery.of(context).size.width <
            //     MediaQuery.of(context).size.height)
            //   Align(
            //     alignment: Alignment.centerLeft,
            //     child: Container(
            //       height: double.infinity,
            //       width: 50,
            //       child: Stack(
            //         children: [
            //           Container(
            //             height: double.infinity,
            //             width: 15,
            //             color: Color.fromARGB(255, 12, 139, 19),
            //           ),
            //           Align(
            //             alignment: Alignment.bottomRight,
            //             child: Container(
            //               width: 50,
            //               height: 40,
            //               decoration: BoxDecoration(
            //                   color: Color.fromARGB(255, 12, 139, 19),
            //                   borderRadius: BorderRadius.only(
            //                       topRight: Radius.circular(5),
            //                       bottomRight: Radius.circular(5))),
            //               child: Align(
            //                 alignment: Alignment.centerRight,
            //                 child: IconButton(
            //                     onPressed: () {
            //                       Scaffold.of(context).openDrawer();
            //                     },
            //                     icon: Icon(Icons.navigate_next,
            //                         color: Colors.white)),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
