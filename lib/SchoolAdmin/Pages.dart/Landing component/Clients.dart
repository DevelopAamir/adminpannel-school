import 'package:flutter/material.dart';

import 'homescreen.dart';

class Subscriber extends StatelessWidget {
  const Subscriber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child:
            // Image.asset('images/Thirdpage.png'),
            Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0, left: 80),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Clients',
                            style: TextStyle(
                                fontSize: 32, color: Color(0xff004E36)),
                          ),
                          Text(
                            'School app support all devices both Computers and Mobiles (iOs and Android) minimum device specifications requirement.',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff9BA49E),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(29),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _Featurecard(
                    text: 'Satyanarayan sec school',
                    image: 'images/computer.png'),
                _Featurecard(
                  text: 'GreenLand College',
                  image: 'images/computer.png',
                ),
                _Featurecard(
                  text: 'Adarsh sec school',
                  image: 'images/computer.png',
                ),
                _Featurecard(
                  text: 'Pokharya sec school',
                  image: 'images/computer.png',
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1,
              child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contacts',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff535353),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Details(
                          maintxt: '9811006844:/n 9812345678',
                        ),
                        Details(
                          maintxt: 'school@gmail.com',
                        ),
                        Details(
                          maintxt: 'Location:Map',
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Products',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff535353),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          child: Image(
                            image: AssetImage(
                              'images/wings.png',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.copyright,
                              size: 25,
                              color: Color(0xff8C8C8C),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Details(
                              maintxt: '2022 school Pvt.Ltd',
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Social Ntework',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff535353),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.facebook,
                              size: 25,
                              color: Color(0xff8C8C8C),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Facebook',
                              style: TextStyle(
                                color: Color(0xff535353),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.message_rounded,
                              size: 25,
                              color: Color(0xff8C8C8C),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Message',
                              style: TextStyle(
                                color: Color(0xff535353),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.telegram_outlined,
                              size: 25,
                              color: Color(0xff8C8C8C),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Teligram',
                              style: TextStyle(
                                color: Color(0xff535353),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              height: 300,
              // width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffE3FFFD),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Featurecard extends StatelessWidget {
  final String text;

  final String image;
  const _Featurecard({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.17,
          height: MediaQuery.of(context).size.width * 0.17,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 35, bottom: 35),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.cover),
                      color: Color(0xffFDC4CF),
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xffFEFFFF),
            boxShadow: [
              BoxShadow(
                color: Color(0xffDCEDF0).withOpacity(0.50),
                spreadRadius: 10,
                blurRadius: 19,
                offset: Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
        ),
      ),
    );
  }
}
