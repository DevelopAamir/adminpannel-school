import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Textfiel.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:adminpannel/Storage/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Notice extends StatefulWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
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
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final grade = '10';
    final firestore = FirebaseFirestore.instance;
    final schoolName = Provider.of<SchoolProvider>(context).info.name;
    final id = DateTime.now().toString();
    bool visibility = false;
    var dataToBeAdded = {
      'description': '',
      'notice_id': id,
      'title': '',
      'url': '',
    };
    return Scaffold(
      appBar: AppBar(title: Text('Notice'), actions: [
        IconButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Add Notice'),
                      actions: [
                        OutlinedButton(
                          child: Text('Next'),
                          onPressed: () async {
                            setState(() {
                              visibility = true;
                            });
                            if (dataToBeAdded['title'] != '' &&
                                dataToBeAdded['description'] != '') {
                              try {
                                await firestore
                                    .collection('Notices')
                                    .doc(id)
                                    .set(dataToBeAdded)
                                    .then((value) async {
                                  await firestore
                                      .collection(schoolName)
                                      .doc('Notices')
                                      .collection('Notices')
                                      .add({
                                    'description': dataToBeAdded['description'],
                                    'notice_id': dataToBeAdded['notice_id'],
                                    'title': dataToBeAdded['title'],
                                    'date': DateTime.now()
                                  }).then((value) {
                                    Fluttertoast.showToast(
                                        msg: 'Notice Added Successfully');
                                  });
                                });
                                setState(() {
                                  visibility = false;
                                });
                              } catch (e) {
                                print(e);
                                setState(() {
                                  visibility = false;
                                });
                              }
                            } else {
                              print('Fill All Parameters');
                            }

                            Navigator.pop(context);
                          },
                        ),
                        OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Back'))
                      ],
                      content: Column(
                        children: [
                          TextField(
                            onChanged: (a) {
                              setState(() {
                                dataToBeAdded['title'] = a;
                              });
                            },
                            decoration:
                                InputDecoration(hintText: 'Enter title'),
                          ),
                          TextField(
                            onChanged: (a) {
                              setState(() {
                                dataToBeAdded['description'] = a;
                              });
                            },
                            decoration:
                                InputDecoration(hintText: 'Enter Description'),
                          ),
                          IconButton(
                              onPressed: () async {
                                setState(() {
                                  visibility = true;
                                });
                                Upload().uploadFile(context).then((value) {
                                  setState(() {
                                    dataToBeAdded['url'] = value;
                                    visibility = false;
                                  });
                                });
                              },
                              icon: Icon(Icons.attach_file))
                        ],
                      ),
                    );
                  });
            },
            icon: Icon(Icons.add))
      ]),
      body: Stack(
        children: [
          StreamBuilder(
            stream: firestore
                .collection(schoolName)
                .doc('Notices')
                .collection('Notices')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshort) {
              var notices = [];
              if (snapshort.hasData) {
                final noticess = snapshort.data!.docs;

                for (var notice in noticess) {
                  notices.add(notice);
                }
              }
              return

                  ///Text(messageWidget);

                  ListView.builder(
                      itemCount: notices.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Are you sure to delete'),
                                    actions: [
                                      OutlinedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Back')),
                                      OutlinedButton(
                                          onPressed: () async {
                                            await firestore
                                                .collection(schoolName)
                                                .doc('Notices')
                                                .collection('Notices')
                                                .doc(notices[i].id)
                                                .delete();
                                            Navigator.pop(context);
                                          },
                                          child: Text('Yes')),
                                    ],
                                  );
                                });
                          },
                          onTap: () async {
                            final url = firestore
                                .collection('Notices')
                                .doc(notices[i]['notice_id'])
                                .get()
                                .then((value) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(value.data()!['title']),
                                      content: Text(
                                          value.data()!['description'] +
                                              '\n' +
                                              value.data()!['date'].toString()),
                                      actions: [
                                        OutlinedButton(
                                            onPressed: () async {
                                              final file = await Upload()
                                                  .getMedia(
                                                      value.data()!['url']);
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             Scaffold(
                                              //                 body: Image.file(
                                              //                     file))));
                                            },
                                            child: Text('Show'))
                                      ],
                                    );
                                  });
                            });
                          },
                          leading: Icon(Icons.notifications),
                          title: Text(notices[i]['title']),
                          subtitle: Text(notices[i]['description']),
                        );
                      });
            },
          ),
          Visibility(
              visible: visibility,
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.green,
              )))
        ],
      ),
    );
  }
}
