import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedScreen extends StatefulWidget {
  const AnimatedScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AnimatedScreenState createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {
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
                return Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    // border: Border.all(width: 1, color: Colors.grey),
                    color: Color.fromARGB(255, 249, 254, 255),
                    borderRadius: BorderRadiusDirectional.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    image: DecorationImage(
                        image: NetworkImage(
                          imgUrl,
                        ),
                        fit: BoxFit.cover),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: 300,
            aspectRatio: 16 / 14,
            viewportFraction: 0.9,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 7),
            autoPlayAnimationDuration: Duration(milliseconds: 4000),
            autoPlayCurve: Curves.decelerate,
            enlargeCenterPage: true,
            scrollDirection: Axis.vertical,
          ),
        ),
      ),
    );
  }
}

class AnimatedScreen2 extends StatefulWidget {
  const AnimatedScreen2({
    Key? key,
  }) : super(key: key);

  @override
  _AnimatedScreen2State createState() => _AnimatedScreen2State();
}

class _AnimatedScreen2State extends State<AnimatedScreen2> {
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
                return Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    // border: Border.all(width: 1, color: Colors.grey),
                    color: Color.fromARGB(255, 249, 254, 255),
                    borderRadius: BorderRadiusDirectional.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    image: DecorationImage(
                        image: NetworkImage(
                          imgUrl,
                        ),
                        fit: BoxFit.cover),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: 300,
            aspectRatio: 16 / 14,
            viewportFraction: 0.9,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 7),
            autoPlayAnimationDuration: Duration(milliseconds: 4000),
            autoPlayCurve: Curves.bounceIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.vertical,
          ),
        ),
      ),
    );
  }
}
