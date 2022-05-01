import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:adminpannel/Storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Leavehistory extends StatefulWidget {
  const Leavehistory({Key? key}) : super(key: key);

  @override
  State<Leavehistory> createState() => _LeavehistoryState();
}

class _LeavehistoryState extends State<Leavehistory> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff12B081),
        title: Text('Leave Histoy'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffE9FFFE),
                    border: Border.all(width: 1.5, color: Colors.black),
                  ),
                  width: 500,
                  height: 600,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Image'),
                              Text(
                                'Satyanarayan Secondary school',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Date:2022/01/05',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Reason: Due to sick',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'To,',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'The Principal',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Satyanarayan sec school, Biratnagar-07',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Explanation'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffE9FFFE),
                  border: Border.all(width: 1.5, color: Colors.black),
                ),
                width: 500,
                height: 600,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Image'),
                            Text(
                              'Satyanarayan Secondary school',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Date:2022/01/05',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Reason: Due to sick',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'To,',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'The Principal',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Satyanarayan sec school, Biratnagar-07',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Explanation'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
