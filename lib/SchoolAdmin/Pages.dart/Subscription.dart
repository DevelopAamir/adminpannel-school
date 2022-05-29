import 'package:flutter/material.dart';

class Subscribes extends StatelessWidget {
  const Subscribes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
