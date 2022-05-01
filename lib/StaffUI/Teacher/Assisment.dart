import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Assisment extends StatefulWidget {
  const Assisment({Key? key}) : super(key: key);

  @override
  State<Assisment> createState() => _AssismentState();
}

class _AssismentState extends State<Assisment> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList = [];

  void imageSelect(ImageSource source) async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage();

      if (images!.isNotEmpty) {
        _imageFileList!.addAll(images);
      }
      print('image List Length:' + _imageFileList!.length.toString());
      setState(() {});

      // final url = await Upload().uploadProfilepic(image);

      // Provider.of<StudentProvider>(context, listen: false)
      //     .addStudentInformation(key: 'Profile_Pic', value: url);
    } catch (e) {
      print('Failed to pick image:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(
            0xff9CCDDB,
          ),
          title: Text("Assisment"),
        ),
        body: Column(
          children: [
            Card(
              elevation: 5,
              child: Column(
                children: [
                  Container(
                    color: Colors.black,
                    child: TextField(
                      decoration: InputDecoration(
                        focusColor: Colors.blue,
                        fillColor: Color(0xffFFFFFF),
                        filled: true,
                        labelText: "Text",
                        labelStyle:
                            TextStyle(color: Colors.black54, fontSize: 15),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    imageSelect(ImageSource.gallery);
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Add",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // height: 100,
                            // width: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Cradss(
                                      text: 'Class',
                                    ),
                                    Cradss(
                                      text: 'Section',
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Cradss(
                                      text: 'Date',
                                    ),
                                    Cradss(
                                      text: 'Name',
                                    ),
                                    // IconButton(
                                    //   onPressed: () {
                                    //     imageSelect(ImageSource.gallery);
                                    //   },
                                    //   icon: Icon(
                                    //     Icons.add,
                                    //     color: Colors.grey[600],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                            // height: 100,
                            // width: 300,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: _imageFileList!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext conext, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Image.file(
                        File(_imageFileList![index].path),
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Color(
                    0xff9CCDDB,
                  ),
                  minimumSize: Size(200, 50),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
                onPressed: () {},
                child: Text('Send Homework'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Cradss extends StatelessWidget {
  final String text;
  const Cradss({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Center(
          child: Text(text),
        ),
        height: 30,
        width: 60,
      ),
    );
  }
}
