import 'package:adminpannel/SchoolAdmin/Pages.dart/Posts/postpage.dart';
import 'package:flutter/material.dart';

class Addposts extends StatelessWidget {
  const Addposts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditPosts()),
                );
              },
              child: Text('Edit posts'),
            ),
          ),
        ],
        title: Text('Add post'),
      ),
      body: Center(
        child: Card(
          child: Container(
            height: 400,
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Add Post Here',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Card(
                  elevation: 0,
                  color: Color(0xffEFEFEF),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: TextField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add text',
                          labelText: 'Add text',
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    width: 400,
                    child: Center(
                      child: Text('Add file'),
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 241, 241, 241),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    width: 400,
                    child: Center(
                      child: Text(
                        'post',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 2, 2, 2),
                        borderRadius: BorderRadius.circular(10)),
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
