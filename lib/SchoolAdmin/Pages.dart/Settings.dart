import 'dart:async';

import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Textfiel.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/dropdown.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/HomePage.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final firestore = FirebaseFirestore.instance;
  var page = 'Fee Settings';
  @override
  void initState() {
    showWarning();
    super.initState();
  }

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    title: Text('Fee Settings'),
                    selected: page == 'Fee Settings',
                    onTap: () {
                      setState(() {
                        page = 'Fee Settings';
                      });
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Profile Settings'),
                    hoverColor: Color.fromARGB(255, 157, 243, 160),
                    selected: page == 'Profile Settings',
                    onTap: () {
                      setState(() {
                        page = 'Profile Settings';
                      });
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Session Settings'),
                    hoverColor: Color.fromARGB(255, 157, 243, 160),
                    selected: page == 'Session Settings',
                    onTap: () {
                      setState(() {
                        page = 'Session Settings';
                      });
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Reset Settings'),
                    hoverColor: Color.fromARGB(255, 157, 243, 160),
                    selected: page == 'Reset Settings',
                    onTap: () {
                      setState(() {
                        page = 'Reset Settings';
                      });
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Exam Settings'),
                    hoverColor: Color.fromARGB(255, 157, 243, 160),
                    selected: page == 'Exam Settings',
                    onTap: () {
                      setState(() {
                        page = 'Exam Settings';
                      });
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Calender Settings'),
                    selected: page == 'Calender Settings',
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Select Date Type'),
                              content: DropDown(
                                items: ['Select', 'english'],
                                onchange: (a) {
                                  Provider.of<SchoolProvider>(context,
                                          listen: false)
                                      .setDate(a);
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(),
          Expanded(
            flex: 5,
            child: Container(
              child: Builder(builder: (
                context,
              ) {
                return selectPageBuilder(context);
              }),
            ),
          ),
        ],
      ),
    );
  }

  showWarning() {
    Timer(Duration(seconds: 3), () {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Danger !',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              content: Container(
                height: 200,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.warning,
                        size: 70,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                        'Be Careful In This Area Your Small Mistake \ncan Couse Missing of All Your Data',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              backgroundColor: Color.fromARGB(255, 255, 226, 224),
              actions: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => HomePage())));
                    },
                    child: Text("Go Back")),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("I'm Awair"))
              ],
            );
          });
    });
  }

  Widget getCurrentFeeSetting(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Manage Fee Types',
            style: TextStyle(fontSize: 30),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              StreamBuilder(
                stream: firestore
                    .collection(Provider.of<SchoolProvider>(context).info.name)
                    .doc('FeeSetting')
                    .collection(DateTime.now().year.toString())
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return snapshot.hasData
                      ? Column(
                          children: snapshot.data!.docs
                              .map(
                                (e) => ListTile(
                                  title: Text(e['type']),
                                  trailing: IconButton(
                                      onPressed: () {
                                        e.reference.delete();
                                      },
                                      icon:
                                          Icon(Icons.close, color: Colors.red)),
                                ),
                              )
                              .toList(),
                        )
                      : Container();
                },
              ),
            ],
          ),
        ),
        CupertinoButton(
          child: Text('Add'),
          color: Colors.green,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Add Fee Types'),
                  content: Textfield(
                    text: 'Enter Fee title',
                    obsecuewtext: false,
                    icon: Icons.add_box,
                    controller: controller,
                    onChange: (a) {},
                  ),
                  actions: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Back'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          try {
                            firestore
                                .collection(Provider.of<SchoolProvider>(context,
                                        listen: false)
                                    .info
                                    .name)
                                .doc('FeeSetting')
                                .collection(
                                  DateTime.now().year.toString(),
                                )
                                .doc(
                                  DateTime.now().toString(),
                                )
                                .set(
                              {'type': controller.text},
                            );

                            setState(
                              () {
                                controller.clear();
                              },
                            );
                            Fluttertoast.showToast(
                                msg: 'Catogary added successfully');
                          } catch (e) {
                            print(e);
                          }
                        } else {
                          Fluttertoast.showToast(msg: 'Fill All Fields');
                        }
                      },
                      child: Text('Add'),
                    )
                  ],
                );
              },
            );
          },
        )
      ],
    );
  }

  Widget getCurrentExamSettings(context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Manage Examination',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Expanded(
            child: StreamBuilder(
              stream: firestore
                  .collection(Provider.of<SchoolProvider>(context).info.name)
                  .doc('ExamSettings')
                  .collection(DateTime.now().year.toString())
                  .snapshots(),
              builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            title: Text(snapshot.data!.docs[index]['key']),
                            trailing: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                snapshot.data!.docs[index].reference.delete();
                              },
                            ),
                          );
                        }))
                    : Container();
              }),
            ),
          ),
          CupertinoButton.filled(
              child: Text('Add'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Add Exams'),
                      content: Textfield(
                        text: 'Enter Exam Name',
                        obsecuewtext: false,
                        icon: Icons.add_box,
                        controller: controller,
                        onChange: (a) {},
                      ),
                      actions: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Back'),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            if (controller.text.isNotEmpty) {
                              try {
                                firestore
                                    .collection(Provider.of<SchoolProvider>(
                                            context,
                                            listen: false)
                                        .info
                                        .name)
                                    .doc('ExamSettings')
                                    .collection(
                                      DateTime.now().year.toString(),
                                    )
                                    .doc(
                                      DateTime.now().toString(),
                                    )
                                    .set(
                                  {'key': controller.text},
                                );

                                setState(
                                  () {
                                    controller.clear();
                                  },
                                );
                                Fluttertoast.showToast(
                                    msg: 'Exam added successfully');
                              } catch (e) {
                                print(e);
                              }
                            } else {
                              Fluttertoast.showToast(msg: 'Fill All Fields');
                            }
                          },
                          child: Text('Add'),
                        )
                      ],
                    );
                  },
                );
              })
        ]),
      ),
    );
  }

  Widget getCurrentProfileSetting(context) {
    return Scaffold();
  }

  Widget getCurrentResetSetting(context) {
    return Scaffold();
  }

  Widget getCurrentSessionSetting(context) {
    return Scaffold();
  }

  selectPageBuilder(context) {
    if (page == 'Fee Settings') {
      return getCurrentFeeSetting(context);
    } else if (page == 'Exam Settings') {
      return getCurrentExamSettings(context);
    } else if (page == 'Profile Settings') {
      return getCurrentProfileSetting(context);
    } else if (page == 'Reset Settings') {
      return getCurrentResetSetting(context);
    } else if (page == 'Session Settings') {
      return getCurrentSessionSetting(context);
    }
  }
}
