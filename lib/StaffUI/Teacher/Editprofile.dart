import 'package:flutter/material.dart';

class Profileedit extends StatelessWidget {
  const Profileedit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(),
        ),
        backgroundColor: Color(0xff9CCDDB),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Textfield(
                hintText: 'Name',
              ),
              Textfield(
                hintText: 'Address',
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    height: 40,
                    width: 440,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Textfield extends StatelessWidget {
  const Textfield({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          fillColor: Color(0xffFFFFFF),
          filled: true,
          hintText: hintText,
          labelText: "Fill Details",
          labelStyle: TextStyle(color: Colors.black54, fontSize: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
