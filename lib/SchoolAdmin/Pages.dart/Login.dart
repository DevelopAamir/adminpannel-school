import 'package:adminpannel/SchoolAdmin/Connector/Login.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Textfiel.dart';
import 'package:adminpannel/SchoolAdmin/ProgressIndicators.dart';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool visibility = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Divider(
                height: 8,
                color: Color(0xff02242C),
              ),
              Spacer(),
              Container(
                width: 380,
                child: Card(
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: 220,
                          child: Image(
                            image: AssetImage("images/Logo21.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Textfield(
                          text: 'Email',
                          icon: Icons.email,
                          obsecuewtext: false,
                          controller: email,
                          onChange: null,
                        ),
                        Textfield(
                          text: 'Password',
                          icon: Icons.password,
                          obsecuewtext: true,
                          controller: password,
                          onChange: null,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              visibility = true;
                            });
                            await LogIn()
                                .login(email.text.trim(), password.text.trim(),
                                    context)
                                .then((value) {});
                            print('tapped');
                            setState(() {
                              visibility = false;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 4, right: 4),
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xffC4C4C4),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  shadowColor: Colors.black,
                ),
              ),
              Spacer(),
            ],
          ),
          indicator(visibility)
        ],
      ),
    );
  }
}
