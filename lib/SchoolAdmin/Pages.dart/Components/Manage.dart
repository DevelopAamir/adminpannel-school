import 'package:adminpannel/SchoolAdmin/AddClass.dart';
import 'package:adminpannel/SchoolAdmin/class.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../StaffUI/Teacher/Class.dart';
import '../Media.dart';
import 'Cards.dart';

class ManageCard extends StatelessWidget {
  final List<int> total;
  ManageCard({
    Key? key,
    required this.total,
  }) : super(key: key);
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    var schoolName =
        Provider.of<SchoolProvider>(context, listen: false).info.name;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    elevation: 0.0,
                    child: Text(
                      'Acadmics',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (Provider.of<SchoolProvider>(context, listen: false)
                          .role ==
                      null)
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AddClass();
                        }));
                      },
                      child: Row(
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Add Class',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              Row(
                children: [
                  Cards(
                    text: 'Total Students',
                    total: total[0].toString(),
                    color: Color(0xffFFA24B),
                  ),
                  Cards(
                    text: 'Total Staffs',
                    total: total[1].toString(),
                    color: Color(0xff4BFF93),
                  ),
                  Cards(
                    text: 'Classes',
                    total: total[2].toString(),
                    color: Color(0xff4BC9FF),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Classes',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                child: StreamBuilder(
                  stream: firestore
                      .collection(schoolName)
                      .doc('Classes')
                      .collection('RegisteredClasses')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return Container(
                      height: 150,
                      child: snapshot.hasData
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: ((context, index) {
                                return snapshot.hasData
                                    ? StreamBuilder(
                                        stream: firestore
                                            .collection(schoolName)
                                            .doc('Academics')
                                            .collection(snapshot.data!
                                                    .docs[index]['class'] +
                                                snapshot.data!.docs[index]
                                                    ['section'])
                                            .snapshots(),
                                        builder: (context,
                                            AsyncSnapshot<QuerySnapshot> snap) {
                                          bool seen = false;
                                          if (snap.hasData) {
                                            for (var d in snap.data!.docs) {
                                              seen = d['Seen'];
                                              if (seen == true) break;
                                            }
                                          }
                                          return Cards1(
                                            color: seen
                                                ? Colors.green.shade100
                                                : Color.fromARGB(
                                                    255, 255, 255, 255),
                                            text: "class: " +
                                                snapshot.data!.docs[index]
                                                    ['class'] +
                                                '\n' +
                                                "Section: " +
                                                snapshot.data!.docs[index]
                                                    ['section'],
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return Academics(
                                                  class_: snapshot.data!
                                                      .docs[index]['class'],
                                                  section: snapshot.data!
                                                      .docs[index]['section'],
                                                );
                                              }));
                                            },
                                          );
                                        })
                                    : Container();
                              }))
                          : Container(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        height: 500,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}

class Cards1 extends StatelessWidget {
  final color;
  final onTap;
  final text;
  // final Widget button;
  const Cards1({
    Key? key,
    required this.color,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 120,
              width: 120,
              child: Center(
                child: Stack(
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        text,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Color.fromARGB(255, 5, 5, 5),
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Icon(
                        Icons.class__outlined,
                        size: 50,
                        color: Color(0xff18E2B2),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
