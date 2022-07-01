import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final total;
  final String text;
  final Widget? navigate;
  final color;
  const Cards({
    Key? key,
    required this.text,
    this.navigate,
    required this.color,
    this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigate != null
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => navigate!),
              );
            }
          : () {},
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width * 0.2,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadiusDirectional.circular(10),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 1,
          //     blurRadius: 2,
          //     offset: Offset(0, 1), // changes position of shadow
          //   ),
          // ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                total,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
