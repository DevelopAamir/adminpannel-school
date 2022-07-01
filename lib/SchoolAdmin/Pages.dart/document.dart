import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Textfiel.dart';
import 'package:adminpannel/SchoolAdmin/ProgressIndicators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentDocuments extends StatefulWidget {
  final CollectionReference<Map<String, dynamic>> data;
  const StudentDocuments({Key? key, required this.data}) : super(key: key);

  @override
  State<StudentDocuments> createState() => _StudentDocumentsState();
}

class _StudentDocumentsState extends State<StudentDocuments> {
  var title = '';
  final file = TextEditingController();
  bool spin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Documents'),
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
                                      widget.data.add({
                                        'title': title,
                                        'attachment': file.text,
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text('Yes'))
                              ]);
                        });
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
        body: Stack(
          children: [
            StreamBuilder(
                stream: widget.data.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return snapshot.hasData
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                              itemCount: snapshot.data!.docs.length,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 3 / 3,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Upload().getMedia(snapshot.data!.docs[index]
                                        ['attachment']);
                                  },
                                  onLongPress: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              title: Text(
                                                  'Do You Really Want To Delete'),
                                              actions: [
                                                OutlinedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Back')),
                                                OutlinedButton(
                                                    onPressed: () {
                                                      snapshot.data!.docs[index]
                                                          .reference
                                                          .delete();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Yes'))
                                              ]);
                                        });
                                  },
                                  child: SizedBox(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Card(
                                            child: Center(
                                                child: Icon(Icons.file_open)),
                                          ),
                                        ),
                                        Text(
                                            snapshot.data!.docs[index]['title'])
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      : Container();
                }),
            indicator(spin)
          ],
        ));
  }
}
