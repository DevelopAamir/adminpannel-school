import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/SignupButton.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/Textfiel.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/HomePage.dart';
import 'package:adminpannel/SchoolAdmin/Pages.dart/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return auth.currentUser == null ? StartPage() : HomePage();
  }
}

class StartPage extends StatelessWidget {
  const StartPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 500,
              child: Card(
                elevation: 5,
                color: Color(0xfff4f4f8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        child: Textfield(
                          text: 'Email',
                          icon: Icons.email,
                          obsecuewtext: false,
                          controller: null,
                          onChange: null,
                        ),
                        color: Colors.white,
                      ),
                      Card(
                        child: Textfield(
                          text: 'Password',
                          icon: Icons.password,
                          obsecuewtext: true,
                          controller: null,
                          onChange: null,
                        ),
                        color: Colors.white,
                      ),
                      Card(
                        child: Textfield(
                          text: 'Confirm Password',
                          icon: Icons.password,
                          obsecuewtext: true,
                          controller: null,
                          onChange: null,
                        ),
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SignupButton(),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          print('tapped');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Login();
                              },
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 4, right: 4),
                          child: Center(
                            child: Text(
                              'Login',
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
                      ),
                    ],
                  ),
                ),
                shadowColor: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
