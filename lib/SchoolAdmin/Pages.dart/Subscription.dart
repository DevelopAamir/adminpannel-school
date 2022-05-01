import 'package:flutter/material.dart';

class Subscribes extends StatelessWidget {
  const Subscribes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff12B081),
        title: Text('Total students'),
      ),
      body: ExpansionTile(
        title: Text('osama'),
        children: [
          ListTile(
            title: Text('osama'),
          ),
          ListTile(
            title: Text('osama'),
          ),
          ListTile(
            title: Text('osama'),
          )
        ],
      ),
    );
  }
}
