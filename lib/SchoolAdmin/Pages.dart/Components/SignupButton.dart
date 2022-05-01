import 'package:adminpannel/SchoolAdmin/Pages.dart/HomePage.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/SignUp_student.dart';
import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('tapped');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 4, right: 4),
        child: Center(
          child: Text(
            'Sign Up',
            style: TextStyle(color: Colors.white),
          ),
        ),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xff005b96),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          print('tapped');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return UserStudent();
              },
            ),
          );
        },
        child: Card(
          color: Colors.red,
          child: Text(
            'SignUp Student',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
