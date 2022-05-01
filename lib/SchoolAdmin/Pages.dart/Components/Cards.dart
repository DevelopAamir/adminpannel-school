import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final String text;
  final Widget navigate;
  const Cards({
    Key? key,
    required this.text,
    required this.navigate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => navigate),
            );
          },
          child: ExpansionTile(
            title: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff12B081),
              ),
            ),
            children: [
              Container(
                height: 150,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff12B081),
                    ),
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
