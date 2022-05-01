import 'package:adminpannel/StaffUI/Teacher/homepage.dart';
import 'package:flutter/material.dart';

class Stfmsg extends StatelessWidget {
  const Stfmsg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffECE9E6),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xffECE9E6),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xffC04848),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Message',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(6, 8),
                    blurRadius: 5),
              ],
              color: Color(0xffC04848),
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(padding: EdgeInsets.all(0)),
                                Cards(
                                  url: 'images/Group88.png',
                                  txt: 'School',
                                  widget: Staffs(),
                                ),
                                Cards(
                                  url: 'images/Group87.png',
                                  txt: 'Teacher',
                                  widget: Staffs(),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(padding: EdgeInsets.all(0)),
                                Cards(
                                  url: 'images/Group89.png',
                                  txt: 'Class',
                                  widget: Staffs(),
                                ),
                                Cards(
                                  url: 'images/Group90.png',
                                  txt: 'Admin',
                                  widget: Staffs(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({
    Key? key,
    required this.url,
    required this.txt,
    required this.widget,
  }) : super(key: key);

  final String url;
  final String txt;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return widget;
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            bottom: 30,
          ),
          child: Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffECE9E6),
                  Color(0xffFFFFFF),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffFFFFFF).withOpacity(1),
                  blurRadius: 26.28,
                  spreadRadius: 0,
                  offset: Offset(
                    -13.14,
                    -13.14,
                  ),
                ),
                BoxShadow(
                  color: Color(0xffC4D0E3).withOpacity(1),
                  blurRadius: 10.0,
                  spreadRadius: 7.0,
                  offset: Offset(
                    15.88,
                    10.51,
                  ),
                )
              ],
              color: Color(0xffECE9E6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image.asset(
                    url,
                    height: 50,
                    width: 50,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    txt,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Color(0xffC04848)),
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
