import 'package:adminpannel/SchoolAdmin/AddClass.dart';
import 'package:adminpannel/SchoolAdmin/class.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../studentspage.dart';

class ManageCard extends StatelessWidget {
  ManageCard({
    Key? key,
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
                      'Management',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AddClass();
                      }));
                    },
                    child: Row(
                      children: [
                        Text(
                          'Add Class',
                          style: TextStyle(color: Colors.green),
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
                                    ? Cards1(
                                        color: Color(0xffFFF7CD),
                                        text: snapshot.data!.docs[index]
                                                ['class'] +
                                            ' ' +
                                            snapshot.data!.docs[index]
                                                ['section'],
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return Academics(
                                              class_: snapshot.data!.docs[index]
                                                  ['class'],
                                              section: snapshot
                                                  .data!.docs[index]['section'],
                                            );
                                          }));
                                        },
                                      )
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
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 80,
              width: 100,
              child: Center(
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0x469FA2F1),
                  child: Text(
                    text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
