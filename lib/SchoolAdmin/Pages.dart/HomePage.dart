import 'package:adminpannel/SchoolAdmin/Connector/Login.dart';
import 'package:adminpannel/SchoolAdmin/Connector/getData.dart';
import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/BottomBar.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Cards.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Drawer1.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Manage.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/animatedscreen.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Media.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Signup.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Subscription.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:adminpannel/Storage/storage.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future getToken(context) async {
    var token = await Store().getData('id');
    Provider.of<SchoolProvider>(context, listen: false).getId(token);
    return token;
  }

  @override
  void initState() {
    getToken(context).then((value) {
      if (value == null) {
        Navigator.pushNamed(context, '/Login');
      } else {
        LogIn().getData(context);
        GetData().getData(context);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: MainDrawer(),
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Drawer1(),
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
                          height: 55,
                          child: AppBar(
                            elevation: 0,
                            automaticallyImplyLeading: false,
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
                                      onTap: () {
                                        Upload().uploadFile(context);
                                      },
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Color(
                                          ///flutter run -d chrome --web-renderer html --profile
                                          0xff085A6C,
                                        ),
                                        backgroundImage: NetworkImage(
                                          'https://i.ytimg.com/vi/VZgnPcMeLf4/hqdefault.jpg',
                                          headers: {
                                            'Access-Control-Allow-Origin':
                                                '5392c387-8403-410e-9456-82f3813bfb86'
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
                      AnimatedScreen(),
                      Column(
                        children: [
                          ManageCard(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Cards(
                                navigate: Subscribes(),
                                text: 'Total Students',
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Cards(
                                navigate: Medias(),
                                text: 'Media',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Cards(
                                text: 'Notifications',
                                navigate: Medias(),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Cards(
                                navigate: Medias(),
                                text: 'Total staff',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          BottomBar()
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
