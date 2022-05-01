import 'package:flutter/material.dart';

class Resultcard extends StatelessWidget {
  const Resultcard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '1',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // Container(
          //   height: 70,
          //   child: VerticalDivider(
          //     color: Colors.black,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'English',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // Container(
          //   height: 70,
          //   child: VerticalDivider(
          //     color: Colors.black,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '4',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // Container(
          //   height: 70,
          //   child: VerticalDivider(
          //     color: Colors.black,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '70',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 50,
                    height: 20,
                    child: VerticalDivider(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '20',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   height: 70,
          //   child: VerticalDivider(
          //     color: Colors.black,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '90',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // Container(
          //   height: 70,
          //   child: VerticalDivider(
          //     color: Colors.black,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '3.4',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
