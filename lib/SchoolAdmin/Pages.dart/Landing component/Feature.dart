import 'dart:math';

import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homescreen.dart';

class Features extends StatefulWidget {
  Features({
    Key? key,
  }) : super(key: key);

  @override
  State<Features> createState() => _FeaturesState();
}

class _FeaturesState extends State<Features> {
  List<Coodinates> coodinates = [
    Coodinates(0, 0),
    Coodinates(0, 0),
    Coodinates(0, 0),
    Coodinates(0, 0),
    Coodinates(0, 0),
    Coodinates(0, 0),
    Coodinates(0, 0),
    Coodinates(0, 0),
    Coodinates(0, 0),
    Coodinates(0, 0),
    Coodinates(0, 0),
    Coodinates(0, 0),
    Coodinates(0, 0),
    Coodinates(0, 0),
    Coodinates(0, 0),
  ];
  ScrollController? controller;
  bool appBarElevate = false;
  @override
  void initState() {
    controller = ScrollController(initialScrollOffset: 0.0);

    controller!.addListener(() {
      if (controller!.hasClients) print(controller!.offset);
      if (mounted) {
        setState(() {
          if (controller!.offset > 30) {
            Provider.of<SchoolProvider>(context, listen: false)
                .changeAppBarFocus(true);
          } else {
            Provider.of<SchoolProvider>(context, listen: false)
                .changeAppBarFocus(false);
          }
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: controller,
        child: Container(
          height: 4595,
          child: Stack(
            children: [
              Bubble(
                x: 500,
                y: 1000,
                increment: true,
                big: true,
                listen: (x, y) {
                  coodinates[0] = Coodinates(x, y);
                  setState(() {});
                },
                coodinates: coodinates,
              ),
              Bubble(
                coodinates: coodinates,
                x: 0,
                y: 2000,
                increment: false,
                big: true,
                listen: (x, y) {
                  coodinates[1] = Coodinates(x, y);
                  setState(() {});
                },
              ),
              Bubble(
                coodinates: coodinates,
                x: 500,
                y: 3000,
                increment: true,
                big: true,
                listen: (x, y) {
                  coodinates[2] = Coodinates(x, y);
                  setState(() {});
                },
              ),
              Bubble(
                coodinates: coodinates,
                x: 1,
                y: 4595 - 291,
                increment: false,
                big: true,
                listen: (x, y) {
                  coodinates[3] = Coodinates(x, y);
                  setState(() {});
                },
              ),
              Bubble(
                coodinates: coodinates,
                x: 1,
                y: 1,
                increment: true,
                big: true,
                listen: (x, y) {
                  coodinates[4] = Coodinates(x, y);
                  setState(() {});
                },
              ),
              Bubble(
                coodinates: coodinates,
                x: 700,
                y: 150,
                increment: false,
                big: false,
                listen: (x, y) {
                  coodinates[5] = Coodinates(x, y);
                  setState(() {});
                },
              ),
              Bubble(
                coodinates: coodinates,
                x: double.infinity - 80,
                y: 400,
                increment: false,
                big: false,
                listen: (x, y) {
                  coodinates[6] = Coodinates(x, y);
                  setState(() {});
                },
              ),
              Bubble(
                coodinates: coodinates,
                x: 1200,
                y: 450,
                increment: true,
                big: false,
                listen: (x, y) {
                  coodinates[7] = Coodinates(x, y);
                  setState(() {});
                },
              ),
              Bubble(
                coodinates: coodinates,
                x: 500,
                y: 500,
                increment: false,
                big: false,
                listen: (x, y) {
                  coodinates[8] = Coodinates(x, y);
                  setState(() {});
                },
              ),
              Bubble(
                coodinates: coodinates,
                x: 800,
                y: 550,
                increment: true,
                big: false,
                listen: (x, y) {
                  coodinates[9] = Coodinates(x, y);
                  setState(() {});
                },
              ),
              Bubble(
                coodinates: coodinates,
                x: 850,
                y: 1000,
                increment: false,
                big: false,
                listen: (x, y) {
                  coodinates[10] = Coodinates(x, y);
                  setState(() {});
                },
              ),
              Bubble(
                coodinates: coodinates,
                x: 400,
                y: 2000,
                increment: false,
                big: false,
                listen: (x, y) {
                  coodinates[11] = Coodinates(x, y);
                  setState(() {});
                },
              ),
              Bubble(
                coodinates: coodinates,
                x: 100,
                y: 3400,
                increment: false,
                big: false,
                listen: (x, y) {
                  coodinates[12] = Coodinates(x, y);
                  setState(() {});
                },
              ),
              Bubble(
                coodinates: coodinates,
                x: 250,
                y: 4000,
                increment: true,
                big: false,
                listen: (x, y) {
                  coodinates[13] = Coodinates(x, y);
                  setState(() {});
                },
              ),
              Bubble(
                coodinates: coodinates,
                x: 70,
                y: 2500,
                increment: false,
                big: false,
                listen: (x, y) {
                  coodinates[14] = Coodinates(x, y);
                  setState(() {});
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 311),
                child: Row(
                  children: [
                    Spacer(),
                    SizedBox(
                        width: 654,
                        height: 650.38,
                        child: Image.asset('images/mock.png')),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 176.0, left: 69),
                    child: Text(
                      'Modernize The Education \nSystem.',
                      style:
                          TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 69, top: 137),
                    child: Text(
                      'Pay Only For The Feature \nYou Use',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 69, top: 142),
                    child: Container(
                      width: 225,
                      height: 79,
                      child: Center(
                        child: Text(
                          'Subscribe Now',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xff6EDED7),
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 235),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Our Modules',
                            style: TextStyle(
                                fontSize: 55,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Container(height: 1, width: 432, color: Colors.grey)
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 115, left: 69),
                    child: Text(
                      '1. Control Panel / Staff Panel',
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        top: 108,
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 1213,
                          height: 607,
                          child:
                              Center(child: Image.asset('images/mackbook.png')),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 104),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Top Features',
                            style: TextStyle(
                                fontSize: 55,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Container(height: 1, width: 432, color: Colors.grey)
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 134),
                    child: Center(
                      child: Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(68.0),
                            child: Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(31),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(-2, 4),
                                        blurRadius: 25,
                                        spreadRadius: 1,
                                        color: Color.fromRGBO(0, 0, 0, 0.07))
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(68.0),
                            child: Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(31),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(-2, 4),
                                        blurRadius: 25,
                                        spreadRadius: 1,
                                        color: Color.fromRGBO(0, 0, 0, 0.07))
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(68.0),
                            child: Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(31),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(-2, 4),
                                        blurRadius: 25,
                                        spreadRadius: 1,
                                        color: Color.fromRGBO(0, 0, 0, 0.07))
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Bubble extends StatefulWidget {
  final x;
  final y;
  final increment;
  final bool big;
  final Function(double, double)? listen;
  final List<Coodinates> coodinates;
  const Bubble({
    Key? key,
    this.x,
    this.y,
    this.increment,
    required this.big,
    this.listen,
    required this.coodinates,
  }) : super(key: key);

  @override
  State<Bubble> createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  double y = 0;
  double x = 0;
  bool incrementY = true;
  bool incrementX = true;
  @override
  void initState() {
    if (y == 0) {
      y = widget.y;
      x = widget.x;
      incrementY = widget.increment;
    }

    if (mounted) {
      setState(() {});
    }

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 60));
    _controller!.repeat();
    _controller!.addListener(() {
      widget.listen!(x, y);
      bool overLap = widget.coodinates.where((element) {
            return element.x == x && element.y < y && element.y > y + 291;
          }).length >
          1;

      if (overLap) {
        print(overLap);
        setState(() {
          if (incrementX) {
            incrementX = false;
          } else {
            incrementX = true;
          }
        });
      }
      setState(() {
        if (y < 0) {
          incrementY = true;
        } else if (y >= 4595 - 291) {
          incrementY = false;
        }
        if (incrementY) {
          y = y + 1;
        } else {
          y = y - 1;
        }
        if (x < 0) {
          incrementX = true;
        } else if (x >= MediaQuery.of(context).size.width - 291) {
          incrementX = false;
        }
        if (incrementX) {
          x = x + 1;
        } else {
          x = x - 1;
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4595,
      width: double.infinity,
      color: Colors.transparent,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller!.view,
            builder: ((context, child) {
              return Positioned(top: y, left: x, child: child!);
            }),
            child: Container(
              width: widget.big ? 291 : 80,
              height: widget.big ? 291 : 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.big ? 145.5 : 40),
                  border: Border.all(
                      color: Color.fromARGB(255, 110, 222, 215), width: 1.5)),
            ),
          )
        ],
      ),
    );
  }
}

class _Featurecard extends StatelessWidget {
  final String text;
  final IconData icns;
  const _Featurecard({
    Key? key,
    required this.text,
    required this.icns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Coodinates {
  final double x;
  final double y;

  Coodinates(this.x, this.y);
}
