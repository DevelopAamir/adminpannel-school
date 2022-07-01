import 'package:flutter/material.dart';

class EditPosts extends StatelessWidget {
  const EditPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: ListView(
        children: [
          Container(
            // color: Colors.red,
            height: 700,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Greenland International secondary school',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '2022 July 4',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.edit)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 10, bottom: 5),
                  child: Text('Admission open'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25),
                  child: Container(
                    width: double.infinity,
                    height: 444,
                    child: Image.asset(
                      'images/picture.png',
                      fit: BoxFit.fill,
                    ),
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.thumb_up),
                      Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 235, 235, 235),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Comment',
                          ),
                        )),
                      ),
                      Icon(Icons.comment),
                      Icon(Icons.share)
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
