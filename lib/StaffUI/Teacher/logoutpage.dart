import 'package:adminpannel/StaffUI/Teacher/homepage.dart';
import 'package:flutter/material.dart';

class Logoutpage extends StatelessWidget {
  const Logoutpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffECE4E4),
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(),
        ),
        backgroundColor: Color(0xff4680D8),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              print('tapped');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Staffs();
                  },
                ),
              );
            },
            child: Setting5(
              icons: Icons.person,
              txts: 'Edit Profile',
            ),
          ),
          GestureDetector(
            onTap: () {
              print('tapped');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Staffs();
                  },
                ),
              );
            },
            child: Setting5(
              icons: Icons.logout,
              txts: 'Log Out',
            ),
          ),
        ],
      ),
    );
  }
}

class Setting5 extends StatelessWidget {
  const Setting5({
    Key? key,
    required this.txts,
    required this.icons,
  }) : super(key: key);
  final String txts;
  final IconData? icons;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: Color(0xffFEFFFE),
          borderRadius: BorderRadiusDirectional.circular(10)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 20),
            child: Icon(
              icons,
              color: Color(0xff00DDEB),
            ),
          ),
          Text(
            txts,
            style: TextStyle(),
          )
        ],
      ),
    );
  }
}
