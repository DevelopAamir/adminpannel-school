import 'package:adminpannel/SchoolAdmin/Pages.dart/Components/BottomBar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Subscriber extends StatelessWidget {
  const Subscriber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 120),
        Text(
          'Clients',
          textAlign: TextAlign.center,
          style: TextStyle(
              letterSpacing: 2, fontSize: 17, color: Color(0xff4AA393)),
        ),
        Text(
          'Meet our respected clients',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xff9BA49E)),
        ),
        SizedBox(height: 20),
        ClientsCard(),
        SizedBox(height: 100),
        Text(
          'What our clients says',
          textAlign: TextAlign.center,
          style: TextStyle(
              letterSpacing: 2, fontSize: 16, color: Color(0xff4AA393)),
        ),
        SizedBox(height: 10),
        Text(
          'TESTIMONIALS',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 32,
              color: Color(0xff004E36)),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: 100, right: 100),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                  ),
                ),
                Text(
                  'Milson mike',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Color(0xff4AA393)),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'We can save our  valuable time by the help of technology (Internet). Now the tehnology is play very important role in our life.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Color(0xff949191)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '2078/05/04',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Color(0xff949191)),
                ),
              ],
            ),
          ),
          height: 150,
          decoration: BoxDecoration(
            color: Color(0xffFFFFFF),
            borderRadius: BorderRadiusDirectional.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color(0xffDCEDF0).withOpacity(0.50),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        BottomBar(),
      ],
    );
  }
}

class ClientsCard extends StatefulWidget {
  const ClientsCard({
    Key? key,
  }) : super(key: key);

  @override
  _ClientsCardState createState() => _ClientsCardState();
}

class _ClientsCardState extends State<ClientsCard> {
  // int _count = 0;

  List imageList = [
    'https://images.adsttc.com/media/images/515b/0985/b3fc/4b29/d600/00b3/large_jpg/2edisonacadbldg2880wphoto.jpg?1364920696',
    'https://i.ytimg.com/vi/VZgnPcMeLf4/hqdefault.jpg',
    'https://i.ytimg.com/vi/VZgnPcMeLf4/hqdefault.jpg',
    'https://img.emg-services.net/HtmlPages/HtmlPage15211/masters-2022-header.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyhkiSKalosCYaz0s33svwGr2M_cCkboZIQw&usqp=CAU',
  ];
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: CupertinoButton(
        onPressed: () {},
        child: CarouselSlider(
          items: imageList.map((imgUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(
                                  imgUrl,
                                ),
                              ),
                            ),
                            Text(
                              'Milson mike',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  letterSpacing: 2,
                                  fontSize: 14,
                                  color: Color(0xff4AA393)),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'School Name: Satyanarayan sec school',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color(0xff9BA49E)),
                            ),
                            Text(
                              'Address: Biratnagar 17, unknown area',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color(0xff9BA49E)),
                            ),
                            Text(
                              'Speciality: International education institute',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color(0xff9BA49E)),
                            ),
                            Text(
                              'Avialable education: Primary,secondary',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color(0xff9BA49E)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Since 1996',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 10,
                                        color: Color(0xffDCDCDC)),
                                  ),
                                  SizedBox(width: 70),
                                  Icon(Icons.facebook,
                                      size: 18, color: Colors.black),
                                  SizedBox(width: 5),
                                  Icon(Icons.info,
                                      size: 18, color: Colors.black),
                                  SizedBox(width: 5),
                                  Icon(Icons.link,
                                      size: 18, color: Colors.black)
                                ],
                              ),
                            )
                          ]),
                    ),
                    height: 444,
                    width: 459,
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadiusDirectional.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffDCEDF0).withOpacity(0.50),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: 444,
            aspectRatio: 14 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 8),
            autoPlayAnimationDuration: Duration(milliseconds: 4000),
            autoPlayCurve: Curves.easeInOutCubic,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ),
    );
  }
}
