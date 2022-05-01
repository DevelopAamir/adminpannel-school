import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  final String texts;
  final String page;
  final IconData icon;
  const DrawerButton({
    Key? key,
    required this.texts,
    required this.page,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          print('tapped');
          Navigator.pushNamed(context, page);
        },
        child: Card(
          elevation: 0.5,
          color: Color(0xffE1EFF0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: Color(0xff1DB691),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  texts,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(height: 5, color: Colors.white);
  }
}
