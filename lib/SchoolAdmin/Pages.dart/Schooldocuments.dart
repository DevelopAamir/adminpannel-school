import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Textfiel.dart';
import 'package:adminpannel/SchoolAdmin/ProgressIndicators.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SchoolDocuments extends StatefulWidget {
  const SchoolDocuments({Key? key}) : super(key: key);

  @override
  State<SchoolDocuments> createState() => _SchoolDocumentsState();
}

class _SchoolDocumentsState extends State<SchoolDocuments> {
  bool spin = false;
  var title = '';
  final file = TextEditingController();
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('School Documents'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            title: Text('Add Document'),
                            content: SizedBox(
                                height: 300,
                                child: Column(
                                  children: [
                                    Textfield(
                                        text: 'Enter Title',
                                        obsecuewtext: false,
                                        icon: Icons.title,
                                        controller: null,
                                        onChange: (a) {
                                          setState(() {
                                            title = a;
                                          });
                                        }),
                                    Textfield(
                                      text: 'Attachment',
                                      obsecuewtext: false,
                                      icon: Icons.attachment,
                                      controller: file,
                                      onChange: (a) {},
                                      onTap: () async {
                                        setState(() {
                                          spin = true;
                                        });
                                        await Upload()
                                            .uploadFile(context)
                                            .then((value) {
                                          setState(() {
                                            file.text = value;
                                          });
                                        });
                                        setState(() {
                                          spin = false;
                                        });
                                      },
                                    )
                                  ],
                                )),
                            actions: [
                              OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Back')),
                              OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      spin = true;
                                    });
                                    firestore
                                        .collection(Provider.of<SchoolProvider>(
                                                context,
                                                listen: false)
                                            .info
                                            .name)
                                        .doc('documents')
                                        .collection('documents')
                                        .add({
                                      'title': title,
                                      'file': file.text
                                    });
                                    setState(() {
                                      spin = false;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text('Yes'))
                            ]);
                      });
                },
                child: Text('Add',
                    style: TextStyle(
                      color: Colors.white,
                    ))),
          )
        ],
      ),
      body: Stack(
        children: [
          StreamBuilder(
              stream: firestore
                  .collection(
                      Provider.of<SchoolProvider>(context, listen: false)
                          .info
                          .name)
                  .doc('documents')
                  .collection('documents')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return !snapshot.hasData
                    ? Container()
                    : ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) => InkWell(
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Really Want To Delete'),
                                    actions: [
                                      OutlinedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Back')),
                                      OutlinedButton(
                                          onPressed: () {
                                            snapshot.data!.docs[index].reference
                                                .delete();
                                            Navigator.pop(context);
                                          },
                                          child: Text('Yes')),
                                    ],
                                  );
                                });
                          },
                          onTap: () {
                            Upload()
                                .getMedia(snapshot.data!.docs[index]['file']);
                          },
                          child: Card(
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: Icon(
                                      Icons.attachment,
                                    ),
                                  ),
                                ),
                                Text(snapshot.data!.docs[index]['title'])
                              ],
                            ),
                          ),
                        ),
                      );
              }),
          indicator(spin)
        ],
      ),
    );
  }
}
