import 'package:adminpannel/SchoolAdmin/Connector/getData.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/animatedscreen.dart';
import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:adminpannel/Storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  var role = '';
  Future getToken(context) async {
    var token = await Store().getData('id');
    var rol = await Store().getData('role');
    setState(() {
      role = rol!;
    });
    Provider.of<SchoolProvider>(context, listen: false).getId(token);
    return token;
  }

  @override
  void initState() {
    getToken(context).then((value) {
      if (value == null) {
        Navigator.pushNamed(context, '/Login');
      } else {
        GetData().getPofile(context);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if ('a' == 'b')
            return true;
          else
            Navigator.pop(context);
          return false;
        },
        child: Scaffold(
          body: Stack(
            children: [
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  Provider.of<SchoolProvider>(context)
                                      .info
                                      .logo),
                            ),
                          ),
                          height: 200,
                          child: AnimatedScreen(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 150.0, left: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 45,
                              child: CircleAvatar(
                                radius: 42,
                                backgroundColor: Colors.grey[200],
                                backgroundImage: NetworkImage(
                                    context.watch<SchoolProvider>().info.logo),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Card(
                                  child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (role != 'Staff')
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'ID:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'School Name:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                      if (role != 'Staff')
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Subscription Date:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      if (role != 'Staff')
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'UserName:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'DOB:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (role != 'Staff')
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              context
                                                  .watch<SchoolProvider>()
                                                  .admin['Information']['ID']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            Provider.of<SchoolProvider>(context)
                                                .info
                                                .name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                      if (role != 'Staff')
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              Provider.of<SchoolProvider>(
                                                      context)
                                                  .admin['Information']
                                                      ['Subscription_Date']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      if (role != 'Staff')
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            Provider.of<SchoolProvider>(context)
                                                .admin['Information']
                                                    ['UserName']
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          Provider.of<SchoolProvider>(context)
                                              .admin['Information']['DOB']
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
