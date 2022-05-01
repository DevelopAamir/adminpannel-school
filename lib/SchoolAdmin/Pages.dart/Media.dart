import 'package:adminpannel/SchoolAdmin/Connector/uploadData.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Cards.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Medias extends StatelessWidget {
  Medias({Key? key}) : super(key: key);
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff12B081), title: Text('Media')),
      body: StreamBuilder(
        stream: firestore
            .collection(
                Provider.of<SchoolProvider>(context, listen: false).info.name)
            .doc('Attachments')
            .collection('Attachments')
            .snapshots(),
        builder: (context, AsyncSnapshot snap) {
          var data = [];
          if (snap.hasData) {
            final medias = snap.data!.docs;

            for (var media in medias) {
              data.add(media);
            }
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
              ),
              itemCount: data.length,
              itemBuilder: (context, i) {
                return Tooltip(
                  message: data[i]['name'].toString(),
                  child: InkWell(
                    focusColor: Colors.amber,
                    onTap: () {
                      Upload().getMedia(data[i]['url']);
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: Image(
                            image: data[i]['name']
                                    .toString()
                                    .toLowerCase()
                                    .contains('pdf')
                                ? AssetImage("images/pic.png")
                                : data[i]['name']
                                        .toString()
                                        .toLowerCase()
                                        .contains('mp4')
                                    ? AssetImage("images/mp4.png")
                                    : data[i]['name']
                                            .toString()
                                            .toLowerCase()
                                            .contains('doc')
                                        ? AssetImage("images/doc.png")
                                        : data[i]['name']
                                                .toString()
                                                .toLowerCase()
                                                .contains('jpg')
                                            ? AssetImage("images/jpg.png")
                                            : AssetImage("images/jpg.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text(
                              data[i]['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
