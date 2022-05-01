import 'package:flutter/material.dart';

class Leave extends StatelessWidget {
  const Leave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.message),
        ],
        backgroundColor: Color(0xff9CCDDB),
        title: Text(
          'Leave for leave',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  maxLines: null,
                ),
              ),
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffDCFFE4),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                child: Center(
                  child: Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color(0xff9CCDDB),
                ),
                height: 40,
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
