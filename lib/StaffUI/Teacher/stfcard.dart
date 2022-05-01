import 'package:flutter/material.dart';

class Stfcard extends StatelessWidget {
  const Stfcard({
    Key? key,
    this.icons,
    required this.clr,
    required this.txts,
  }) : super(key: key);
  final IconData? icons;
  final Color clr;
  final Text txts;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      color: Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        width: 150,
        height: 150,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icons,
                color: clr,
                size: 40,
              ),
              txts
            ],
          ),
        ),
      ),
    );
  }
}
