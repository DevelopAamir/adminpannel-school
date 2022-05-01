import 'package:adminpannel/SchoolAdmin/Pages.dart/Landing%20component/Clients.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Landing%20component/Contacts.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Login.dart';
import 'package:adminpannel/Storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dataProvider.dart';
import 'Landing component/Feature.dart';
import 'Landing component/homescreen.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({Key? key}) : super(key: key);

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  getToken(context) async {
    var token = await Store().getData('id');
    Provider.of<SchoolProvider>(context, listen: false).getId(token.toString());
  }

  var dx;
  var dy;
  List widgets = [
    Home(),
    Features(),
    Subscriber(),
    Contact(),
    Login(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) => setState(() {
        dx = event.position.dx;
        dy = event.position.dy;
      }),
      child: Scaffold(
        backgroundColor: Color(0xffF9FCFE),
        appBar: AppBar(
          leadingWidth: 175.0,
          leading: Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Image(
              fit: BoxFit.fitWidth,
              image: AssetImage(
                "images/bird0.png",
              ),
            ),
          ),
          backgroundColor: Color(0xffF9FCFE),
          elevation: 0,
          actions: [
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Row(
                children: [
                  Expanded(
                    child: Apbarbutton(
                      text: 'Home',
                      onTap: () {
                        setState(() {
                          currentIndex = 0;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Apbarbutton(
                      text: 'Feature',
                      onTap: () {
                        setState(() {
                          currentIndex = 1;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Apbarbutton(
                      text: 'Clients',
                      onTap: () {
                        setState(() {
                          currentIndex = 2;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Apbarbutton(
                      text: 'Contact',
                      onTap: () {
                        setState(() {
                          currentIndex = 3;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Apbarbutton(
                      text: 'Login',
                      onTap: () async {
                        await getToken(context);

                        setState(() {
                          currentIndex = 4;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Builder(builder: (context) {
          return widgets[currentIndex];
        }),
      ),
    );
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }
}

class Apbarbutton extends StatefulWidget {
  final String text;
  final onTap;
  const Apbarbutton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  State<Apbarbutton> createState() => _ApbarbuttonState();
}

class _ApbarbuttonState extends State<Apbarbutton> {
  bool focus = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: MouseRegion(
        onEnter: (a) {
          setState(() {
            focus = true;
          });
        },
        onExit: (a) {
          setState(() {
            focus = false;
          });
        },
        child: MaterialButton(
          padding: EdgeInsets.zero,
          enableFeedback: false,
          highlightColor: Colors.transparent,
          clipBehavior: Clip.none,
          highlightElevation: 5.0,
          splashColor: Colors.transparent,
          onPressed: widget.onTap,
          child: Container(
            height: focus == false ? 40 : 45,
            width: focus == false ? 100 : 105,
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(color: Colors.black),
              ),
            ),
            decoration: BoxDecoration(
              color: focus == false
                  ? Colors.white
                  : Color.fromARGB(255, 245, 248, 245),
              borderRadius: BorderRadiusDirectional.circular(26),
              boxShadow: [
                focus == false
                    ? BoxShadow(
                        color: Color(0xff12FFFF).withOpacity(0.2),
                        spreadRadius: 2.0,
                        blurRadius: 10.0,
                        offset: Offset(0, 2))
                    : BoxShadow(
                        color: Color(0xff12FFFF).withOpacity(0.3),
                        spreadRadius: 4.0,
                        blurRadius: 9.0,
                        offset: Offset(0, 2), // changes position of shadow
                      ), // changes position of shadow
              ],
            ),
          ),
        ),
      ),
    );
  }
}
